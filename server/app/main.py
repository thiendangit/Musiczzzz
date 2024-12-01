from fastapi import FastAPI
from app.api.router import api_router
from app.db.database import SessionLocal

app = FastAPI(
    title="Music App API",
    description="API for Music Application",
    version="1.0.0"
)

app.include_router(api_router)