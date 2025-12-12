-- UNIFAP (Universidade Federal do Amapá) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/unifap.sql

-- ============================================================================
-- CONQUISTAS UNIFAP
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UNIFAP
('unifap_essays_1', 'Primeira Redação UNIFAP', 'Enviou sua primeira redação UNIFAP', '📝', 'unifap', 'essays_count', 1, 25, 0),
('unifap_essays_5', 'Escritor UNIFAP', 'Enviou 5 redações UNIFAP', '✍️', 'unifap', 'essays_count', 5, 50, 1),
('unifap_essays_10', 'Redator Dedicado UNIFAP', 'Enviou 10 redações UNIFAP', '📚', 'unifap', 'essays_count', 10, 100, 2),

-- Notas UNIFAP (0-100)
('unifap_bronze', 'Nota Bronze UNIFAP', 'Atingiu 60+ na UNIFAP', '🥉', 'unifap', 'score', 60, 100, 2),
('unifap_prata', 'Nota Prata UNIFAP', 'Atingiu 80+ na UNIFAP', '🥈', 'unifap', 'score', 80, 200, 5),
('unifap_ouro', 'Nota Ouro UNIFAP', 'Atingiu 90+ na UNIFAP', '🥇', 'unifap', 'score', 90, 300, 10),

-- Lições UNIFAP
('unifap_lessons_5', 'Iniciante UNIFAP', 'Completou 5 lições da UNIFAP', '📖', 'unifap', 'lessons', 5, 50, 1),
('unifap_lessons_15', 'Estudante UNIFAP', 'Completou 15 lições da UNIFAP', '📚', 'unifap', 'lessons', 15, 150, 3),
('unifap_lessons_20', 'Mestre UNIFAP', 'Completou todas as 20 lições UNIFAP', '🎓', 'unifap', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UNIFAP - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura Textual, 3-Argumentação, 4-Linguagem e Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unifap', 1, 1, 'A Redação UNIFAP', 'Conhecendo o vestibular', 
'# A Redação da UNIFAP

## Universidade Federal do Amapá
Localizada em Macapá, a UNIFAP é a principal universidade do estado.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Linguagem e norma culta

## Contexto Regional
O Amapá é um estado amazônico com rica biodiversidade.',
'[{"question": "A UNIFAP está localizada em:", "options": ["Belém", "Macapá", "Manaus"], "correct": 1}]',
30, 'free', 0),

('unifap', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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
❌ Fugir do tema
❌ Tangenciar
❌ Copiar textos de apoio',
'[{"question": "Tangenciar o tema é:", "options": ["Desenvolver bem", "Abordar parcialmente"], "correct": 1}]',
35, 'previous', 0),

('unifap', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Preservação da biodiversidade amazônica

❌ "A preservação é importante"
✅ "A biodiversidade amazônica demanda políticas integradas de preservação e desenvolvimento sustentável"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('unifap', 1, 4, 'Temas Regionais', 'Contexto amazônico', 
'# Temas Relevantes

## Contexto Amapá/Amazônia
- Biodiversidade amazônica
- Povos indígenas e quilombolas
- Fronteira e geopolítica
- Recursos naturais
- Desenvolvimento sustentável

## Repertório Útil
- Floresta Amazônica
- Rio Amazonas
- Tratados ambientais
- Dados do INPE/IBAMA',
'[{"question": "O Amapá faz fronteira com:", "options": ["Peru", "Guiana Francesa", "Colômbia"], "correct": 1}]',
45, 'previous', 0),

('unifap', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UNIFAP

## Tipos válidos
- Dados: IBGE, INPE, IBAMA
- Histórico: Formação do Amapá
- Ambiental: Biodiversidade
- Legal: Constituição, Código Florestal

## Conhecimentos regionais
- Território Federal até 1988
- Zona de fronteira
- Economia extrativista
- Riqueza mineral',
'[{"question": "O Amapá virou estado em:", "options": ["1960", "1988", "2000"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA TEXTUAL (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unifap', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
'# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção ideal
Intro 20% | Desenvolvimento 60% | Conclusão 20%',
'[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]',
30, 'free', 0),

('unifap', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
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

('unifap', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', 
'# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos são suficientes.',
'[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]',
40, 'previous', 0),

('unifap', 2, 4, 'Conectivos', 'Ligando ideias', 
'# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que',
'[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]',
45, 'previous', 0),

('unifap', 2, 5, 'Conclusão', 'Fechando o texto', 
'# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão final

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: ARGUMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unifap', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
'# Argumentação

## Tipos principais
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.',
'[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]',
30, 'free', 0),

('unifap', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica a sociedade"
✅ Avançado: "Esse cenário revela falhas estruturais..."

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('unifap', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
'# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta ao defendido

## Teste
Pergunte: "Isso prova minha tese?"',
'[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]',
40, 'previous', 0),

('unifap', 3, 4, 'Progressão', 'Avançando ideias', 
'# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais complexo

## Conectivos
- "Além disso..."
- "Soma-se a isso..."',
'[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]',
45, 'previous', 0),

('unifap', 3, 5, 'Repertório', 'Usando referências', 
'# Repertório

## Fontes confiáveis
- IBGE, INPE, ONU
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente',
'[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: LINGUAGEM E NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unifap', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('unifap', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Havia'' é impessoal?", "options": ["Não", "Sim"], "correct": 1}]',
35, 'previous', 0),

('unifap', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Prefiro café do que chá'' é:", "options": ["Correto", "Incorreto"], "correct": 1}]',
40, 'previous', 0),

('unifap', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('unifap', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UNIFAP

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

SELECT 'UNIFAP: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'unifap';
