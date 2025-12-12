-- UFPA (Universidade Federal do Pará) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/ufpa.sql

-- ============================================================================
-- CONQUISTAS UFPA
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFPA
('ufpa_essays_1', 'Primeira Redação UFPA', 'Enviou sua primeira redação UFPA', '📝', 'ufpa', 'essays_count', 1, 25, 0),
('ufpa_essays_5', 'Escritor UFPA', 'Enviou 5 redações UFPA', '✍️', 'ufpa', 'essays_count', 5, 50, 1),
('ufpa_essays_10', 'Redator Dedicado UFPA', 'Enviou 10 redações UFPA', '📚', 'ufpa', 'essays_count', 10, 100, 2),

-- Notas UFPA (0-100)
('ufpa_bronze', 'Nota Bronze UFPA', 'Atingiu 60+ na UFPA', '🥉', 'ufpa', 'score', 60, 100, 2),
('ufpa_prata', 'Nota Prata UFPA', 'Atingiu 80+ na UFPA', '🥈', 'ufpa', 'score', 80, 200, 5),
('ufpa_ouro', 'Nota Ouro UFPA', 'Atingiu 90+ na UFPA', '🥇', 'ufpa', 'score', 90, 300, 10),

-- Lições UFPA
('ufpa_lessons_5', 'Iniciante UFPA', 'Completou 5 lições da UFPA', '📖', 'ufpa', 'lessons', 5, 50, 1),
('ufpa_lessons_15', 'Estudante UFPA', 'Completou 15 lições da UFPA', '📚', 'ufpa', 'lessons', 15, 150, 3),
('ufpa_lessons_20', 'Mestre UFPA', 'Completou todas as 20 lições UFPA', '🎓', 'ufpa', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFPA - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura Textual, 3-Argumentação, 4-Domínio da Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufpa', 1, 1, 'A Redação UFPA', 'Conhecendo o vestibular', 
'# A Redação da UFPA

## Universidade Federal do Pará
Localizada em Belém, a UFPA é a maior universidade da Amazônia.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões regionais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Contexto Amazônico
A UFPA valoriza conhecimentos sobre a região Norte.',
'[{"question": "A UFPA está localizada em:", "options": ["Manaus", "Belém", "Macapá"], "correct": 1}]',
30, 'free', 0),

('ufpa', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
'# Análise do Tema

## Elementos da Proposta
1. **Tema central:** O assunto principal
2. **Recorte:** Delimitação específica
3. **Textos de apoio:** Contextualização

## Estratégia
1. Leia a proposta completa
2. Identifique palavras-chave
3. Note delimitações
4. Defina seu posicionamento

## Evite
❌ Fugir do tema = nota zero
❌ Tangenciar = nota muito baixa',
'[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]',
35, 'previous', 0),

('ufpa', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desenvolvimento sustentável na Amazônia

❌ "A Amazônia é importante"
✅ "O desenvolvimento sustentável amazônico requer integração entre preservação ambiental e geração de renda para comunidades ribeirinhas"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('ufpa', 1, 4, 'Temas Regionais', 'Contexto paraense', 
'# Temas do Pará/Amazônia

## Assuntos Relevantes
- Floresta Amazônica
- Povos ribeirinhos e indígenas
- Mineração (Carajás)
- Hidrelétricas (Belo Monte)
- Cultura paraense

## Repertório Útil
- Círio de Nazaré
- Ver-o-Peso
- Carimbó
- Açaí e gastronomia',
'[{"question": "O Círio de Nazaré é:", "options": ["Festa junina", "Maior procissão católica do Brasil"], "correct": 1}]',
45, 'previous', 0),

('ufpa', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UFPA

## Tipos válidos
- Dados: IBGE, INPE
- Ambiental: Amazônia
- Literário: Autores paraenses
- Cultural: Tradições locais

## Autores paraenses
- Dalcídio Jurandir
- Benedito Monteiro
- Bruno de Menezes
- Música: Brega paraense',
'[{"question": "Dalcídio Jurandir era:", "options": ["Pintor", "Escritor paraense"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA TEXTUAL (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufpa', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
'# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão',
'[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]',
30, 'free', 0),

('ufpa', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
'# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica',
'[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]',
35, 'previous', 0),

('ufpa', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', 
'# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.',
'[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]',
40, 'previous', 0),

('ufpa', 2, 4, 'Conectivos', 'Ligando ideias', 
'# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que',
'[{"question": "''Porquanto'' indica:", "options": ["Oposição", "Causa"], "correct": 1}]',
45, 'previous', 0),

('ufpa', 2, 5, 'Conclusão', 'Fechando o texto', 
'# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: ARGUMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufpa', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
'# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.',
'[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]',
30, 'free', 0),

('ufpa', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('ufpa', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
'# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"',
'[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]',
40, 'previous', 0),

('ufpa', 3, 4, 'Progressão', 'Avançando ideias', 
'# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."',
'[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]',
45, 'previous', 0),

('ufpa', 3, 5, 'Repertório Amazônico', 'Referências regionais', 
'# Repertório para UFPA

## Fontes confiáveis
- IBGE, INPE, INPA
- Dados ambientais
- Constituição Federal

## Conhecimentos locais
- Círio de Nazaré
- Ver-o-Peso
- Ilha de Marajó
- Carajás (mineração)',
'[{"question": "Ver-o-Peso é:", "options": ["Museu", "Mercado tradicional de Belém"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO DA NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufpa', 4, 1, 'Norma Culta', 'Gramática essencial', 
'# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌',
'[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
30, 'free', 0),

('ufpa', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Há problemas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
35, 'previous', 0),

('ufpa', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Referir-se a algo'' tem crase?", "options": ["Sim", "Depende"], "correct": 1}]',
40, 'previous', 0),

('ufpa', 4, 4, 'Pontuação', 'Vírgulas e mais', 
'# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento',
'[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]',
45, 'previous', 0),

('ufpa', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UFPA

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

SELECT 'UFPA: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'ufpa';
