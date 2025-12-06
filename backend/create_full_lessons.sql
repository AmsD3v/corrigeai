-- 25 Lições Completas do ENEM - 5 por Competência
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/lessons.sql

-- Atualizar tabela settings
ALTER TABLE settings ADD COLUMN IF NOT EXISTS lesson_cooldown_hours INTEGER DEFAULT 168;
ALTER TABLE settings ADD COLUMN IF NOT EXISTS lesson_repeat_xp_percent INTEGER DEFAULT 50;

-- Atualizar tabela user_lesson
ALTER TABLE user_lesson ADD COLUMN IF NOT EXISTS times_completed INTEGER DEFAULT 0;
ALTER TABLE user_lesson ADD COLUMN IF NOT EXISTS cooldown_until TIMESTAMP;

-- Limpar lições existentes
DELETE FROM user_lesson;
DELETE FROM lesson;

-- ==================== COMPETÊNCIA 1: NORMA CULTA (5 lições) ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('enem', 1, 1, 'Introdução à Norma Culta', 'O que é avaliado na Competência 1', 
'# Competência 1: Norma Culta

A **Competência 1** avalia o domínio da modalidade escrita formal da língua portuguesa.

## O que é avaliado?
- Ortografia e acentuação
- Concordância verbal e nominal
- Regência verbal e nominal
- Pontuação e crase

## Níveis de pontuação
| Nota | Descrição |
|------|-----------|
| 200 | Excelente domínio, desvios mínimos |
| 160 | Bom domínio, poucos desvios |
| 120 | Domínio mediano |
| 80 | Domínio insuficiente |

> **Dica:** Revise sua redação ao menos 2 vezes!',
'[{"question": "O que a Competência 1 avalia?", "options": ["Argumentação", "Norma culta escrita", "Coesão", "Proposta"], "correct": 1}, {"question": "Qual a nota máxima por competência?", "options": ["100", "200", "1000"], "correct": 1}]',
25, 'free', 0),

('enem', 1, 2, 'Concordância Verbal', 'Regras essenciais', 
'# Concordância Verbal

O verbo concorda em número e pessoa com o sujeito.

## Regras Fundamentais

**Sujeito Simples:** *Os alunos **estudam**.*
**Sujeito Composto antes do verbo:** Plural → *João e Maria **chegaram**.*
**Sujeito Composto depois do verbo:** Singular ou plural → ***Chegou/Chegaram** João e Maria.*

## Verbos Impessoais (sempre singular)
- **Haver** (existir): *Havia muitas pessoas.* ✅
- **Fazer** (tempo): *Faz dois anos.* ✅

## Casos Especiais
| Expressão | Concordância |
|-----------|--------------|
| A maioria de | Singular ou plural |
| Mais de um | Singular |
| Cerca de | Com o numeral |',
'[{"question": "Qual está CORRETO?", "options": ["Haviam muitos erros", "Havia muitos erros", "Houveram erros"], "correct": 1}, {"question": "Faz ou fazem cinco anos?", "options": ["Faz (impessoal)", "Fazem"], "correct": 0}, {"question": "A maioria estudou/estudaram?", "options": ["Só estudou", "Só estudaram", "Ambos corretos"], "correct": 2}]',
30, 'previous', 0),

('enem', 1, 3, 'Concordância Nominal', 'Casos complexos', 
'# Concordância Nominal

## Casos Especiais

### É proibido / É necessário
- Sem artigo: invariável → *É proibido entrada.*
- Com artigo: concorda → *É proibida a entrada.*

### Palavras Invariáveis
- **Menos**: *Menos pessoas* ✅ (*Menas* ❌)
- **Alerta**: *Estavam alerta* ✅
- **Pseudo**: *Pseudocientistas* ✅

### Palavras Variáveis
- **Anexo/Incluso**: *Seguem **anexas** as fotos.*
- **Obrigado/a**: *Ela disse **obrigada**.*

### Meio/Bastante
- Adjetivo (variável): *Ela estava **meia** triste.*
- Advérbio (invariável): *Está **meio** cansada.* (um pouco)',
'[{"question": "Qual está CORRETO?", "options": ["Segue anexo as fotos", "Seguem anexas as fotos"], "correct": 1}, {"question": "Menas pessoas?", "options": ["Correto", "Incorreto - menos é invariável"], "correct": 1}, {"question": "Ela está meia ou meio cansada?", "options": ["Meia (concorda)", "Meio (advérbio invariável)"], "correct": 1}]',
35, 'previous', 0),

