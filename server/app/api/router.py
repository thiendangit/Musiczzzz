from fastapi import APIRouter

from app.api.endpoints import auth
# Import thêm các router khác
# from api.endpoints import auth
# from api.endpoints import music
# from api.endpoints import playlist

api_router = APIRouter()

# User routes
api_router.include_router(
    auth.router,
    prefix="/auth",
    tags=["auth"]
)

# Auth routes
# api_router.include_router(
#     auth.router,
#     prefix="/auth", 
#     tags=["auth"]
# )

# Music routes
# api_router.include_router(
#     music.router,
#     prefix="/music",
#     tags=["music"]
# )

# Playlist routes 
# api_router.include_router(
#     playlist.router,
#     prefix="/playlist",
#     tags=["playlist"]
# )