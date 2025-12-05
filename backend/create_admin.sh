#!/bin/bash
# Script para criar administrador no CorrigeAI
# Uso: ./create_admin.sh

echo ""
echo "🔐 Criando Administrador CorrigeAI"
echo "=================================="
echo ""

# Pedir email
read -p "📧 Email do admin (padrão: admin@corrigeai.online): " ADMIN_EMAIL
ADMIN_EMAIL=${ADMIN_EMAIL:-admin@corrigeai.online}

# Pedir senha
read -sp "🔑 Senha do admin: " ADMIN_PASSWORD
echo ""

# Pedir nome
read -p "👤 Nome completo (padrão: Administrador CorrigeAI): " ADMIN_NAME
ADMIN_NAME=${ADMIN_NAME:-Administrador CorrigeAI}

echo ""
echo "⏳ Criando administrador..."
echo ""

# Executar dentro do container
docker exec -i prosaai_backend bash -c "cd /app && python -c \"
import sys
import os

# Adiciona /app ao path
sys.path.insert(0, '/app')
sys.path.insert(0, '/app/src')

# Agora importa
from src.database import SessionLocal, Base, engine
from src.models import User
from passlib.context import CryptContext

# Cria tabelas se não existirem
Base.metadata.create_all(bind=engine)

pwd_context = CryptContext(schemes=['bcrypt'], deprecated='auto')

db = SessionLocal()

try:
    # Verifica se admin já existe
    existing_admin = db.query(User).filter(User.email == '$ADMIN_EMAIL').first()
    
    if existing_admin:
        print('⚠️  Admin já existe! Atualizando...')
        existing_admin.full_name = '$ADMIN_NAME'
        existing_admin.hashed_password = pwd_context.hash('$ADMIN_PASSWORD')
        existing_admin.is_admin = True
        existing_admin.is_active = True
        existing_admin.credits = 999999
        existing_admin.free_credits = 999999
        existing_admin.role = 'admin'
        db.commit()
        print('✅ Admin atualizado com sucesso!')
    else:
        print('📝 Criando novo administrador...')
        admin_user = User(
            email='$ADMIN_EMAIL',
            full_name='$ADMIN_NAME',
            hashed_password=pwd_context.hash('$ADMIN_PASSWORD'),
            is_admin=True,
            is_active=True,
            credits=999999,
            free_credits=999999,
            role='admin'
        )
        db.add(admin_user)
        db.commit()
        print('✅ Administrador criado com sucesso!')
    
    print('')
    print('📧 Email: $ADMIN_EMAIL')
    print('👤 Nome: $ADMIN_NAME')
    print('💰 Créditos: 999999')
    
except Exception as e:
    print(f'❌ Erro: {e}')
    import traceback
    traceback.print_exc()
    db.rollback()
finally:
    db.close()
\""

echo ""
echo "✅ Processo concluído!"
echo ""