('enem', 1, 4, 'Regência Verbal', 'Preposições corretas', 
'# Regência Verbal

## Verbos Importantes

| Verbo | Regência | Exemplo |
|-------|----------|---------|
| Assistir (ver) | a | Assisti **ao** filme |
| Visar (objetivar) | a | Visa **ao** sucesso |
| Obedecer | a | Obedeço **aos** pais |
| Preferir | a | Prefiro café **a** chá |
| Implicar | - | Implica mudanças |
| Namorar | - | Namorou Maria |
| Aspirar (desejar) | a | Aspiro **ao** cargo |

## Erros Comuns

❌ *Prefiro café **do que** chá.*
✅ *Prefiro café **a** chá.*

❌ *Namorei **com** ela.*
✅ *Namorei ela.*

❌ *Assisti **o** jogo.*
✅ *Assisti **ao** jogo.*',
'[{"question": "Assistir (ver) pede qual preposição?", "options": ["Nenhuma", "A", "Em"], "correct": 1}, {"question": "Prefiro café... chá", "options": ["do que", "a", "que"], "correct": 1}, {"question": "Namorar usa preposição?", "options": ["Sim, com", "Não, é transitivo direto"], "correct": 1}]',
40, 'previous', 0),

('enem', 1, 5, 'Crase Definitiva', 'Domine a crase', 
'# Crase: Guia Completo

Crase = preposição A + artigo A = À

## USA-SE CRASE

1. **Antes de femininas com artigo**: Fui **à** escola.
2. **Expressões femininas**: à noite, à tarde, à vontade
3. **Horas determinadas**: Cheguei **às** 10h.

## NÃO USA-SE CRASE

1. **Antes de masculinas**: Fui a pé.
2. **Antes de verbos**: Começou a estudar.
3. **Antes de pronomes**: Referi-me a ela.

## Truque Infalível

Substitua por palavra masculina:
- Se aparecer **AO** → use crase
- Se aparecer **A** ou **O** → não use

*Fui à escola* → *Fui ao colégio* ✅',
'[{"question": "Fui à pé ou a pé?", "options": ["à pé", "a pé (masculina)"], "correct": 1}, {"question": "Cheguei... 8 horas", "options": ["a", "às"], "correct": 1}, {"question": "Referi-me... aquela situação", "options": ["a", "àquela"], "correct": 1}]',
45, 'previous', 0);

-- ==================== COMPETÊNCIA 2: COMPREENSÃO DO TEMA (5 lições) ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('enem', 2, 1, 'Compreendendo a Proposta', 'Interpretar o tema', 
'# Competência 2: Compreensão do Tema

## O que é avaliado?
A capacidade de compreender a proposta e desenvolver o tema dissertativo-argumentativo.

## Elementos da Proposta
1. **Tema central** - O assunto principal
2. **Recorte temático** - A delimitação específica
3. **Textos motivadores** - Contextualização

## Erros Graves
| Erro | Consequência |
|------|-------------|
| Tangenciar o tema | Nota muito baixa |
| Fugir do tema | ZERO na C2 |
| Copiar motivadores | ZERO na redação |

## Como garantir boa nota
1. Leia a proposta 3 vezes
2. Identifique palavras-chave
3. Use motivadores como inspiração apenas',
'[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Zero na C2", "Zero total"], "correct": 1}, {"question": "Copiar motivadores resulta em:", "options": ["Desconto", "Zero na C2", "Zero na redação"], "correct": 2}]',
30, 'free', 0),

