# Princípio da Excelência - Sempre o Melhor

## Filosofia Core

**SEMPRE escolha a MELHOR opção em TODOS os aspectos!**

Não aceite "bom o suficiente" - busque EXCELÊNCIA em tudo!

---

## 🏆 Tecnologia - Sempre o Melhor

### Escolha Tecnologias:
- ✅ **Modernas** - Versões atuais, não legadas
- ✅ **Performáticas** - Rápidas e eficientes
- ✅ **Seguras** - Zero vulnerabilidades conhecidas
- ✅ **Mantidas** - Comunidade ativa, updates regulares
- ✅ **Escaláveis** - Suporta crescimento

### Exemplos:
```
❌ EVITE:
- Bibliotecas deprecated
- Versões antigas com vulnerabilidades
- Soluções lentas/ineficientes
- Tecnologias abandonadas

✅ PREFIRA:
- FastAPI (não Flask/Django lento)
- Next.js 14+ (não Create React App)
- PostgreSQL (não SQLite em produção)
- Redis (não cache em memória)
- Bcrypt/Argon2 (não MD5/SHA1)
```

---

## 💻 Código - Sempre o Melhor

### Qualidade de Código:
- ✅ **Limpo** - Fácil de ler e entender
- ✅ **Modular** - Componentes reutilizáveis
- ✅ **Tipado** - TypeScript/Type hints completos
- ✅ **Testado** - Cobertura >70%
- ✅ **Documentado** - Comentários úteis

### Padrões:
```python
# ❌ RUIM:
def f(x):
    return x * 2

# ✅ EXCELENTE:
def calculate_double_value(value: float) -> float:
    """
    Calcula o dobro de um valor.
    
    Args:
        value: Valor para duplicar
    
    Returns:
        Valor duplicado
    
    Example:
        >>> calculate_double_value(5.0)
        10.0
    """
    if value < 0:
        raise ValueError("Valor deve ser positivo")
    
    return value * 2.0
```

---

## 🔒 Segurança - Sempre o Melhor

### Princípios de Segurança:
- ✅ **Zero secrets** no código
- ✅ **Validação** em TODAS entradas
- ✅ **Criptografia** forte (AES-256)
- ✅ **HTTPS** sempre em produção
- ✅ **Rate limiting** em endpoints públicos
- ✅ **Autenticação** moderna (JWT com refresh)
- ✅ **Sanitização** de inputs (XSS/SQL injection)

### Exemplos:
```python
# ❌ INSEGURO:
SECRET_KEY = "my-secret-123"  # Hardcoded!
password = request.data['password']  # Sem validação!
sql = f"SELECT * FROM users WHERE id = {user_id}"  # SQL injection!

# ✅ SEGURO:
SECRET_KEY = os.getenv('SECRET_KEY')  # Variável de ambiente
if not SECRET_KEY:
    raise ValueError("SECRET_KEY não configurada!")

# Validação com Pydantic/Zod
password = PasswordValidator.validate(request.data['password'])

# Query parametrizada
user = db.query(User).filter(User.id == user_id).first()
```

---

## 🏗️ Arquitetura - Sempre o Melhor

### Princípios Arquiteturais:
- ✅ **Separação de Concerns** - Backend/Frontend/Bot separados
- ✅ **Modular** - Cada módulo uma responsabilidade
- ✅ **Escalável** - Design para crescimento
- ✅ **Resiliente** - Trata falhas graciosamente
- ✅ **Observável** - Logs, métricas, monitoramento

### Estrutura:
```
❌ EVITE:
- Monolito gigante
- Código duplicado
- Acoplamento forte
- Sem tratamento de erros

✅ PREFIRA:
- Módulos pequenos e focados
- DRY (Don't Repeat Yourself)
- Dependency Injection
- Try-catch em operações críticas
- Circuit breakers
```

---

## ⚡ Performance - Sempre o Melhor

### Otimizações:
- ✅ **Índices** no banco de dados
- ✅ **Cache** para dados frequentes
- ✅ **Async/await** para I/O
- ✅ **Lazy loading** de componentes
- ✅ **Paginação** de listas grandes
- ✅ **Compressão** de assets
- ✅ **CDN** para estáticos

### Exemplos:
```python
# ❌ LENTO:
users = User.objects.all()  # Carrega TUDO
for user in users:
    trades = Trade.objects.filter(user_id=user.id)  # N+1 query!

# ✅ RÁPIDO:
users = User.objects.prefetch_related('trades').all()[:100]  # Limit + prefetch
# OU
trades = Trade.objects.filter(user_id__in=user_ids).select_related('user')
```

---

## 🧪 Testes - Sempre o Melhor

### Cobertura de Testes:
- ✅ **Unitários** - Funções individuais
- ✅ **Integração** - Fluxos completos
- ✅ **E2E** - Interface do usuário
- ✅ **Performance** - Benchmarks
- ✅ **Segurança** - Penetration tests

