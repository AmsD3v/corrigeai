-- UFMG - Conquistas e 20 Lições (5 por critério)
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/ufmg.sql

-- ============================================================================
-- CONQUISTAS UFMG
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFMG
('ufmg_essays_1', 'Primeira Redação UFMG', 'Enviou sua primeira redação UFMG', '📝', 'ufmg', 'essays_count', 1, 25, 0),
('ufmg_essays_5', 'Escritor UFMG', 'Enviou 5 redações UFMG', '✍️', 'ufmg', 'essays_count', 5, 50, 1),
('ufmg_essays_10', 'Redator Dedicado UFMG', 'Enviou 10 redações UFMG', '📚', 'ufmg', 'essays_count', 10, 100, 2),

-- Notas UFMG (0-100)
('ufmg_bronze', 'Nota Bronze UFMG', 'Atingiu 60+ na UFMG', '🥉', 'ufmg', 'score', 60, 100, 2),
('ufmg_prata', 'Nota Prata UFMG', 'Atingiu 80+ na UFMG', '🥈', 'ufmg', 'score', 80, 200, 5),
('ufmg_ouro', 'Nota Ouro UFMG', 'Atingiu 90+ na UFMG', '🥇', 'ufmg', 'score', 90, 300, 10),

-- Lições UFMG
('ufmg_lessons_5', 'Iniciante UFMG', 'Completou 5 lições da UFMG', '📖', 'ufmg', 'lessons', 5, 50, 1),
('ufmg_lessons_15', 'Estudante UFMG', 'Completou 15 lições da UFMG', '📚', 'ufmg', 'lessons', 15, 150, 3),
('ufmg_lessons_20', 'Mestre UFMG', 'Completou todas as 20 lições UFMG', '🎓', 'ufmg', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFMG - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema e Gênero, 2-Coerência e Coesão, 3-Recursos Linguísticos, 4-Aspectos Formais
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA E GÊNERO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufmg', 1, 1, 'A Redação UFMG', 'Conhecendo a prova', 
'# A Redação da UFMG

## Características
- **Formato:** Pode variar (dissertação, carta, artigo)
- **Extensão:** 25 a 30 linhas
- **Tema:** Questões sociais e humanísticas
- **Nota:** Parte da nota final do vestibular

## Critérios de Avaliação
1. Adequação ao tema e ao gênero
2. Coerência e coesão
3. Recursos linguísticos
4. Aspectos formais

## Diferencial UFMG
- Pode cobrar diferentes gêneros textuais
- Valoriza leitura crítica da coletânea
- Foco em questões sociais brasileiras',
'[{"question": "A UFMG pode cobrar diferentes gêneros?", "options": ["Sim", "Não, só dissertação"], "correct": 0}, {"question": "Extensão recomendada:", "options": ["15-20 linhas", "25-30 linhas"], "correct": 1}]',
30, 'free', 0),

('ufmg', 1, 2, 'Gêneros Textuais', 'Dominando formatos', 
'# Gêneros na UFMG

## Gêneros possíveis
1. **Dissertação-argumentativa:** Mais comum
2. **Carta argumentativa:** Para destinatário
3. **Artigo de opinião:** Publicação em mídia
4. **Texto de divulgação:** Científico acessível

## Como identificar
Leia o comando com atenção:
- "Escreva uma carta para..." = carta
- "Produza um artigo para..." = artigo
- "Redija um texto dissertativo" = dissertação

## Adaptação
Cada gênero tem estrutura própria!',
'[{"question": "Carta argumentativa precisa de:", "options": ["Título", "Vocativo e saudação"], "correct": 1}]',
35, 'previous', 0),

('ufmg', 1, 3, 'Interpretando a Proposta', 'Análise cuidadosa', 
'# Análise da Proposta

## Elementos
1. **Comando:** O que fazer
2. **Tema:** Assunto delimitado
3. **Gênero:** Tipo de texto
4. **Coletânea:** Textos de apoio

## Estratégia
1. Leia o comando PRIMEIRO
2. Identifique o gênero pedido
3. Note o recorte temático
4. Use a coletânea como apoio

## Erro grave
Escrever gênero diferente do pedido = nota muito baixa',
'[{"question": "O que ler primeiro?", "options": ["Coletânea", "Comando da proposta"], "correct": 1}]',
40, 'previous', 0),