('enem', 2, 2, 'Repertório Sociocultural', 'Como usar referências', 
'# Repertório Sociocultural

## Tipos de Repertório

1. **Dados/Estatísticas**: IBGE, ONU, pesquisas
2. **Referências Históricas**: Fatos relevantes
3. **Citações**: Filósofos, sociólogos
4. **Obras**: Livros, filmes, músicas
5. **Leis**: Constituição, ECA

## Como usar corretamente

✅ **Legitimado** - Fontes confiáveis
✅ **Pertinente** - Relacionado ao tema
✅ **Produtivo** - Usado para argumentar

❌ Repertório "decoreba" sem conexão
❌ Citações inventadas
❌ Dados sem fonte',
'[{"question": "Inventar citação de filósofo é:", "options": ["Permitido", "Fraude que pode zerar"], "correct": 1}, {"question": "Repertório deve ser:", "options": ["Só estatísticas", "Legitimado, pertinente e produtivo", "Só citações"], "correct": 1}]',
35, 'previous', 0),

('enem', 2, 3, 'Estrutura Dissertativa', 'Organização do texto', 
'# Estrutura Dissertativo-Argumentativa

## Estrutura Obrigatória

### INTRODUÇÃO (1 parágrafo)
- Contextualização do tema
- Apresentação da tese
- Indicação dos argumentos

### DESENVOLVIMENTO (2+ parágrafos)
- Um argumento por parágrafo
- Tópico frasal + Repertório + Análise

### CONCLUSÃO (1 parágrafo)
- Retomada da tese
- Proposta de intervenção

## Conectivos Essenciais
| Função | Conectivos |
|--------|-----------|
| Adicionar | Além disso, Ademais |
| Contrastar | Entretanto, Contudo |
| Concluir | Portanto, Logo |',
'[{"question": "Quantos parágrafos mínimos no desenvolvimento?", "options": ["1", "2", "3"], "correct": 1}, {"question": "A introdução deve ter:", "options": ["Proposta de intervenção", "Tese e contextualização"], "correct": 1}]',
40, 'previous', 0),

('enem', 2, 4, 'Tese e Posicionamento', 'Defendendo seu ponto', 
'# Construindo sua Tese

## O que é Tese?
Seu posicionamento claro sobre o tema.

## Características de uma boa tese
- Clara e objetiva
- Defensável com argumentos
- Não óbvia ou superficial

## Exemplos

**Tema:** Violência contra a mulher

❌ *A violência é ruim.* (Óbvio)
✅ *A violência contra a mulher reflete estruturas patriarcais enraizadas que demandam ações educacionais e punitivas.*

## Onde colocar?
- Final da introdução
- Após a contextualização',
'[{"question": "A tese deve ser:", "options": ["Óbvia e simples", "Clara e defensável"], "correct": 1}, {"question": "Onde a tese aparece?", "options": ["No desenvolvimento", "Na introdução"], "correct": 1}]',
35, 'previous', 0),

('enem', 2, 5, 'Tema vs Assunto', 'Diferença crucial', 
'# Tema vs Assunto

## A diferença que te separa de 200

**Assunto**: Amplo, genérico
*Ex: Educação, Meio ambiente, Violência*

**Tema**: Específico, delimitado
*Ex: Desafios da educação inclusiva no Brasil contemporâneo*

## Como identificar o TEMA

1. Leia o comando da proposta
2. Identifique o RECORTE
3. Note as CONDIÇÕES (no Brasil, hoje, etc.)

## Exemplo Prático

**Proposta:** "A invisibilidade do trabalho doméstico no Brasil"

- **Assunto:** Trabalho doméstico
- **Tema:** A INVISIBILIDADE (recorte específico)

Erro: Falar só sobre trabalho doméstico sem abordar a invisibilidade.',
'[{"question": "Tema é igual a assunto?", "options": ["Sim", "Não, tema é mais específico"], "correct": 1}, {"question": "Abordar só o assunto configura:", "options": ["Boa nota", "Tangenciamento"], "correct": 1}]',
40, 'previous', 0);

