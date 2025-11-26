"""
Script para dar créditos grátis a um usuário
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

# Get email and amount from command line
email = sys.argv[1] if len(sys.argv) > 1 else "eduluis219@gmail.com"
amount = int(sys.argv[2]) if len(sys.argv) > 2 else 10

try:
    user = db.query(User).filter(User.email == email).first()
    
    if not user:
        print(f"❌ Usuário com email '{email}' não encontrado")
        db.close()
        sys.exit(1)
    
    print(f"📋 Usuário encontrado:")
    print(f"   ID: {user.id}")
    print(f"   Email: {user.email}")
    print(f"   Nome: {user.full_name}")
    print(f"   Free Credits ANTES: {getattr(user, 'free_credits', 0)}")
    
    # Update using ORM
    user.free_credits = amount
    db.commit()
    db.refresh(user)
    
    print(f"   Free Credits DEPOIS: {getattr(user, 'free_credits', 0)}")
    
    print(f"\n✅ Usuário '{user.email}' agora tem {amount} créditos grátis!")
    
except Exception as e:
    print(f"\n❌ ERRO: {e}")
    db.rollback()
finally:
    db.close()
