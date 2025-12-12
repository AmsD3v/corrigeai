-- Lições UNESP e ITA/IME
-- Execute após create_licoes_vestibulares.sql

-- ============================================================================
-- UNESP - 20 LIÇÕES (5 por critério)
-- Critérios: 1-Desenvolvimento do Tema, 2-Organização, 3-Coerência/Coesão, 4-Norma Culta
-- ============================================================================

-- CRITÉRIO 1: DESENVOLVIMENTO DO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unesp', 1, 1, 'A Redação UNESP', 'Conhecendo a prova', 
'# A Redação da UNESP

## Características
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Tema:** Baseado em textos de apoio
- **Nota:** 0 a 100 pontos

## Critérios
1. Desenvolvimento do tema
2. Organização textual
3. Coerência e coesão
4. Norma culta

## Diferenças de outros vestibulares
- Temas mais diretos e sociais
- Textos de apoio mais curtos
- Valoriza posicionamento claro',
'[{"question": "A UNESP cobra dissertação-argumentativa?", "options": ["Sim", "Não"], "correct": 0}, {"question": "Extensão recomendada:", "options": ["10-15 linhas", "25-30 linhas"], "correct": 1}]',
30, 'free', 0),

('unesp', 1, 2, 'Textos de Apoio', 'Usando o material fornecido', 
'# Textos de Apoio UNESP

## Características
- 2 a 4 textos curtos
- Perspectivas variadas
- Dados e opiniões

## Como usar
1. Leia todos atentamente
2. Identifique a questão central
3. Encontre argumentos
4. NÃO COPIE - parafraseie

## Estratégia
Use os textos como ponto de partida, mas VÁ ALÉM com seu repertório.',
'[{"question": "Deve usar apenas os textos de apoio?", "options": ["Sim", "Não, deve ir além"], "correct": 1}]',
35, 'previous', 0),

('unesp', 1, 3, 'Tese Clara', 'Posicionando-se sobre o tema', 
'# Construindo a Tese

## O que é uma boa tese?
- Posicionamento claro
- Defensável com argumentos
- Presente na introdução
- Retomada na conclusão

## Exemplos
**Tema:** Impactos das redes sociais

❌ "As redes sociais têm pontos positivos e negativos"
✅ "Embora facilitem a comunicação, as redes sociais aprofundam a superficialidade das relações"',
'[{"question": "Uma boa tese é:", "options": ["Vaga e genérica", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('unesp', 1, 4, 'Argumentação Sólida', 'Construindo defesas', 
'# Argumentos na UNESP

## Tipos valorizados
- **Dados:** Estatísticas confiáveis
- **Exemplos:** Casos concretos
- **Autoridade:** Especialistas
- **Históricos:** Contexto temporal

## Estrutura do argumento
1. Afirmação (tópico frasal)
2. Fundamentação (evidência)
3. Análise (interpretação)
4. Conexão com a tese

## Quantidade ideal
2-3 argumentos bem desenvolvidos',
'[{"question": "Quantos argumentos são ideais?", "options": ["1", "2-3", "5+"], "correct": 1}]',
45, 'previous', 0),

('unesp', 1, 5, 'Repertório Atualizado', 'Conhecimentos contemporâneos', 
'# Repertório para UNESP

## Fontes recomendadas
- Jornais de qualidade
- Revistas científicas
- Documentários
- Dados oficiais (IBGE, OMS)

## Temas recorrentes
- Meio ambiente
- Tecnologia
- Educação
- Desigualdade social
- Saúde pública

## Dica de ouro
Mantenha fichas de repertório por tema para consulta rápida.',
'[{"question": "Repertório atualizado vem de:", "options": ["Redes sociais apenas", "Fontes confiáveis variadas"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ORGANIZAÇÃO TEXTUAL (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unesp', 2, 1, 'Estrutura da Dissertação', 'Organizando o texto', 
'# Estrutura UNESP

## Modelo recomendado

### Introdução (5-7 linhas)
- Contextualização
- Tese clara

### Desenvolvimento (15-18 linhas)
- 2 parágrafos
- 1 argumento + exemplo cada
- Progressão lógica

### Conclusão (5-7 linhas)
- Retomada da tese
- Proposta ou reflexão final',
'[{"question": "Quantos parágrafos de desenvolvimento?", "options": ["1", "2", "4"], "correct": 1}]',
30, 'free', 0),

