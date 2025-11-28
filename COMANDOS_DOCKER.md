# 🚀 Comandos Docker - CorrigeAI

## Iniciar/Parar/Reiniciar
```bash
sudo docker-compose up -d              # Iniciar tudo
sudo docker-compose down               # Parar tudo
sudo docker-compose restart            # Reiniciar tudo
```

## Deploy (Atualizar do GitHub)
```bash
cd ~/corrigeai
git pull origin main
sudo docker-compose up -d --build
```

## Ver Status e Logs
```bash
sudo docker ps                         # Ver containers rodando
sudo docker-compose logs -f            # Ver logs em tempo real
sudo docker logs prosaai_backend       # Logs só do backend
```

## Rollback (Voltar Versão Anterior)
```bash
# 1. Ver últimos commits
git log --oneline -10

# 2. Voltar para commit específico (ex: 58055cc)
git checkout 58055cc
sudo docker-compose up -d --build

# 3. Voltar para versão atual (desfazer rollback)
git checkout main
sudo docker-compose up -d --build
```

## Backup e Restore do Banco
```bash
# Backup
sudo docker exec prosaai_db pg_dump -U user prosaai > backup_$(date +%Y%m%d).sql

# Restore
cat backup_20251128.sql | sudo docker exec -i prosaai_db psql -U user -d prosaai
```

## Criar Usuário Admin
```bash
curl -X POST http://localhost:8000/users/ \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@corrigeai.online","password":"Admin@123!","full_name":"Administrador"}'

sudo docker exec prosaai_db psql -U user -d prosaai -c "UPDATE \"user\" SET is_admin = true WHERE email = 'admin@corrigeai.online';"
```

## Solução de Problemas
```bash
# Container crashando?
sudo docker logs prosaai_backend --tail=100
sudo docker-compose restart backend

# Rebuild completo (se mudou dependências)
sudo docker-compose down
sudo docker-compose build --no-cache
sudo docker-compose up -d

# Limpar tudo e recriar (⚠️ DELETA BANCO)
sudo docker-compose down -v
sudo docker-compose up -d --build
```

## Editar Variáveis de Ambiente
```bash
nano ~/corrigeai/.env
sudo docker-compose restart
```

## Auto-Start (já configurado)
```bash
# Ver status
sudo systemctl status corrigeai.service
sudo systemctl status cloudflare-tunnel.service

# Restart
sudo systemctl restart corrigeai.service
sudo systemctl restart cloudflare-tunnel.service
```

---

**Site:** https://corrigeai.online  
**API:** https://api.corrigeai.online  
**Swagger:** https://api.corrigeai.online/docs
