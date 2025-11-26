"""
Script para tornar um usuário administrador por email
"""
import sys
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from src.models import User
from src.core.config import settings

# Create engine
engine = create_engine(settings.DATABASE_URL)
SessionLocal = sessionmaker(bind=engine)
db = SessionLocal()

# Get email from command line or use default
email = sys.argv[1] if len(sys.argv) > 1 else "eduluis219@gmail.com"

# Find user
user = db.query(User).filter(User.email == email).first()

if not user:
    print(f"❌ Usuário com email '{email}' não encontrado")
    db.close()
    sys.exit(1)

# Make admin
user.is_admin = True
db.commit()

print(f"✅ Usuário '{user.email}' agora é ADMINISTRADOR!")
print(f"   ID: {user.id}")
print(f"   Nome: {user.full_name}")
print(f"   is_admin: {user.is_admin}")

db.close()