('unesp', 2, 2, 'Introdução Eficiente', 'Abrindo bem o texto', 
'# A Introdução

## Elementos
1. Frase de abertura (contexto)
2. Delimitação do tema
3. Apresentação da tese

## Estratégias de abertura
- Dado estatístico
- Citação relevante
- Fato histórico
- Pergunta retórica

## Exemplo
*"Segundo o IBGE, 70% dos brasileiros... [dado] Esse cenário revela que... [tema] Portanto, é urgente... [tese]"*',
'[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto, tema e tese"], "correct": 1}]',
35, 'previous', 0),

('unesp', 2, 3, 'Desenvolvimento Progressivo', 'Avançando ideias', 
'# Parágrafos de Desenvolvimento

## Estrutura do parágrafo
1. **Tópico frasal:** Ideia principal
2. **Desenvolvimento:** Argumentação
3. **Exemplificação:** Caso concreto
4. **Fechamento:** Conexão com a tese

## Progressão
D1 → D2: crescente em complexidade

## Conectivos de progressão
- "Além disso..."
- "Mais ainda..."
- "Soma-se a isso..."',
'[{"question": "Parágrafos devem:", "options": ["Repetir ideias", "Progredir em complexidade"], "correct": 1}]',
40, 'previous', 0),

('unesp', 2, 4, 'Conclusão Propositiva', 'Fechando com força', 
'# A Conclusão UNESP

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## O que evitar
❌ Iniciar com "Portanto, conclui-se..."
❌ Introduzir argumento novo
❌ Ser repetitivo

## Dica
Faça uma projeção futura ou chamado à reflexão.',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
45, 'previous', 0),

('unesp', 2, 5, 'Proporção e Equilíbrio', 'Balanceando o texto', 
'# Equilíbrio Textual

## Proporção ideal
- Introdução: ~20%
- Desenvolvimento: ~60%
- Conclusão: ~20%

## Checklist de equilíbrio
- [ ] Parágrafos de tamanho similar?
- [ ] Argumentos igualmente desenvolvidos?
- [ ] Transições claras?

## Erro comum
Desenvolvimento 1 extenso, Desenvolvimento 2 curto.',
'[{"question": "Desenvolvimento deve ocupar:", "options": ["20%", "60%", "90%"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: COERÊNCIA E COESÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unesp', 3, 1, 'Coerência Textual', 'Sentido do texto', 
'# Coerência

## O que é?
Sentido global do texto - as ideias fazem sentido juntas.

## Tipos
- **Interna:** Entre partes do texto
- **Externa:** Com a realidade
- **Argumentativa:** Lógica das ideias

## Problemas comuns
❌ Contradição entre parágrafos
❌ Afirmações sem fundamento
❌ Conclusão oposta à tese',
'[{"question": "Coerência é:", "options": ["Conexão entre frases", "Sentido global do texto"], "correct": 1}]',
30, 'free', 0),

('unesp', 3, 2, 'Coesão Referencial', 'Retomando termos', 
'# Coesão Referencial

## Mecanismos
1. **Pronomes:** ele, isso, tal
2. **Sinônimos:** variação lexical
3. **Hiperônimos:** termo mais geral
4. **Elipse:** omissão intencional

## Exemplo
*"A tecnologia... Ela... Esse avanço... Tal fenômeno..."*

## Evite
❌ Repetição excessiva do mesmo termo',
'[{"question": "Coesão referencial usa:", "options": ["Repetição", "Pronomes e sinônimos"], "correct": 1}]',
35, 'previous', 0),

('unesp', 3, 3, 'Conectivos', 'Ligando ideias', 
'# Conectivos

## Por função

### Adição
Além disso, ademais, outrossim

### Oposição
Contudo, entretanto, não obstante

### Conclusão
Portanto, logo, destarte

### Explicação
Ou seja, isto é, a saber

### Causa
Porque, visto que, uma vez que

### Consequência
Por isso, assim, de modo que',
'[{"question": "''Contudo'' indica:", "options": ["Adição", "Oposição", "Conclusão"], "correct": 1}]',
40, 'previous', 0),

