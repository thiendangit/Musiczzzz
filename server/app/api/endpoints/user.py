from fastapi import APIRouter

from models.user import UserCreate

router = APIRouter()

@router.post("/sign-up")
async def sign_up(user: UserCreate):
    return {"message": user}
