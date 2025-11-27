@echo off
REM Script para enviar alterações para o GitHub - Windows
REM Uso: publish.bat "mensagem do commit"

echo.
echo ========================================
echo   Enviando para GitHub - CorrigeAI
echo ========================================
echo.

REM Verificar se foi passada uma mensagem
if "%~1"=="" (
    echo ERRO: Precisa passar uma mensagem de commit
    echo Uso: publish.bat "sua mensagem aqui"
    exit /b 1
)

REM Status atual
echo [1/5] Verificando status...
git status --short

echo.
echo [2/5] Adicionando arquivos...
git add .

echo.
echo [3/5] Criando commit...
git commit -m "%~1"

if errorlevel 1 (
    echo.
    echo Nenhuma alteracao para commitar ou erro no commit
    exit /b 1
)

echo.
echo [4/5] Enviando para GitHub...
git push origin main

if errorlevel 1 (
    echo.
    echo ERRO ao fazer push!
    exit /b 1
)

echo.
echo ========================================
echo   Push concluido com sucesso!
echo ========================================
echo.

REM Mostrar último commit
git log --oneline -1

echo.
pause
