# 🚀 Guia de Deploy - CorrigeAI na DigitalOcean

## ⚠️ Alerta sobre Recursos

| Configuração Escolhida | Recomendação |
|----------------------|--------------|
| $4/mês (512 MB RAM) | **Apertado** - Docker + PostgreSQL + Backend + Frontend |
| **Recomendado mínimo** | $6/mês (1 GB RAM) ou $12/mês (2 GB RAM) |

> [!WARNING]
> Com 512 MB, o servidor pode ficar lento ou travar durante correções de IA. Considere o plano de $6/mês (1 GB RAM).

---

## 📋 Pré-requisitos

- [x] Domínio: `corrigeai.online`
- [ ] Conta na DigitalOcean
- [ ] Droplet criado (Ubuntu 22.04)
- [ ] SSH configurado

---

## 1️⃣ Criar Droplet na DigitalOcean

1. Acesse [cloud.digitalocean.com](https://cloud.digitalocean.com)
2. Clique em **Create → Droplets**
3. Configure:
   - **Image**: Ubuntu 22.04 LTS
   - **Plan**: Regular SSD, **$6/mo (1 GB)** ou superior
   - **Region**: NYC1 ou mais próximo do Brasil (SF ou NYC)
   - **Authentication**: SSH Key (recomendado) ou Password
4. Clique em **Create Droplet**
5. Anote o **IP do servidor** (ex: `64.23.xxx.xxx`)

---

## 2️⃣ Configurar DNS do Domínio

No seu registrador de domínio (onde registrou `corrigeai.online`):

| Tipo | Nome | Valor |
|------|------|-------|
| A | @ | `IP_DO_DROPLET` |
| A | www | `IP_DO_DROPLET` |
| A | api | `IP_DO_DROPLET` |

> Aguarde 5-30 minutos para propagação DNS.

---

## 3️⃣ Conectar ao Servidor via SSH

```bash
ssh root@IP_DO_DROPLET
# ou
ssh root@corrigeai.online
```

---

## 4️⃣ Instalar Docker no Servidor

Execute no servidor:

```bash
# Atualizar sistema
apt update && apt upgrade -y

# Instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Instalar Docker Compose
apt install docker-compose-plugin -y

# Verificar instalação
docker --version
docker compose version
```

---

## 5️⃣ Clonar Projeto no Servidor

```bash
# Criar diretório
mkdir -p /opt/corrigeai
cd /opt/corrigeai

# Se usar Git (recomendado)
git clone https://github.com/SEU_USUARIO/corrigeai.git .

# OU copiar arquivos via SCP (do seu PC local)
# No Windows PowerShell local:
# scp -r f:\corrigeai\* root@IP_DO_DROPLET:/opt/corrigeai/
```

---

## 6️⃣ Configurar Variáveis de Ambiente

### Backend (.env)

```bash
cd /opt/corrigeai/backend
nano .env
```

Conteúdo:
```env
# Database
DATABASE_URL=postgresql://user:password@db:5432/prosaai
POSTGRES_USER=user
POSTGRES_PASSWORD=SUA_SENHA_FORTE_AQUI
POSTGRES_DB=prosaai

# Security
SECRET_KEY=SUA_CHAVE_SECRETA_32_CARACTERES
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30

# AI APIs
GEMINI_API_KEY=sua_chave_gemini
GROQ_API_KEY=sua_chave_groq

# URLs
FRONTEND_URL=https://corrigeai.online
```

### Frontend (.env)

```bash
cd /opt/corrigeai/frontend
nano .env
```

Conteúdo:
```env
VITE_API_URL=https://corrigeai.online/api
```

---

## 7️⃣ Configurar docker-compose.prod.yml

Criar arquivo de produção:

```bash
cd /opt/corrigeai
nano docker-compose.prod.yml
```

Conteúdo:
```yaml
version: '3.8'

services:
  db:
    image: postgres:15-alpine
    container_name: prosaai_db
    environment:
      POSTGRES_USER: ${POSTGRES_USER:-user}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD:-password}
      POSTGRES_DB: ${POSTGRES_DB:-prosaai}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER:-user}"]
      interval: 5s
      timeout: 5s
      retries: 5
    restart: always

  backend:
    build: ./backend
    container_name: prosaai_backend
    env_file:
      - ./backend/.env
    depends_on:
      db:
        condition: service_healthy
    restart: always

  frontend:
    build: ./frontend
    container_name: prosaai_frontend
    depends_on:
      - backend
    restart: always

  nginx:
    image: nginx:alpine
    container_name: prosaai_nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./certbot/conf:/etc/letsencrypt:ro
      - ./certbot/www:/var/www/certbot:ro
    depends_on:
      - frontend
      - backend
    restart: always

  certbot:
    image: certbot/certbot
    container_name: prosaai_certbot
    volumes:
      - ./certbot/conf:/etc/letsencrypt
      - ./certbot/www:/var/www/certbot
    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"

volumes:
  postgres_data:
```

---

## 8️⃣ Configurar NGINX para HTTPS

```bash
nano /opt/corrigeai/nginx.conf
```

Conteúdo:
```nginx
events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    # Gzip
    gzip on;
    gzip_types text/plain application/json application/javascript text/css;

    server {
        listen 80;
        server_name corrigeai.online www.corrigeai.online;
        
        location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }
        
        location / {
            return 301 https://$host$request_uri;
        }
    }

    server {
        listen 443 ssl http2;
        server_name corrigeai.online www.corrigeai.online;
        
        ssl_certificate /etc/letsencrypt/live/corrigeai.online/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/corrigeai.online/privkey.pem;
        
        # Frontend
        location / {
            proxy_pass http://frontend:80;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }
        
        # API Backend
        location /api/ {
            proxy_pass http://backend:8000/;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_read_timeout 120s;
        }
    }
}
```

---

## 9️⃣ Obter Certificado SSL (HTTPS)

```bash
cd /opt/corrigeai

# Criar diretórios
mkdir -p certbot/conf certbot/www

# Primeiro, subir nginx temporário para validação
docker compose -f docker-compose.prod.yml up -d nginx

# Obter certificado
docker run --rm \
  -v /opt/corrigeai/certbot/conf:/etc/letsencrypt \
  -v /opt/corrigeai/certbot/www:/var/www/certbot \
  certbot/certbot certonly --webroot \
  -w /var/www/certbot \
  -d corrigeai.online -d www.corrigeai.online \
  --email seu@email.com \
  --agree-tos --no-eff-email
```

---

## 🔟 Migrar Banco de Dados Local

### No seu PC LOCAL (Windows):

```powershell
# Exportar banco
docker exec prosaai_db pg_dump -U user prosaai > backup_local.sql

# Copiar para servidor
scp backup_local.sql root@IP_DO_DROPLET:/opt/corrigeai/
```

### No SERVIDOR:

```bash
cd /opt/corrigeai

# Subir apenas o banco
docker compose -f docker-compose.prod.yml up -d db

# Aguardar inicializar
sleep 10

# Importar backup
docker exec -i prosaai_db psql -U user -d prosaai < backup_local.sql
```

---

## 1️⃣1️⃣ Iniciar Todos os Serviços

```bash
cd /opt/corrigeai

# Build e start
docker compose -f docker-compose.prod.yml up -d --build

# Verificar status
docker compose -f docker-compose.prod.yml ps

# Ver logs
docker compose -f docker-compose.prod.yml logs -f
```

---

## ✅ Verificação Final

1. Acesse `https://corrigeai.online`
2. Teste o login
3. Teste criar uma redação e corrigir
4. Teste o chat do Professor AI

---

## 🔧 Comandos Úteis

```bash
# Ver logs de um serviço
docker compose -f docker-compose.prod.yml logs -f backend

# Reiniciar serviço
docker compose -f docker-compose.prod.yml restart backend

# Parar tudo
docker compose -f docker-compose.prod.yml down

# Atualizar (após git pull)
docker compose -f docker-compose.prod.yml up -d --build
```

---

## 📝 Checklist Final

- [ ] Droplet criado na DigitalOcean
- [ ] DNS configurado (A records)
- [ ] Docker instalado no servidor
- [ ] Código clonado/copiado
- [ ] Variáveis de ambiente configuradas
- [ ] Banco de dados migrado
- [ ] Certificado SSL obtido
- [ ] Serviços rodando
- [ ] Site acessível via HTTPS
