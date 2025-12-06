-- UERJ - Conquistas e 20 Lições (5 por critério)
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/uerj.sql

-- ============================================================================
-- CONQUISTAS UERJ
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UERJ
('uerj_essays_1', 'Primeira Redação UERJ', 'Enviou sua primeira redação UERJ', '📝', 'uerj', 'essays_count', 1, 25, 0),
('uerj_essays_5', 'Escritor UERJ', 'Enviou 5 redações UERJ', '✍️', 'uerj', 'essays_count', 5, 50, 1),
('uerj_essays_10', 'Redator Dedicado UERJ', 'Enviou 10 redações UERJ', '📚', 'uerj', 'essays_count', 10, 100, 2),

-- Notas UERJ (0-100)
('uerj_bronze', 'Nota Bronze UERJ', 'Atingiu 60+ na UERJ', '🥉', 'uerj', 'score', 60, 100, 2),
('uerj_prata', 'Nota Prata UERJ', 'Atingiu 80+ na UERJ', '🥈', 'uerj', 'score', 80, 200, 5),
('uerj_ouro', 'Nota Ouro UERJ', 'Atingiu 90+ na UERJ', '🥇', 'uerj', 'score', 90, 300, 10),

-- Lições UERJ
('uerj_lessons_5', 'Iniciante UERJ', 'Completou 5 lições da UERJ', '📖', 'uerj', 'lessons', 5, 50, 1),
('uerj_lessons_15', 'Estudante UERJ', 'Completou 15 lições da UERJ', '📚', 'uerj', 'lessons', 15, 150, 3),
('uerj_lessons_20', 'Mestre UERJ', 'Completou todas as 20 lições UERJ', '🎓', 'uerj', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UERJ - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Desenvolvimento Argumentativo, 3-Progressão Textual, 4-Adequação Linguística
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('uerj', 1, 1, 'A Redação UERJ', 'Conhecendo a prova', 
'# A Redação da UERJ

## Características
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Tema:** Questões sociais e atualidades
- **Nota:** 0 a 10 pontos (multiplicado por fator)

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Desenvolvimento argumentativo
3. Progressão textual
4. Adequação linguística

## Diferencial UERJ
- Temas voltados à realidade carioca/brasileira
- Valoriza posicionamento crítico
- Aceita referências culturais diversas',
'[{"question": "A redação UERJ avalia quantos critérios?", "options": ["3", "4", "5"], "correct": 1}, {"question": "Qual a extensão recomendada?", "options": ["10-20 linhas", "20-30 linhas", "30-40 linhas"], "correct": 1}]',
30, 'free', 0),

('uerj', 1, 2, 'Interpretando a Proposta', 'Como entender o tema', 
'# Análise da Proposta

## Elementos da Proposta UERJ
1. **Comando:** O que é pedido
2. **Tema:** Assunto delimitado
3. **Coletânea:** Textos de apoio

## Estratégia de Leitura
1. Leia o comando primeiro
2. Identifique palavras-chave
3. Leia a coletânea buscando argumentos
4. Defina seu posicionamento

## Armadilhas
❌ Responder apenas parte do tema
❌ Fugir para assunto relacionado
❌ Copiar a coletânea',
'[{"question": "O comando deve ser lido:", "options": ["Após a coletânea", "Antes da coletânea"], "correct": 1}, {"question": "Copiar coletânea:", "options": ["É permitido", "Prejudica a nota"], "correct": 1}]',
35, 'previous', 0),

('uerj', 1, 3, 'Recorte Temático', 'Delimitando o assunto', 
'# Recorte Temático

## O que é?
A delimitação específica dentro de um assunto amplo.

## Exemplo
**Assunto:** Educação
**Tema UERJ:** "Os impactos da pandemia na educação pública carioca"

## Como identificar
- Leia todas as condições do tema
- Note especificadores: "no Brasil", "hoje", "jovens"
- Relacione com a coletânea

## Erro grave
Falar do assunto geral sem abordar o recorte específico = tangenciamento',
'[{"question": "Tangenciamento ocorre quando:", "options": ["Foge do tema", "Aborda só o assunto geral", "Copia textos"], "correct": 1}]',
40, 'previous', 0),

('uerj', 1, 4, 'Posicionamento Crítico', 'Defendendo sua tese', 
'# Posicionamento na UERJ

## Tese Clara
- Apresente sua opinião de forma explícita
- Seja defensável com argumentos
- Evite senso comum

## Exemplo
**Tema:** Cotas raciais

❌ "As cotas são um tema polêmico"
✅ "As cotas raciais constituem reparação histórica necessária para reduzir desigualdades estruturais"

## Onde posicionar
- Final da introdução
- Retomar na conclusão',
'[{"question": "Tese deve ser:", "options": ["Vaga e neutra", "Clara e defensável"], "correct": 1}]',
45, 'previous', 0),

('uerj', 1, 5, 'Temas Recorrentes', 'O que a UERJ costuma cobrar', 
'# Temas Frequentes UERJ

## Áreas
- Questões sociais brasileiras
- Cidadania e direitos
- Cultura e identidade
- Meio ambiente urbano
- Educação e trabalho

## Dica
A UERJ valoriza olhar crítico sobre a realidade carioca e brasileira.

## Repertório útil
- Constituição Federal
- Estatutos (ECA, Idoso)
- Dados sobre RJ
- Autores brasileiros',
'[{"question": "A UERJ valoriza:", "options": ["Repertório internacional apenas", "Olhar crítico sobre realidade brasileira"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: DESENVOLVIMENTO ARGUMENTATIVO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('uerj', 2, 1, 'Argumentação Sólida', 'Construindo argumentos', 
'# Argumentação na UERJ

## Tipos de Argumento
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas, autores
4. **Causa-consequência:** Relações lógicas

## Estrutura
1. Afirmação (tópico frasal)
2. Fundamentação
3. Exemplo/dado
4. Análise crítica
5. Conexão com tese',
'[{"question": "Quantos elementos tem um bom argumento?", "options": ["2", "3-5", "7+"], "correct": 1}]',
30, 'free', 0),

('uerj', 2, 2, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório na UERJ

## Fontes Valorizadas
- Dados oficiais (IBGE, IPEA)
- Leis e documentos
- Autores e pensadores
- Fatos históricos
- Obras artísticas

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente
4. Não apenas "decoreba"

## Repertório local
A UERJ valoriza conhecimento sobre Rio de Janeiro e Brasil.',
'[{"question": "Repertório deve ser:", "options": ["Apenas citado", "Citado e analisado"], "correct": 1}]',
35, 'previous', 0),

('uerj', 2, 3, 'Análise Crítica', 'Aprofundando argumentos', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica a sociedade"
✅ Avançado: "Esse cenário perpetua desigualdades estruturais, uma vez que..."

## Fórmula
DADO + "isso revela/demonstra" + INTERPRETAÇÃO + CONEXÃO

## Exemplo
"Segundo o IBGE, 40% dos jovens não concluem o ensino médio. Esse dado evidencia uma falha sistêmica na retenção escolar, perpetuando o ciclo de exclusão social."',
'[{"question": "Análise crítica vai além de:", "options": ["Citar dados", "Apenas descrever"], "correct": 1}]',
40, 'previous', 0),

('uerj', 2, 4, 'Contra-argumentação', 'Fortalecendo sua posição', 
'# Contra-argumentação

## O que é?
Antecipar objeções e refutá-las.

## Estrutura
1. Apresente visão contrária
2. Reconheça parcialmente
3. Refute com argumentos
4. Reforce sua tese

## Exemplo
"Alguns argumentam que... Entretanto, tal visão desconsidera que... Portanto, mantém-se que..."

## Benefício
Demonstra maturidade e domínio do tema.',
'[{"question": "Contra-argumentação serve para:", "options": ["Enfraquecer sua tese", "Fortalecer sua posição"], "correct": 1}]',
45, 'previous', 0),

('uerj', 2, 5, 'Autoria', 'Desenvolvendo voz própria', 
'# Autoria na Redação

## O que é?
Sua capacidade de interpretar, não apenas reproduzir.

## Características
- Opinião fundamentada
- Análise original
- Conexões criativas
- Vocabulário próprio

## Como desenvolver
1. Leia diversos gêneros
2. Pratique interpretação
3. Forme opinião sobre temas
4. Escreva com regularidade',
'[{"question": "Autoria significa:", "options": ["Copiar bem", "Interpretar e criar"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: PROGRESSÃO TEXTUAL (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('uerj', 3, 1, 'Estrutura do Texto', 'Organizando parágrafos', 
'# Estrutura Dissertativa

## Modelo UERJ
- **Introdução:** Contexto + tese
- **D1:** Primeiro argumento
- **D2:** Segundo argumento
- **Conclusão:** Retomada + fechamento

## Proporção
- Intro: ~20% do texto
- Desenvolvimento: ~60%
- Conclusão: ~20%',
'[{"question": "Desenvolvimento ocupa:", "options": ["20%", "40%", "60%"], "correct": 2}]',
30, 'free', 0),

('uerj', 3, 2, 'Introdução Eficaz', 'Abrindo o texto', 
'# A Introdução

## Elementos
1. Frase de abertura (contexto)
2. Delimitação do tema
3. Tese clara

## Estratégias
- Citação relevante
- Dado estatístico
- Contextualização histórica
- Pergunta retórica

## Evite
- Introduções longas demais
- Ir direto à tese sem contexto
- Frases vazias',
'[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tema + tese"], "correct": 1}]',
35, 'previous', 0),

('uerj', 3, 3, 'Parágrafos Progressivos', 'Avançando ideias', 
'# Progressão Textual

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura do parágrafo
1. Tópico frasal
2. Desenvolvimento
3. Exemplificação
4. Análise
5. Conexão

## Conexão entre parágrafos
Use conectivos e retomadas para criar fluidez.',
'[{"question": "Progressão significa:", "options": ["Repetir ideias", "Adicionar informações novas"], "correct": 1}]',
40, 'previous', 0),

('uerj', 3, 4, 'Conectivos', 'Ligando ideias', 
'# Conectivos Essenciais

## Por função

### Adição
Além disso, ademais, outrossim

### Oposição
Contudo, entretanto, todavia

### Conclusão
Portanto, logo, destarte

### Causa
Porque, visto que, uma vez que

### Consequência
De modo que, assim, por isso',
'[{"question": "''Contudo'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]',
45, 'previous', 0),

