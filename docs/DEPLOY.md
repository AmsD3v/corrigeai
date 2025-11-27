# 🚀 Guia de Deploy - Atualizar Servidor de Produção

## ✅ Código já está no GitHub!

O código foi enviado com sucesso para o repositório. Agora você pode atualizar o servidor.

---

## 📋 Passos para Atualizar o Servidor

### 1️⃣ Conectar ao Servidor
```bash
# SSH para o servidor (seu notebook)
ssh usuario@seu-servidor
```

### 2️⃣ Navegar para o Diretório do Projeto
```bash
cd /caminho/para/corrigeai
```

### 3️⃣ Fazer Pull das Alterações
```bash
git pull origin main
```

### 4️⃣ Atualizar Backend

```bash
cd backend

# Instalar/atualizar dependências (se houver novas)
pip install -r requirements.txt

# Executar migração do banco de dados
python src/migrate_settings.py

# Reiniciar o serviço backend
sudo systemctl restart corrigeai-backend
# OU se estiver usando PM2:
# pm2 restart corrigeai-backend
```

### 5️⃣ Atualizar Frontend

```bash
cd ../frontend

# Instalar/atualizar dependências (se houver novas)
npm install

# Buildar para produção
npm run build

# O build vai para a pasta `dist/`
# Copiar para a pasta servida pelo nginx/apache (se necessário)
# sudo cp -r dist/* /var/www/corrigeai/
```

### 6️⃣ Reiniciar Nginx (se aplicável)
```bash
sudo systemctl restart nginx
```

---

## ⚙️ Configurações Importantes

### Variáveis de Ambiente

**Backend (`backend/.env`):**
- Já está configurado para produção
- Verifique se as API keys estão corretas:
  - `GEMINI_API_KEY`
  - `GROQ_API_KEY`
  - `SECRET_KEY`
  - `DATABASE_URL`
  - `CORS_ORIGINS` (deve incluir seu domínio de produção)

**Frontend:**
- As URLs já estão configuradas corretamente em `.env`:
  - `VITE_API_BASE_URL=https://api.corrigeai.online`
  - `VITE_APP_BASE_URL=https://corrigeai.online`

---

## 🔧 Novas Funcionalidades Neste Deploy

### ✅ Painel de Configurações Admin
- Admin pode alterar provedor de IA (Gemini/Groq)
- Admin pode atualizar API keys pelo painel
- Acesse: `/admin/configuracoes`

### ✅ Edição de Usuários
- Admin pode editar nome, email e créditos dos usuários
- Acesse: `/admin/usuarios`

### ✅ Correções de Bugs
- Corrigido erro "NoneType object is not callable"
- Correção de redações agora funciona corretamente
- Fallback automático entre provedores de IA

---

## 🧪 Testes Pós-Deploy

Após atualizar, teste:

1. **Login/Logout** - Verificar autenticação
2. **Submissão de Redação** - Testar correção com IA
3. **Painel Admin** - Configurações e edição de usuários
4. **Compra de Créditos** - Testar integração Mercado Pago

---

## 🆘 Troubleshooting

### Backend não inicia?
```bash
# Ver logs do serviço
sudo journalctl -u corrigeai-backend -f

# OU se usando PM2:
pm2 logs corrigeai-backend
```

### Frontend com erro 404?
- Verifique se o build foi copiado para a pasta correta do nginx
- Verifique configuração do nginx: `sudo nginx -t`

### Correção retorna nota zero?
1. Vá em `/admin/configuracoes`
2. Selecione o provedor (Gemini recomendado)
3. Insira a API Key
4. Clique em "Salvar"
5. Teste uma nova redação

---

## 📞 Suporte

Se algo não funcionar, verifique:
- Logs do backend
- Logs do nginx
- Console do navegador (F12)

**Commit aplicado:** `d6f79ca`  
**Arquivos alterados:** 23 arquivos (34 adições)
