# ProsaAI

Plataforma SaaS para correção de redações com Inteligência Artificial.

## Tecnologias Utilizadas
- **Frontend:** React com TypeScript
- **Backend:** FastAPI com Python
- **Serviço de Correção:** Python (com bibliotecas de NLP gratuitas)
- **Banco de Dados:** PostgreSQL
- **Orquestração:** Docker e Docker Compose

## Funcionalidades

- **Autenticação de usuários com JWT**: Sistema completo com tokens de acesso e refresh, cookies seguros e proteção de rotas
- **Registro e login de usuários**: Funcionalidades implementadas e testadas com sucesso
- **Submissão de redações para correção**: Sistema operacional com integração ao serviço de correção
- **Sistema de créditos para controle de uso**: Implementado e funcionando para restringir o uso da plataforma
- **Correção de redações com feedback**: Serviço de correção ativo com mock de feedback e pontuação

## Setup do Ambiente

### Pré-requisitos
- Docker Desktop (https://www.docker.com/products/docker-desktop/)
- Git (opcional se já tiver o código)

### Execução com Docker (Recomendado)
1. Certifique-se de que o Docker Desktop está em execução
2. Clone o repositório
3. O arquivo \.env\ já está configurado na raiz do projeto
4. Execute um dos seguintes comandos:

#### Opção 1: Usando script (Windows)
- Execute `start_project.bat` ou `start_project.ps1`

#### Opção 2: Manualmente
```bash
docker-compose up --build -d
```

Os serviços estarão disponíveis em:
- **Frontend:** http://localhost
- **Backend API:** http://localhost:8000
- **Documentação da API:** http://localhost:8000/docs

### Execução sem Docker (Desenvolvimento)
1. Siga as instruções individuais para cada serviço (backend, frontend, correction-service)
2. Configure o banco de dados PostgreSQL localmente

## Estrutura do Projeto
\\\
/
├── .env
├── .env.example
├── README.md
├── DOCKER_SETUP.md
├── start_project.bat
├── start_project.ps1
├── docker-compose.yml
├── frontend/
├── backend/
├── services/
│   └── correction-service/
├── database/
├── docs/
└── scripts/
\\\

