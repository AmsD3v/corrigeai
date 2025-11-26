@echo off
echo Iniciando o projeto ProsaAI com Docker...
echo.
echo ATENCAO: Certifique-se de que o Docker Desktop esta rodando antes de continuar!
echo.
pause

REM Verifica se o Docker esta rodando
docker ps > nul 2>&1
if %errorlevel% neq 0 (
    echo ERRO: O Docker nao esta rodando. Por favor, inicie o Docker Desktop.
    pause
    exit /b 1
)

echo Iniciando os servicos com Docker Compose...
docker-compose up --build -d

echo.
echo Servicos iniciados com sucesso!
echo.
echo Acesse a aplicacao atraves dos seguintes endpoints:
echo.  - Frontend: http://localhost
echo.  - Backend API: http://localhost:8000
echo.  - Documentacao da API: http://localhost:8000/docs
echo.  - Servico de Correcao: http://localhost:8002
echo.
echo Para ver os logs dos containers, execute: docker-compose logs -f
echo Para parar os servicos, execute: docker-compose down
echo.

pause