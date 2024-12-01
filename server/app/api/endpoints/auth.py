from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.models.auth import User as UserModel
from app.schemas.auth import User as UserSchema, UserCreate, UserLogin
from app.db.database import get_db 
from app.utils.auth import hash_password, verify_password
import uuid

router = APIRouter()

@router.post("/signup/", status_code=200, response_model=UserSchema)
async def create_user(user: UserCreate, db: Session = Depends(get_db)):
    # Check if email exists
    existing_user = db.query(UserModel).filter(UserModel.email == user.email).first()

    if existing_user:
        raise HTTPException(
            status_code=400,
            detail="Email already registered."
        )

    hashed_password = hash_password(user.password)
    
    new_user = UserModel(
        id=str(uuid.uuid4()),
        username=user.username,
        email=user.email,
        password=hashed_password
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    return new_user

@router.post("/login/", status_code = 200, response_model=UserSchema)
async def login(user: UserLogin, db: Session = Depends(get_db)):
    # Check if email exists
    existing_user = db.query(UserModel).filter(UserModel.email == user.email).first()

    print(user.email)

    if not existing_user:
        raise HTTPException(
            status_code=400,
            detail="Email not exist."
        )
    
    match_password = verify_password(user.password, existing_user.password)

    if match_password:
        return existing_user
    else:
        raise HTTPException(
        status_code=400,
        detail="Incorrect password."
        )