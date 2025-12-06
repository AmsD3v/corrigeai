-- SISU (Sistema de Seleção Unificada) - Conquistas e 25 Lições (5 por competência)
-- Nota: SISU usa nota do ENEM, lições focam em maximizar pontuação
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/sisu.sql

-- ============================================================================
-- CONQUISTAS SISU
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações SISU
('sisu_essays_1', 'Primeira Redação SISU', 'Enviou sua primeira redação para o SISU', '📝', 'sisu', 'essays_count', 1, 25, 0),
('sisu_essays_5', 'Candidato SISU', 'Enviou 5 redações para o SISU', '✍️', 'sisu', 'essays_count', 5, 50, 1),
('sisu_essays_10', 'Veterano SISU', 'Enviou 10 redações para o SISU', '📚', 'sisu', 'essays_count', 10, 100, 2),

-- Notas SISU (0-1000)
('sisu_bronze', 'Nota Bronze SISU', 'Atingiu 600+ na redação SISU', '🥉', 'sisu', 'score', 600, 100, 2),
('sisu_prata', 'Nota Prata SISU', 'Atingiu 800+ na redação SISU', '🥈', 'sisu', 'score', 800, 200, 5),
('sisu_ouro', 'Nota Ouro SISU', 'Atingiu 900+ na redação SISU', '🥇', 'sisu', 'score', 900, 300, 10),
('sisu_mil', 'Nota 1000 SISU', 'Atingiu nota máxima na redação!', '💎', 'sisu', 'score', 1000, 500, 20),

-- Lições SISU
('sisu_lessons_5', 'Iniciante SISU', 'Completou 5 lições do SISU', '📖', 'sisu', 'lessons', 5, 50, 1),
('sisu_lessons_15', 'Estudante SISU', 'Completou 15 lições do SISU', '📚', 'sisu', 'lessons', 15, 150, 3),
('sisu_lessons_25', 'Mestre SISU', 'Completou todas as 25 lições SISU', '🎓', 'sisu', 'lessons', 25, 300, 5);

-- ============================================================================
-- LIÇÕES SISU - 25 (5 por competência do ENEM)
-- Foco: Estratégias para maximizar nota e conseguir vaga
-- ============================================================================

-- COMPETÊNCIA 1: NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('sisu', 1, 1, 'O SISU e a Redação', 'Como a redação impacta sua vaga', 
'# O SISU e a Importância da Redação

## O que é o SISU?
Sistema de Seleção Unificada que usa a nota do ENEM para acesso a universidades públicas.

## Impacto da Redação
- Peso pode chegar a 40% em alguns cursos
- Nota zero elimina o candidato
- Diferencial para cursos concorridos

## Média ENEM vs Nota de Corte
A redação pode ser o diferencial entre conseguir ou não a vaga!

## Nota mínima exigida
Alguns cursos exigem nota mínima de 400 ou 500 na redação.',
'[{"question": "O SISU usa nota de qual prova?", "options": ["Vestibular próprio", "ENEM"], "correct": 1}, {"question": "Nota zero na redação:", "options": ["Reduz a média", "Elimina o candidato"], "correct": 1}]',
25, 'free', 0),

('sisu', 1, 2, 'Erros que Custam Pontos', 'Desvios gramaticais penalizados', 
'# Erros que Reduzem sua Nota

## Mais Penalizados (C1)
1. **Concordância:** "Os alunos vai..."
2. **Crase:** Uso incorreto
3. **Pontuação:** Vírgula entre sujeito e verbo
4. **Ortografia:** Erros primários

## Impacto
Cada erro pode custar 20-40 pontos na C1!

## Estratégia
Reserve 10 minutos para revisar gramática.',
'[{"question": "Quanto tempo para revisão gramatical?", "options": ["0 minutos", "10 minutos"], "correct": 1}]',
30, 'previous', 0),

('sisu', 1, 3, 'Concordância Perfeita', 'Dominando concordância', 
'# Concordância para Nota 200

## Verbal
- Sujeito composto: verbo no plural
- Verbos impessoais: sempre singular
- "Haver" existindo: HAVIA (nunca "haviam")

## Nominal
- Adjetivo concorda com substantivo
- "Menos" é invariável (nunca "menas")
- "Anexo" concorda (anexas as fotos)',
'[{"question": "''Havia muitas pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
35, 'previous', 0),

