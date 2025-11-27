# Configuração do Mercado Pago - Instruções para o Servidor

## 📋 Pré-requisitos

- Servidor com acesso SSH
- Backend já deployado em `~/corrigeai/backend`
- Python venv ativo

## 🔐 Step 1: Configurar Credenciais no Servidor

**NO SERVIDOR, execute:**

```bash
cd ~/corrigeai/backend
nano .env
```

**Adicione estas linhas ao final do arquivo:**

```bash
# Mercado Pago API
MP_PUBLIC_KEY=APP_USR-045f36e3-ef88-4c34-9972-c193bfd1fd4c
MP_ACCESS_TOKEN=APP_USR-5824620292625235-112303-dc5b1b0b77251b2362cc6fa19315bfd2-2953317711

# URLs da aplicação
FRONTEND_URL=https://corrigeai.online
BACKEND_URL=https://api.corrigeai.online
```

Salve: `Ctrl+X` → `Y` → `Enter`

## 📦 Step 2: Criar Pacotes no Banco de Dados

```bash
cd ~/corrigeai/backend
source ~/corrigeai/venv/bin/activate

# Executar script (criar pacotes)
python create_packages.py
```

**Saída esperada:**
```
✅ Pacotes criados com sucesso!

📦 Pacotes disponíveis:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Starter      |  10 créditos +  2 bônus | R$ 19.90
2. Popular      |  30 créditos + 10 bônus | R$ 49.90 (17% OFF!)
3. Pro          | 100 créditos + 50 bônus | R$ 149.90 (25% OFF!)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 🔄 Step 3: Restart Backend

```bash
pm2 restart corrigeai-backend

# Verificar logs
pm2 logs corrigeai-backend --lines 20 --nostream
```

## ✅ Step 4: Verificar no Browser

1. Acesse: **https://corrigeai.online/painel/comprar-creditos**
2. Os 3 cards devem aparecer com preços e features
3. Teste o botão "Comprar Agora" - deve redirecionar ao Mercado Pago

## 🐛 Troubleshooting

**Se os cards não aparecerem:**

```bash
# Verificar se pacotes existem
source ~/corrigeai/venv/bin/activate
python -c "from src.database import SessionLocal, init_db_engine; from src.models import Package; init_db_engine(); db = SessionLocal(); print(f'Pacotes: {db.query(Package).count()}'); db.close()"
```

**Se der erro de autenticação MP:**

```bash
# Verificar .env
grep MP_ ~/corrigeai/backend/.env

# Deve mostrar:
# MP_PUBLIC_KEY=APP_USR-045f36e3...
# MP_ACCESS_TOKEN=APP_USR-5824620292625235...
```

## 📚 Informações dos Pacotes

| Pacote  | Créditos | Bônus | Preço    | Desconto |
|---------|----------|-------|----------|----------|
| Starter | 10       | 2     | R$ 19.90 | -        |
| Popular | 30       | 10    | R$ 49.90 | 17% OFF  |
| Pro     | 100      | 50    | R$ 149.90| 25% OFF  |

## 🔗 Webhooks

O webhook do Mercado Pago está configurado para:
```
https://api.corrigeai.online/api/payment/webhook
```

Isso permite que o sistema atualize o saldo automaticamente após o pagamento.
