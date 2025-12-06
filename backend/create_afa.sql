-- AFA (Academia da Força Aérea) - Conquistas e 20 Lições (5 por critério)
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/afa.sql

-- ============================================================================
-- CONQUISTAS AFA
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações AFA
('afa_essays_1', 'Primeira Redação AFA', 'Enviou sua primeira redação AFA', '📝', 'afa', 'essays_count', 1, 25, 0),
('afa_essays_5', 'Escritor AFA', 'Enviou 5 redações AFA', '✍️', 'afa', 'essays_count', 5, 50, 1),
('afa_essays_10', 'Redator Dedicado AFA', 'Enviou 10 redações AFA', '📚', 'afa', 'essays_count', 10, 100, 2),

-- Notas AFA (0-100)
('afa_bronze', 'Nota Bronze AFA', 'Atingiu 60+ na AFA', '🥉', 'afa', 'score', 60, 100, 2),
('afa_prata', 'Nota Prata AFA', 'Atingiu 80+ na AFA', '🥈', 'afa', 'score', 80, 200, 5),
('afa_ouro', 'Nota Ouro AFA', 'Atingiu 90+ na AFA', '🥇', 'afa', 'score', 90, 300, 10),

-- Lições AFA
('afa_lessons_5', 'Iniciante AFA', 'Completou 5 lições da AFA', '📖', 'afa', 'lessons', 5, 50, 1),
('afa_lessons_15', 'Estudante AFA', 'Completou 15 lições da AFA', '📚', 'afa', 'lessons', 15, 150, 3),
('afa_lessons_20', 'Mestre AFA', 'Completou todas as 20 lições AFA', '🎓', 'afa', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES AFA - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura e Organização, 3-Argumentação e Fundamentação, 4-Expressão e Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('afa', 1, 1, 'A Redação AFA', 'Conhecendo a prova militar', 
'# A Redação da AFA

## O que é a AFA?
Academia da Força Aérea - forma oficiais aviadores da FAB.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades, ética, valores militares
- **Perfil:** Texto formal e objetivo

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e organização
3. Argumentação e fundamentação
4. Expressão e norma culta

## Diferencial
Valoriza postura ética e conhecimento de valores da carreira militar.',
'[{"question": "A AFA forma oficiais de qual força?", "options": ["Exército", "Marinha", "Aeronáutica"], "correct": 2}, {"question": "Extensão recomendada:", "options": ["15-20 linhas", "20-30 linhas"], "correct": 1}]',
30, 'free', 0),

('afa', 1, 2, 'Temas Militares', 'Assuntos frequentes', 
'# Temas na AFA

## Áreas Recorrentes
- Ética e valores
- Liderança e disciplina
- Tecnologia e defesa
- Sociedade e cidadania
- Meio ambiente
- Atualidades brasileiras

## Abordagem Esperada
- Posicionamento claro
- Argumentação fundamentada
- Valores de integridade
- Visão de responsabilidade social

## Repertório Útil
- Constituição Federal
- Defesa Nacional
- Fatos históricos brasileiros',
'[{"question": "A AFA valoriza postura:", "options": ["Neutra", "Ética e fundamentada"], "correct": 1}]',
35, 'previous', 0),

('afa', 1, 3, 'Interpretando a Proposta', 'Análise cuidadosa', 
'# Análise da Proposta

## Elementos
1. **Tema central:** O assunto
2. **Recorte:** Delimitação específica
3. **Comando:** O que fazer

## Estratégia
1. Leia o tema completo
2. Identifique palavras-chave
3. Note delimitações (tempo, espaço)
4. Defina seu posicionamento

## Erro grave
Fugir do tema ou tangenciar = nota muito baixa',
'[{"question": "Tangenciar o tema significa:", "options": ["Desenvolver bem", "Abordar parcialmente"], "correct": 1}]',
40, 'previous', 0),

('afa', 1, 4, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Liderança na sociedade atual

❌ "A liderança é importante"
✅ "A liderança eficaz combina competência técnica e inteligência emocional, sendo essencial para organizações contemporâneas"

## Posição na AFA
Tese assertiva, sem rodeios.',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e objetiva"], "correct": 1}]',
45, 'previous', 0),

('afa', 1, 5, 'Valores e Ética', 'Base da argumentação AFA', 
'# Valores na Redação AFA

## Valores da FAB
- Integridade
- Profissionalismo
- Comprometimento
- Disciplina
- Patriotismo

## Como usar
Não cite diretamente, mas deixe transparecer em sua argumentação.

## Exemplo
Ao discutir liderança, demonstre valorização de responsabilidade e ética - não apenas cite que são importantes.',
'[{"question": "Valores devem:", "options": ["Ser citados diretamente", "Transparecer na argumentação"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA E ORGANIZAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('afa', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
'# Estrutura para AFA

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + fechamento (5-7 linhas)

## Característica AFA
Estrutura clara e objetiva, sem rodeios.',
'[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]',
30, 'free', 0),

('afa', 2, 2, 'Introdução Direta', 'Abrindo com clareza', 
'# A Introdução AFA

## Elementos
1. Contextualização breve
2. Apresentação do tema
3. Tese clara

## Estilo
Direto e objetivo - sem floreios.

## Exemplo
"A liderança constitui elemento fundamental para o sucesso de qualquer organização. [contexto] No cenário contemporâneo, marcado por rápidas transformações, [tema] é imperativo que líderes desenvolvam tanto competências técnicas quanto habilidades interpessoais. [tese]"',
'[{"question": "Introdução AFA deve ser:", "options": ["Longa e detalhada", "Direta e objetiva"], "correct": 1}]',
35, 'previous', 0),

('afa', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', 
'# Desenvolvimento

## Estrutura do Parágrafo
1. **Tópico frasal:** Ideia principal
2. **Fundamentação:** Argumento
3. **Exemplo:** Caso ou dado
4. **Análise:** Interpretação
5. **Fechamento:** Link com tese

## Quantidade
2 parágrafos bem desenvolvidos > 3 superficiais',
'[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]',
40, 'previous', 0),

('afa', 2, 4, 'Progressão Textual', 'Avançando ideias', 
'# Progressão

## Princípio
Cada parágrafo adiciona informação nova.

## Técnica
- D1: Argumento mais acessível
- D2: Argumento mais complexo ou complementar

## Conectivos de progressão
- "Além disso..."
- "Soma-se a isso..."
- "Em complemento..."',
'[{"question": "Progressão significa:", "options": ["Repetir ideias", "Adicionar informações"], "correct": 1}]',
45, 'previous', 0),

('afa', 2, 5, 'Conclusão Objetiva', 'Fechando o texto', 
'# Conclusão AFA

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Reflexão final ou projeção

## Estilo
Objetiva e assertiva.

## Evite
- Novas informações
- Repetir literalmente a introdução
- Frases vazias como "conclui-se que"',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: ARGUMENTAÇÃO E FUNDAMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('afa', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
'# Argumentação

## Tipos Valorizados
1. **Dados:** Estatísticas confiáveis
2. **Exemplos:** Casos históricos
3. **Autoridade:** Especialistas
4. **Lógica:** Causa e consequência

## Na AFA
Valoriza argumentação fundamentada, não opinativa.',
'[{"question": "AFA valoriza argumento:", "options": ["Opinativo", "Fundamentado"], "correct": 1}]',
30, 'free', 0),

('afa', 3, 2, 'Repertório para AFA', 'Conhecimento útil', 
'# Repertório

## Áreas Úteis
- História do Brasil e da FAB
- Defesa e segurança
- Tecnologia aeroespacial
- Ética e liderança
- Atualidades brasileiras

## Fontes
- Constituição Federal
- Fatos históricos
- Dados oficiais
- Pensadores reconhecidos',
'[{"question": "Repertório AFA deve incluir:", "options": ["Só entretenimento", "História, ética, atualidades"], "correct": 1}]',
35, 'previous', 0),

('afa', 3, 3, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é importante"
⚠️ Médio: "Isso afeta a sociedade"
✅ Avançado: "Esse cenário revela desafios estruturais que demandam..."

## Fórmula
DADO + interpretação + consequência + conexão com tese',
'[{"question": "Análise crítica vai além de:", "options": ["Descrever", "Citar"], "correct": 1}]',
40, 'previous', 0),

('afa', 3, 4, 'Coerência Argumentativa', 'Lógica do texto', 
'# Coerência

## Princípio
Argumentos devem apoiar a tese, não contradizê-la.

## Problemas comuns
❌ Tese X, argumento Y
❌ Conclusão diferente do defendido
❌ Exemplos que não comprovam

## Solução
Sempre pergunte: "Isso prova minha tese?"',
'[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]',
45, 'previous', 0),

('afa', 3, 5, 'Fundamentação Sólida', 'Provas concretas', 
'# Fundamentação

## O que é?
Provas concretas para suas afirmações.

## Tipos
- Dados estatísticos
- Exemplos históricos
- Casos concretos
- Citações de autoridade

## Na AFA
Evite afirmações sem fundamento. Toda opinião deve ter base.',
'[{"question": "Opinião sem fundamento é:", "options": ["Válida", "Problemática"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: EXPRESSÃO E NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('afa', 4, 1, 'Norma Culta', 'Gramática essencial', 
'# Norma Culta

## Pontos Críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros Graves
- "Haviam pessoas" ❌
- "Prefiro isso do que" ❌
- Vírgula entre sujeito e verbo ❌',
'[{"question": "''Havia muitas pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
30, 'free', 0),

('afa', 4, 2, 'Registro Formal', 'Linguagem adequada', 
'# Registro Formal

## Características
- Terceira pessoa
- Vocabulário culto
- Frases completas
- Tom objetivo

## Evite
- "A gente" → use "nós"
- Gírias e coloquialismos
- Contrações: "pra", "tá"',
'[{"question": "Registro formal usa:", "options": ["Gírias", "Terceira pessoa"], "correct": 1}]',
35, 'previous', 0),

('afa', 4, 3, 'Objetividade', 'Clareza na expressão', 
'# Clareza e Objetividade

## Princípios
- Uma ideia por período
- Vocabulário preciso
- Evitar ambiguidades

## Na AFA
Estilo militar: claro, direto, sem rodeios.

## Exemplo
❌ "Pode-se dizer que talvez seja possível..."
✅ "É necessário que..."',
'[{"question": "Texto AFA deve ser:", "options": ["Rebuscado", "Claro e direto"], "correct": 1}]',
40, 'previous', 0),

('afa', 4, 4, 'Vocabulário', 'Escolha de palavras', 
'# Vocabulário Adequado

## Substituições
| Simples | Sofisticado |
|---------|-------------|
| Mostrar | Evidenciar |
| Problema | Desafio |
| Importante | Fundamental |

## Cuidado
Use apenas palavras que domina.',
'[{"question": "Vocabulário deve ser:", "options": ["Complexo sempre", "Preciso e adequado"], "correct": 1}]',
45, 'previous', 0),

('afa', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist AFA

## Conteúdo
- [ ] Tema atendido?
- [ ] Tese clara?
- [ ] Argumentos fundamentados?

## Estrutura
- [ ] 4 parágrafos?
- [ ] Transições claras?

## Gramática
- [ ] Concordâncias?
- [ ] Pontuação?
- [ ] Regências?

**Reserve 10 minutos para revisão!**',
'[{"question": "Revisão deve levar:", "options": ["0 minutos", "10 minutos"], "correct": 1}]',
50, 'previous', 0);

SELECT 'AFA: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'afa';
