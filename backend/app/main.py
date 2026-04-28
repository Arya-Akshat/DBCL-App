from __future__ import annotations

import hashlib
import sqlite3
import time
import uuid
from typing import Any

from fastapi import Depends, FastAPI, Header, HTTPException

from .database import get_connection, init_db
from .schemas import (
    AuthResponse,
    EventCreate,
    ForgotPasswordRequest,
    LoginRequest,
    SignupRequest,
    TripEndRequest,
    TripStartRequest,
    UserProfile,
)


app = FastAPI(title="DBCL Backend", version="0.1.0")


@app.on_event("startup")
def startup_event() -> None:
    init_db()


def _hash_password(password: str) -> str:
    return hashlib.sha256(password.encode("utf-8")).hexdigest()


def _build_ranking(score: int) -> str:
    if score >= 90:
        return "Elite"
    if score >= 75:
        return "Professional"
    if score >= 60:
        return "Good"
    return "Bad"


def _row_to_user(row: Any) -> UserProfile:
    return UserProfile(
        user_id=row["user_id"],
        name=row["name"],
        phone=row["phone"],
        address=row["address"],
        email=row["email"],
        emergency_contact=row["emergency_contact"] or "",
        profile_photo_path=row["profile_photo_path"],
        license_image_path=row["license_image_path"],
        score=row["score"],
    )


def _token_to_user_id(authorization: str | None = Header(default=None)) -> str:
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing bearer token")
    return authorization.replace("Bearer ", "", 1)


def _load_user(user_id: str) -> UserProfile:
    with get_connection() as connection:
        row = connection.execute("SELECT * FROM users WHERE user_id = ?", (user_id,)).fetchone()
    if row is None:
        raise HTTPException(status_code=404, detail="User not found")
    return _row_to_user(row)


@app.post("/auth/signup", response_model=AuthResponse)
def signup(payload: SignupRequest) -> AuthResponse:
    user_id = f"DBCL-{uuid.uuid4().hex[:8].upper()}"
    try:
        with get_connection() as connection:
            existing = connection.execute("SELECT user_id FROM users WHERE email = ?", (payload.email,)).fetchone()
            if existing:
                raise HTTPException(status_code=409, detail="Email already registered")
            connection.execute(
                """
                INSERT INTO users (
                    user_id, name, phone, address, email, password_hash,
                    emergency_contact, profile_photo_path, license_image_path, score
                ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """,
                (
                    user_id,
                    payload.name,
                    payload.phone,
                    payload.address,
                    payload.email,
                    _hash_password(payload.password),
                    "",
                    payload.profile_photo_path,
                    payload.license_image_path,
                    82,
                ),
            )
            row = connection.execute("SELECT * FROM users WHERE user_id = ?", (user_id,)).fetchone()
    except sqlite3.IntegrityError as exc:
        if "users.email" in str(exc):
            raise HTTPException(status_code=409, detail="Email already registered") from exc
        raise

    return AuthResponse(token=user_id, user=_row_to_user(row))


@app.post("/auth/login", response_model=AuthResponse)
def login(payload: LoginRequest) -> AuthResponse:
    with get_connection() as connection:
        row = connection.execute("SELECT * FROM users WHERE email = ?", (payload.email,)).fetchone()
    if row is None or row["password_hash"] != _hash_password(payload.password):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    return AuthResponse(token=row["user_id"], user=_row_to_user(row))


@app.post("/auth/forgot-password")
def forgot_password(payload: ForgotPasswordRequest) -> dict[str, str]:
    return {"message": f"If {payload.email} exists, reset instructions have been queued."}


@app.get("/user/profile", response_model=UserProfile)
def get_profile(user_id: str = Depends(_token_to_user_id)) -> UserProfile:
    return _load_user(user_id)


@app.put("/user/profile", response_model=UserProfile)
def update_profile(payload: UserProfile, user_id: str = Depends(_token_to_user_id)) -> UserProfile:
    if payload.user_id != user_id:
        raise HTTPException(status_code=403, detail="Cannot update another user")

    try:
        with get_connection() as connection:
            connection.execute(
                """
                UPDATE users
                SET name = ?, phone = ?, address = ?, email = ?, emergency_contact = ?,
                    profile_photo_path = ?, license_image_path = ?, score = ?
                WHERE user_id = ?
                """,
                (
                    payload.name,
                    payload.phone,
                    payload.address,
                    payload.email,
                    payload.emergency_contact,
                    payload.profile_photo_path,
                    payload.license_image_path,
                    payload.score,
                    user_id,
                ),
            )
    except sqlite3.IntegrityError as exc:
        if "users.email" in str(exc):
            raise HTTPException(status_code=409, detail="Email already registered") from exc
        raise

    return _load_user(user_id)