('sisu', 1, 4, 'Regência e Crase', 'Preposições certas', 
'# Regência para SISU

## Verbos importantes
| Verbo | Regência |
|-------|----------|
| Assistir (ver) | A - Assisti AO filme |
| Visar (objetivar) | A - Visa AO sucesso |
| Preferir | A - Prefiro café A chá |

## Crase
- Antes de femininas determinadas: à escola ✅
- Antes de masculinas: a pé ✅ (sem crase)',
'[{"question": "''Prefiro isso do que aquilo'' é:", "options": ["Correto", "Incorreto - usar A"], "correct": 1}]',
40, 'previous', 0),

('sisu', 1, 5, 'Checklist Gramatical', 'Revisão final C1', 
'# Checklist C1 - Nota 200

## Antes de finalizar
- [ ] Concordâncias verbais corretas?
- [ ] Concordâncias nominais corretas?
- [ ] Regências adequadas?
- [ ] Crases corretas?
- [ ] Pontuação adequada?

## Dica de ouro
Leia em voz baixa - erros "soam" estranhos.',
'[{"question": "Checklist ajuda a:", "options": ["Perder tempo", "Evitar erros"], "correct": 1}]',
45, 'previous', 0);

-- COMPETÊNCIA 2: TEMA E REPERTÓRIO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('sisu', 2, 1, 'Entendendo o Tema', 'Não fuja do tema!', 
'# C2: Compreensão do Tema

## O que é avaliado
- Compreensão correta do tema
- Desenvolvimento completo
- Uso de repertório pertinente

## Perigos
❌ Fugir do tema = ZERO na C2
❌ Tangenciar = Nota muito baixa
❌ Copiar motivadores = Pode zerar

## Estratégia
Leia a proposta 3 vezes antes de escrever.',
'[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "ZERO na C2"], "correct": 1}]',
25, 'free', 0),

('sisu', 2, 2, 'Tema vs Assunto', 'A diferença crucial', 
'# Tema ≠ Assunto

## Assunto
Amplo, genérico: "Educação", "Saúde"

## Tema
Específico, delimitado: "Desafios da educação inclusiva no Brasil"

## Como identificar
1. Leia o comando
2. Identifique o RECORTE
3. Note condições: "no Brasil", "atualmente"

## Erro
Falar do assunto sem o recorte = tangenciar',
'[{"question": "Tema é:", "options": ["Genérico", "Específico e delimitado"], "correct": 1}]',
30, 'previous', 0),

('sisu', 2, 3, 'Repertório Legitimado', 'Fontes confiáveis', 
'# Repertório para C2

## Tipos válidos
- Dados: IBGE, ONU, pesquisas
- Histórico: Fatos relevantes
- Filosófico: Pensadores
- Cultural: Obras, filmes
- Legal: Leis, Constituição

## Requisitos
✅ Legitimado (fonte confiável)
✅ Pertinente (relacionado ao tema)
✅ Produtivo (usado na argumentação)',
'[{"question": "Repertório deve ser:", "options": ["Qualquer informação", "Legitimado e pertinente"], "correct": 1}]',
35, 'previous', 0),

('sisu', 2, 4, 'Repertório Versátil', 'Referências multiuso', 
'# Repertório Coringa

## Citações versáteis
- Zygmunt Bauman: Modernidade
- Hannah Arendt: Política
- Paulo Freire: Educação
- Simone de Beauvoir: Gênero

## Dados coringa
- Constituição Federal
- DUDH (Direitos Humanos)
- ODS (Objetivos de Desenvolvimento)

## Dica
Monte fichas de repertório por tema!',
'[{"question": "Bauman é útil para falar de:", "options": ["Matemática", "Modernidade e sociedade"], "correct": 1}]',
40, 'previous', 0),

('sisu', 2, 5, 'Checklist C2', 'Garantindo nota máxima', 
'# Checklist C2

## Antes de finalizar
- [ ] Tema corretamente compreendido?
- [ ] Recorte temático respeitado?
- [ ] Repertório é legitimado?
- [ ] Repertório conectado ao tema?
- [ ] Não copiei os motivadores?

## Impacto
C2 mal avaliada = nota total prejudicada',
'[{"question": "Copiar motivadores:", "options": ["É permitido", "Pode zerar"], "correct": 1}]',
45, 'previous', 0);

