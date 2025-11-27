#!/bin/bash

# Script de Deploy Automático - CorrigeAI
# Este script atualiza o código do GitHub e reinicia os serviços

set -e  # Para execução em caso de erro

echo "🚀 Iniciando deploy do CorrigeAI..."
echo "=================================="

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Diretório do projeto (ajuste se necessário)
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"

echo -e "${YELLOW}📂 Diretório do projeto: $PROJECT_DIR${NC}"

# 1. Fazer pull do GitHub
echo ""
echo -e "${YELLOW}📥 Fazendo pull do GitHub...${NC}"
git pull origin main

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Erro ao fazer pull do GitHub${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Pull concluído${NC}"

# 1.5. Verificar/criar ambiente virtual
echo ""
echo -e "${YELLOW}🐍 Verificando ambiente virtual Python...${NC}"

if [ ! -d "venv" ]; then
    echo "Ambiente virtual não encontrado. Criando..."
    python3 -m venv venv
    echo -e "${GREEN}✅ Ambiente virtual criado${NC}"
else
    echo -e "${GREEN}✅ Ambiente virtual já existe${NC}"
fi

# Ativar ambiente virtual
echo "Ativando ambiente virtual..."
source venv/bin/activate
echo -e "${GREEN}✅ Ambiente virtual ativado${NC}"

# 2. Parar Backend
echo ""
echo -e "${YELLOW}🛑 Parando Backend...${NC}"

# Verifica se está usando systemd
if systemctl is-active --quiet corrigeai-backend 2>/dev/null; then
    sudo systemctl stop corrigeai-backend
    echo -e "${GREEN}✅ Backend parado (systemd)${NC}"
# Ou se está usando PM2
elif pm2 list | grep -q "corrigeai-backend" 2>/dev/null; then
    pm2 stop corrigeai-backend
    echo -e "${GREEN}✅ Backend parado (PM2)${NC}"
# Ou mata processo Python diretamente
else
    pkill -f "uvicorn.*corrigeai" || echo "Nenhum processo backend encontrado"
    echo -e "${GREEN}✅ Backend parado${NC}"
fi

# 3. Parar Frontend
echo ""
echo -e "${YELLOW}🛑 Parando Frontend...${NC}"

# Parar serviço do frontend se existir
if systemctl is-active --quiet corrigeai-frontend 2>/dev/null; then
    sudo systemctl stop corrigeai-frontend
    echo -e "${GREEN}✅ Frontend parado (systemd)${NC}"
elif pm2 list | grep -q "corrigeai-frontend" 2>/dev/null; then
    pm2 stop corrigeai-frontend
    echo -e "${GREEN}✅ Frontend parado (PM2)${NC}"
else
    # Para servidor de desenvolvimento se estiver rodando
    pkill -f "vite.*corrigeai" || echo "Nenhum processo frontend encontrado"
    echo -e "${GREEN}✅ Frontend parado${NC}"
fi

# 4. Atualizar Backend
echo ""
echo -e "${YELLOW}🔧 Atualizando Backend...${NC}"
cd backend

# Instalar/atualizar dependências (venv já está ativo)
if [ -f "requirements.txt" ]; then
    echo "Atualizando dependências Python..."
    pip install -r requirements.txt --quiet 2>/dev/null || echo "⚠️ Dependências já instaladas"
fi

# Executar migração se existir
if [ -f "src/migrate_settings.py" ]; then
    echo "Executando migração do banco de dados..."
    python src/migrate_settings.py 2>/dev/null || echo "⚠️ Migração já executada ou erro ignorado"
fi

echo -e "${GREEN}✅ Backend atualizado${NC}"

# 5. Atualizar Frontend
echo ""
echo -e "${YELLOW}🔧 Atualizando Frontend...${NC}"
cd ../frontend

# Instalar/atualizar dependências
if [ -f "package.json" ]; then
    echo "Atualizando dependências Node..."
    npm install --silent
fi

# Build para produção
echo "Buildando frontend..."
npm run build

# Copiar para pasta do nginx (ajuste o caminho se necessário)
if [ -d "/var/www/corrigeai" ]; then
    echo "Copiando build para /var/www/corrigeai..."
    sudo cp -r dist/* /var/www/corrigeai/
    echo -e "${GREEN}✅ Frontend buildado e copiado${NC}"
else
    echo -e "${YELLOW}⚠️  Pasta /var/www/corrigeai não encontrada, build feito mas não copiado${NC}"
fi

cd ..

# 6. Iniciar Backend
echo ""
echo -e "${YELLOW}▶️  Iniciando Backend...${NC}"

if systemctl list-unit-files | grep -q "corrigeai-backend.service"; then
    sudo systemctl start corrigeai-backend
    sudo systemctl status corrigeai-backend --no-pager | head -n 10
    echo -e "${GREEN}✅ Backend iniciado (systemd)${NC}"
elif command -v pm2 &> /dev/null; then
    cd backend
    # Usar Python do venv
    pm2 delete corrigeai-backend 2>/dev/null || true
    pm2 start run.py --name corrigeai-backend --interpreter "$PROJECT_DIR/venv/bin/python3"
    pm2 save
    cd ..
    echo -e "${GREEN}✅ Backend iniciado (PM2 com venv)${NC}"
else
    echo -e "${YELLOW}⚠️  Iniciando backend manualmente...${NC}"
    cd backend
    nohup ../venv/bin/python3 run.py > ../logs/backend.log 2>&1 &
    echo $! > ../backend.pid
    cd ..
    echo -e "${GREEN}✅ Backend iniciado (PID: $(cat backend.pid))${NC}"
fi

# 7. Iniciar Frontend (se necessário)
echo ""
echo -e "${YELLOW}▶️  Iniciando Frontend...${NC}"

if systemctl list-unit-files | grep -q "corrigeai-frontend.service"; then
    sudo systemctl start corrigeai-frontend
    echo -e "${GREEN}✅ Frontend iniciado (systemd)${NC}"
elif command -v pm2 &> /dev/null && pm2 list | grep -q "corrigeai-frontend"; then
    pm2 start corrigeai-frontend
    echo -e "${GREEN}✅ Frontend iniciado (PM2)${NC}"
else
    echo -e "${YELLOW}ℹ️  Frontend é servido pelo Nginx/Apache (build já copiado)${NC}"
fi

# 8. Reiniciar Nginx
echo ""
echo -e "${YELLOW}🔄 Reiniciando Nginx...${NC}"
if command -v nginx &> /dev/null; then
    sudo systemctl reload nginx
    echo -e "${GREEN}✅ Nginx recarregado${NC}"
else
    echo -e "${YELLOW}⚠️  Nginx não encontrado${NC}"
fi

# Resumo final
echo ""
echo "=================================="
echo -e "${GREEN}✅ Deploy concluído com sucesso!${NC}"
echo ""
echo "📊 Status dos serviços:"
echo "----------------------"

# Backend
if systemctl is-active --quiet corrigeai-backend 2>/dev/null; then
    echo -e "Backend: ${GREEN}✅ Rodando (systemd)${NC}"
elif pm2 list | grep -q "corrigeai-backend" 2>/dev/null; then
    echo -e "Backend: ${GREEN}✅ Rodando (PM2)${NC}"
elif [ -f "backend.pid" ] && ps -p $(cat backend.pid) > /dev/null 2>&1; then
    echo -e "Backend: ${GREEN}✅ Rodando (PID: $(cat backend.pid))${NC}"
else
    echo -e "Backend: ${RED}❌ Não está rodando${NC}"
fi

# Nginx
if systemctl is-active --quiet nginx 2>/dev/null; then
    echo -e "Nginx: ${GREEN}✅ Rodando${NC}"
else
    echo -e "Nginx: ${YELLOW}⚠️  Status desconhecido${NC}"
fi

echo ""
echo "🌐 Acesse: https://corrigeai.online"
echo ""
