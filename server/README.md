source .venv/bin/activate && pip install -r requirements.txt
source .venv/bin/activate && uvicorn app.main:app --reload --host 0.0.0.0 --port 8000