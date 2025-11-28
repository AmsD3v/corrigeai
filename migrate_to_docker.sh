#!/bin/bash
# Script de Migração PM2 → Docker
# Execute no servidor: bash migrate_to_docker.sh

set -e  # Parar se houver erro

echo "🚀 Iniciando Migração PM2 → Docker"
echo "===================================="

# 1. Backup do banco de dados
echo "📦 1/8: Fazendo backup do banco..."
mkdir -p ~/backups
docker exec prosaai_db pg_dump -U user prosaai > ~/backups/prosaai_$(date +%Y%m%d_%H%M%S).sql 2>/dev/null || echo "⚠️  Banco ainda não está no Docker, pulando backup..."

# 2. Salvar estado PM2
echo "💾 2/8: Salvando estado do PM2..."
pm2 save
cp ~/.pm2/dump.pm2 ~/backups/pm2_dump_$(date +%Y%m%d_%H%M%S).json

# 3. Parar PM2
echo "🛑 3/8: Parando serviços PM2..."
pm2 stop all
pm2 delete all

# 4. Atualizar código
echo "📥 4/8: Atualizando código do GitHub..."
cd ~/corrigeai
git pull origin main

# 5. Criar arquivo .env na raiz
echo "⚙️  5/8: Configurando variáveis de ambiente..."
cat > .env << 'EOF'
# Banco de Dados (PostgreSQL no Docker)
DATABASE_URL=postgresql://user:password@db:5432/prosaai

# Segurança JWT
SECRET_KEY=09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

# CORS - Produção
CORS_ORIGINS=https://corrigeai.online,https://www.corrigeai.online,https://api.corrigeai.online,http://localhost:5173

# APIs de IA
GEMINI_API_KEY=AIzaSyD8MWRa5g8TUxTv2CoQpiIR1EDWMrn9dMI
GROQ_API_KEY=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

# Mercado Pago
MP_ACCESS_TOKEN=APP_USR-5824620292625235-112303-dc5b1b0b77251b2362cc6fa19315bfd2-2953317711
MP_PUBLIC_KEY=APP_USR-045f36e3-ef88-4c34-9972-c193bfd1fd4c

# URLs da Aplicação
FRONTEND_URL=https://corrigeai.online
BACKEND_URL=https://api.corrigeai.online

# Resend (Email) - ADICIONAR SUA API KEY AQUI!
RESEND_API_KEY=re_sua_api_key_do_resend_aqui
FEEDBACK_EMAIL=feedback@corrigeai.online
EOF

echo " ⚠️  IMPORTANTE: Edite o .env e adicione sua API Key do Resend!"
echo "    Execute: nano ~/corrigeai/.env"
read -p "Pressione ENTER após configurar a API Key do Resend..."

# 6. Build e Start Docker
echo "🐳 6/8: Construindo imagens Docker..."
docker-compose down -v 2>/dev/null || true
docker-compose build

echo "🚀 7/8: Iniciando containers..."
docker-compose up -d

# 7. Aguardar containers iniciarem
echo "⏳ Aguardando containers iniciarem..."
sleep 10

# 8. Verificar status
echo "✅ 8/8: Verificando status dos containers..."
docker-compose ps

echo ""
echo "===================================="
echo "✅ Migração Concluída!"
echo "===================================="
echo ""
echo "Próximos passos:"
echo "1. Verificar logs: docker-compose logs -f"
echo "2. Testar backend: curl http://localhost:8000/docs"
echo "3. Testar site: https://corrigeai.online"
echo ""
echo "Para auto-start no boot:"
echo "  sudo systemctl enable docker"
echo "  Criar: sudo nano /etc/systemd/system/corrigeai.service"