('ufmg', 1, 4, 'Coletânea UFMG', 'Usando textos de apoio', 
'# A Coletânea

## Função
- Contextualizar o tema
- Oferecer perspectivas
- Fornecer dados

## Como usar
✅ Parafrasear ideias
✅ Dialogar com os textos
✅ Ir além do que apresentam

❌ Copiar trechos
❌ Ignorar completamente
❌ Usar apenas um texto

## Dica
A coletânea é ponto de partida, não limite.',
'[{"question": "Pode copiar a coletânea?", "options": ["Sim", "Não, deve parafrasear"], "correct": 1}]',
45, 'previous', 0),

('ufmg', 1, 5, 'Temas Recorrentes', 'O que a UFMG cobra', 
'# Temas Frequentes

## Áreas
- Questões sociais brasileiras
- Educação e cultura
- Meio ambiente
- Tecnologia e sociedade
- Ética e cidadania

## Diferencial mineiro
A UFMG às vezes aborda questões regionais ou relacionadas a Minas Gerais.

## Repertório útil
- Autores mineiros (Drummond, Guimarães Rosa)
- Dados sobre educação
- Constituição e leis',
'[{"question": "A UFMG pode abordar temas regionais?", "options": ["Sim", "Não"], "correct": 0}]',
50, 'previous', 0);

-- CRITÉRIO 2: COERÊNCIA E COESÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufmg', 2, 1, 'Coerência Textual', 'Sentido global', 
'# Coerência

## O que é?
O sentido global do texto - ideias fazem sentido juntas.

## Tipos
- **Interna:** Entre partes do texto
- **Externa:** Com a realidade
- **Temática:** Com o tema proposto

## Problemas
❌ Contradição entre parágrafos
❌ Conclusão oposta à tese
❌ Informações sem fundamento',
'[{"question": "Coerência é:", "options": ["Conexão entre frases", "Sentido global do texto"], "correct": 1}]',
30, 'free', 0),

('ufmg', 2, 2, 'Coesão Referencial', 'Retomando termos', 
'# Coesão Referencial

## Mecanismos
1. **Pronomes:** ele, isso, aquele
2. **Sinônimos:** variação lexical
3. **Hiperônimos:** termo mais geral
4. **Elipse:** omissão intencional

## Exemplo
"O Brasil enfrenta desafios. **O país** precisa de reformas. **Essa nação** tem potencial..."

## Benefício
Evita repetição e cria fluidez.',
'[{"question": "Substituir ''Brasil'' por ''o país'' é:", "options": ["Erro", "Coesão referencial"], "correct": 1}]',
35, 'previous', 0),

('ufmg', 2, 3, 'Conectivos', 'Ligando ideias', 
'# Conectivos Essenciais

## Por função
| Função | Conectivos |
|--------|------------|
| Adição | Além disso, ademais |
| Oposição | Contudo, entretanto |
| Conclusão | Portanto, logo |
| Causa | Porque, visto que |
| Consequência | De modo que, assim |

## Variação
Não repita o mesmo conectivo várias vezes!',
'[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]',
40, 'previous', 0),

('ufmg', 2, 4, 'Progressão Textual', 'Avançando ideias', 
'# Progressão

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura progressiva
1. Introdução: Tese
2. D1: Primeiro argumento
3. D2: Segundo argumento (aprofunda)
4. Conclusão: Síntese

## Erro comum
Repetir a mesma ideia com palavras diferentes.',
'[{"question": "Progressão significa:", "options": ["Repetir ideias", "Adicionar informações novas"], "correct": 1}]',
45, 'previous', 0),

('ufmg', 2, 5, 'Transições', 'Entre parágrafos', 
'# Transições Fluidas

## Técnicas
1. Retomar palavra-chave do anterior
2. Usar conectivo adequado
3. Fazer referência ao já dito

## Exemplo
Final D1: "...perpetua desigualdades."
Início D2: "**Além dessa questão estrutural**, a educação..."

## Benefício
Texto fluido e bem articulado.',
'[{"question": "Transições conectam:", "options": ["Frases apenas", "Parágrafos entre si"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: RECURSOS LINGUÍSTICOS (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufmg', 3, 1, 'Vocabulário Adequado', 'Escolha de palavras', 
'# Vocabulário

## Princípios
- Precisão: palavra certa para cada ideia
- Variedade: evitar repetições
- Adequação: registro formal

## Substituições úteis
| Simples | Sofisticado |
|---------|-------------|
| Mostrar | Evidenciar |
| Problema | Impasse |
| Importante | Fundamental |

## Cuidado
Use apenas palavras que domina.',
'[{"question": "Vocabulário deve ser:", "options": ["Complexo sempre", "Preciso e adequado"], "correct": 1}]',
30, 'free', 0),

