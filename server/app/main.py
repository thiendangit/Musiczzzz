from fastapi import FastAPI
from app.api.router import api_router
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="Music App API",
    description="API for Music Application",
    version="1.0.0"
)

app.include_router(api_router)