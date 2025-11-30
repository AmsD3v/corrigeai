@echo off
chcp 65001 >nul
color 0A
cls

echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo    🚀 CorrigeAI - Enviar Arquivos para GitHub
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.

REM Verificar se há mudanças
echo 📊 Verificando mudanças...
git status --short
echo.

REM Perguntar tipo de commit
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo 📝 Tipo de Commit:
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
echo   1. feat     - Nova funcionalidade
echo   2. fix      - Correção de bug
echo   3. docs     - Documentação
echo   4. style    - Estilo/formatação
echo   5. refactor - Refatoração
echo   6. test     - Testes
echo   7. chore    - Manutenção
echo.
set /p tipo="Escolha o tipo (1-7): "

if "%tipo%"=="1" set tipo_commit=feat
if "%tipo%"=="2" set tipo_commit=fix
if "%tipo%"=="3" set tipo_commit=docs
if "%tipo%"=="4" set tipo_commit=style
if "%tipo%"=="5" set tipo_commit=refactor
if "%tipo%"=="6" set tipo_commit=test
if "%tipo%"=="7" set tipo_commit=chore

if not defined tipo_commit (
    echo ❌ Tipo inválido!
    pause
    exit /b 1
)

echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo 📝 Descrição das Alterações:
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
set /p descricao="Digite a descrição: "

if "%descricao%"=="" (
    echo ❌ Descrição não pode ser vazia!
    pause
    exit /b 1
)

echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo 📦 Resumo:
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
echo   Tipo: %tipo_commit%
echo   Mensagem: %tipo_commit%: %descricao%
echo.
set /p confirma="Confirmar envio? (S/N): "

if /i not "%confirma%"=="S" (
    echo ❌ Envio cancelado!
    pause
    exit /b 0
)

echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ⚙️  Processando...
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.

REM Adicionar todos os arquivos
echo 📁 Adicionando arquivos...
git add -A
if errorlevel 1 (
    echo ❌ Erro ao adicionar arquivos!
    pause
    exit /b 1
)
echo ✅ Arquivos adicionados!
echo.

REM Fazer commit
echo 💾 Criando commit...
git commit -m "%tipo_commit%: %descricao%"
if errorlevel 1 (
    echo ❌ Erro ao criar commit!
    pause
    exit /b 1
)
echo ✅ Commit criado!
echo.

REM Enviar para GitHub
echo 🚀 Enviando para GitHub...
git push origin main
if errorlevel 1 (
    echo ❌ Erro ao enviar para GitHub!
    pause
    exit /b 1
)

echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ✅ Sucesso!
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
echo   📦 Commit: %tipo_commit%: %descricao%
echo   🌐 Branch: main
echo   ✨ Arquivos enviados para GitHub!
echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

pause