-- ==================== COMPETÊNCIA 3: ARGUMENTAÇÃO (5 lições) ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('enem', 3, 1, 'Tipos de Argumentos', 'Construindo argumentos sólidos', 
'# Tipos de Argumentos

## 1. Argumento de Autoridade
*"Segundo o sociólogo Zygmunt Bauman..."*

## 2. Argumento por Exemplificação
*"Um exemplo disso é a cidade de Curitiba, onde..."*

## 3. Argumento por Dados
*"Dados do IBGE mostram que 70%..."*

## 4. Argumento por Comparação
*"Diferentemente da Alemanha, o Brasil..."*

## 5. Argumento por Causa/Consequência
*"Isso ocorre porque... Resultando em..."*

## Estrutura do Parágrafo
1. Tópico frasal
2. Desenvolvimento
3. Repertório
4. Análise crítica
5. Fechamento',
'[{"question": "Citar dados do IBGE é:", "options": ["Arg. de autoridade", "Arg. por dados", "Arg. por comparação"], "correct": 1}, {"question": "Tópico frasal serve para:", "options": ["Concluir", "Apresentar ideia principal"], "correct": 1}]',
30, 'free', 0),

('enem', 3, 2, 'Análise Crítica', 'Desenvolvendo autoria', 
'# Análise Crítica

## O que diferencia nota 120 de 200?
A capacidade de INTERPRETAR, não só citar.

## Níveis de Análise

❌ **Básico**: *"O IBGE mostra que 11% são analfabetos."*

⚠️ **Intermediário**: *"...o que é um problema sério."*

✅ **Avançado**: *"...Esse dado revela uma falha sistêmica na educação básica, perpetuando o ciclo de exclusão social, uma vez que esses indivíduos têm acesso limitado ao mercado qualificado."*

## Fórmula
DADO + "isso revela/demonstra que" + INTERPRETAÇÃO + CONEXÃO COM TESE',
'[{"question": "O que caracteriza análise crítica?", "options": ["Só citar dados", "Interpretar e relacionar"], "correct": 1}, {"question": "''Isso é ruim'' é boa análise?", "options": ["Sim", "Não, muito superficial"], "correct": 1}]',
40, 'previous', 0),

('enem', 3, 3, 'Falácias Argumentativas', 'Evitando erros de lógica', 
'# Falácias a Evitar

## 1. Generalização Apressada
❌ *"Todos os políticos são corruptos."*

## 2. Apelo à Emoção
❌ *"Pense nas criancinhas que sofrem..."*

## 3. Falsa Causa
❌ *"Depois que X aconteceu, veio Y, logo X causou Y."*

## 4. Ataque Pessoal (Ad Hominem)
❌ *"Fulano disse X, mas ele é corrupto, logo X é mentira."*

## 5. Falso Dilema
❌ *"Ou acabamos com a pobreza ou acabamos com a violência."*

## Como evitar?
- Base seus argumentos em FATOS
- Use LÓGICA, não emoção
- Considere NUANCES',
'[{"question": "''Todos os jovens são assim'' é:", "options": ["Argumento válido", "Generalização apressada"], "correct": 1}, {"question": "Usar emoção é:", "options": ["Sempre bom", "Falácia se for único argumento"], "correct": 1}]',
35, 'previous', 0),

('enem', 3, 4, 'Progressão Argumentativa', 'Desenvolvendo o raciocínio', 
'# Progressão Argumentativa

## O que é?
O aprofundamento das ideias ao longo do texto.

## Como fazer?

### Parágrafo de Desenvolvimento

1. **Tópico Frasal** - Apresenta o argumento
2. **Explicação** - Desenvolve a ideia
3. **Repertório** - Prova com dados/citação
4. **Análise** - Interpreta criticamente
5. **Link** - Conecta à tese

## Exemplo

*Primeiramente, a negligência estatal contribui para o problema.* [Tópico]
*O Estado brasileiro falha em...*  [Explicação]
*Segundo dados do IPEA...*  [Repertório]
*Esse cenário revela a omissão...*  [Análise]
*perpetuando o problema discutido.*  [Link]',
'[{"question": "Progressão argumentativa é:", "options": ["Repetir a mesma ideia", "Aprofundar o raciocínio"], "correct": 1}, {"question": "O link serve para:", "options": ["Iniciar novo assunto", "Conectar à tese"], "correct": 1}]',
40, 'previous', 0),

