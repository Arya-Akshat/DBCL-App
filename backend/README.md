# DBCL Backend

Run locally:

```bash
cd backend
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

The API accepts event summaries from the mobile app and does not accept continuous video or raw frame streams.
