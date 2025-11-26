"""
Script para verificar se a coluna is_admin existe e listar todos os admins
"""
from sqlalchemy import create_engine, inspect
from sqlalchemy.orm import sessionmaker
from src.models import User
from src.core.config import settings

# Create engine
engine = create_engine(settings.DATABASE_URL)
SessionLocal = sessionmaker(bind=engine)
db = SessionLocal()

# Check if is_admin column exists
inspector = inspect(engine)
columns = [col['name'] for col in inspector.get_columns('user')]

print("=" * 60)
print("📋 COLUNAS DA TABELA USER:")
print("=" * 60)
for col in columns:
    print(f"  - {col}")

if 'is_admin' in columns:
    print("\n✅ Coluna 'is_admin' EXISTE!")
else:
    print("\n❌ Coluna 'is_admin' NÃO EXISTE!")
    print("   Execute: python add_is_admin_column.py")

print("\n" + "=" * 60)
print("👥 LISTA DE USUÁRIOS:")
print("=" * 60)

users = db.query(User).all()
for user in users:
    is_admin = getattr(user, 'is_admin', 'N/A')
    print(f"  ID: {user.id} | Email: {user.email:40} | is_admin: {is_admin}")

db.close()