('enem', 3, 5, 'Projeto de Texto', 'Planejando antes de escrever', 
'# Projeto de Texto

## Por que planejar?
Evita tangenciamento e garante organização.

## Passo a Passo

### 1. Análise da Proposta (5 min)
- Identifique o TEMA exato
- Note o RECORTE específico

### 2. Brainstorm (5 min)
- Liste possíveis CAUSAS
- Liste possíveis CONSEQUÊNCIAS
- Anote REPERTÓRIOS que conhece

### 3. Seleção (5 min)
- Escolha 2 argumentos fortes
- Defina sua TESE
- Esboce a PROPOSTA

### 4. Estrutura
- INTRO: Contexto + Tese
- D1: Argumento 1 + Repertório
- D2: Argumento 2 + Repertório
- CONCLUSÃO: Retomada + Proposta',
'[{"question": "Projeto de texto ajuda a evitar:", "options": ["Erros de português", "Tangenciamento e desorganização"], "correct": 1}, {"question": "Quantos argumentos são ideais?", "options": ["1 muito desenvolvido", "2 bem desenvolvidos"], "correct": 1}]',
45, 'previous', 0);

-- ==================== COMPETÊNCIA 4: COESÃO (5 lições) ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('enem', 4, 1, 'Coesão Referencial', 'Evitando repetições', 
'# Coesão Referencial

## O que é?
Mecanismos para retomar elementos sem repetir.

## Tipos

### 1. Pronomes
*O Brasil tem problemas. **Ele** precisa melhorar.*

### 2. Sinônimos
*O Brasil tem problemas. **O país** precisa melhorar.*

### 3. Hiperônimos
*O cão fugiu. **O animal** foi encontrado.*

### 4. Elipse
*João estudou. [Ø] Passou no vestibular.*

## Exemplo Ruim vs Bom

❌ *O Brasil tem problemas. O Brasil precisa mudar. O Brasil é um país...*

✅ *O Brasil tem problemas. **O país** precisa mudar. **A nação** é capaz...*',
'[{"question": "Substituir Brasil por ''o país'' é:", "options": ["Coesão sequencial", "Coesão referencial"], "correct": 1}, {"question": "Por que evitar repetições?", "options": ["Estética apenas", "Melhor fluidez e nota"], "correct": 1}]',
30, 'free', 0),

('enem', 4, 2, 'Conectivos Essenciais', 'Ligando as ideias', 
'# Conectivos Essenciais

## Por Função

| Função | Conectivos |
|--------|-----------|
| Adição | além disso, ademais, outrossim |
| Oposição | entretanto, contudo, todavia, no entanto |
| Conclusão | portanto, logo, destarte, assim |
| Causa | pois, porque, uma vez que, visto que |
| Consequência | de modo que, de forma que |
| Tempo | posteriormente, em seguida, então |

## Erros Comuns

❌ Usar o mesmo conectivo várias vezes
❌ Usar conectivo que não combina com a ideia
❌ Não usar conectivos (texto solto)

## Dica de Ouro
Varie os conectivos! Se usou "além disso", use "ademais" depois.',
'[{"question": "Ademais indica:", "options": ["Oposição", "Adição"], "correct": 1}, {"question": "Destarte indica:", "options": ["Conclusão", "Tempo"], "correct": 0}, {"question": "Todavia indica:", "options": ["Adição", "Oposição"], "correct": 1}]',
35, 'previous', 0),

('enem', 4, 3, 'Coesão entre Parágrafos', 'Amarrando o texto', 
'# Coesão entre Parágrafos

## Como conectar parágrafos?

### 1. Retomada
*"**Esse problema** mencionado..."* (retoma anterior)

### 2. Adição
*"**Além desse aspecto**, cabe ressaltar..."*

### 3. Contraste
*"**Em contrapartida**, observa-se..."*

### 4. Consequência
*"**Em decorrência disso**..."*

## Modelo de Transição

**Final do D1:** *...perpetuando desigualdades.*

**Início do D2:** *Além dessa questão estrutural, a negligência do Estado...*

O "além dessa questão estrutural" conecta os dois parágrafos.',
'[{"question": "''Esse problema'' serve para:", "options": ["Adicionar ideia nova", "Retomar parágrafo anterior"], "correct": 1}, {"question": "Parágrafos devem ter:", "options": ["Conexão entre si", "Ideias isoladas"], "correct": 0}]',
40, 'previous', 0),