### Mínimos:
```
Cobertura de testes: >70%
Testes críticos: 100%
CI/CD: Obrigatório
```

---

## 📚 Documentação - Sempre o Melhor

### Documentação Completa:
- ✅ **README** - Como usar
- ✅ **API Docs** - Swagger/OpenAPI
- ✅ **Inline** - Comentários úteis
- ✅ **Guides** - Tutoriais passo a passo
- ✅ **Changelog** - Histórico de mudanças
- ✅ **Troubleshooting** - Soluções de problemas

---

## 🚀 Deploy - Sempre o Melhor

### Infraestrutura:
- ✅ **PostgreSQL** em produção (não SQLite)
- ✅ **Redis** para cache
- ✅ **PM2/Systemd** para processos
- ✅ **Nginx** como proxy reverso
- ✅ **HTTPS** com certificados válidos
- ✅ **Backups** automatizados diários
- ✅ **Monitoramento** 24/7 (Prometheus/Grafana)
- ✅ **Logs** estruturados (JSON)
- ✅ **Alertas** (Slack/Discord/Email)

---

## 🎯 Checklist de Excelência

Antes de considerar uma feature "completa", verifique:

- [ ] ✅ Usa a melhor tecnologia para o problema?
- [ ] ✅ Código está limpo e bem estruturado?
- [ ] ✅ Type hints/TypeScript completos?
- [ ] ✅ Validações em todas entradas?
- [ ] ✅ Tratamento de erros robusto?
- [ ] ✅ Segurança verificada? (sem secrets expostos)
- [ ] ✅ Performance otimizada? (índices, cache)
- [ ] ✅ Testes escritos e passando?
- [ ] ✅ Documentação atualizada?
- [ ] ✅ Logs adequados para debug?
- [ ] ✅ Escalável para 10x mais usuários?
- [ ] ✅ Resiliente a falhas?

**Se QUALQUER resposta for NÃO → MELHORE antes de continuar!**

---

## 💡 Mentalidade

### Ao Implementar Qualquer Feature:

**Pergunte-se:**
1. Esta é a MELHOR solução?
2. Há uma forma MAIS SEGURA?
3. Há uma forma MAIS RÁPIDA?
4. Há uma forma MAIS SIMPLES?
5. Vai escalar para 100x mais usuários?
6. Está usando best practices da indústria?

**Se NÃO for o MELHOR → REFATORE!**

---

## 🔥 Exemplos Práticos

### Escolha de Banco de Dados:

```
Cenário: Produção com múltiplos usuários

❌ SQLite - Não escala, locks, sem replicação
✅ PostgreSQL - Escalável, ACID, replicação, índices avançados

Escolha: POSTGRESQL (sempre em produção!)
```

### Escolha de Cache:

```
Cenário: Cache de dados frequentes

❌ Variável global - Perde ao reiniciar, não compartilha entre workers
❌ Arquivo JSON - Lento, não concorrente
✅ Redis - Rápido, persistente, distribuído, TTL automático

Escolha: REDIS (sempre!)
```

### Escolha de Auth:

```
Cenário: Autenticação de usuários

❌ Session cookies - Não escala horizontal, não stateless
❌ JWT de 30 dias - Risco se token vazado
✅ JWT curto (15min) + Refresh Token (7 dias)

Escolha: JWT com REFRESH (melhor segurança + UX!)
```

---

## 🛡️ Nunca Comprometa

### NUNCA aceite:
- ❌ Secrets no código
- ❌ SQL injection vulnerabilities
- ❌ Senhas em plaintext
- ❌ CORS wildcard (*) em produção
- ❌ Código sem testes em features críticas
- ❌ Logs de senha/tokens
- ❌ Dependencies com vulnerabilidades

### SEMPRE exija:
- ✅ Variáveis de ambiente para secrets
- ✅ Queries parametrizadas
- ✅ Hash de senhas (bcrypt/argon2)
- ✅ CORS com lista explícita
- ✅ Testes em código crítico
- ✅ Logs estruturados (sem dados sensíveis)
- ✅ Dependencies atualizadas

---

## 📊 Métricas de Qualidade

### Código deve ter:
- **Complexidade ciclomática:** <10
- **Linhas por função:** <50
- **Linhas por arquivo:** <500
- **Duplicação:** <5%
- **Cobertura de testes:** >70%
- **Type coverage:** 100%

### Performance deve ter:
- **Response time:** <200ms (p95)
- **Queries DB:** <50ms
- **Cache hit rate:** >80%
- **Uptime:** >99.9%

---

## 🎯 Resultado

**Seguindo estes princípios:**
- ✅ Código de qualidade enterprise
- ✅ Segurança máxima
- ✅ Performance ótima
- ✅ Manutenibilidade fácil
- ✅ Escalabilidade garantida

**SEMPRE O MELHOR!** 🏆

---

## ⚡ Regra de Ouro

**Quando em dúvida entre duas soluções:**

