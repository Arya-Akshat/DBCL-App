from __future__ import annotations

from pydantic import BaseModel, EmailStr, Field


class SignupRequest(BaseModel):
    name: str
    phone: str
    address: str
    email: EmailStr
    password: str = Field(min_length=6)
    license_image_path: str | None = None
    profile_photo_path: str | None = None


class LoginRequest(BaseModel):
    email: EmailStr
    password: str


class ForgotPasswordRequest(BaseModel):
    email: EmailStr


class UserProfile(BaseModel):
    user_id: str
    name: str
    phone: str
    address: str
    email: EmailStr
    emergency_contact: str = ""
    profile_photo_path: str | None = None
    license_image_path: str | None = None
    score: int = 1000


class AuthResponse(BaseModel):
    token: str
    user: UserProfile


class EventCreate(BaseModel):
    type: str
    duration: float
    timestamp: int
    points: int = -5
    snapshot_path: str | None = None
    is_recovery: bool = False


class TripStartRequest(BaseModel):
    start_time: str


class TripEndRequest(BaseModel):
    end_time: str
    score: int
    events_count: int

