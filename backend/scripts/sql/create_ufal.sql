-- UFAL (Universidade Federal de Alagoas) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/ufal.sql

-- ============================================================================
-- CONQUISTAS UFAL
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFAL
('ufal_essays_1', 'Primeira Redação UFAL', 'Enviou sua primeira redação UFAL', '📝', 'ufal', 'essays_count', 1, 25, 0),
('ufal_essays_5', 'Escritor UFAL', 'Enviou 5 redações UFAL', '✍️', 'ufal', 'essays_count', 5, 50, 1),
('ufal_essays_10', 'Redator Dedicado UFAL', 'Enviou 10 redações UFAL', '📚', 'ufal', 'essays_count', 10, 100, 2),

-- Notas UFAL (0-100)
('ufal_bronze', 'Nota Bronze UFAL', 'Atingiu 60+ na UFAL', '🥉', 'ufal', 'score', 60, 100, 2),
('ufal_prata', 'Nota Prata UFAL', 'Atingiu 80+ na UFAL', '🥈', 'ufal', 'score', 80, 200, 5),
('ufal_ouro', 'Nota Ouro UFAL', 'Atingiu 90+ na UFAL', '🥇', 'ufal', 'score', 90, 300, 10),

-- Lições UFAL
('ufal_lessons_5', 'Iniciante UFAL', 'Completou 5 lições da UFAL', '📖', 'ufal', 'lessons', 5, 50, 1),
('ufal_lessons_15', 'Estudante UFAL', 'Completou 15 lições da UFAL', '📚', 'ufal', 'lessons', 15, 150, 3),
('ufal_lessons_20', 'Mestre UFAL', 'Completou todas as 20 lições UFAL', '🎓', 'ufal', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFAL - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura e Coesão, 3-Argumentação, 4-Domínio da Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufal', 1, 1, 'A Redação UFAL', 'Conhecendo o vestibular', 
'# A Redação da UFAL

## Universidade Federal de Alagoas
Localizada em Maceió, a UFAL é a principal universidade do estado.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coesão
3. Argumentação
4. Domínio da norma culta

## Contexto Regional
A UFAL pode abordar temas do Nordeste brasileiro.',
'[{"question": "A UFAL está localizada em:", "options": ["Recife", "Maceió", "Salvador"], "correct": 1}]',
30, 'free', 0),

('ufal', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
'# Análise do Tema

## Elementos da Proposta
1. **Tema central:** O assunto principal
2. **Recorte:** Delimitação específica
3. **Textos de apoio:** Contextualização

## Estratégia
1. Leia a proposta completa
2. Identifique palavras-chave
3. Note delimitações temporais/espaciais
4. Defina seu posicionamento

## Evite
❌ Fugir do tema = nota zero
❌ Tangenciar = nota muito baixa',
'[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]',
35, 'previous', 0),

('ufal', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução
- Retomada na conclusão

## Exemplo
**Tema:** Desigualdade social no Nordeste

❌ "A desigualdade é ruim"
✅ "A desigualdade no Nordeste reflete históricas políticas excludentes que demandam investimentos em educação e infraestrutura"',
'[{"question": "A tese deve estar:", "options": ["Na conclusão apenas", "Na introdução"], "correct": 1}]',
40, 'previous', 0),

('ufal', 1, 4, 'Temas Regionais', 'Contexto nordestino', 
'# Temas do Nordeste

## Assuntos Recorrentes
- Seca e recursos hídricos
- Desenvolvimento regional
- Turismo e economia
- Cultura nordestina
- Desigualdade social

## Repertório Útil
- Graciliano Ramos (Vidas Secas)
- Transposição do São Francisco
- SUDENE
- Economia do turismo',
'[{"question": "Vidas Secas é de:", "options": ["Machado de Assis", "Graciliano Ramos"], "correct": 1}]',
45, 'previous', 0),

('ufal', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UFAL

## Tipos válidos
- Dados: IBGE, IPEA
- Histórico: Formação do Nordeste
- Literário: Autores regionais
- Legal: Constituição, políticas públicas

## Autores nordestinos
- Graciliano Ramos
- Rachel de Queiroz
- Jorge Amado
- Ariano Suassuna',
'[{"question": "Rachel de Queiroz escreveu:", "options": ["O Quinze", "Capitães da Areia"], "correct": 0}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA E COESÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufal', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
'# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
- Intro: 20%
- Desenvolvimento: 60%
- Conclusão: 20%',
'[{"question": "Desenvolvimento ocupa:", "options": ["40%", "60%"], "correct": 1}]',
30, 'free', 0),