('unesp', 3, 4, 'Transições entre Parágrafos', 'Fluidez textual', 
'# Transições

## Técnicas
1. Retomar palavra-chave do parágrafo anterior
2. Usar conectivo adequado
3. Fazer ponte temática

## Exemplo
*"...impacta a educação."*
*"Além da educação, a economia também sofre..."*

## Erro comum
❌ Parágrafos desconexos
✅ Referência ao anterior',
'[{"question": "Transições conectam:", "options": ["Frases apenas", "Parágrafos entre si"], "correct": 1}]',
45, 'previous', 0),

('unesp', 3, 5, 'Progressão Temática', 'Avançando o tema', 
'# Progressão

## O que é?
Cada parte do texto acrescenta informação nova.

## Tipos
- **Linear:** Cada frase adiciona info
- **Constante:** Retoma tema e expande
- **Derivada:** Tema gera subtemas

## Checklist
- [ ] Há informação nova em cada parágrafo?
- [ ] As ideias avançam logicamente?
- [ ] Não há redundância?',
'[{"question": "Progressão significa:", "options": ["Repetir ideias", "Avançar com informações novas"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unesp', 4, 1, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
O verbo concorda com o sujeito.

*"Os alunos estudam" ✅*
*"Os alunos estuda" ❌*

## Nominal
Adjetivos concordam com substantivos.

*"Questões importantes" ✅*
*"Questões importante" ❌*

## Casos especiais
- Sujeito composto posposto
- Expressões partitivas
- Verbos impessoais',
'[{"question": "Concordância verbal é entre:", "options": ["Verbo e objeto", "Verbo e sujeito"], "correct": 1}]',
30, 'free', 0),

('unesp', 4, 2, 'Regência', 'Verbal e nominal', 
'# Regência

## Verbal
*"Assistir ao filme" ✅*
*"Assistir o filme" ❌*

## Verbos problemáticos
- Preferir: A a B (não "do que")
- Visar: A algo (com preposição)
- Obedecer: A algo/alguém

## Nominal
*"Capacidade de..." ✅*
*"Capacidade em..." ❌*',
'[{"question": "''Assistir'' (ver) rege:", "options": ["Objeto direto", "Objeto indireto (a)"], "correct": 1}]',
35, 'previous', 0),

('unesp', 4, 3, 'Crase', 'Quando usar', 
'# Crase

## Regra básica
a (preposição) + a (artigo) = à

## Usa-se
- Antes de palavras femininas
- Com locuções femininas
- Indicando hora

*"Vou à escola" ✅*

## Não usa-se
- Antes de masculinos
- Antes de verbos
- Antes de "a distância"

*"Vou a pé" ✅*',
'[{"question": "Crase é:", "options": ["Acento", "Fusão de preposição + artigo"], "correct": 1}]',
40, 'previous', 0),

('unesp', 4, 4, 'Pontuação', 'Vírgulas e mais', 
'# Pontuação

## Vírgula - USA-SE
- Separar itens de lista
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
❌ Entre sujeito e verbo
❌ Entre verbo e complemento

## Outros sinais
- Ponto e vírgula: orações coordenadas longas
- Dois-pontos: explicação, citação
- Travessão: destaque',
'[{"question": "Pode usar vírgula entre sujeito e verbo?", "options": ["Sim", "Não"], "correct": 1}]',
45, 'previous', 0),

('unesp', 4, 5, 'Revisão Gramatical', 'Polindo o texto', 
'# Checklist de Revisão

## Concordância
- [ ] Verbos concordam com sujeitos?
- [ ] Adjetivos concordam?

## Regência
- [ ] Preposições corretas?
- [ ] Crases adequadas?

## Pontuação
- [ ] Vírgulas bem colocadas?
- [ ] Pontos finais presentes?

## Dica
Leia em voz baixa para identificar erros.',
'[{"question": "Revisão deve ser feita:", "options": ["Nunca", "Nos últimos 10 minutos"], "correct": 1}]',
50, 'previous', 0);

-- ============================================================================
-- ITA/IME - 20 LIÇÕES (5 por critério)
-- Critérios: 1-Argumentação Técnica, 2-Estrutura Lógica, 3-Linguagem Precisa, 4-Repertório
-- ============================================================================