@app.post("/event")
def create_event(payload: EventCreate, user_id: str = Depends(_token_to_user_id)) -> dict[str, Any]:
    with get_connection() as connection:
        connection.execute(
            """
            INSERT INTO events (user_id, type, duration, timestamp, points, snapshot_path, is_recovery)
            VALUES (?, ?, ?, ?, ?, ?, ?)
            """,
            (
                user_id,
                payload.type,
                payload.duration,
                payload.timestamp,
                payload.points,
                payload.snapshot_path,
                int(payload.is_recovery),
            ),
        )
        connection.execute(
            "UPDATE users SET score = MAX(0, MIN(100, score + ?)) WHERE user_id = ?",
            (payload.points, user_id),
        )

    return {"status": "ok"}


@app.get("/events")
def list_events(user_id: str = Depends(_token_to_user_id)) -> list[dict[str, Any]]:
    with get_connection() as connection:
        rows = connection.execute(
            "SELECT * FROM events WHERE user_id = ? ORDER BY timestamp DESC",
            (user_id,),
        ).fetchall()

    return [
        {
            "id": row["id"],
            "type": row["type"],
            "duration": row["duration"],
            "timestamp": row["timestamp"],
            "points": row["points"],
            "snapshot_path": row["snapshot_path"],
            "is_recovery": bool(row["is_recovery"]),
        }
        for row in rows
    ]


@app.post("/trip/start")
def start_trip(payload: TripStartRequest, user_id: str = Depends(_token_to_user_id)) -> dict[str, str]:
    with get_connection() as connection:
        connection.execute("UPDATE trips SET active = 0 WHERE user_id = ? AND active = 1", (user_id,))
        connection.execute(
            "INSERT INTO trips (user_id, start_time, active) VALUES (?, ?, 1)",
            (user_id, payload.start_time),
        )
    return {"status": "started"}


@app.post("/trip/end")
def end_trip(payload: TripEndRequest, user_id: str = Depends(_token_to_user_id)) -> dict[str, str]:
    with get_connection() as connection:
        trip = connection.execute(
            "SELECT id FROM trips WHERE user_id = ? AND active = 1 ORDER BY id DESC LIMIT 1",
            (user_id,),
        ).fetchone()
        if trip is None:
            raise HTTPException(status_code=404, detail="No active trip found")
        connection.execute(
            """
            UPDATE trips
            SET end_time = ?, score = ?, events_count = ?, active = 0
            WHERE id = ?
            """,
            (payload.end_time, payload.score, payload.events_count, trip["id"]),
        )
        connection.execute("UPDATE users SET score = ? WHERE user_id = ?", (payload.score, user_id))
    return {"status": "ended"}


@app.get("/trips")
def list_trips(user_id: str = Depends(_token_to_user_id)) -> list[dict[str, Any]]:
    with get_connection() as connection:
        rows = connection.execute(
            """
            SELECT id, start_time, COALESCE(end_time, start_time) AS end_time, score, events_count
            FROM trips
            WHERE user_id = ?
            ORDER BY id DESC
            """,
            (user_id,),
        ).fetchall()

    return [
        {
            "id": f"trip-{row['id']}",
            "start_time": row["start_time"],
            "end_time": row["end_time"],
            "score": row["score"],
            "events_count": row["events_count"],
        }
        for row in rows
    ]


@app.get("/score")
def get_score(user_id: str = Depends(_token_to_user_id)) -> dict[str, Any]:
    user = _load_user(user_id)
    return {"score": user.score, "ranking": _build_ranking(user.score)}


@app.get("/ranking")
def get_ranking(user_id: str = Depends(_token_to_user_id)) -> dict[str, Any]:
    user = _load_user(user_id)
    return {"user_id": user.user_id, "ranking": _build_ranking(user.score), "score": user.score}


@app.get("/health")
def healthcheck() -> dict[str, Any]:
    return {"status": "ok", "timestamp": int(time.time())}
