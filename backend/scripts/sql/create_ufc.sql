-- UFC (Universidade Federal do Ceará) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/ufc.sql

-- ============================================================================
-- CONQUISTAS UFC
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFC
('ufc_essays_1', 'Primeira Redação UFC', 'Enviou sua primeira redação UFC', '📝', 'ufc', 'essays_count', 1, 25, 0),
('ufc_essays_5', 'Escritor UFC', 'Enviou 5 redações UFC', '✍️', 'ufc', 'essays_count', 5, 50, 1),
('ufc_essays_10', 'Redator Dedicado UFC', 'Enviou 10 redações UFC', '📚', 'ufc', 'essays_count', 10, 100, 2),

-- Notas UFC (0-100)
('ufc_bronze', 'Nota Bronze UFC', 'Atingiu 60+ na UFC', '🥉', 'ufc', 'score', 60, 100, 2),
('ufc_prata', 'Nota Prata UFC', 'Atingiu 80+ na UFC', '🥈', 'ufc', 'score', 80, 200, 5),
('ufc_ouro', 'Nota Ouro UFC', 'Atingiu 90+ na UFC', '🥇', 'ufc', 'score', 90, 300, 10),

-- Lições UFC
('ufc_lessons_5', 'Iniciante UFC', 'Completou 5 lições da UFC', '📖', 'ufc', 'lessons', 5, 50, 1),
('ufc_lessons_15', 'Estudante UFC', 'Completou 15 lições da UFC', '📚', 'ufc', 'lessons', 15, 150, 3),
('ufc_lessons_20', 'Mestre UFC', 'Completou todas as 20 lições UFC', '🎓', 'ufc', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFC - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura Textual, 3-Argumentação, 4-Domínio da Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufc', 1, 1, 'A Redação UFC', 'Conhecendo o vestibular', 
'# A Redação da UFC

## Universidade Federal do Ceará
Localizada em Fortaleza, a UFC é uma das principais universidades do Nordeste.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Contexto Regional
A UFC pode abordar temas do Nordeste e do Ceará.',
'[{"question": "A UFC está localizada em:", "options": ["Recife", "Fortaleza", "Salvador"], "correct": 1}]',
30, 'free', 0),

('ufc', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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

('ufc', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Seca no Nordeste

❌ "A seca é um problema"
✅ "A seca nordestina demanda políticas públicas integradas de convivência com o semiárido, não apenas ações emergenciais"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('ufc', 1, 4, 'Temas Regionais', 'Contexto cearense', 
'# Temas do Ceará/Nordeste

## Assuntos Recorrentes
- Seca e convivência com semiárido
- Turismo e desenvolvimento
- Cultura popular
- Desigualdade regional
- Migração

## Repertório Útil
- Patativa do Assaré (poeta)
- Rachel de Queiroz (escritora)
- Padre Cícero
- Transposição do São Francisco',
'[{"question": "Rachel de Queiroz escreveu:", "options": ["O Quinze", "Vidas Secas"], "correct": 0}]',
45, 'previous', 0),

('ufc', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UFC

## Tipos válidos
- Dados: IBGE, IPEA
- Histórico: Formação do Nordeste
- Literário: Autores cearenses
- Cultural: Tradições populares

## Autores cearenses
- Rachel de Queiroz (O Quinze)
- Patativa do Assaré (cordel)
- José de Alencar (Iracema)
- Humor: Renato Aragão',
'[{"question": "Patativa do Assaré é:", "options": ["Novelista", "Poeta popular"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA TEXTUAL (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufc', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('ufc', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
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

('ufc', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', 
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

('ufc', 2, 4, 'Conectivos', 'Ligando ideias', 
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

('ufc', 2, 5, 'Conclusão', 'Fechando o texto', 
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
('ufc', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
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

('ufc', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas estruturais..."

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('ufc', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
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

('ufc', 3, 4, 'Progressão', 'Avançando ideias', 
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

('ufc', 3, 5, 'Repertório Nordestino', 'Referências regionais', 
'# Repertório para UFC

## Autores úteis
- Rachel de Queiroz
- Patativa do Assaré
- José de Alencar

## Temas regionais
- Seca e semiárido
- Cultura popular
- Forró e tradições
- Artesanato',
'[{"question": "Iracema é de:", "options": ["Machado de Assis", "José de Alencar"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO DA NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufc', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('ufc', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Faz dois anos'' é:", "options": ["Incorreto", "Correto (impessoal)"], "correct": 1}]',
35, 'previous', 0),

('ufc', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Obedecer o pai'' é:", "options": ["Correto", "Incorreto (obedecer A)"], "correct": 1}]',
40, 'previous', 0),

('ufc', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('ufc', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UFC

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

SELECT 'UFC: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'ufc';