1. Qual é mais SEGURA? → Escolha essa
2. Se empate, qual é mais PERFORMÁTICA? → Escolha essa
3. Se empate, qual é mais SIMPLES? → Escolha essa
4. Se empate, qual é mais TESTÁVEL? → Escolha essa
5. Se empate, qual é mais ESCALÁVEL? → Escolha essa

**SEMPRE escolha a opção que maximiza qualidade!**

**NÃO aceite "funciona" - exija "EXCELENTE"!** ✨


# README e CHANGELOG - Documentação Obrigatória

## Regra: Toda feature nova = README + CHANGELOG

**SEMPRE atualize documentação ao adicionar funcionalidades!**

---

## 1. README.md - Funcionalidades

### **Quando atualizar:**
- Nova funcionalidade implementada
- Nova API endpoint criada
- Novo componente importante adicionado
- Mudança no fluxo de uso

### **O QUE incluir:**

```markdown
## Funcionalidades

### 🎯 Nova Funcionalidade (adicionado 13/11/2025)

**Descrição:**
- O que faz
- Por que é útil
- Como usar

**Exemplo:**
```bash
# Como usar a funcionalidade
comando ou código de exemplo
```

**Requisitos:**
- Dependência 1
- Dependência 2
```

### ❌ NÃO FAÇA:

```markdown
## Features
- Login
- Dashboard
- Bot
```

### ✅ FAÇA:

```markdown
## Funcionalidades

### 🔐 Autenticação
Sistema de login com JWT tokens e refresh automático.
- Login/Logout
- Sessão persistente
- Proteção de rotas

### 📊 Dashboard Tempo Real
Dashboard com métricas atualizadas automaticamente.
- Saldo total (cotação USD/BRL real)
- Top 5 Performance (CoinCap API)
- Trades em tempo real
- Modal histórico mensal
```

---

## 2. CHANGELOG.md - Histórico de Mudanças

### **Formato obrigatório:**

```markdown
# Changelog

## [Unreleased]
### Added
- Nova funcionalidade X
- Novo componente Y

### Changed
- Melhorado performance de Z
- Atualizado dependência A

### Fixed
- Corrigido bug no login
- Corrigido saldo não atualizava

### Removed
- Removido código deprecated

## [1.0.05b] - 2025-11-13
### Added
- Top 5 Performance tempo real (CoinCap API)
- Modal histórico trades mensal
- Cotação USD/BRL tempo real (AwesomeAPI)

### Fixed
- Saldo modal intermitente
- Cryptos não carregavam por exchange
```

### **Categorias:**

- **Added:** Novas funcionalidades
- **Changed:** Mudanças em funcionalidades existentes
- **Deprecated:** Funcionalidades que serão removidas
- **Removed:** Funcionalidades removidas
- **Fixed:** Bugs corrigidos
- **Security:** Correções de segurança

---

## 3. Quando Commitar

### **Após implementar funcionalidade:**

**1. Implementar código**
```bash
git commit -m "feat: Adiciona modal historico mensal"
```

**2. Atualizar README.md**
```bash
git commit -m "docs: Adiciona modal historico ao README"
```

**3. Atualizar CHANGELOG.md**
```bash
git commit -m "docs: Atualiza CHANGELOG v1.0.05b"
```

### ✅ FLUXO CORRETO:

```
1. feat: Implementa funcionalidade
2. docs: Atualiza README com nova funcionalidade
3. docs: Atualiza CHANGELOG com mudanças
```

---

## 4. Checklist Documentação

**Antes de considerar feature completa:**

- [ ] ✅ Código implementado e testado
- [ ] ✅ README.md atualizado com:
  - [ ] Descrição da funcionalidade
  - [ ] Como usar
  - [ ] Exemplo prático
  - [ ] Requisitos (se houver)
- [ ] ✅ CHANGELOG.md atualizado com:
  - [ ] Categoria correta (Added/Fixed/Changed)
  - [ ] Descrição clara da mudança
  - [ ] Data/versão

---

## 5. Estrutura README.md

### **Seções obrigatórias:**

```markdown
# Auronex Trading Bot

## 📋 Sobre
Breve descrição do projeto

## ✨ Funcionalidades
Lista todas funcionalidades (atualize SEMPRE!)

## 🚀 Instalação
Como instalar

## 💻 Uso
Como usar (exemplos práticos)

## 📊 API Endpoints
Lista de endpoints disponíveis

## 🔧 Configuração
Variáveis de ambiente, configs

## 🤝 Contribuindo
Como contribuir

## 📝 Licença
MIT ou outra
```

---

## 6. Exemplos Práticos

### **Feature: Modal Histórico**

**README.md:**
```markdown
### 📊 Modal Histórico Mensal

Visualize todos os trades do mês em uma modal interativa.

**Como usar:**
1. Abrir dashboard
2. Clicar no card "Trades Hoje"
3. Ver histórico completo
4. Exportar CSV (opcional)

**Endpoint:** `/api/trades/month`
```

