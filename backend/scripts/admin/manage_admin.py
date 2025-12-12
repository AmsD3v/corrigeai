#!/usr/bin/env python3
"""
Script unificado para criação/atualização de usuário administrador.
Uso:
    python manage_admin.py                           # Usa valores padrão
    python manage_admin.py --email admin@exemplo.com # Especifica email
    python manage_admin.py --email admin@exemplo.com --password SenhaForte123
    python manage_admin.py --list                    # Lista todos os admins
"""
import sys
import os
import argparse
from pathlib import Path

# Adiciona os diretórios necessários ao path (funciona local e no Docker)
# No Docker: /app/scripts/admin/manage_admin.py -> /app
# Local: backend/scripts/admin/manage_admin.py -> backend
script_dir = Path(__file__).parent.absolute()
backend_dir = script_dir.parent.parent  # scripts/admin -> scripts -> backend
app_dir = Path("/app")  # Docker path

# Adiciona ambos os paths possíveis
for path in [backend_dir, app_dir, backend_dir / "src", app_dir / "src"]:
    if path.exists() and str(path) not in sys.path:
        sys.path.insert(0, str(path))

def get_db_session():
    """Obtém sessão do banco de dados."""
    from src.database import init_db_engine
    # Inicializa o engine primeiro
    init_db_engine()
    # Agora importa SessionLocal que já foi definido
    from src.database import SessionLocal
    return SessionLocal()

def list_admins():
    """Lista todos os usuários administradores."""
    from src import models
    
    db = get_db_session()
    try:
        admins = db.query(models.User).filter(
            (models.User.is_admin == True) | (models.User.role == "admin")
        ).all()
        
        if not admins:
            print("❌ Nenhum administrador encontrado no banco de dados.")
            return
        
        print("\n" + "=" * 60)
        print("👑 ADMINISTRADORES CADASTRADOS")
        print("=" * 60)
        for admin in admins:
            print(f"  📧 Email: {admin.email}")
            print(f"     Nome: {admin.full_name or 'N/A'}")
            print(f"     ID: {admin.id}")
            print(f"     Créditos: {admin.credits}")
            print(f"     is_admin: {getattr(admin, 'is_admin', 'N/A')}")
            print("-" * 40)
        print("=" * 60 + "\n")
    finally:
        db.close()

def create_or_update_admin(email: str, password: str, name: str):
    """Cria ou atualiza um usuário administrador."""
    from src import models
    from src.security import get_password_hash
    from datetime import datetime
    
    db = get_db_session()
    try:
        # Verifica se usuário já existe
        existing_user = db.query(models.User).filter(
            models.User.email == email
        ).first()
        
        if existing_user:
            print(f"⚠️  Usuário {email} já existe. Atualizando para admin...")
            existing_user.full_name = name
            existing_user.hashed_password = get_password_hash(password)
            existing_user.is_admin = True
            existing_user.is_active = True
            existing_user.role = "admin"
            existing_user.credits = 999999
            existing_user.free_credits = 999999
            db.commit()
            db.refresh(existing_user)
            user = existing_user
            action = "ATUALIZADO"
        else:
            print(f"🆕 Criando novo administrador: {email}")
            user = models.User(
                email=email,
                full_name=name,
                hashed_password=get_password_hash(password),
                is_admin=True,
                is_active=True,
                role="admin",
                credits=999999,
                free_credits=999999,
                created_at=datetime.utcnow()
            )
            db.add(user)
            db.commit()
            db.refresh(user)
            action = "CRIADO"
        
        print("\n" + "=" * 60)
        print(f"✅ ADMINISTRADOR {action} COM SUCESSO!")
        print("=" * 60)
        print(f"📧 Email: {email}")
        print(f"🔑 Senha: {password}")
        print(f"👤 Nome: {name}")
        print(f"💰 Créditos: {user.credits}")
        print(f"🆔 ID: {user.id}")
        print("=" * 60)
        print("\n⚠️  IMPORTANTE: Altere a senha após o primeiro login!")
        print("🚀 Pode fazer login agora!\n")
        
    except Exception as e:
        print(f"❌ Erro ao criar/atualizar admin: {e}")
        db.rollback()
        raise
    finally:
        db.close()

def main():
    parser = argparse.ArgumentParser(
        description="Gerenciador de usuários administradores do CorrigeAI",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Exemplos:
  python manage_admin.py                              # Cria admin padrão
  python manage_admin.py --email admin@meusite.com   # Especifica email
  python manage_admin.py --list                       # Lista todos admins
  python manage_admin.py -e admin@x.com -p Senha123  # Email e senha
        """
    )
    
    parser.add_argument(
        "-e", "--email",
        default="admin@corrigeai.online",
        help="Email do administrador (padrão: admin@corrigeai.online)"
    )
    parser.add_argument(
        "-p", "--password",
        default="Admin@2024",
        help="Senha do administrador (padrão: Admin@2024)"
    )
    parser.add_argument(
        "-n", "--name",
        default="Administrador CorrigeAI",
        help="Nome completo (padrão: Administrador CorrigeAI)"
    )
    parser.add_argument(
        "-l", "--list",
        action="store_true",
        help="Lista todos os administradores cadastrados"
    )
    
    args = parser.parse_args()
    
    print("\n" + "=" * 60)
    print("🔐 GERENCIADOR DE ADMIN - CorrigeAI")
    print("=" * 60 + "\n")
    
    if args.list:
        list_admins()
    else:
        create_or_update_admin(args.email, args.password, args.name)

if __name__ == "__main__":
    main()
