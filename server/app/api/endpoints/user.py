from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.models.user import User
from app.db.database import get_db  # Import get_db từ database.py

router = APIRouter()

@router.post("/users/", response_model=User)
def create_user(user: User, db: Session = Depends(get_db)):
    db_user = User(
        username=user.username,
        email=user.email,
        password=user.password  # Trong thực tế nên hash password
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user
