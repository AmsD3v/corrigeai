# 🐍 Configuração do Ambiente Virtual Python

## Por que usar ambiente virtual?

✅ **Isolamento** - Cada projeto tem suas próprias dependências  
✅ **Sem conflitos** - Versões diferentes de pacotes para projetos diferentes  
✅ **Reprodutível** - Fácil recriar o mesmo ambiente em outro servidor  
✅ **Seguro** - Não polui o Python global do sistema  

---

## 🚀 Setup Inicial no Servidor (Uma vez apenas)

**Execute estes comandos no servidor:**

```bash
# 1. Ir para o projeto
cd ~/corrigeai

# 2. Criar ambiente virtual
python3 -m venv venv

# 3. Ativar
source venv/bin/activate

# 4. Instalar dependências do projeto
pip install -r backend/requirements.txt

# 5. Verificar instalação
which python3  # Deve mostrar: ~/corrigeai/venv/bin/python3
pip list       # Mostrar pacotes instalados
```

---

## 🔄 Atualizar PM2 para usar o venv

**Parar e recriar os processos PM2:**

```bash
# 1. Parar processo atual
pm2 stop corrigeai-backend
pm2 delete corrigeai-backend

# 2. Iniciar com Python do venv
cd ~/corrigeai/backend
pm2 start run.py --name corrigeai-backend --interpreter ~/corrigeai/venv/bin/python3

# 3. Salvar configuração
pm2 save

# 4. Verificar
pm2 status
pm2 logs corrigeai-backend --lines 20
```

---

## 📝 Comandos Úteis

### Ativar venv manualmente:
```bash
cd ~/corrigeai
source venv/bin/activate
```

### Desativar venv:
```bash
deactivate
```

### Adicionar novo pacote:
```bash
source venv/bin/activate
pip install nome-do-pacote
pip freeze > backend/requirements.txt  # Atualizar lista
```

### Recriar venv do zero:
```bash
rm -rf venv
python3 -m venv venv
source venv/bin/activate
pip install -r backend/requirements.txt
```

---

## ✅ O deploy.sh agora:

1. ✅ Cria o venv automaticamente se não existir
2. ✅ Ativa o venv antes de instalar dependências
3. ✅ Configura PM2 para usar `venv/bin/python3`
4. ✅ Isola completamente o projeto

---

## 🆘 Troubleshooting

### Erro: "venv not found"
```bash
cd ~/corrigeai
python3 -m venv venv
```

### Ver qual Python está sendo usado:
```bash
pm2 show corrigeai-backend | grep interpreter
```

### Reinstalar tudo:
```bash
source venv/bin/activate
pip install --force-reinstall -r backend/requirements.txt
```

---

**✅ Após configurar, o `./deploy.sh` vai cuidar de tudo automaticamente!**
