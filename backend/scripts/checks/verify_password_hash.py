from src.database import init_db_engine
from src import models, security
from sqlalchemy.orm import Session

def verify_user_password():
    engine = init_db_engine()
    session = Session(engine)
    
    email = "teste@teste.com"
    password = "Teste@123"
    
    print(f"🔍 Checking user: {email}")
    user = session.query(models.User).filter(models.User.email == email).first()
    
    if not user:
        print("❌ User not found in database!")
        return
        
    print(f"✅ User found: ID={user.id}, Role={user.role}")
    print(f"🔐 Stored Hash: {user.hashed_password}")
    
    is_valid = security.verify_password(password, user.hashed_password)
    
    if is_valid:
        print("✅ Password verification SUCCESS!")
    else:
        print("❌ Password verification FAILED!")
        print("   The stored hash does not match 'Teste@123'")

if __name__ == "__main__":
    verify_user_password()