-- CRITÉRIO 1: ARGUMENTAÇÃO TÉCNICA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ita', 1, 1, 'A Redação ITA', 'Rigor técnico', 
'# A Redação do ITA

## Características
- **Rigor técnico** na argumentação
- **Temas científicos/tecnológicos** frequentes
- **Extensão:** 20 a 30 linhas
- **Valoriza:** lógica e precisão

## Diferencial
O ITA espera argumentação precisa, quase científica.

## O que a banca busca
- Clareza de raciocínio
- Argumentos fundamentados
- Linguagem objetiva
- Pensamento analítico',
'[{"question": "O ITA valoriza:", "options": ["Argumentação emocional", "Argumentação lógica e precisa"], "correct": 1}]',
30, 'free', 0),

('ita', 1, 2, 'Argumentação Científica', 'Método e rigor', 
'# Argumentação Científica

## Características
- Baseada em evidências
- Lógica causa-consequência
- Dados quantitativos
- Fontes confiáveis

## Estrutura
1. Premissa verificável
2. Desenvolvimento lógico
3. Conclusão fundamentada

## Evite
❌ "Muitas pessoas pensam..."
❌ "Desde os primórdios..."
✅ "Segundo estudo da USP (2023), 73%..."',
'[{"question": "Argumento científico é baseado em:", "options": ["Opiniões pessoais", "Evidências e dados"], "correct": 1}]',
35, 'previous', 0),

('ita', 1, 3, 'Dados e Estatísticas', 'Usando números', 
'# Uso de Dados

## Por que usar?
O ITA valoriza argumentação quantitativa.

## Como usar corretamente
1. Cite a fonte
2. Contextualize o dado
3. Analise o significado
4. Conecte com a tese

## Exemplo
*"De acordo com o IPCC (2023), a temperatura global aumentou 1,1°C desde a era pré-industrial. Este dado evidencia que..."*

## Cuidados
- Use fontes confiáveis
- Não invente números',
'[{"question": "Ao citar dados, deve:", "options": ["Inventar números", "Citar a fonte"], "correct": 1}]',
40, 'previous', 0),

('ita', 1, 4, 'Raciocínio Lógico', 'Construindo deduções', 
'# Lógica na Argumentação

## Tipos de raciocínio
- **Dedutivo:** Geral → Particular
- **Indutivo:** Particular → Geral
- **Analógico:** Comparação

## Exemplo dedutivo
*"Toda tecnologia gera impactos ambientais. [premissa geral] A IA é uma tecnologia. [premissa específica] Logo, a IA gera impactos ambientais. [conclusão]"*

## Evite falácias
- Generalização apressada
- Falsa causa
- Apelo à autoridade inválida',
'[{"question": "Raciocínio dedutivo vai do:", "options": ["Particular ao geral", "Geral ao particular"], "correct": 1}]',
45, 'previous', 0),

('ita', 1, 5, 'Contra-argumentação Técnica', 'Antecipando objeções', 
'# Contra-argumentação

## Por que fazer?
Demonstra maturidade intelectual e domínio do tema.

## Estrutura
1. Apresente a objeção
2. Reconheça sua validade parcial
3. Refute com evidências
4. Reforce sua posição

## Exemplo
*"Poder-se-ia argumentar que a energia nuclear é perigosa. De fato, acidentes como Chernobyl ocorreram. Entretanto, dados recentes mostram que... Portanto, quando bem gerida..."*',
'[{"question": "Contra-argumentação demonstra:", "options": ["Fraqueza", "Maturidade intelectual"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA LÓGICA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ita', 2, 1, 'Estrutura Analítica', 'Organizando logicamente', 
'# Estrutura para ITA

## Modelo recomendado
1. **Introdução:** Contexto + tese clara
2. **D1:** Argumento principal
3. **D2:** Argumento secundário ou contra-argumentação
4. **Conclusão:** Síntese lógica

## Diferencial
A estrutura deve refletir um raciocínio, não apenas organização.',
'[{"question": "Estrutura no ITA deve refletir:", "options": ["Apenas organização", "Raciocínio lógico"], "correct": 1}]',
30, 'free', 0),

