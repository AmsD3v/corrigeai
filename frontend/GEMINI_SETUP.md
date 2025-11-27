# 📝 CorrigeAI - Guia de Configuração da API do Google Gemini

Este guia explica como configurar a integração com o Google Gemini API para geração de temas de redação.

## 🔑 Obtendo sua API Key

1. **Acesse o Google AI Studio:**
   - Visite: https://makersuite.google.com/app/apikey
   - Ou: https://aistudio.google.com/app/apikey

2. **Faça login com sua conta Google**

3. **Crie uma nova API Key:**
   - Clique em "Create API Key"
   - Escolha um projeto existente ou crie um novo
   - Copie a API Key gerada

## ⚙️ Configurando no Projeto

1. **Crie o arquivo `.env` na pasta `frontend/`:**
   ```bash
   cd frontend
   cp .env.example .env
   ```

2. **Edite o arquivo `.env` e adicione sua API Key:**
   ```env
   VITE_GEMINI_API_KEY=sua_api_key_aqui
   VITE_API_BASE_URL=http://localhost:3000/api
   ```

3. **Reinicie o servidor de desenvolvimento:**
   ```bash
   npm run dev
   ```

## ✅ Testando a Integração

1. Acesse `/painel/redigir-redacao`
2. Selecione uma categoria de tema
3. Clique em "✨ Gerar Tema com IA"
4. Se configurado corretamente, um tema será gerado pela IA do Gemini

## ⚠️ Tratamento de Erros

- **Se a API Key não estiver configurada:** O sistema usa temas pré-definidos como fallback
- **Se houver erro na API:** Uma mensagem de aviso é exibida e um tema sugerido é usado
- **Logs de erro:** Verifique o console do navegador para detalhes

## 💰 Limites e Custos

- **Tier Gratuito:** 60 requisições por minuto
- **Custo:** Verifique os preços atuais em https://ai.google.dev/pricing
- **Recomendação:** Use o tier gratuito para desenvolvimento e testes

## 🔒 Segurança

- **NUNCA** commite o arquivo `.env` no Git
- O arquivo `.env` já está no `.gitignore`
- Mantenha sua API Key privada
- Rotacione a API Key periodicamente

## 📚 Documentação Oficial

- Google Gemini API: https://ai.google.dev/docs
- Guia de início rápido: https://ai.google.dev/tutorials/get_started_web

## 🐛 Problemas Comuns

### Erro: "API Key inválida"
- Verifique se copiou a API Key corretamente
- Confirme que a API Key está ativa no Google AI Studio

### Erro: "Quota exceeded"
- Você excedeu o limite de requisições gratuitas
- Aguarde alguns minutos ou upgrade para um plano pago

### Tema não é gerado
- Abra o console do navegador (F12)
- Verifique se há erros relacionados à API
- Confirme que o arquivo `.env` está na pasta correta

## 🚀 Próximos Passos

Após configurar a API do Gemini para geração de temas, você pode:
- Implementar a correção completa de redações com IA
- Adicionar mais categorias de temas
- Personalizar os prompts para gerar temas mais específicos