('enem', 4, 4, 'Operadores Argumentativos', 'Direcionando interpretação', 
'# Operadores Argumentativos

## Tipos

### 1. Ênfase
*Sobretudo, principalmente, especialmente*
*"O Estado deve atuar, **sobretudo** na educação."*

### 2. Atenuação
*Talvez, possivelmente, em certa medida*

### 3. Contraste
*No entanto, porém, todavia*

### 4. Conclusão
*Portanto, logo, assim, destarte*

### 5. Esclarecimento
*Ou seja, isto é, em outras palavras*

## Uso Estratégico
- Use ênfase no ponto mais importante
- Use atenuação em afirmações fortes
- Use esclarecimento para garantir clareza',
'[{"question": "Sobretudo serve para:", "options": ["Atenuar", "Enfatizar"], "correct": 1}, {"question": "Ou seja serve para:", "options": ["Esclarecer", "Contrastar"], "correct": 0}]',
35, 'previous', 0),

('enem', 4, 5, 'Coesão Avançada', 'Técnicas de alto nível', 
'# Coesão Avançada

## Técnicas Sofisticadas

### 1. Encapsulamento
Resumir ideia anterior em um substantivo:
*"...o governo falha na saúde e educação. **Essa negligência** afeta milhões."*

### 2. Catáfora
Anunciar o que virá:
*"O problema é **este**: falta investimento."*

### 3. Antonímia
Usar opostos para contrastar:
*"Enquanto uns têm **excesso**, outros vivem na **escassez**."*

### 4. Paralelismo
Repetir estruturas:
*"Não basta **criar** leis, é preciso **fiscalizar** seu cumprimento e **punir** as violações."*

## Impacto na Nota
Coesão sofisticada = diferencial para nota 200!',
'[{"question": "Encapsulamento é:", "options": ["Resumir ideia em substantivo", "Usar sinônimos apenas"], "correct": 0}, {"question": "Paralelismo melhora:", "options": ["Só estética", "Fluidez e argumentação"], "correct": 1}]',
45, 'previous', 0);

-- ==================== COMPETÊNCIA 5: PROPOSTA (5 lições) ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('enem', 5, 1, 'Os 5 Elementos', 'Estrutura obrigatória', 
'# Os 5 Elementos da Proposta

## Obrigatórios para nota máxima

### 1. 👤 AGENTE
**Quem** executa? (Governo, MEC, Mídia, ONGs...)

### 2. 🎯 AÇÃO
**O que** será feito? (Criar, implementar, fiscalizar...)

### 3. 🔧 MODO/MEIO
**Como** será feito? (Por meio de, através de...)

### 4. 📋 DETALHAMENTO
**Especificação** (Onde, quando, com quem...)

### 5. 📌 FINALIDADE
**Para que** fazer? (A fim de, com objetivo de...)

## Modelo Completo

*"O **MEC** [agente] deve **criar campanhas** [ação] **por meio de parcerias com influenciadores** [modo] **nas redes sociais, semanalmente** [detalhamento], **a fim de conscientizar sobre fake news** [finalidade]."*',
'[{"question": "Quantos elementos obrigatórios?", "options": ["3", "4", "5"], "correct": 2}, {"question": "Agente responde:", "options": ["O que fazer", "Quem faz"], "correct": 1}]',
35, 'free', 0),

