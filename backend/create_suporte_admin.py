from src.database import init_db_engine
from src import models, security
from sqlalchemy.orm import Session

def create_suporte_admin():
    engine = init_db_engine()
    session = Session(engine)
    
    email = "suporte@corrigeai.com"
    password = "Admin@2024"
    full_name = "Suporte Admin"
    
    # Check if user already exists
    user = session.query(models.User).filter(models.User.email == email).first()
    
    if user:
        print(f"⚠️ User {email} already exists. Updating to admin...")
        user.role = "admin"
        user.hashed_password = security.get_password_hash(password)
        user.is_active = True
        user.credits = 9999
        user.free_credits = 9999
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
            credits=9999,
            free_credits=9999
        )
        session.add(user)
    
    session.commit()
    print(f"\n{'='*60}")
    print(f"✅ ADMIN CRIADO COM SUCESSO!")
    print(f"{'='*60}")
    print(f"📧 Email: {email}")
    print(f"🔑 Senha: {password}")
    print(f"👤 Role: admin")
    print(f"💰 Créditos: 9999")
    print(f"{'='*60}\n")
    print("🚀 Pode fazer login agora!")

if __name__ == "__main__":
    create_suporte_admin()

