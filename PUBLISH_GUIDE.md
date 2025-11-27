# 📤 Script de Publicação para GitHub

## Como usar:

### Windows:
```cmd
publish.bat "sua mensagem de commit aqui"
```

### Exemplos:
```cmd
# Correção de bugs
publish.bat "fix: Corrige erro no login"

# Nova feature
publish.bat "feat: Adiciona painel de relatórios"

# Atualização de docs
publish.bat "docs: Atualiza README"
```

## O que o script faz:

1. ✅ Mostra status dos arquivos
2. ✅ Adiciona todos os arquivos (`git add .`)
3. ✅ Cria commit com sua mensagem
4. ✅ Faz push para `origin main`
5. ✅ Mostra confirmação

## ⚠️ Importante:

- Use mensagens claras e descritivas
- Prefixos recomendados:
  - `feat:` - Nova funcionalidade
  - `fix:` - Correção de bug
  - `docs:` - Documentação
  - `refactor:` - Refatoração de código
  - `style:` - Formatação, espaços
  - `test:` - Testes

## 🔒 Segurança:

O token do GitHub já está configurado, você não precisa digitar senha!