**CHANGELOG.md:**
```markdown
## [1.0.05b] - 2025-11-13
### Added
- Modal histórico trades mensal com export CSV
- Endpoint `/api/trades/month` para buscar trades do mês
- Botão "Ver Histórico" no card Trades Hoje
```

---

## 7. Regras Importantes

### **SEMPRE:**
- Atualizar README ao adicionar feature
- Atualizar CHANGELOG ao fazer commit importante
- Incluir exemplos práticos
- Datar mudanças no CHANGELOG

### **NUNCA:**
- Commitar feature sem atualizar docs
- README desatualizado
- CHANGELOG sem versão/data
- Documentação vaga

---

## 8. Template Rápido

**Quando implementar nova feature:**

```markdown
📝 README.md:

### 🆕 [Nome da Feature]
[Descrição breve]

**Como usar:**
[Passo a passo ou exemplo código]

**Requisitos:**
[Se houver dependências]

---

📝 CHANGELOG.md:

## [Unreleased]
### Added
- [Descrição clara da feature]
```

---

## ✅ Resultado

**README:** Sempre atualizado ✅  
**CHANGELOG:** Histórico completo ✅  
**Usuários:** Sabem usar todas features ✅  
**Manutenção:** Fácil entender mudanças ✅

---

**Documentação = Parte essencial da feature!** 📝✅


# Git Commit Convention - Auronex

## Regra: 1 Tarefa = 1 Commit

**SEMPRE faça commits atômicos e descritivos!**

---

## 📝 Formato Obrigatório

### Estrutura:
```
<tipo>: <descrição curta>

[corpo opcional]

[footer opcional]
```

### Tipos Permitidos:

- **feat:** Nova funcionalidade
- **fix:** Correção de bug
- **docs:** Apenas documentação
- **style:** Formatação (sem mudança de lógica)
- **refactor:** Refatoração (sem feat/fix)
- **perf:** Melhoria de performance
- **test:** Adicionar/corrigir testes
- **chore:** Tarefas de manutenção

---

## ✅ Exemplos CORRETOS

### Features:
```bash
git commit -m "feat: Adiciona autenticação JWT com refresh token"
git commit -m "feat: Implementa circuit breaker no bot após 5 perdas"
git commit -m "feat: Adiciona validação de senha forte (8+ chars)"
```

### Fixes:
```bash
git commit -m "fix: Corrige criptografia hardcoded - agora usa .env"
git commit -m "fix: Corrige CORS wildcard - lista explícita de origens"
git commit -m "fix: Corrige bypass de validação de capital"
```

### Docs:
```bash
git commit -m "docs: Atualiza README com novas funcionalidades"
git commit -m "docs: Adiciona auditoria técnica completa"
git commit -m "docs: Atualiza CHANGELOG v1.0.06"
```

### Performance:
```bash
git commit -m "perf: Adiciona 12 índices no banco de dados"
git commit -m "perf: Implementa cache Redis para cotações"
```

### Refactor:
```bash
git commit -m "refactor: Extrai validações para módulo separado"
git commit -m "refactor: Move rate limiter para dependencies.py"
```

---

## ❌ Exemplos INCORRETOS

```bash
# ❌ Muito vago
git commit -m "update"
git commit -m "fix bug"
git commit -m "changes"

# ❌ Múltiplas tarefas em 1 commit
git commit -m "feat: Login + Dashboard + Bots + API Keys"

# ❌ Sem tipo
git commit -m "adiciona autenticação"

# ❌ Tipo errado
git commit -m "feature: adiciona login"  # ❌ deve ser "feat:"
```

---

## 🎯 Workflow Recomendado

### Para Cada Funcionalidade:

```bash
# 1. Implementar UMA funcionalidade
# (ex: adicionar refresh token)

# 2. Testar completamente
# (verificar se funciona)

# 3. Commit descritivo
git add fastapi_app/auth.py fastapi_app/routers/auth.py
git commit -m "feat: Implementa refresh token JWT (15min + 7 dias)"

# 4. Próxima funcionalidade
# (ex: adicionar rate limiting)

# 5. Testar

# 6. Commit separado
git add fastapi_app/rate_limiter.py fastapi_app/routers/auth.py
git commit -m "feat: Adiciona rate limiting em login (5 tentativas/min)"
```

---

## 📊 Mensagens Detalhadas (Opcional)

### Com Corpo:
```bash
git commit -m "feat: Adiciona autenticação JWT

- Access token: 15 minutos
- Refresh token: 7 dias
- Endpoint /api/auth/refresh implementado
- Compatível com frontend React"
```

### Com Breaking Changes:
```bash
git commit -m "feat: Adiciona autenticação obrigatória em endpoints

BREAKING CHANGE: Endpoints /api/exchange/balance e /api/trades/*
agora exigem token JWT. Frontend precisa incluir Authorization header."
```

---

## 🔧 Commits de Bugfix

