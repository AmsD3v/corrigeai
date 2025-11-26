from src.database import init_db_engine
from src import models, security
from sqlalchemy.orm import Session

def create_admin_user():
    engine = init_db_engine()
    session = Session(engine)
    
    email = "omelhordorockoficial@gmail.com"
    password = "Teste@123"
    full_name = "Admin User"
    
    # Check if user already exists
    user = session.query(models.User).filter(models.User.email == email).first()
    
    if user:
        print(f"⚠️ User {email} already exists. Updating to admin...")
        user.role = "admin"
        user.hashed_password = security.get_password_hash(password)
        print(f"✅ Password reset to: {password}")
    else:
        print(f"🆕 Creating new admin user: {email}")
        hashed_password = security.get_password_hash(password)
        user = models.User(
            email=email,
            hashed_password=hashed_password,
            full_name=full_name,
            role="admin",
            is_active=True,
            credits=9999
        )
        session.add(user)
    
    session.commit()
    print(f"✅ User {email} is now an ADMIN with password '{password}'")
    print("🚀 Try logging in now!")

if __name__ == "__main__":
    create_admin_user()
