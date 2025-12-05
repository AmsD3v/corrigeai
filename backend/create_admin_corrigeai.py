"""
Script para criar usuário administrador
Email: admin@corrigeai.online
Senha: **Apogeu2002**
"""
import sys
import os
from pathlib import Path

# Adiciona o diretório backend/src ao path para imports
backend_dir = Path(__file__).parent / "src"
sys.path.insert(0, str(backend_dir))

from database import SessionLocal, engine, Base
from models import User
from passlib.context import CryptContext

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def create_admin():
    # Cria todas as tabelas se não existirem
    Base.metadata.create_all(bind=engine)
    
    db = SessionLocal()
    
    try:
        # Verifica se admin já existe
        existing_admin = db.query(User).filter(User.email == "admin@corrigeai.online").first()
        
        if existing_admin:
            print("⚠️  Admin já existe!")
            print(f"   Email: {existing_admin.email}")
            print(f"   Nome: {existing_admin.full_name}")
            print(f"   Admin: {existing_admin.is_admin}")
            
            # Pergunta se quer atualizar a senha
            response = input("\n🔄 Deseja atualizar a senha? (s/n): ")
            if response.lower() == 's':
                existing_admin.hashed_password = pwd_context.hash("**Apogeu2002**")
                existing_admin.is_admin = True
                existing_admin.is_active = True
                db.commit()
                print("✅ Senha do admin atualizada com sucesso!")
            else:
                print("❌ Operação cancelada.")
            return
        
        # Cria novo admin
        admin_user = User(
            email="admin@corrigeai.online",
            full_name="Administrador CorrigeAI",
            hashed_password=pwd_context.hash("**Apogeu2002**"),
            is_admin=True,
            is_active=True,
            credits=999999,
            free_credits=999999,
            role="admin"
        )
        
        db.add(admin_user)
        db.commit()
        db.refresh(admin_user)
        
        print("✅ Administrador criado com sucesso!")
        print(f"   Email: {admin_user.email}")
        print(f"   Senha: **Apogeu2002**")
        print(f"   ID: {admin_user.id}")
        print(f"   Créditos: {admin_user.credits}")
        
    except Exception as e:
        print(f"❌ Erro ao criar administrador: {e}")
        db.rollback()
        raise
    finally:
        db.close()

if __name__ == "__main__":
    create_admin()