('ufmg', 3, 2, 'Estrutura Sintática', 'Variando períodos', 
'# Variedade Sintática

## Tipos de período
- **Simples:** Uma oração
- **Composto por coordenação:** Orações independentes
- **Composto por subordinação:** Orações dependentes

## Técnica
Alterne tipos para criar ritmo e fluidez.

## Exemplo
"A educação é fundamental. [simples] Contudo, quando negligenciada pelo Estado, ela falha em cumprir seu papel transformador. [composto]"',
'[{"question": "Variar períodos melhora:", "options": ["Apenas estética", "Ritmo e fluidez"], "correct": 1}]',
35, 'previous', 0),

('ufmg', 3, 3, 'Figuras de Linguagem', 'Recursos estilísticos', 
'# Figuras de Linguagem

## Úteis em dissertação
- **Metáfora:** Comparação implícita
- **Antítese:** Oposição de ideias
- **Ironia:** Crítica sutil
- **Metonímia:** Substituição

## Uso moderado
Figuras enriquecem, mas em excesso prejudicam a clareza.

## Exemplo
"O Planalto silencia..." (metonímia)',
'[{"question": "Figuras de linguagem devem:", "options": ["Ser abundantes", "Ser usadas com moderação"], "correct": 1}]',
40, 'previous', 0),

('ufmg', 3, 4, 'Argumentação Linguística', 'Modalização', 
'# Modalização

## O que é?
Marcas linguísticas que indicam posição do autor.

## Tipos
- **Certeza:** "É evidente que..."
- **Possibilidade:** "Possivelmente..."
- **Necessidade:** "É preciso que..."
- **Avaliação:** "Lamentavelmente..."

## Uso estratégico
Modalize para fortalecer ou atenuar afirmações.',
'[{"question": "Modalização indica:", "options": ["Tamanho do texto", "Posição do autor"], "correct": 1}]',
45, 'previous', 0),

('ufmg', 3, 5, 'Estilo e Autoria', 'Voz própria', 
'# Desenvolvendo Estilo

## O que é autoria?
Sua forma única de expressar ideias.

## Características
- Interpretação própria
- Vocabulário pessoal
- Análise original
- Conexões criativas

## Como desenvolver
1. Leia diversos autores
2. Pratique regularmente
3. Revise criticamente
4. Experimente abordagens',
'[{"question": "Autoria é:", "options": ["Copiar bem", "Ter voz própria"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: ASPECTOS FORMAIS (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufmg', 4, 1, 'Norma Culta', 'Gramática essencial', 
'# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌ → "Havia pessoas" ✅
- "Prefiro isso do que aquilo" ❌ → "Prefiro isso a aquilo" ✅
- Vírgula entre sujeito e verbo ❌',
'[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
30, 'free', 0),

('ufmg', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.
"Os alunos estudam" ✅

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular
- "A maioria de": singular ou plural

## Nominal
Adjetivos concordam com substantivos.
"Questões importantes" ✅',
'[{"question": "Sujeito composto pede verbo:", "options": ["Singular", "Plural"], "correct": 1}]',
35, 'previous', 0),

('ufmg', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
| Verbo | Regência |
|-------|----------|
| Assistir (ver) | a |
| Visar (objetivar) | a |
| Preferir | a (não "do que") |

## Crase
a + a = à
- Antes de femininas: à escola ✅
- Antes de masculinas: a pé ✅ (sem crase)',
'[{"question": "''Assisti o filme'' é:", "options": ["Correto", "Incorreto - assistir A"], "correct": 1}]',
40, 'previous', 0),

('ufmg', 4, 4, 'Pontuação', 'Vírgulas e mais', 
'# Pontuação

## Vírgula - USA-SE
- Separar itens de lista
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento

## Outros sinais
- Ponto e vírgula: orações coordenadas longas
- Dois-pontos: explicação, enumeração',
'[{"question": "Pode usar vírgula entre sujeito e verbo?", "options": ["Sim", "Não"], "correct": 1}]',
45, 'previous', 0),

('ufmg', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist de Revisão

## Conteúdo (5 min)
- [ ] Atendeu ao gênero pedido?
- [ ] Desenvolveu o tema?
- [ ] Argumentos coerentes?

## Gramática (5 min)
- [ ] Concordâncias corretas?
- [ ] Pontuação adequada?
- [ ] Regências corretas?

## Estrutura (2 min)
- [ ] Parágrafos equilibrados?
- [ ] Transições claras?

**Reserve 10-12 minutos para revisão!**',
'[{"question": "Revisão deve levar:", "options": ["0 minutos", "10-12 minutos"], "correct": 1}]',
50, 'previous', 0);

SELECT 'UFMG: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'ufmg';