('uerj', 3, 5, 'Conclusão', 'Fechando o texto', 
'# A Conclusão

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Reflexão final ou proposta

## Estratégias
- Projeção futura
- Questionamento
- Chamado à reflexão

## Evite
- Novas informações
- Repetir literalmente a introdução
- Frases genéricas',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: ADEQUAÇÃO LINGUÍSTICA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('uerj', 4, 1, 'Norma Culta', 'Domínio gramatical', 
'# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro isso do que aquilo" ❌
- Vírgula entre sujeito e verbo ❌',
'[{"question": "''Havia pessoas'' é:", "options": ["Correto", "Incorreto"], "correct": 0}]',
30, 'free', 0),

('uerj', 4, 2, 'Registro Formal', 'Linguagem adequada', 
'# Registro Formal

## Características
- Terceira pessoa predominante
- Vocabulário culto
- Construções completas
- Ausência de gírias

## Evite
- "A gente vê que..."
- "Tipo assim..."
- Contrações orais: "pra", "tá"',
'[{"question": "''A gente'' é adequado?", "options": ["Sim", "Não, usar nós"], "correct": 1}]',
35, 'previous', 0),

('uerj', 4, 3, 'Vocabulário', 'Escolha de palavras', 
'# Vocabulário Adequado

## Substituições úteis
| Simples | Sofisticado |
|---------|-------------|
| Mostrar | Evidenciar |
| Problema | Impasse |
| Importante | Fundamental |
| Fazer | Realizar |

## Cuidado
Use apenas palavras que conhece bem.',
'[{"question": "Vocabulário deve ser:", "options": ["Complexo sempre", "Adequado e preciso"], "correct": 1}]',
40, 'previous', 0),

('uerj', 4, 4, 'Coesão', 'Amarrando o texto', 
'# Coesão Textual

## Mecanismos
1. Pronomes: ele, isso, tal
2. Sinônimos: variação lexical
3. Conectivos: ligação de ideias
4. Elipse: omissão intencional

## Evite
Repetição excessiva do mesmo termo.',
'[{"question": "Coesão usa:", "options": ["Apenas conectivos", "Vários mecanismos"], "correct": 1}]',
45, 'previous', 0),

('uerj', 4, 5, 'Revisão Final', 'Polindo o texto', 
'# Checklist de Revisão

## Gramática
- [ ] Concordâncias corretas?
- [ ] Regências adequadas?
- [ ] Pontuação correta?

## Conteúdo
- [ ] Tese clara?
- [ ] Argumentos desenvolvidos?
- [ ] Conclusão coerente?

## Forma
- [ ] Parágrafos equilibrados?
- [ ] Conectivos variados?
- [ ] Vocabulário adequado?

## Dica
Reserve 10 minutos para revisão!',
'[{"question": "Revisão deve levar:", "options": ["0 minutos", "10 minutos"], "correct": 1}]',
50, 'previous', 0);

SELECT 'UERJ: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'uerj';
