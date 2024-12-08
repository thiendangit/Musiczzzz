from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.models.auth import User as UserModel
from app.schemas.auth import User as UserSchema, UserCreate, UserLogin, LoginResponse
from app.db.database import get_db 
from app.utils.auth import hash_password, verify_password
import uuid
import smtplib  # For sending emails
from email.mime.text import MIMEText
from pydantic import BaseModel
import jwt  # Import JWT library
import datetime

router = APIRouter()

class ForgotPasswordRequest(BaseModel):
    email: str

SECRET_KEY = "your_secret_key"  # Replace with your actual secret key
ALGORITHM = "HS256"  # Algorithm for encoding the JWT

def create_access_token(data: dict, expires_delta: datetime.timedelta = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.datetime.utcnow() + expires_delta
    else:
        expire = datetime.datetime.utcnow() + datetime.timedelta(minutes=15)  # Default expiration time
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

@router.post("/signup/", status_code=200, response_model=UserSchema)
async def create_user(user: UserCreate, db: Session = Depends(get_db)):
    print(f'${user}')
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

@router.post("/login/", response_model=LoginResponse)
async def login(user: UserLogin, db: Session = Depends(get_db)):
    existing_user = db.query(UserModel).filter(UserModel.email == user.email).first()

    if not existing_user:
        raise HTTPException(
            status_code=400,
            detail="Email not exist."
        )
    
    match_password = verify_password(user.password, existing_user.password)

    if match_password:
        access_token = create_access_token(data={"sub": existing_user.email})
        print({"access_token": access_token, "token_type": "bearer", "user": existing_user})
        return {"access_token": access_token, "token_type": "bearer", "user": existing_user}
    else:
        raise HTTPException(
            status_code=400,
            detail="Incorrect password."
        )

@router.post("/forgot-password/")
async def forgot_password(request: ForgotPasswordRequest, db: Session = Depends(get_db)):
    # Check if the user exists
    user = db.query(UserModel).filter(UserModel.email == request.email).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # Generate a password reset token (you can use JWT or any other method)
    reset_token = str(uuid.uuid4())  # Example token generation

    # Send email with the reset link (you need to implement this function)
    send_reset_email(user.email, reset_token)

    return {"message": "Reset link sent to your email"}

def send_reset_email(email: str, token: str):
    # Implement your email sending logic here
    # This is a simple example using smtplib
    msg = MIMEText(f"Click the link to reset your password: http://yourdomain.com/reset-password?token={token}")
    msg['Subject'] = 'Password Reset Request'
    msg['From'] = 'your_email@example.com'
    msg['To'] = email

    # Send the email
    with smtplib.SMTP('smtp.example.com', 587) as server:
        server.starttls()
        server.login('your_email@example.com', 'your_password')
        server.send_message(msg)