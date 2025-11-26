# ProsaAI - Instruções para Execução com Docker no Windows

## Requisitos

Antes de executar o projeto, é necessário ter instalado:

1. **Docker Desktop** para Windows (https://www.docker.com/products/docker-desktop/)
2. **Git** para clonar o repositório (opcional se já tiver o código)

## Configuração Inicial

### 1. Preparação do ambiente

1. Certifique-se de que o Docker Desktop está instalado e em execução
2. Verifique se o WSL 2 está habilitado (recomendado para melhor performance)

### 2. Variáveis de ambiente

O arquivo `.env` já foi configurado na raiz do projeto com as variáveis necessárias:

```
# Variáveis de ambiente para o ProsaAI

# Backend
DATABASE_URL=postgresql://user:password@db:5432/prosaai

# Configurações JWT
SECRET_KEY=prosaai_secret_key_for_dev_purpose_only_change_in_production
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

# URLs
CORS_ORIGINS=http://frontend:80,http://localhost:5173,http://localhost:3000
CORRECTION_SERVICE_URL=http://correction_service:8002

# Google OAuth (opcional para desenvolvimento)
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=

# Correction Service (IA)
CORRECTION_SERVICE_API_KEY=
```

## Execução do Projeto

### Opção 1: Usando os scripts fornecidos

No Windows, você pode usar um dos seguintes scripts:

1. **start_project.bat** - Script batch tradicional
2. **start_project.ps1** - Script PowerShell

Execute um deles como administrador:

```bash
# Para executar o script batch
start_project.bat

# Para executar o script PowerShell
powershell -ExecutionPolicy Bypass -File start_project.ps1
```

### Opção 2: Execução manual

1. Abra o PowerShell ou Prompt de Comando na pasta raiz do projeto
2. Certifique-se de que o Docker Desktop está em execução
3. Execute o comando:

```bash
docker-compose up --build -d
```

Este comando irá:

- Construir as imagens Docker para cada serviço
- Iniciar os contêineres:
  - Banco de dados PostgreSQL
  - Backend FastAPI
  - Frontend React
  - Serviço de correção de redações

## Estrutura dos Serviços

O projeto é composto por 4 serviços principais:

### 1. Banco de Dados (db)
- PostgreSQL 16
- Porta externa: 5433 (interna: 5432)
- Dados persistentes com volume `db_data`

### 2. Backend (backend)
- FastAPI em Python
- Porta: 8000
- Conecta-se ao banco de dados e fornece a API

### 3. Frontend (frontend)
- React/TypeScript
- Porta: 80 (disponível em http://localhost)
- Interface de usuário para o sistema

### 4. Serviço de Correção (correction_service)
- FastAPI em Python com spaCy para NLP
- Porta: 8002
- Processa redações e fornece feedback

## Endpoints Importantes

- **Frontend**: http://localhost
- **Backend API**: http://localhost:8000
- **Backend Documentação**: http://localhost:8000/docs
- **Health Check**: http://localhost:8000/health
- **Serviço de Correção**: http://localhost:8002

## Verificação de Status

Para verificar se os serviços estão rodando:

```bash
docker-compose ps
```

Para ver os logs de todos os serviços:

```bash
docker-compose logs -f
```

Para ver os logs de um serviço específico:

```bash
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f db
docker-compose logs -f correction_service
```

## Parando os Serviços

Para parar todos os serviços:

```bash
docker-compose down
```

## Solução de Problemas

### Erro: "Docker Desktop is not running"
- Certifique-se de que o Docker Desktop está instalado e em execução
- Reinicie o Docker Desktop se necessário

### Erro: "Port already in use"
- Verifique se não há outros serviços rodando nas portas 80, 8000 ou 8002
- Execute `docker-compose down` para parar serviços anteriores

### Erro: "CORS policy" ou "Access-Control-Allow-Origin"
- Esse erro ocorre quando o frontend tenta acessar o backend de um domínio diferente
- O backend já está configurado para permitir requisições de http://localhost
- Verifique se você está acessando o frontend via http://localhost (não via IP ou porta diferente)

### Erro: "Could not open compose project" ou erro de sintaxe no docker-compose.yml
- Verifique a sintaxe do arquivo docker-compose.yml
- Certifique-se de que todos os campos de environment estão formatados corretamente (com dois pontos após o nome da variável)
- Exemplo de formato correto:
```
environment:
  DATABASE_URL: postgresql://user:password@db:5432/prosaai
  SECRET_KEY: ${SECRET_KEY:-default_value}
```

### Primeira execução demorada
- Na primeira execução, o Docker precisa baixar e construir todas as imagens
- Isso pode levar alguns minutos dependendo da conexão com a internet

### Erro de conexão com o banco de dados
- O sistema implementa retry automático na conexão com o banco de dados
- Aguarde alguns segundos após iniciar os containers para que todos os serviços estejam prontos

## Desenvolvimento com Hot Reload

O projeto está configurado para desenvolvimento com hot reload:

- Modificações no código do backend serão refletidas automaticamente
- Modificações no código do frontend serão refletidas automaticamente
- O serviço de correção também atualiza com alterações

## Segurança

- JWT tokens com refresh tokens
- Senhas armazenadas com bcrypt
- CORS configurado para segurança
- Uso de cookies seguros para refresh tokens

## Funcionalidades Implementadas

O projeto ProsaAI inclui as seguintes funcionalidades completas:

- **Autenticação de usuários com JWT**: Sistema completo com tokens de acesso e refresh, cookies seguros e proteção de rotas
- **Registro e login de usuários**: Funcionalidades implementadas e testadas com sucesso
- **Submissão de redações para correção**: Sistema operacional com integração ao serviço de correção
- **Sistema de créditos para controle de uso**: Implementado e funcionando para restringir o uso da plataforma
- **Correção de redações com feedback**: Serviço de correção ativo com mock de feedback e pontuação

## Problemas Conhecidos e Soluções

### Erro no frontend ao lidar com erros de validação (código 422)
- **Descrição**: O frontend React pode apresentar erros javascript quando dados inválidos são enviados para o backend
- **Causa**: O React está falhando ao lidar corretamente com as respostas de erro de validação do Pydantic (status 422)
- **Solução**: O backend está funcionando corretamente e retornando as mensagens de validação apropriadas - o problema está no tratamento dessas respostas no frontend
- **Status**: Backend completamente funcional, problema de tratamento de erros no frontend

Quando ocorrerem erros de validação 422 no frontend, o backend continua funcionando corretamente como demonstrado por testes diretos via curl.