### Durante Desenvolvimento:
```bash
git commit -m "fix: Adiciona load_dotenv() em auth.py"
git commit -m "fix: Adiciona import logger em bots.py"
git commit -m "fix: Corrige indentação em exchange.py"
```

### Após Deploy:
```bash
git commit -m "fix: Corrige login retornando 401 (hash incompatível)"
git commit -m "fix: Corrige dashboard travado em carregando"
```

---

## 📚 Commits de Documentação

```bash
git commit -m "docs: Adiciona auditoria técnica completa (43 problemas)"
git commit -m "docs: Atualiza CHANGELOG para v1.0.06"
git commit -m "docs: Adiciona guias de configuração .env"
```

---

## 🎯 Regras Importantes

### SEMPRE:
- 1 funcionalidade = 1 commit
- Mensagem clara (o QUE foi feito, não COMO)
- Tipo correto (feat/fix/docs)
- Testar antes de commitar
- Commits pequenos e frequentes

### NUNCA:
- Commits gigantes (100+ arquivos)
- Mensagens vagas ("update", "fix")
- Múltiplas features em 1 commit
- Commitar código não testado
- Commitar com erros de lint

---

## 📅 Exemplo de Workflow de 1 Dia

```bash
# Manhã: Implementar segurança
git commit -m "feat: Adiciona criptografia segura via .env"
git commit -m "feat: Implementa CORS restrito com lista explícita"
git commit -m "feat: Adiciona refresh token JWT"

# Tarde: Implementar validações
git commit -m "feat: Adiciona validação de senha forte"
git commit -m "feat: Implementa rate limiting em login"
git commit -m "feat: Adiciona validação de símbolos na exchange"

# Noite: Performance
git commit -m "perf: Adiciona 12 índices no banco de dados"

# Bugfixes encontrados
git commit -m "fix: Adiciona load_dotenv() em módulos principais"
git commit -m "fix: Corrige import logger em routers"

# Documentação
git commit -m "docs: Adiciona auditoria técnica completa"
git commit -m "docs: Atualiza CHANGELOG v1.0.06"
```

**Total:** 11 commits bem organizados! ✅

---

## 🚀 Push para Produção

### Após Testar Local:
```bash
# Ver commits
git log --oneline -10

# Push
git push origin main
```

### No Servidor:
```bash
ssh usuario@auronex.com.br
cd /home/serverhome/auronex
git pull origin main

# Ver o que foi atualizado
git log --oneline -10

# Deploy
./DEPLOY_PRODUCAO_COM_ENV.sh
```

---

## 📊 Benefícios

### Commits Atômicos:
- ✅ Fácil reverter features específicas
- ✅ Histórico limpo e compreensível
- ✅ Code review mais fácil
- ✅ Bisect funciona melhor
- ✅ Cherry-pick possível

### Mensagens Claras:
- ✅ Entender mudanças sem ler código
- ✅ Gerar CHANGELOG automaticamente
- ✅ Rastrear quando feature foi adicionada
- ✅ Comunicação com equipe

---

## ✅ Checklist Antes de Commit

- [ ] Código testado e funcionando?
- [ ] Sem erros de lint?
- [ ] Mensagem descritiva?
- [ ] Tipo correto (feat/fix/docs)?
- [ ] Apenas 1 funcionalidade?
- [ ] Arquivos relacionados incluídos?

**Se SIM para todos → git commit!** ✅

---

## 🏆 Resultado

**Com commits organizados:**
- ✅ Histórico Git limpo
- ✅ Fácil reverter mudanças
- ✅ CHANGELOG automático
- ✅ Comunicação clara
- ✅ Code review eficiente

**SEMPRE: 1 tarefa = 1 commit!** 📝


# Uso de Ferramentas e MCPs

## Use TODAS as ferramentas disponíveis!

**SEMPRE aproveite ao máximo os recursos disponíveis:**

---

## 🧰 FERRAMENTAS DISPONÍVEIS

### **1. MCPs (Model Context Protocol)**

**Playwright MCP:**
- Debug de interfaces web
- Testar navegação
- Capturar screenshots
- Verificar elementos DOM

**Sequential Thinking MCP:**
- Problemas complexos
- Análise passo a passo
- Debugging profundo
- Planejamento de features

**Context7 MCP:**
- Documentação de bibliotecas
- Buscar APIs públicas
- Exemplos de código
- Best practices

**Quando usar:**
- ❌ Problemas simples (leitura de arquivo)
- ✅ Debug complexo de UI
- ✅ Análise profunda de bugs
- ✅ Pesquisa de documentação
- ✅ Problemas que requerem raciocínio multi-etapa

---

## 📋 REGRAS DO PROJETO

**SEMPRE consultar:**

### **Workspace Rules (Always Applied):**
- Git Commit Convention
- README e CHANGELOG obrigatórios
- TypeScript Quality Rules

### **Repository Rules:**
- Implementação Incremental
- 1 tarefa = 1 commit

**Como usar:**
- Ler regras ANTES de implementar
- Seguir convenções estabelecidas
- Não criar padrões novos que conflitem