-- COMPETÊNCIA 3: ARGUMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('sisu', 3, 1, 'Argumentação ENEM', 'O que é avaliado', 
'# C3: Argumentação

## Critérios
- Seleção de argumentos
- Organização das ideias
- Análise crítica

## Níveis
- 200: Argumentação consistente, repertório diversificado
- 160: Bom, mas com falhas pontuais
- 120: Superficial
- 80 ou menos: Problemas sérios',
'[{"question": "Nota 200 em C3 exige:", "options": ["Argumentação superficial", "Argumentação consistente"], "correct": 1}]',
25, 'free', 0),

('sisu', 3, 2, 'Tipos de Argumento', 'Variedade argumentativa', 
'# Tipos de Argumento

## Os mais eficazes
1. **Dados:** Estatísticas, pesquisas
2. **Autoridade:** Especialistas, autores
3. **Exemplificação:** Casos concretos
4. **Comparação:** Paralelos
5. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos por redação.',
'[{"question": "Quantos tipos de argumento usar:", "options": ["1 tipo só", "Ao menos 2"], "correct": 1}]',
30, 'previous', 0),

('sisu', 3, 3, 'Projeto de Texto', 'Planejando antes', 
'# Projeto de Texto

## Por que planejar?
Evita tangenciamento e desorganização.

## Estrutura (5 min)
1. Identifique o tema
2. Defina a tese
3. Escolha 2 argumentos
4. Selecione repertório
5. Esboce a proposta

## Tempo SISU
90 min total → 5 min planejando',
'[{"question": "Planejar leva:", "options": ["30 minutos", "5 minutos"], "correct": 1}]',
35, 'previous', 0),

('sisu', 3, 4, 'Análise Crítica', 'O diferencial', 
'# Análise Crítica

## O que diferencia
Não basta citar - é preciso ANALISAR.

## Níveis
❌ "O IBGE mostra que 11% são analfabetos."
⚠️ "...o que é um problema."
✅ "...revelando falha sistêmica que perpetua exclusão social."

## Fórmula
DADO + "isso revela/demonstra que" + INTERPRETAÇÃO',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar e relacionar"], "correct": 1}]',
40, 'previous', 0),

('sisu', 3, 5, 'Checklist C3', 'Argumentação nota 200', 
'# Checklist C3

## Antes de finalizar
- [ ] Tese clara e defendida?
- [ ] 2+ argumentos desenvolvidos?
- [ ] Repertório diversificado?
- [ ] Análise crítica presente?
- [ ] Progressão entre parágrafos?

## Diferencial
Argumentação autoral = nota alta',
'[{"question": "Autoria significa:", "options": ["Copiar bem", "Interpretar com originalidade"], "correct": 1}]',
45, 'previous', 0);

-- COMPETÊNCIA 4: COESÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('sisu', 4, 1, 'Coesão Textual', 'Ligando as partes', 
'# C4: Coesão

## O que é avaliado
- Uso de conectivos
- Referenciação
- Fluidez entre parágrafos

## Impacto
Texto "solto" = nota baixa em C4',
'[{"question": "Coesão avalia:", "options": ["Gramática apenas", "Conexão entre partes"], "correct": 1}]',
25, 'free', 0),

('sisu', 4, 2, 'Conectivos Essenciais', 'O vocabulário da coesão', 
'# Conectivos por Função

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia, não obstante

## Conclusão
Portanto, logo, destarte, assim

## Causa
Porque, visto que, uma vez que, porquanto

## Consequência
De modo que, de forma que, por conseguinte',
'[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]',
30, 'previous', 0),

('sisu', 4, 3, 'Referenciação', 'Evitando repetição', 
'# Coesão Referencial

## Mecanismos
1. **Pronomes:** ele, isso, aquele
2. **Sinônimos:** "Brasil" → "o país"
3. **Hiperônimos:** termo mais geral
4. **Elipse:** omissão intencional

## Evite
❌ "O Brasil... O Brasil... O Brasil..."
✅ "O Brasil... O país... A nação..."',
'[{"question": "Repetição excessiva:", "options": ["É boa", "Prejudica a nota"], "correct": 1}]',
35, 'previous', 0),

