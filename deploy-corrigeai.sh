#!/bin/bash

set -e  # Parar em caso de erro

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 CorrigeAI - Script de Deploy Robusto"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# ============================================================
# 1. MATAR PROCESSOS INDESEJADOS
# ============================================================
echo "🔪 [1/8] Matando processos antigos..."

# Matar Python/Uvicorn fora do Docker
echo "   → Matando processos Python/Uvicorn..."
sudo pkill -9 -f uvicorn 2>/dev/null || true
sudo pkill -9 python 2>/dev/null || true

# Matar PM2
echo "   → Matando PM2..."
pm2 stop all 2>/dev/null || true
pm2 delete all 2>/dev/null || true
pm2 kill 2>/dev/null || true

# Matar Cloudflared (vamos recriar depois)
echo "   → Matando Cloudflare Tunnel..."
sudo pkill -9 cloudflared 2>/dev/null || true

# Liberar portas
echo "   → Liberando portas 80, 8000, 5433..."
sudo fuser -k 80/tcp 2>/dev/null || true
sudo fuser -k 8000/tcp 2>/dev/null || true
sudo fuser -k 5433/tcp 2>/dev/null || true

sleep 2
echo "   ✅ Processos limpos!"
echo ""

# ============================================================
# 2. LIMPAR DOCKER
# ============================================================
echo "🧹 [2/8] Limpando Docker..."

# Reiniciar serviço Docker para limpar processos travados
echo "   → Reiniciando serviço Docker (correção de permissão)..."
sudo systemctl restart docker
sleep 10

cd ~/corrigeai

# Parar e remover containers na força bruta (evita erro de permissão)
echo "   → Removendo containers na força..."
sudo docker kill prosaai_backend prosaai_frontend prosaai_db 2>/dev/null || true
sudo docker rm -f prosaai_backend prosaai_frontend prosaai_db || true

# Parar via compose (garantia extra)
echo "   → Parando via compose..."
sudo docker-compose down || true

# Forçar remoção de containers corrompidos
echo "   → Removendo containers antigos..."
sudo docker container prune -f

# Limpar imagens antigas (opcional, economiza espaço)
echo "   → Limpando imagens não usadas..."
sudo docker image prune -f

sleep 2
echo "   ✅ Docker limpo!"
echo ""

# ============================================================
# 3. PULL DO GITHUB
# ============================================================
echo "📥 [3/8] Atualizando código do GitHub..."

cd ~/corrigeai
git fetch origin
git reset --hard origin/main

LAST_COMMIT=$(git log -1 --oneline)
echo "   → Último commit: $LAST_COMMIT"
echo "   ✅ Código atualizado!"
echo ""

# ============================================================
# 4. REBUILD E RECRIAR CONTAINERS
# ============================================================
# ============================================================
# 4. REBUILD E RECRIAR CONTAINERS
# ============================================================
echo "🔨 [4/8] Reconstruindo containers..."

# Forçar rebuild do frontend sem cache para garantir atualização
echo "   → Forçando rebuild do frontend (sem cache)..."
sudo docker-compose build --no-cache frontend

# Subir tudo
sudo docker-compose up -d --build

echo "   → Aguardando containers iniciarem..."
sleep 25

echo "   ✅ Containers recriados!"
echo ""

# ============================================================
# 5. VERIFICAR STATUS DOS CONTAINERS
# ============================================================
echo "📊 [5/8] Verificando status..."

BACKEND_STATUS=$(sudo docker inspect -f '{{.State.Status}}' prosaai_backend 2>/dev/null || echo "não encontrado")
FRONTEND_STATUS=$(sudo docker inspect -f '{{.State.Status}}' prosaai_frontend 2>/dev/null || echo "não encontrado")
DB_STATUS=$(sudo docker inspect -f '{{.State.Status}}' prosaai_db 2>/dev/null || echo "não encontrado")