---

## 🎯 ESTRATÉGIA DE USO

### **Problema Simples:**
```
Tarefa: "Adicionar campo email no formulário"

✅ Usar: Ferramentas básicas (read_file, search_replace)
❌ Não usar: MCPs (overkill)
```

### **Problema Complexo:**
```
Tarefa: "Dashboard não mostra valores e não sei por quê"

✅ Usar: Sequential Thinking MCP
  1. Analisar fluxo de dados
  2. Verificar cada camada
  3. Identificar onde quebra
  4. Propor solução

✅ Usar: Playwright MCP (se for UI)
  - Navegar para página
  - Inspecionar elementos
  - Ver console errors
  - Testar interações
```

### **Documentação/Biblioteca:**
```
Tarefa: "Implementar validação com Zod"

✅ Usar: Context7 MCP
  - Resolver library ID (/colinhacks/zod)
  - Buscar exemplos de validação
  - Ver best practices
  - Implementar corretamente
```

---

## 🔧 FERRAMENTAS POR CASO DE USO

### **Debug UI:**
- Playwright MCP ✅
- Console F12 (via instruções)
- Network tab

### **Debug Lógica:**
- Sequential Thinking MCP ✅
- Logs detalhados
- Print statements

### **Pesquisa:**
- Context7 MCP (bibliotecas) ✅
- Web Search (APIs públicas)
- grep (código existente)

### **Análise Código:**
- codebase_search ✅
- grep ✅
- read_file ✅

---

## ✅ CHECKLIST ANTES DE IMPLEMENTAR

**1. Consultar regras:**
- [ ] Li workspace rules?
- [ ] Li repository rules?
- [ ] Seguindo convenções?

**2. Escolher ferramentas:**
- [ ] Problema complexo? → MCPs
- [ ] Precisa docs? → Context7
- [ ] Debug UI? → Playwright
- [ ] Simples? → Ferramentas básicas

**3. Implementar:**
- [ ] 1 funcionalidade por vez
- [ ] Testar completamente
- [ ] Commit feat:/fix:
- [ ] Atualizar README/CHANGELOG

---

## 🎯 EXEMPLOS PRÁTICOS

### **Exemplo 1: Bug Intermitente**

```
Problema: "Saldo modal às vezes mostra R$ 0"

✅ USAR:
1. Sequential Thinking: Analisar fluxo
2. grep: Buscar código setSaldoExchange
3. read_file: Ver componente completo
4. Logs: Adicionar console.log detalhados
5. Testar: Reproduzir erro
6. Fix: Corrigir (reset + catch robusto)
7. Commit: "fix: Saldo modal intermitente com reset"
```

### **Exemplo 2: Nova Feature**

```
Tarefa: "Adicionar Top 5 Performance com dados reais"

✅ USAR:
1. Context7: Pesquisar CoinGecko/CoinCap APIs
2. Web Search: Comparar APIs (limites, custos)
3. Sequential Thinking: Planejar implementação
4. Implementar: Backend + Frontend
5. Testar: Ver dados reais
6. Commit: "feat: Top 5 Performance CoinCap tempo real"
7. Docs: Atualizar README + CHANGELOG
```

### **Exemplo 3: Debug Produção**

```
Problema: "Login funciona local, loop em produção"

✅ USAR:
1. Sequential Thinking: Diferenças local vs prod
2. grep: Buscar "login" em código
3. curl: Testar API produção diretamente
4. Logs: Ver console F12 produção
5. Identificar: API não retorna user
6. Fix: Remover response_model
7. Commit: "fix: Login retorna user em producao"
```

---

## 🚀 RESULTADO

**Com MCPs:**
- Debug mais rápido ✅
- Soluções melhores ✅
- Menos tentativa-erro ✅

**Com Regras:**
- Código organizado ✅
- Commits claros ✅
- Docs atualizados ✅

**Com Ambos:**
- Qualidade máxima ✅
- Eficiência máxima ✅
- Cliente feliz ✅

---

**USE TODAS AS FERRAMENTAS!** 🧰  
**SIGA TODAS AS REGRAS!** 📋  
**RESULTADO: EXCELÊNCIA!** 🏆


# TypeScript Quality Rules

## Sem Ignorar Erros Sem Explicação

**NUNCA use `@ts-ignore` ou `@ts-expect-error` sem comentário explicativo!**

### ❌ ERRADO:

```typescript
// @ts-ignore
const value = someFunction()
```

### ✅ CORRETO:

```typescript
// @ts-ignore - API externa não tem types, aguardando @types/library
const value = someFunction()

// OU melhor ainda, criar type:
interface ExternalAPI {
  someFunction: () => string
}
const value = (someFunction as ExternalAPI['someFunction'])()
```

---

## Warnings = Erros

**Trate TODOS os warnings como erros críticos!**

### Warnings Comuns:

**1. Variável não usada:**
```typescript
// ❌ ERRADO
const [data, setData] = useState()

// ✅ CORRETO
const [data, setData] = useState()
// Usar data OU
const [_data, setData] = useState()  // _ = intencionalmente não usado
```

**2. any não especificado:**
```typescript
// ❌ ERRADO
const handleClick = (e: any) => {}

// ✅ CORRETO
const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {}
```

**3. Dependências useEffect:**
```typescript
// ❌ ERRADO (warning)
useEffect(() => {
  fetchData()
}, [])  // fetchData não está nas deps!

// ✅ CORRETO
useEffect(() => {
  fetchData()
}, [fetchData])

// OU se intencional:
useEffect(() => {
  fetchData()
// eslint-disable-next-line react-hooks/exhaustive-deps
}, [])  // Comentar POR QUÊ ignora
```

---

## Regras de Qualidade

### 1. **SEMPRE tipar explicitamente:**

```typescript
// ❌ ERRADO
const fetchData = async (id) => {
  const response = await api.get('/data')
  return response.data
}

// ✅ CORRETO
const fetchData = async (id: number): Promise<DataType> => {
  const response = await api.get<DataResponse>('/data')
  return response.data
}
```

### 2. **Interfaces sobre types para objetos:**

```typescript
// ❌ ERRADO
type User = {
  id: number
  name: string
}

// ✅ CORRETO
interface User {
  id: number
  name: string
}
```

### 3. **Evitar `any` SEMPRE:**

```typescript
// ❌ ERRADO
const parseData = (data: any) => data.value

// ✅ CORRETO
interface DataInput {
  value: string
}
const parseData = (data: DataInput) => data.value

// OU se realmente desconhecido:
const parseData = (data: unknown) => {
  if (typeof data === 'object' && data !== null && 'value' in data) {
    return (data as {value: string}).value
  }
  throw new Error('Invalid data format')
}
```

### 4. **Comentar supressões:**

```typescript
// ✅ CORRETO - Comentar POR QUÊ ignora
// @ts-expect-error - React 18 types incompatíveis, fix pendente em v2.0
<Component legacyProp={value} />

// @ts-ignore - ccxt não exporta types, criar definição manual é overhead
const exchange = new ccxt.binance()
```

---

## Build sem Warnings

**Build DEVE passar sem warnings!**

```bash
# Antes de commitar:
npm run build

# Deve mostrar:
✓ Compiled successfully
# SEM warnings!
```

**Se houver warnings:**
1. Corrija TODOS antes de commit
2. OU comente por que são aceitáveis
3. NUNCA commite com warnings não tratados

---

## Checklist TypeScript:

- [ ] ✅ Sem `any` (use tipos específicos ou `unknown`)
- [ ] ✅ Sem variáveis não usadas (ou prefixar com `_`)
- [ ] ✅ Sem `@ts-ignore` sem comentário explicativo
- [ ] ✅ useEffect deps completas (ou comentar por quê não)
- [ ] ✅ Interfaces bem definidas
- [ ] ✅ Build sem warnings
- [ ] ✅ npm run build passa limpo

---

**TypeScript rigoroso = Menos bugs em produção!** ✅


# Validação de Dados - TypeScript + Zod

## Use TypeScript + Zod para TODAS as validações

**SEMPRE valide dados de entrada (formulários, APIs) com Zod!**

---

## 1. Validação de Formulários

### ❌ ERRADO (sem validação):

```typescript
const handleSubmit = (e: FormEvent) => {
  e.preventDefault()
  const email = e.target.email.value
  const password = e.target.password.value
  
  // Sem validação!
  login(email, password)
}
```

### ✅ CORRETO (com Zod):

```typescript
import { z } from 'zod'

const loginSchema = z.object({
  email: z.string().email('Email inválido'),
  password: z.string().min(6, 'Senha deve ter no mínimo 6 caracteres')
})

type LoginForm = z.infer<typeof loginSchema>

const handleSubmit = (e: FormEvent) => {
  e.preventDefault()
  
  const formData = {
    email: e.target.email.value,
    password: e.target.password.value
  }
  
  try {
    const validated = loginSchema.parse(formData)
    login(validated.email, validated.password)
  } catch (error) {
    if (error instanceof z.ZodError) {
      // Mensagem clara do primeiro erro
      toast.error(error.errors[0].message)
    }
  }
}
```

---

## 2. Validação de Respostas de API

### ❌ ERRADO (sem validação):

```typescript
const fetchUser = async () => {
  const response = await fetch('/api/user')
  const data = await response.json()
  return data  // any implícito!
}
```

### ✅ CORRETO (com Zod):

```typescript
import { z } from 'zod'

const userSchema = z.object({
  id: z.number(),
  email: z.string().email(),
  first_name: z.string(),
  last_name: z.string(),
  is_active: z.boolean(),
  subscription: z.object({
    plan: z.enum(['free', 'premium', 'pro']),
    status: z.string()
  }).optional()
})

type User = z.infer<typeof userSchema>

const fetchUser = async (): Promise<User> => {
  const response = await fetch('/api/user')
  const data = await response.json()
  
  try {
    return userSchema.parse(data)
  } catch (error) {
    if (error instanceof z.ZodError) {
      console.error('Dados inválidos da API:', error.errors)
      throw new Error('Resposta da API está inválida')
    }
    throw error
  }
}
```