('ita', 2, 2, 'Introdução Precisa', 'Abrindo com clareza', 
'# Introdução ITA

## Elementos
1. Contextualização objetiva
2. Delimitação do problema
3. Tese clara e direta

## Evite
- Introduções vagas
- Frases de efeito vazias
- Contextualizações longas

## Ideal
Ir direto ao ponto com precisão.',
'[{"question": "Introdução no ITA deve ser:", "options": ["Longa e detalhada", "Precisa e direta"], "correct": 1}]',
35, 'previous', 0),

('ita', 2, 3, 'Desenvolvimento Estruturado', 'Parágrafos analíticos', 
'# Parágrafos Analíticos

## Estrutura PEAL
- **P**onto: Afirmação central
- **E**vidência: Dado/exemplo
- **A**nálise: Interpretação
- **L**ink: Conexão com tese

## Exemplo
*"A IA transforma a indústria [P]. Segundo relatório da McKinsey, 50% das tarefas podem ser automatizadas [E]. Isso significa redução de custos e aumento de eficiência [A]. Portanto, a adoção de IA é estratégica [L]."*',
'[{"question": "PEAL significa:", "options": ["Ponto, Evidência, Análise, Link", "Parágrafo, Estrutura, Argumento, Lógica"], "correct": 0}]',
40, 'previous', 0),

('ita', 2, 4, 'Progressão Lógica', 'Avançando o raciocínio', 
'# Progressão no ITA

## Princípio
Cada parte do texto deve avançar o raciocínio.

## Técnicas
- Do simples ao complexo
- Da premissa à conclusão
- Do geral ao específico

## Conectivos de progressão
- "Consequentemente..."
- "A partir disso..."
- "Tal análise revela..."',
'[{"question": "Progressão lógica vai:", "options": ["Do complexo ao simples", "Do simples ao complexo"], "correct": 1}]',
45, 'previous', 0),

('ita', 2, 5, 'Conclusão Sintética', 'Fechando com precisão', 
'# Conclusão ITA

## Elementos
1. Retomada sintética da tese
2. Síntese das evidências
3. Projeção ou implicação

## Evite
- Novas informações
- Conclusões desconectadas
- Frases vazias

## Modelo
*"A análise evidenciou que... [síntese] Isso implica... [consequência] Portanto... [conclusão final]"*',
'[{"question": "Conclusão pode ter informação nova?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: LINGUAGEM PRECISA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ita', 3, 1, 'Precisão Lexical', 'Escolha de palavras', 
'# Vocabulário Preciso

## Princípio
Cada palavra deve ter função clara.

## Substituições
| Vago | Preciso |
|------|---------|
| Coisa | Fator, elemento, aspecto |
| Muito | Significativo, expressivo |
| Problema | Desafio, entrave, impasse |

## Evite
- "Basicamente..."
- "Na verdade..."
- "De certa forma..."',
'[{"question": "Linguagem precisa evita:", "options": ["Termos específicos", "Termos vagos"], "correct": 1}]',
30, 'free', 0),

('ita', 3, 2, 'Vocabulário Técnico', 'Termos especializados', 
'# Termos Técnicos

## Quando usar
- Se dominar o conceito
- Se for relevante ao tema
- Se puder explicar se necessário

## Áreas úteis
- Economia: PIB, inflação, recessão
- Tecnologia: algoritmo, machine learning
- Ciência: hipótese, variável, correlação

## Cuidado
Use apenas termos que conhece bem.',
'[{"question": "Vocabulário técnico deve ser:", "options": ["Usado sempre", "Usado com domínio"], "correct": 1}]',
35, 'previous', 0),

('ita', 3, 3, 'Objetividade', 'Sem rodeios', 
'# Linguagem Objetiva

## Características
- Frases diretas
- Voz ativa preferível
- Sem redundâncias

## Exemplos
❌ "Pode-se dizer que é possível afirmar que..."
✅ "Os dados indicam que..."

❌ "É importante ressaltar o fato de que..."
✅ "Destaca-se que..."',
'[{"question": "Objetividade usa:", "options": ["Muitos rodeios", "Frases diretas"], "correct": 1}]',
40, 'previous', 0),

