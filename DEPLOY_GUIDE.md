# 🚀 Como Usar o Script de Deploy

## No Servidor (primeira vez)

### 1. Dar permissão de execução ao script:
```bash
chmod +x deploy.sh
```

### 2. Executar o deploy:
```bash
./deploy.sh
```

---

## O que o script faz automaticamente:

1. ✅ Faz `git pull` do GitHub
2. ✅ Para o Backend (systemd/PM2/processo)
3. ✅ Para o Frontend (se aplicável)
4. ✅ Atualiza dependências do Backend (`pip install`)
5. ✅ Executa migração do banco de dados
6. ✅ Atualiza dependências do Frontend (`npm install`)
7. ✅ Faz build do Frontend (`npm run build`)
8. ✅ Copia build para `/var/www/corrigeai/`
9. ✅ Inicia o Backend
10. ✅ Recarrega o Nginx

---

## Compatibilidade

O script detecta automaticamente como os serviços estão rodando:
- **systemd** (recomendado para produção)
- **PM2** (gerenciador de processos Node)
- **Processo direto** (fallback)

---

## Após executar

Você verá um resumo como:

```
✅ Deploy concluído com sucesso!

📊 Status dos serviços:
----------------------
Backend: ✅ Rodando (systemd)
Nginx: ✅ Rodando

🌐 Acesse: https://corrigeai.online
```

---

## Troubleshooting

### Erro de permissão?
```bash
sudo ./deploy.sh
```

### Ver logs do backend:
```bash
# systemd
sudo journalctl -u corrigeai-backend -f

# PM2
pm2 logs corrigeai-backend

# Arquivo de log
tail -f logs/backend.log
```

### Nginx não recarrega?
```bash
# Testar configuração
sudo nginx -t

# Reiniciar manualmente
sudo systemctl restart nginx
```

---

## ⚡ Deploy Rápido (apenas pull e restart)

Se você só quer atualizar sem rebuild:

```bash
git pull origin main
sudo systemctl restart corrigeai-backend
sudo systemctl reload nginx
```

---

**Arquivo do script:** `deploy.sh`  
**Última atualização:** 2025-11-27