('enem', 5, 2, 'Direitos Humanos', 'Evitando nota zero', 
'# Proposta e Direitos Humanos

## ⚠️ PODE ZERAR SUA REDAÇÃO

### ❌ Propostas PROIBIDAS:
1. Pena de morte
2. Tortura ou violência
3. Discriminação
4. Censura
5. Trabalho forçado

### ✅ Propostas ADEQUADAS:
1. Educação e conscientização
2. Políticas públicas inclusivas
3. Fiscalização e punição LEGAL
4. Apoio a vítimas
5. Integração social

## Exemplos

**Tema:** Violência contra mulheres

❌ *"Agressores devem ser linchados."*
✅ *"Aplicação rigorosa da Lei Maria da Penha."*',
'[{"question": "Defender pena de morte:", "options": ["É permitido", "Pode zerar"], "correct": 1}, {"question": "Propor censura:", "options": ["É válido", "Viola liberdade de expressão"], "correct": 1}]',
40, 'previous', 0),

('enem', 5, 3, 'Coerência com Argumentos', 'Conectando conclusão', 
'# Coerência na Proposta

## A Proposta deve resolver o problema discutido!

### ❌ Incoerente

**Argumentou:** Falta de educação financeira nas escolas.
**Proposta:** "Investir mais em saúde."

### ✅ Coerente

**Argumentou:** Falta de educação financeira nas escolas.
**Proposta:** "MEC deve incluir educação financeira como disciplina obrigatória."

## Estrutura da Conclusão

1. Retomada da tese (1-2 linhas)
2. Proposta 1 → Ligada ao Argumento 1
3. Proposta 2 (opcional) → Ligada ao Arg. 2',
'[{"question": "Proposta deve se relacionar a:", "options": ["Qualquer tema", "Argumentos desenvolvidos"], "correct": 1}, {"question": "Proposta genérica é suficiente?", "options": ["Sim", "Não, faltam elementos"], "correct": 1}]',
35, 'previous', 0),

('enem', 5, 4, 'Agentes Específicos', 'Quem pode agir?', 
'# Escolhendo o Agente Correto

## Agentes Comuns

### Governo
- **Poder Executivo**: Ministérios, Prefeituras
- **Poder Legislativo**: Criar/modificar leis
- **Poder Judiciário**: Fiscalizar, punir

### Sociedade Civil
- **Mídia**: Campanhas, divulgação
- **ONGs**: Projetos sociais
- **Escolas**: Educação, formação
- **Empresas**: Responsabilidade social
- **Famílias**: Educação doméstica

## Dica de Ouro
Escolha agentes que PODEM agir sobre o problema!

**Problema ambiental** → Ministério do Meio Ambiente
**Problema educacional** → MEC, Escolas
**Problema de saúde** → Ministério da Saúde',
'[{"question": "Para problemas educacionais, o melhor agente é:", "options": ["Ministério da Saúde", "MEC ou Escolas"], "correct": 1}, {"question": "ONGs podem ser agentes?", "options": ["Não", "Sim"], "correct": 1}]',
40, 'previous', 0),

('enem', 5, 5, 'Proposta Nota 200', 'Exemplo completo', 
'# Construindo a Proposta Perfeita

## Checklist Final

☐ AGENTE específico e capaz
☐ AÇÃO concreta e realizável
☐ MODO/MEIO de execução claro
☐ DETALHAMENTO suficiente
☐ FINALIDADE conectada ao tema
☐ RESPEITA direitos humanos
☐ COERENTE com argumentos

## Exemplo Nota 200

**Tema:** Evasão escolar no Brasil

*"Portanto, medidas são necessárias. O **Ministério da Educação** [agente], em parceria com as secretarias estaduais, deve **implementar programas de bolsa-permanência** [ação] **por meio de transferência de renda condicionada à frequência** [modo], **destinados a famílias de baixa renda em todo território nacional** [detalhamento], **a fim de garantir que jovens em vulnerabilidade permaneçam na escola e concluam o ensino básico** [finalidade]."*',
'[{"question": "Uma boa proposta deve ter:", "options": ["Apenas agente e ação", "Todos os 5 elementos"], "correct": 1}, {"question": "A proposta deve ser:", "options": ["Genérica", "Específica e detalhada"], "correct": 1}]',
50, 'previous', 0);

SELECT 'Criadas ' || COUNT(*) || ' lições com sucesso!' as status FROM lesson;