---

## 3. Validação de Props de Componente

### ❌ ERRADO:

```typescript
interface BotCardProps {
  bot: any  // ❌ any!
  onEdit: (id: number) => void
}
```

### ✅ CORRETO:

```typescript
import { z } from 'zod'

const botSchema = z.object({
  id: z.number(),
  name: z.string(),
  exchange: z.enum(['binance', 'bybit', 'mercadobitcoin']),
  symbols: z.array(z.string()),
  capital: z.number().positive(),
  is_active: z.boolean(),
  is_testnet: z.boolean()
})

type Bot = z.infer<typeof botSchema>

interface BotCardProps {
  bot: Bot  // ✅ Tipado!
  onEdit: (id: number) => void
}
```

---

## 4. Mensagens de Erro Claras

### ❌ ERRADO (genérico):

```typescript
catch (error) {
  toast.error('Erro')  // ❌ Não ajuda!
}
```

### ✅ CORRETO (específico):

```typescript
catch (error) {
  if (error instanceof z.ZodError) {
    // Primeira mensagem de erro (mais relevante)
    const firstError = error.errors[0]
    toast.error(`${firstError.path.join('.')}: ${firstError.message}`)
    
    // OU todas:
    error.errors.forEach(err => {
      toast.error(`${err.path.join('.')}: ${err.message}`)
    })
  } else if (error instanceof Error) {
    toast.error(error.message)
  } else {
    toast.error('Erro inesperado. Contate o suporte.')
  }
}
```

---

## 5. Validação com Mensagens Customizadas

```typescript
const botConfigSchema = z.object({
  name: z.string()
    .min(3, 'Nome deve ter no mínimo 3 caracteres')
    .max(50, 'Nome deve ter no máximo 50 caracteres'),
  
  exchange: z.enum(['binance', 'bybit', 'mercadobitcoin'], {
    errorMap: () => ({ message: 'Selecione uma exchange válida' })
  }),
  
  symbols: z.array(z.string())
    .min(1, 'Selecione pelo menos 1 criptomoeda')
    .max(5, 'Máximo 5 criptomoedas permitidas'),
  
  capital: z.number()
    .positive('Capital deve ser maior que zero')
    .max(10000, 'Capital máximo: $10.000')
    .refine(val => val >= 2, {
      message: 'Capital mínimo: $2.00'
    })
})
```

---

## 6. Validação em Backend (FastAPI)

```python
from pydantic import BaseModel, Field, validator

class BotCreate(BaseModel):
    name: str = Field(..., min_length=3, max_length=50)
    exchange: str
    symbols: list[str] = Field(..., min_items=1, max_items=5)
    capital: float = Field(..., ge=2.0, le=10000.0)
    
    @validator('exchange')
    def validate_exchange(cls, v):
        allowed = ['binance', 'bybit', 'mercadobitcoin']
        if v not in allowed:
            raise ValueError(f'Exchange deve ser uma de: {", ".join(allowed)}')
        return v
    
    @validator('symbols')
    def validate_symbols(cls, v, values):
        exchange = values.get('exchange')
        # Validar se symbols existem na exchange
        return v
```

---

## Checklist Validação:

- [ ] ✅ Formulários validam com Zod
- [ ] ✅ APIs validam respostas
- [ ] ✅ Props de componentes tipadas
- [ ] ✅ Mensagens de erro claras e específicas
- [ ] ✅ Erros tratados individualmente
- [ ] ✅ Backend valida com Pydantic
- [ ] ✅ Nunca confiar em dados não validados

---

## Exemplo Completo (Create Bot):

```typescript
// Schema
const createBotSchema = z.object({
  name: z.string().min(3, 'Nome mínimo 3 caracteres'),
  exchange: z.enum(['binance', 'bybit', 'mercadobitcoin']),
  symbols: z.array(z.string()).min(1, 'Selecione pelo menos 1 crypto'),
  capital: z.number().min(2, 'Capital mínimo $2').max(10000, 'Capital máximo $10k')
})

// Uso
const handleSubmit = async () => {
  try {
    // ✅ Validar
    const validated = createBotSchema.parse({
      name,
      exchange,
      symbols,
      capital: parseFloat(capital)
    })
    
    // ✅ Enviar dados validados
    await botsApi.create(validated)
    toast.success('Bot criado com sucesso!')
    
  } catch (error) {
    if (error instanceof z.ZodError) {
      // ✅ Mensagem específica
      toast.error(error.errors[0].message)
    } else {
      toast.error('Erro ao criar bot')
    }
  }
}
```

---

**Validação rigorosa = Menos bugs = Clientes felizes!** ✅
