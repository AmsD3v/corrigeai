-- UnB (Universidade de Brasília) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/unb.sql

-- ============================================================================
-- CONQUISTAS UnB
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UnB
('unb_essays_1', 'Primeira Redação UnB', 'Enviou sua primeira redação UnB', '📝', 'unb', 'essays_count', 1, 25, 0),
('unb_essays_5', 'Escritor UnB', 'Enviou 5 redações UnB', '✍️', 'unb', 'essays_count', 5, 50, 1),
('unb_essays_10', 'Redator Dedicado UnB', 'Enviou 10 redações UnB', '📚', 'unb', 'essays_count', 10, 100, 2),

-- Notas UnB (0-10)
('unb_bronze', 'Nota Bronze UnB', 'Atingiu 6+ na UnB', '🥉', 'unb', 'score', 6, 100, 2),
('unb_prata', 'Nota Prata UnB', 'Atingiu 8+ na UnB', '🥈', 'unb', 'score', 8, 200, 5),
('unb_ouro', 'Nota Ouro UnB', 'Atingiu 9+ na UnB', '🥇', 'unb', 'score', 9, 300, 10),

-- Lições UnB
('unb_lessons_5', 'Iniciante UnB', 'Completou 5 lições da UnB', '📖', 'unb', 'lessons', 5, 50, 1),
('unb_lessons_15', 'Estudante UnB', 'Completou 15 lições da UnB', '📚', 'unb', 'lessons', 15, 150, 3),
('unb_lessons_20', 'Mestre UnB', 'Completou todas as 20 lições UnB', '🎓', 'unb', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UnB - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura e Coerência, 3-Argumentação, 4-Domínio Linguístico
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unb', 1, 1, 'A Redação UnB', 'Conhecendo o vestibular', 
'# A Redação da UnB

## Universidade de Brasília
Localizada na capital federal, a UnB é uma das melhores universidades do país.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades, política, sociedade

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coerência
3. Argumentação
4. Domínio linguístico

## Diferencial
Por estar em Brasília, temas políticos e de gestão pública são frequentes.',
'[{"question": "A UnB está localizada em:", "options": ["São Paulo", "Brasília", "Rio de Janeiro"], "correct": 1}]',
30, 'free', 0),

('unb', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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

('unb', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Reforma política no Brasil

❌ "A reforma é importante"
✅ "A reforma política brasileira deve priorizar a redução do número de partidos e o financiamento público de campanhas"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('unb', 1, 4, 'Temas de Brasília', 'Contexto político', 
'# Temas Recorrentes na UnB

## Assuntos Frequentes
- Política e democracia
- Administração pública
- Federalismo
- Cidadania e direitos
- Corrupção e transparência

## Repertório Útil
- Constituição Federal
- Três Poderes
- História de Brasília
- Políticas públicas',
'[{"question": "Brasília foi inaugurada em:", "options": ["1950", "1960", "1970"], "correct": 1}]',
45, 'previous', 0),

('unb', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UnB

## Tipos válidos
- Dados: IBGE, IPEA, TCU
- Histórico: República brasileira
- Legal: Constituição Federal
- Político: Teorias de Estado

## Pensadores úteis
- Sérgio Buarque de Holanda
- Raymundo Faoro
- Darcy Ribeiro (fundador da UnB)
- Celso Furtado',
'[{"question": "Darcy Ribeiro foi:", "options": ["Presidente", "Fundador da UnB"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA E COERÊNCIA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unb', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('unb', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
'# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias para UnB
- Referência histórica
- Dado político/social
- Citação de pensadores
- Contexto constitucional',
'[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]',
35, 'previous', 0),

('unb', 2, 3, 'Coerência Textual', 'Sentido global', 
'# Coerência

## O que é?
Sentido global do texto - ideias conectadas logicamente.

## Problemas
❌ Contradição entre parágrafos
❌ Conclusão oposta à tese
❌ Argumentos desconexos

## Solução
Cada parte deve sustentar a tese.',
'[{"question": "Coerência é:", "options": ["Gramática", "Sentido global"], "correct": 1}]',
40, 'previous', 0),

('unb', 2, 4, 'Conectivos', 'Ligando ideias', 
'# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que',
'[{"question": "''Outrossim'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]',
45, 'previous', 0),

('unb', 2, 5, 'Conclusão', 'Fechando o texto', 
'# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Para UnB
Propostas ligadas a políticas públicas são bem-vindas.

## Evite
- Novas informações
- Repetir a introdução',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: ARGUMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unb', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
'# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Para UnB
Argumentos baseados em dados oficiais e legislação.',
'[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]',
30, 'free', 0),

('unb', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas institucionais..."

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('unb', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
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

('unb', 3, 4, 'Progressão', 'Avançando ideias', 
'# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais direto
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."',
'[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]',
45, 'previous', 0),

('unb', 3, 5, 'Repertório Político', 'Referências para UnB', 
'# Repertório para UnB

## Autores úteis
- Sérgio Buarque de Holanda
- Raymundo Faoro
- Darcy Ribeiro
- Celso Furtado

## Temas
- Democracia
- Federalismo
- Políticas públicas
- Cidadania',
'[{"question": "Raízes do Brasil é de:", "options": ["Darcy Ribeiro", "Sérgio Buarque de Holanda"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO LINGUÍSTICO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unb', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('unb', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Fazem dois anos'' é:", "options": ["Correto", "Incorreto (faz)"], "correct": 1}]',
35, 'previous', 0),

('unb', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Aspiro o cargo'' é:", "options": ["Correto", "Incorreto (aspirar A)"], "correct": 1}]',
40, 'previous', 0),

('unb', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('unb', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UnB

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

SELECT 'UnB: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'unb';
