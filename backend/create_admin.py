"""
Script para criar um usuário administrador no banco de dados.
Execute com: python create_admin.py
"""
import sys
from pathlib import Path

# Adiciona o diretório src ao path
sys.path.insert(0, str(Path(__file__).parent / "src"))

from sqlalchemy.orm import Session
from src.database import SessionLocal, init_db_engine
from src.models import User
from src.security import get_password_hash

def create_admin_user():
    """Cria um usuário administrador no banco de dados."""
    
    # Inicializa o engine do banco de dados
    print("🔌 Conectando ao banco de dados...")
    init_db_engine()
    
    # Importa SessionLocal DEPOIS de init_db_engine
    from src.database import SessionLocal as get_session
    
    # Cria uma sessão
    db: Session = get_session()
    
    try:
        # Dados do admin
        admin_email = "admin@corrigeai.com"
        admin_password = "Admin@123"  # ALTERE ESTA SENHA APÓS O PRIMEIRO LOGIN!
        admin_name = "Administrador"
        
        # Verifica se o admin já existe
        existing_admin = db.query(User).filter(User.email == admin_email).first()
        
        if existing_admin:
            print(f"⚠️  Usuário admin já existe: {admin_email}")
            print(f"   Nome: {existing_admin.full_name}")
            print(f"   Is Admin: {existing_admin.is_admin}")
            
            # Pergunta se quer atualizar
            response = input("\n🔄 Deseja atualizar para admin e resetar a senha? (s/n): ")
            if response.lower() == 's':
                existing_admin.is_admin = True
                existing_admin.hashed_password = get_password_hash(admin_password)
                existing_admin.full_name = admin_name
                db.commit()
                print(f"✅ Usuário atualizado com sucesso!")
                print(f"📧 Email: {admin_email}")
                print(f"🔑 Senha: {admin_password}")
                print(f"\n⚠️  IMPORTANTE: Altere a senha após o primeiro login!")
            else:
                print("❌ Operação cancelada.")
            return
        
        # Cria o novo admin
        print(f"\n👤 Criando usuário administrador...")
        admin_user = User(
            full_name=admin_name,
            email=admin_email,
            hashed_password=get_password_hash(admin_password),
            is_active=True,
            is_admin=True,
            role="admin",
            credits=999999,  # Créditos ilimitados
            free_credits=999999
        )
        
        db.add(admin_user)
        db.commit()
        db.refresh(admin_user)
        
        print(f"\n✅ Usuário administrador criado com sucesso!")
        print(f"📧 Email: {admin_email}")
        print(f"🔑 Senha: {admin_password}")
        print(f"💰 Créditos: {admin_user.credits}")
        print(f"🎁 Créditos Grátis: {admin_user.free_credits}")
        print(f"\n⚠️  IMPORTANTE: Altere a senha após o primeiro login!")
        
    except Exception as e:
        print(f"❌ Erro ao criar usuário admin: {e}")
        db.rollback()
        raise
    finally:
        db.close()

if __name__ == "__main__":
    print("=" * 60)
    print("🚀 CRIAÇÃO DE USUÁRIO ADMINISTRADOR - CorrigeAI")
    print("=" * 60)
    create_admin_user()
    print("=" * 60)
