Write-Host "Iniciando o projeto ProsaAI com Docker..." -ForegroundColor Green
Write-Host ""

Write-Host "ATENCAO: Certifique-se de que o Docker Desktop esta rodando antes de continuar!" -ForegroundColor Yellow
Write-Host ""
Read-Host "Pressione ENTER para continuar..."

# Verifica se o Docker esta rodando
try {
    docker ps > $null
    if ($LASTEXITCODE -ne 0) {
        throw "Docker nao esta rodando"
    }
} catch {
    Write-Host "ERRO: O Docker nao esta rodando. Por favor, inicie o Docker Desktop." -ForegroundColor Red
    Read-Host "Pressione ENTER para sair..."
    exit 1
}

Write-Host "Iniciando os servicos com Docker Compose..." -ForegroundColor Green
docker-compose up --build -d

Write-Host ""
Write-Host "Servicos iniciados com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "Acesse a aplicacao atraves dos seguintes endpoints:" -ForegroundColor Cyan
Write-Host "  - Frontend: http://localhost" -ForegroundColor Cyan
Write-Host "  - Backend API: http://localhost:8000" -ForegroundColor Cyan
Write-Host "  - Documentacao da API: http://localhost:8000/docs" -ForegroundColor Cyan
Write-Host "  - Servico de Correcao: http://localhost:8002" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para ver os logs dos containers, execute: docker-compose logs -f" -ForegroundColor Cyan
Write-Host "Para parar os servicos, execute: docker-compose down" -ForegroundColor Cyan
Write-Host ""

Read-Host "Pressione ENTER para sair..."