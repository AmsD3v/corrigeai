#!/bin/bash
echo "🚀 Iniciando CorrigeAI..."

# 1. Matar processos antigos
echo "🔪 Limpando processos..."
sudo fuser -k 8000/tcp 2>/dev/null
sudo fuser -k 80/tcp 2>/dev/null
pm2 stop all 2>/dev/null
pm2 delete all 2>/dev/null
pm2 kill 2>/dev/null

# 2. Limpar e recriar containers
echo "🧹 Recriando containers..."
cd ~/corrigeai
sudo docker-compose down 2>/dev/null
sudo docker container prune -f
sudo docker-compose up -d
sleep 20

# 3. Pegar IPs dos novos containers
BACKEND_IP=$(sudo docker inspect prosaai_backend | grep '"IPAddress"' | grep -v '""' | head -1 | awk '{print $2}' | tr -d '",')
FRONTEND_IP=$(sudo docker inspect prosaai_frontend | grep '"IPAddress"' | grep -v '""' | head -1 | awk '{print $2}' | tr -d '",')

echo "Backend IP: $BACKEND_IP"
echo "Frontend IP: $FRONTEND_IP"

# 4. Atualizar Cloudflare Tunnel config
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

# 5. Reiniciar tunnel
echo "🔒 Reiniciando Cloudflare Tunnel..."
sudo pkill -9 cloudflared
sleep 3
nohup cloudflared tunnel run corrigeai-tunnel > ~/tunnel.log 2>&1 &
sleep 10

echo ""
echo "✅ CorrigeAI iniciado com sucesso!"
echo "🌐 Site: https://corrigeai.online"
echo "⚙️ API:  https://api.corrigeai.online"
sudo docker ps
