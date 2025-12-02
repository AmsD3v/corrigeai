#!/usr/bin/env python3
"""
Script para recriar o banco de dados do zero e inserir usuário admin.
Usa após resetar containers Docker.
"""
import os
import sys
from datetime import datetime
from sqlalchemy import create_engine
from dotenv import load_dotenv

# Add src to path
sys.path.append(os.path.join(os.path.dirname(__file__), 'src'))

# Import models AFTER adding src to path
from src.database import Base
from src.models import User, Submission, Correction, Transaction, Package, Settings
from src.auth import get_password_hash

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    print("❌ DATABASE_URL não encontrada no .env")
    sys.exit(1)

print(f"🔗 Conectando ao banco: {DATABASE_URL.split('@')[1] if '@' in DATABASE_URL else DATABASE_URL}")

engine = create_engine(DATABASE_URL)

def drop_all_tables():
    """Remove todas as tabelas existentes"""
    print("\n🗑️  Removendo todas as tabelas...")
    Base.metadata.drop_all(bind=engine)
    print("✅ Tabelas removidas!")

def create_all_tables():
    """Cria todas as tabelas do schema"""
    print("\n📋 Criando tabelas...")
    Base.metadata.create_all(bind=engine)
    print("✅ Tabelas criadas:")
    for table in Base.metadata.sorted_tables:
        print(f"   - {table.name}")

def create_admin_user():
    """Cria usuário administrador padrão"""
    from sqlalchemy.orm import sessionmaker
    
    print("\n👤 Criando usuário administrador...")
    
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db = SessionLocal()
    
    try:
        # Verificar se já existe
        existing = db.query(User).filter(User.email == "admin@corrigeai.online").first()
        if existing:
            print("⚠️  Usuário admin já existe!")
            return
        
        # Criar admin
        admin = User(
            full_name="Administrador CorrigeAI",
            email="admin@corrigeai.online",
            hashed_password=get_password_hash("Admin@2024"),  # MUDE ISSO EM PRODUÇÃO!
            is_active=True,
            is_admin=True,
            role="admin",
            credits=9999,
            free_credits=9999,
            created_at=datetime.utcnow()
        )
        
        db.add(admin)
        db.commit()
        db.refresh(admin)
        
        print(f"✅ Admin criado com sucesso!")
        print(f"   Email: admin@corrigeai.online")
        print(f"   Senha: Admin@2024")
        print(f"   ID: {admin.id}")
        print("\n⚠️  IMPORTANTE: Altere a senha após o primeiro login!")
        
    except Exception as e:
        print(f"❌ Erro ao criar admin: {e}")
        db.rollback()
    finally:
        db.close()

def main():
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🔧 CorrigeAI - Recriação Completa do Banco de Dados")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    
    try:
        # 1. Dropar tudo
        drop_all_tables()
        
        # 2. Recriar schema
        create_all_tables()
        
        # 3. Criar admin
        create_admin_user()
        
        print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
        print("✅ BANCO DE DADOS RECONSTRUÍDO COM SUCESSO!")
        print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n")
        
    except Exception as e:
        print(f"\n❌ ERRO: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