echo "   → Backend:  $BACKEND_STATUS"
echo "   → Frontend: $FRONTEND_STATUS"
echo "   → Database: $DB_STATUS"

if [ "$BACKEND_STATUS" != "running" ] || [ "$FRONTEND_STATUS" != "running" ] || [ "$DB_STATUS" != "running" ]; then
    echo "   ❌ ERRO: Algum container não está rodando!"
    echo "   Logs do backend:"
    sudo docker logs prosaai_backend --tail=20
    exit 1
fi

echo "   ✅ Todos containers rodando!"
echo ""

# ============================================================
# 6. PEGAR IPS DOS CONTAINERS
# ============================================================
echo "🔍 [6/8] Obtendo IPs dos containers..."

BACKEND_IP=$(sudo docker inspect prosaai_backend | grep '"IPAddress"' | grep -v '""' | head -1 | awk '{print $2}' | tr -d '",')
FRONTEND_IP=$(sudo docker inspect prosaai_frontend | grep '"IPAddress"' | grep -v '""' | head -1 | awk '{print $2}' | tr -d '",')

if [ -z "$BACKEND_IP" ] || [ -z "$FRONTEND_IP" ]; then
    echo "   ❌ ERRO: Não foi possível obter IPs dos containers!"
    exit 1
fi

echo "   → Backend IP:  $BACKEND_IP"
echo "   → Frontend IP: $FRONTEND_IP"
echo "   ✅ IPs obtidos!"
echo ""

# ============================================================
# 7. ATUALIZAR CLOUDFLARE TUNNEL CONFIG
# ============================================================
echo "⚙️  [7/8] Configurando Cloudflare Tunnel..."

cat > ~/.cloudflared/config.yml << EOF
tunnel: 97554a99-c599-429d-a61e-a6d624f63e28
credentials-file: /home/auronex-server-2/.cloudflared/97554a99-c599-429d-a61e-a6d624f63e28.json

ingress:
  - hostname: api.corrigeai.online
    service: http://$BACKEND_IP:8000
  - hostname: corrigeai.online
    service: http://$FRONTEND_IP:80
  - hostname: www.corrigeai.online
    service: http://$FRONTEND_IP:80
  - service: http_status:404
EOF

echo "   ✅ Configuração atualizada!"
echo ""

# ============================================================
# 8. REINICIAR CLOUDFLARE TUNNEL
# ============================================================
echo "🔒 [8/8] Reiniciando Cloudflare Tunnel..."

# Garantir que não há processos rodando
sudo pkill -9 cloudflared 2>/dev/null || true
sleep 3

# Iniciar tunnel em background
nohup cloudflared tunnel run corrigeai-tunnel > ~/tunnel.log 2>&1 &

echo "   → Aguardando tunnel conectar..."
sleep 10

# Verificar se está rodando
TUNNEL_PID=$(pgrep -f "cloudflared tunnel run" | head -1)

if [ -z "$TUNNEL_PID" ]; then
    echo "   ❌ ERRO: Tunnel não iniciou!"
    echo "   Últimas linhas do log:"
    tail -20 ~/tunnel.log
    exit 1
fi

echo "   → Tunnel PID: $TUNNEL_PID"
echo "   ✅ Tunnel conectado!"
echo ""

# ============================================================
# RESUMO FINAL
# ============================================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ DEPLOY CONCLUÍDO COM SUCESSO!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 Status do Sistema:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sudo docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo ""
echo "🌐 URLs:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Frontend: https://corrigeai.online"
echo "   API:      https://api.corrigeai.online"
echo ""
echo "📝 IPs Internos:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Backend:  $BACKEND_IP:8000"
echo "   Frontend: $FRONTEND_IP:80"
echo ""
echo "🔍 Comandos Úteis:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "   Ver logs backend:  sudo docker logs prosaai_backend -f"
echo "   Ver logs tunnel:   tail -f ~/tunnel.log"
echo "   Reiniciar tudo:    ~/deploy-corrigeai.sh"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
