from pydantic import BaseModel, EmailStr

class UserBase(BaseModel):
    username: str
    email: EmailStr
    password: str

class UserCreate(UserBase):
    pass

class User(UserBase):
    id: str
    
    class Config:
        from_attributes = True

class UserLogin(BaseModel):
    email: str
    password: str

class UserShow(BaseModel):
    email: str
    username: str