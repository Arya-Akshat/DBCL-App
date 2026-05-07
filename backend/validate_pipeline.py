"""
DBCL Pipeline Validation Script
Run with: python backend/validate_pipeline.py
"""
import requests
import time
import sys
import io

BASE_URL = "http://localhost:8000"
USER_ID  = "DEMO-001"
HEADERS  = {"ngrok-skip-browser-warning": "true"}
results  = []

def check(name, passed, detail=""):
    status = "PASS" if passed else "FAIL"
    print(f"  [{status}]  {name}")
    if detail:
        print(f"           -> {detail}")
    results.append(passed)

print("\n======== DBCL PIPELINE VALIDATION ========\n")

# CHECK 1: Backend health
print("SECTION 1 \u2014 Backend Reachability")
try:
    r = requests.get(f"{BASE_URL}/health", timeout=3)
    check("Backend /health", r.status_code == 200,
          f"status={r.status_code} body={r.text[:60]}")
except Exception as e:
    check("Backend /health", False, str(e))

# CHECK 2: Frame upload endpoint accepts JPEG
print("\nSECTION 2 \u2014 Frame Upload")
try:
    # Minimal 1x1 white JPEG (hardcoded bytes, no PIL needed)
    white_jpeg = (
        b'\xff\xd8\xff\xe0\x00\x10JFIF\x00\x01\x01'
        b'\x00\x00\x01\x00\x01\x00\x00\xff\xdb\x00C'
        b'\x00\x08\x06\x06\x07\x06\x05\x08\x07\x07'
        b'\x07\t\t\x08\n\x0c\x14\r\x0c\x0b\x0b\x0c'
        b'\x19\x12\x13\x0f\x14\x1d\x1a\x1f\x1e\x1d'
        b'\x1a\x1c\x1c $.\' ",#\x1c\x1c(7),01444'
        b'\x1f\'9=82<.342\x1edL\t\x02\xff\xd9'
    )
    r = requests.post(
        f"{BASE_URL}/video_feed/{USER_ID}",
        headers={**HEADERS, "Content-Type": "image/jpeg"},
        data=white_jpeg,
        timeout=5
    )
    check("POST /video_feed/{user_id}",
          r.status_code == 200,
          f"status={r.status_code} body={r.text[:60]}")
except Exception as e:
    check("POST /video_feed/{user_id}", False, str(e))

# CHECK 3: Frame serve endpoint returns JPEG
print("\nSECTION 3 \u2014 Frame Serving")
try:
    time.sleep(0.5)
    r = requests.get(
        f"{BASE_URL}/video_feed/{USER_ID}",
        headers=HEADERS,
        timeout=5
    )
    is_jpeg = "image/jpeg" in r.headers.get("content-type", "")
    check("GET /video_feed/{user_id} returns JPEG",
          r.status_code == 200 and is_jpeg,
          f"status={r.status_code} content-type={r.headers.get('content-type')}")
    check("Frame has content (non-empty bytes)",
          len(r.content) > 50,
          f"frame size={len(r.content)} bytes")
except Exception as e:
    check("GET /video_feed/{user_id}", False, str(e))

# CHECK 4: CORS header present on frame endpoint
try:
    cors = r.headers.get("access-control-allow-origin", "")
    check("CORS header on /video_feed",
          cors == "*",
          f"access-control-allow-origin='{cors}'")
except Exception as e:
    check("CORS header", False, str(e))

# CHECK 5: Metadata endpoint
print("\nSECTION 4 \u2014 Metadata & Events")
try:
    r = requests.get(
        f"{BASE_URL}/frame_metadata/{USER_ID}",
        headers=HEADERS,
        timeout=5
    )
    data = r.json()
    has_keys = all(k in data for k in
                   ["timestamp", "ear_score",
                    "hand_on_wheel", "events"])
    check("GET /frame_metadata/{user_id} has required keys",
          r.status_code == 200 and has_keys,
          f"keys={list(data.keys())}")
except Exception as e:
    check("GET /frame_metadata/{user_id}", False, str(e))

# CHECK 6: Event logging endpoint
try:
    r = requests.post(
        f"{BASE_URL}/log_event/{USER_ID}",
        headers=HEADERS,
        json={
            "event_type": "validation_test",
            "timestamp": int(time.time() * 1000)
        },
        timeout=5
    )
    check("POST /log_event/{user_id}",
          r.status_code == 200,
          f"status={r.status_code} body={r.text[:60]}")
except Exception as e:
    check("POST /log_event/{user_id}", False, str(e))

# CHECK 7: Event appears in metadata after logging
try:
    time.sleep(0.5)
    r = requests.get(
        f"{BASE_URL}/frame_metadata/{USER_ID}",
        headers=HEADERS,
        timeout=5
    )
    events = r.json().get("events", [])
    found = any(
        e.get("type") == "validation_test"
        for e in events
        if isinstance(e, dict)
    )
    check("Logged event visible in /frame_metadata",
          found,
          f"events in response={events}")
except Exception as e:
    check("Event visibility in metadata", False, str(e))

# CHECK 8: Timestamp freshness
print("\nSECTION 5 \u2014 Offline Detection")
try:
    r = requests.get(
        f"{BASE_URL}/frame_metadata/{USER_ID}",
        headers=HEADERS,
        timeout=5
    )
    ts = r.json().get("timestamp")
    if ts:
        age = time.time() - (ts / 1000.0)
        check("Frame timestamp is recent (< 30s)",
              age < 30,
              f"frame age={age:.1f}s")
    else:
        check("Frame timestamp is recent (< 30s)",
              False, "timestamp is null")
except Exception as e:
    check("Frame timestamp freshness", False, str(e))

# CHECK 9: Backend still healthy after all checks
print("\nSECTION 6 \u2014 Final Health Check")
try:
    r = requests.get(f"{BASE_URL}/health", timeout=5)
    check("Backend still healthy after all checks",
          r.status_code == 200,
          f"status={r.status_code}")
except Exception as e:
    check("Backend health", False, str(e))

# FINAL SUMMARY
print("\n======== SUMMARY ========")
passed = sum(results)
total  = len(results)
print(f"  {passed}/{total} checks passed.\n")
if passed == total:
    print("  All systems operational. DBCL pipeline is healthy.\n")
else:
    failed = [i+1 for i, v in enumerate(results) if not v]
    print(f"  Fix the FAIL items above (checks: {failed}).\n")
    sys.exit(1)
