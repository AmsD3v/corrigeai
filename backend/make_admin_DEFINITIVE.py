"""
Script DEFINITIVO para tornar usuário admin
"""
import sys
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from src.models import User
from src.core.config import settings

# Create engine
engine = create_engine(settings.DATABASE_URL)
SessionLocal = sessionmaker(bind=engine)
db = SessionLocal()

# Get email from command line or use default
email = sys.argv[1] if len(sys.argv) > 1 else "eduluis219@gmail.com"

try:
    # Method 1: Try using ORM
    user = db.query(User).filter(User.email == email).first()
    
    if not user:
        print(f"❌ Usuário com email '{email}' não encontrado")
        db.close()
        sys.exit(1)
    
    print(f"📋 Usuário encontrado:")
    print(f"   ID: {user.id}")
    print(f"   Email: {user.email}")
    print(f"   Nome: {user.full_name}")
    print(f"   is_admin ANTES: {getattr(user, 'is_admin', None)}")
    
    # Method 2: Update using raw SQL (more reliable)
    db.execute(
        text("UPDATE user SET is_admin = :admin WHERE id = :user_id"),
        {"admin": True, "user_id": user.id}
    )
    db.commit()
    
    # Verify
    db.refresh(user)
    print(f"   is_admin DEPOIS: {getattr(user, 'is_admin', None)}")
    
    # Double check with raw SQL
    result = db.execute(
        text("SELECT is_admin FROM user WHERE id = :user_id"),
        {"user_id": user.id}
    ).fetchone()
    
    print(f"   is_admin (SQL direto): {result[0] if result else 'N/A'}")
    
    print(f"\n✅ Usuário '{user.email}' agora é ADMINISTRADOR!")
    
except Exception as e:
    print(f"\n❌ ERRO: {e}")
    db.rollback()
finally:
    db.close()