('ufal', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
'# A Introdução

## Elementos
1. Contextualização do tema
2. Apresentação do assunto
3. Tese clara

## Estratégias de abertura
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica',
'[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]',
35, 'previous', 0),

('ufal', 2, 3, 'Coesão Textual', 'Conectando ideias', 
'# Coesão

## Mecanismos
1. **Conectivos:** ligam orações e parágrafos
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo',
'[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]',
40, 'previous', 0),

('ufal', 2, 4, 'Transições', 'Entre parágrafos', 
'# Transições Fluidas

## Técnicas
1. Retomar palavra-chave do anterior
2. Usar conectivo adequado
3. Fazer referência ao já dito

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão, a educação..."',
'[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]',
45, 'previous', 0),

('ufal', 2, 5, 'Conclusão', 'Fechando o texto', 
'# A Conclusão

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Proposta ou reflexão final

## Evite
- Novas informações
- Repetir literalmente a introdução
- Frases genéricas como "conclui-se que"',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: ARGUMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufal', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
'# Argumentação

## Tipos principais
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes por redação.',
'[{"question": "Quantos tipos de argumento usar:", "options": ["1", "2 ou mais"], "correct": 1}]',
30, 'free', 0),

('ufal', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## O que diferencia notas altas
Não basta citar - é preciso ANALISAR.

## Níveis
❌ "O IBGE mostra que..."
⚠️ "...o que é um problema"
✅ "...revelando falha estrutural que perpetua exclusão"

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar dados"], "correct": 1}]',
35, 'previous', 0),

('ufal', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
'# Coerência

## Princípio
Todos os argumentos devem apoiar a tese.

## Problemas comuns
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta ao defendido

## Teste
Pergunte: "Isso prova minha tese?"',
'[{"question": "Argumentos devem:", "options": ["Ser variados apenas", "Apoiar a tese"], "correct": 1}]',
40, 'previous', 0),

('ufal', 3, 4, 'Progressão', 'Avançando ideias', 
'# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura sugerida
- D1: Argumento mais acessível
- D2: Argumento mais complexo

## Conectivos
- "Além disso..."
- "Soma-se a isso..."
- "Outrossim..."',
'[{"question": "Progressão significa:", "options": ["Repetir", "Avançar ideias"], "correct": 1}]',
45, 'previous', 0),

('ufal', 3, 5, 'Repertório', 'Usando referências', 
'# Repertório Argumentativo

## Fontes confiáveis
- IBGE, IPEA, ONU
- Constituição Federal
- Autores reconhecidos
- Fatos históricos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente',
'[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO DA NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufal', 4, 1, 'Norma Culta', 'Gramática essencial', 
'# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro isso do que" ❌
- Vírgula entre sujeito e verbo ❌',
'[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
30, 'free', 0),

('ufal', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.
"Os alunos estudam" ✅

## Casos especiais
- Sujeito composto: verbo no plural
- Verbos impessoais: singular (havia, faz)

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Havia'' com sujeito plural:", "options": ["Haviam", "Havia (impessoal)"], "correct": 1}]',
35, 'previous', 0),

('ufal', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A → Assisti AO filme
- Visar (objetivar): A → Visa AO sucesso
- Preferir: A → Prefiro café A chá

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Prefiro isso do que aquilo'' é:", "options": ["Correto", "Incorreto"], "correct": 1}]',
40, 'previous', 0),

('ufal', 4, 4, 'Pontuação', 'Vírgulas e mais', 
'# Pontuação

## Vírgula - USA-SE
- Separar itens de lista
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento',
'[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]',
45, 'previous', 0),

('ufal', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UFAL

## Conteúdo
- [ ] Tema atendido?
- [ ] Tese clara?
- [ ] Argumentos desenvolvidos?

## Gramática
- [ ] Concordâncias?
- [ ] Regências?
- [ ] Pontuação?

## Estrutura
- [ ] 4 parágrafos?
- [ ] Transições claras?

**Reserve 10 minutos!**',
'[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]',
50, 'previous', 0);

SELECT 'UFAL: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'ufal';