('ita', 3, 4, 'Impessoalidade', 'Tom acadêmico', 
'# Tom Impessoal

## Técnicas
- Terceira pessoa
- Verbos impessoais
- Construções passivas

## Exemplos
❌ "Eu penso que..."
✅ "Evidencia-se que..."

❌ "Na minha opinião..."
✅ "A análise revela..."

## Exceção
Primeira pessoa do plural científico: "Observamos que..."',
'[{"question": "No ITA, evita-se:", "options": ["Impessoalidade", "Primeira pessoa singular"], "correct": 1}]',
45, 'previous', 0),

('ita', 3, 5, 'Revisão de Estilo', 'Polindo a linguagem', 
'# Checklist de Linguagem

## Precisão
- [ ] Todas as palavras são necessárias?
- [ ] Há termos vagos para substituir?

## Objetividade
- [ ] As frases são diretas?
- [ ] Há redundâncias?

## Impessoalidade
- [ ] Evitei "eu acho"?
- [ ] Usei construções impessoais?

## Dica final
Cada frase deve ter função clara.',
'[{"question": "Revisão de estilo foca em:", "options": ["Tamanho do texto", "Precisão e objetividade"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: REPERTÓRIO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ita', 4, 1, 'Temas Científicos', 'Preparando-se', 
'# Repertório Científico

## Áreas frequentes
- Inteligência artificial
- Mudanças climáticas
- Biotecnologia
- Energia e sustentabilidade
- Espaço e astronomia

## Fontes
- Scientific American Brasil
- Nature (divulgação)
- Pesquisa FAPESP
- Relatórios ONU/IPCC',
'[{"question": "Temas científicos são comuns no ITA?", "options": ["Sim", "Não"], "correct": 0}]',
30, 'free', 0),

('ita', 4, 2, 'Ética na Ciência', 'Debates contemporâneos', 
'# Dilemas Éticos

## Temas
- Privacidade de dados
- Edição genética (CRISPR)
- Armas autônomas
- Clonagem
- Experimentação animal

## Abordagem
1. Apresente o dilema
2. Mostre os lados
3. Analise criticamente
4. Posicione-se com fundamentação',
'[{"question": "Dilemas éticos devem ser:", "options": ["Ignorados", "Analisados criticamente"], "correct": 1}]',
35, 'previous', 0),

('ita', 4, 3, 'Tecnologia e Sociedade', 'Impactos sociais', 
'# Tecnologia e Sociedade

## Tópicos
- Automação e emprego
- Redes sociais e democracia
- Vigilância digital
- Fake news e desinformação
- Digital divide

## Análise
Considere sempre:
- Benefícios
- Riscos
- Desafios
- Soluções',
'[{"question": "Análise de tecnologia considera:", "options": ["Apenas benefícios", "Benefícios, riscos e soluções"], "correct": 1}]',
40, 'previous', 0),

('ita', 4, 4, 'Inovação e Progresso', 'História da ciência', 
'# Contexto Histórico

## Marcos úteis
- Revoluções industriais (1ª a 4ª)
- Revolução digital
- Lei de Moore
- Corrida espacial
- Desenvolvimento de vacinas

## Como usar
Conecte eventos históricos com debates atuais.

## Exemplo
*"Assim como a 1ª Revolução Industrial transformou o trabalho, a IA promove nova transformação..."*',
'[{"question": "Contexto histórico serve para:", "options": ["Preencher espaço", "Conectar com debates atuais"], "correct": 1}]',
45, 'previous', 0),

('ita', 4, 5, 'Construindo Repertório', 'Estudo contínuo', 
'# Mantendo-se Atualizado

## Rotina sugerida
- Diariamente: 15 min de notícias científicas
- Semanalmente: 1 artigo de divulgação
- Mensalmente: 1 documentário

## Organização
Crie fichas:
- Tema
- Dados principais
- Autores/fontes
- Aplicações possíveis

## Dica final
Repertório se constrói ao longo do tempo, não na véspera.',
'[{"question": "Repertório se constrói:", "options": ["Na véspera da prova", "Ao longo do tempo"], "correct": 1}]',
50, 'previous', 0);

SELECT 'Criadas ' || COUNT(*) || ' lições!' as status FROM lesson;
