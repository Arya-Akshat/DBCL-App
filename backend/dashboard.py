import streamlit as st
import requests
import time
from datetime import datetime

# 1. Configuration
BASE_URL = "http://localhost:8000"
USER_ID = "DEMO-001"
HEADERS = {"ngrok-skip-browser-warning": "true"}

st.set_page_config(
    page_title="Driver Safety Dashboard",
    page_icon="🚗",
    layout="wide"
)

st.title("🚗 Driver Safety Dashboard")
st.markdown("### Real-time AI Pipeline Monitoring")

# 2. Main Monitoring Section
col_left, col_right = st.columns([1.5, 1])

with col_left:
    st.subheader("Live Camera Feed")
    try:
        r = requests.get(
            f"{BASE_URL}/video_feed/{USER_ID}",
            headers=HEADERS,
            timeout=3
        )
        if r.status_code == 200:
            # Note: channels="BGR" was requested, though JPEG is usually RGB
            st.image(r.content, channels="BGR", width=400)
        elif r.status_code == 204:
            st.info("⏳ Waiting for driver to start monitoring...")
        else:
            st.warning(f"Unexpected status: {r.status_code}")
    except requests.exceptions.RequestException as e:
        st.error(f"Cannot reach backend: {e}")

with col_right:
    st.subheader("Pipeline Metrics")
    try:
        resp = requests.get(
            f"{BASE_URL}/frame_metadata/{USER_ID}",
            headers=HEADERS,
            timeout=3
        )
        meta = resp.json()

        ear   = meta.get("ear_score")
        hand  = meta.get("hand_near_ear")
        ts    = meta.get("timestamp")
        events = meta.get("events", [])

        # Detection Results
        m_col1, m_col2 = st.columns(2)
        m_col1.metric("EAR Score", round(ear, 3) if ear is not None else "N/A")
        m_col2.metric("Hand Near Ear", "YES" if hand is True else ("NO" if hand is False else "N/A"))

        # Offline detection (timestamp is in ms from Flutter)
        if ts:
            ts_seconds = ts / 1000.0
            if (time.time() - ts_seconds) < 10:
                st.success("🟢 Driver ONLINE")
            else:
                st.error("🔴 Driver OFFLINE — no frame in last 10s")
        else:
            st.warning("⚪ System Status: Initializing...")

        if ear and ear < 0.2:
            st.error(f"🚨 ALERT: LOW EAR DETECTED ({ear:.2f})")
        if hand:
            st.error("🚨 ALERT: HAND NEAR EAR DETECTED")

        # Events log
        if events:
            st.subheader("Latest Safety Events")
            st.table(events)

    except Exception as e:
        st.warning(f"Could not load metadata: {e}")

# 3. Refresh Loop
time.sleep(1)
st.rerun()
