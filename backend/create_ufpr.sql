-- UFPR (Universidade Federal do Paraná) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/ufpr.sql

-- ============================================================================
-- CONQUISTAS UFPR
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFPR
('ufpr_essays_1', 'Primeira Redação UFPR', 'Enviou sua primeira redação UFPR', '📝', 'ufpr', 'essays_count', 1, 25, 0),
('ufpr_essays_5', 'Escritor UFPR', 'Enviou 5 redações UFPR', '✍️', 'ufpr', 'essays_count', 5, 50, 1),
('ufpr_essays_10', 'Redator Dedicado UFPR', 'Enviou 10 redações UFPR', '📚', 'ufpr', 'essays_count', 10, 100, 2),

-- Notas UFPR (0-60)
('ufpr_bronze', 'Nota Bronze UFPR', 'Atingiu 36+ na UFPR', '🥉', 'ufpr', 'score', 36, 100, 2),
('ufpr_prata', 'Nota Prata UFPR', 'Atingiu 48+ na UFPR', '🥈', 'ufpr', 'score', 48, 200, 5),
('ufpr_ouro', 'Nota Ouro UFPR', 'Atingiu 54+ na UFPR', '🥇', 'ufpr', 'score', 54, 300, 10),

-- Lições UFPR
('ufpr_lessons_5', 'Iniciante UFPR', 'Completou 5 lições da UFPR', '📖', 'ufpr', 'lessons', 5, 50, 1),
('ufpr_lessons_15', 'Estudante UFPR', 'Completou 15 lições da UFPR', '📚', 'ufpr', 'lessons', 15, 150, 3),
('ufpr_lessons_20', 'Mestre UFPR', 'Completou todas as 20 lições UFPR', '🎓', 'ufpr', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFPR - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura Textual, 3-Argumentação, 4-Domínio da Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufpr', 1, 1, 'A Redação UFPR', 'Conhecendo o vestibular', 
'# A Redação da UFPR

## Universidade Federal do Paraná
Localizada em Curitiba, a UFPR é a mais antiga universidade federal do Brasil.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Diferencial
UFPR: primeira federal do Brasil (1912).',
'[{"question": "A UFPR está localizada em:", "options": ["Porto Alegre", "Curitiba", "Florianópolis"], "correct": 1}]',
30, 'free', 0),

('ufpr', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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

('ufpr', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Sustentabilidade urbana

❌ "A sustentabilidade é importante"
✅ "O modelo de urbanização curitibano demonstra que planejamento integrado de transporte e áreas verdes pode conciliar desenvolvimento e qualidade de vida"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('ufpr', 1, 4, 'Temas Regionais', 'Contexto paranaense', 
'# Temas do Paraná/Sul

## Assuntos Relevantes
- Urbanização de Curitiba
- Agronegócio (soja, trigo)
- Imigração europeia
- Meio ambiente (Araucárias)
- Cooperativismo

## Repertório Útil
- Dalton Trevisan (escritor)
- Paulo Leminski (poeta)
- Curitiba: modelo urbano
- Cataratas do Iguaçu',
'[{"question": "Paulo Leminski era:", "options": ["Pintor", "Poeta curitibano"], "correct": 1}]',
45, 'previous', 0),

('ufpr', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UFPR

## Tipos válidos
- Dados: IBGE, IPARDES
- Histórico: Imigração no Sul
- Literário: Autores paranaenses
- Urbanístico: Curitiba

## Autores paranaenses
- Dalton Trevisan
- Paulo Leminski
- Helena Kolody
- Emiliano Perneta',
'[{"question": "Dalton Trevisan é conhecido como:", "options": ["Poeta maldito", "Vampiro de Curitiba"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA TEXTUAL (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufpr', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('ufpr', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
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

('ufpr', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', 
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

('ufpr', 2, 4, 'Conectivos', 'Ligando ideias', 
'# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que',
'[{"question": "''Destarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]',
45, 'previous', 0),

('ufpr', 2, 5, 'Conclusão', 'Fechando o texto', 
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
('ufpr', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
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

('ufpr', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('ufpr', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
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

('ufpr', 3, 4, 'Progressão', 'Avançando ideias', 
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

('ufpr', 3, 5, 'Repertório', 'Usando referências', 
'# Repertório

## Fontes confiáveis
- IBGE, IPARDES
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente',
'[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO DA NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufpr', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('ufpr', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Houve problemas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
35, 'previous', 0),

('ufpr', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Ir à Curitiba'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]',
40, 'previous', 0),

('ufpr', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('ufpr', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UFPR

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

SELECT 'UFPR: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'ufpr';