('sisu', 4, 4, 'Transições', 'Entre parágrafos', 
'# Transições Fluidas

## Técnica
Retome algo do parágrafo anterior:

**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão estrutural, a negligência..."

## Conectivos de transição
- "Diante desse cenário..."
- "Nessa perspectiva..."
- "Além desse aspecto..."',
'[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]',
40, 'previous', 0),

('sisu', 4, 5, 'Checklist C4', 'Coesão nota 200', 
'# Checklist C4

## Antes de finalizar
- [ ] Conectivos variados?
- [ ] Sem repetições excessivas?
- [ ] Parágrafos conectados?
- [ ] Referências claras?
- [ ] Texto fluido?

## Dica
Releia buscando "buracos" entre ideias.',
'[{"question": "C4 avalia:", "options": ["Conteúdo", "Conexão textual"], "correct": 1}]',
45, 'previous', 0);

-- COMPETÊNCIA 5: PROPOSTA DE INTERVENÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('sisu', 5, 1, 'Os 5 Elementos', 'Estrutura obrigatória', 
'# C5: Proposta de Intervenção

## 5 Elementos Obrigatórios
1. **AGENTE:** Quem faz? (Governo, MEC...)
2. **AÇÃO:** O que fazer?
3. **MODO/MEIO:** Como fazer?
4. **DETALHAMENTO:** Especificação
5. **FINALIDADE:** Para quê?

## Impacto
Falta de elementos = nota proporcional',
'[{"question": "Quantos elementos obrigatórios?", "options": ["3", "5"], "correct": 1}]',
25, 'free', 0),

('sisu', 5, 2, 'Agentes Eficazes', 'Quem pode agir?', 
'# Escolhendo o Agente

## Governo
- Poder Executivo: Ministérios
- Poder Legislativo: Leis
- Poder Judiciário: Fiscalização

## Sociedade Civil
- Mídia: Campanhas
- ONGs: Projetos
- Escolas: Educação
- Empresas: Responsabilidade social

## Dica
Escolha agente que PODE agir no problema.',
'[{"question": "Problema educacional → agente:", "options": ["Ministério da Saúde", "MEC"], "correct": 1}]',
30, 'previous', 0),

('sisu', 5, 3, 'Direitos Humanos', 'Evitando ZERO', 
'# Proposta e Direitos Humanos

## ⚠️ PODE ZERAR

### Proibido propor:
- Pena de morte
- Tortura
- Censura
- Discriminação
- Trabalho forçado

### Permitido:
- Educação e conscientização
- Políticas públicas
- Fiscalização legal
- Apoio a vítimas',
'[{"question": "Propor censura:", "options": ["É válido", "Pode zerar"], "correct": 1}]',
35, 'previous', 0),

('sisu', 5, 4, 'Proposta Completa', 'Exemplo nota 200', 
'# Modelo de Proposta

## Exemplo completo
"O **MEC** [agente] deve **criar campanhas educativas** [ação] **por meio de parcerias com influenciadores digitais** [modo] **nas redes sociais, semanalmente, alcançando jovens de 15 a 25 anos** [detalhamento], **a fim de conscientizar sobre os riscos das fake news e promover o pensamento crítico** [finalidade]."

## Estrutura
AGENTE + AÇÃO + MODO + DETALHAMENTO + FINALIDADE',
'[{"question": "Proposta completa tem:", "options": ["3 elementos", "5 elementos"], "correct": 1}]',
40, 'previous', 0),

('sisu', 5, 5, 'Checklist C5', 'Proposta nota 200', 
'# Checklist C5 - SISU

## Antes de finalizar
- [ ] Agente específico?
- [ ] Ação concreta?
- [ ] Modo/meio claro?
- [ ] Detalhamento presente?
- [ ] Finalidade explícita?
- [ ] Respeita direitos humanos?
- [ ] Conectada aos argumentos?

## Impacto no SISU
C5 = diferencial para nota de corte!',
'[{"question": "C5 completa impacta:", "options": ["Pouco", "Significativamente na nota"], "correct": 1}]',
50, 'previous', 0);

SELECT 'SISU: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'sisu';
