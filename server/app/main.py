from fastapi import FastAPI
from api.router import api_router

app = FastAPI(
    title="Music App API",
    description="API for Music Application",
    version="1.0.0"
)

app.include_router(api_router)