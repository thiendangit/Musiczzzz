from passlib.context import CryptContext

# Tạo context cho bcrypt
pwd_context = CryptContext(schemes = ["bcrypt"], deprecated = "auto")

# Hàm băm mật khẩu
def hash_password(password: str) -> str:
    return pwd_context.hash(password)


# Hàm xác minh mật khẩu
def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)