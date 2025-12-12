-- Sistema Multi-Vestibular - Conquistas e Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/multivestibular.sql

-- Adicionar coluna exam_type em achievement se não existir
ALTER TABLE achievement ADD COLUMN IF NOT EXISTS exam_type VARCHAR;
CREATE INDEX IF NOT EXISTS idx_achievement_exam_type ON achievement(exam_type);

-- Limpar dados antigos
DELETE FROM user_achievement;
DELETE FROM achievement;

-- ==================== CONQUISTAS GLOBAIS ====================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Streak (verdadeiramente global - conta dias de estudo)
('streak_7', 'Estudante Dedicado', '7 dias seguidos de estudo', '🔥', NULL, 'streak', 7, 50, 1),
('streak_30', 'Mestre da Consistência', '30 dias seguidos de estudo', '🌟', NULL, 'streak', 30, 200, 3),
('streak_100', 'Lenda da Disciplina', '100 dias seguidos de estudo', '👑', NULL, 'streak', 100, 500, 10);

-- ==================== CONQUISTAS ENEM ====================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações ENEM
('enem_essays_1', 'Primeira Redação ENEM', 'Enviou sua primeira redação ENEM', '📝', 'enem', 'essays_count', 1, 25, 0),
('enem_essays_5', 'Escritor ENEM', 'Enviou 5 redações ENEM', '✍️', 'enem', 'essays_count', 5, 50, 1),
('enem_essays_10', 'Redator Dedicado ENEM', 'Enviou 10 redações ENEM', '📚', 'enem', 'essays_count', 10, 100, 2),

-- Notas ENEM (0-1000)
('enem_bronze', 'Nota Bronze ENEM', 'Atingiu 600+ no ENEM', '🥉', 'enem', 'score', 600, 100, 2),
('enem_prata', 'Nota Prata ENEM', 'Atingiu 800+ no ENEM', '🥈', 'enem', 'score', 800, 200, 5),
('enem_ouro', 'Nota Ouro ENEM', 'Atingiu 900+ no ENEM', '🥇', 'enem', 'score', 900, 300, 10),
('enem_perfeito', 'Nota 1000 ENEM', 'Atingiu nota máxima no ENEM', '💎', 'enem', 'score', 1000, 500, 20),

-- Lições ENEM
('enem_lessons_5', 'Iniciante ENEM', 'Completou 5 lições do ENEM', '📖', 'enem', 'lessons', 5, 50, 1),
('enem_lessons_15', 'Estudante ENEM', 'Completou 15 lições do ENEM', '📚', 'enem', 'lessons', 15, 150, 3),
('enem_lessons_25', 'Mestre ENEM', 'Completou todas as 25 lições ENEM', '🎓', 'enem', 'lessons', 25, 300, 5);

-- ==================== CONQUISTAS FUVEST ====================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações FUVEST
('fuvest_essays_1', 'Primeira Redação FUVEST', 'Enviou sua primeira redação FUVEST', '📝', 'fuvest', 'essays_count', 1, 25, 0),
('fuvest_essays_5', 'Escritor FUVEST', 'Enviou 5 redações FUVEST', '✍️', 'fuvest', 'essays_count', 5, 50, 1),
('fuvest_essays_10', 'Redator Dedicado FUVEST', 'Enviou 10 redações FUVEST', '📚', 'fuvest', 'essays_count', 10, 100, 2),

-- Notas FUVEST (0-100)
('fuvest_bronze', 'Nota Bronze FUVEST', 'Atingiu 60+ na FUVEST', '🥉', 'fuvest', 'score', 60, 100, 2),
('fuvest_prata', 'Nota Prata FUVEST', 'Atingiu 80+ na FUVEST', '🥈', 'fuvest', 'score', 80, 200, 5),
('fuvest_ouro', 'Nota Ouro FUVEST', 'Atingiu 90+ na FUVEST', '🥇', 'fuvest', 'score', 90, 300, 10),

-- Lições FUVEST
('fuvest_lessons_5', 'Iniciante FUVEST', 'Completou 5 lições da FUVEST', '📖', 'fuvest', 'lessons', 5, 50, 1),
('fuvest_lessons_15', 'Estudante FUVEST', 'Completou 15 lições da FUVEST', '📚', 'fuvest', 'lessons', 15, 150, 3),
('fuvest_lessons_25', 'Mestre FUVEST', 'Completou todas as 25 lições FUVEST', '🎓', 'fuvest', 'lessons', 25, 300, 5);

-- ==================== CONQUISTAS UNICAMP ====================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UNICAMP
('unicamp_essays_1', 'Primeira Redação UNICAMP', 'Enviou sua primeira redação UNICAMP', '📝', 'unicamp', 'essays_count', 1, 25, 0),
('unicamp_essays_5', 'Escritor UNICAMP', 'Enviou 5 redações UNICAMP', '✍️', 'unicamp', 'essays_count', 5, 50, 1),
('unicamp_essays_10', 'Redator Dedicado UNICAMP', 'Enviou 10 redações UNICAMP', '📚', 'unicamp', 'essays_count', 10, 100, 2),

-- Notas UNICAMP (0-100)
('unicamp_bronze', 'Nota Bronze UNICAMP', 'Atingiu 60+ na UNICAMP', '🥉', 'unicamp', 'score', 60, 100, 2),
('unicamp_prata', 'Nota Prata UNICAMP', 'Atingiu 80+ na UNICAMP', '🥈', 'unicamp', 'score', 80, 200, 5),
('unicamp_ouro', 'Nota Ouro UNICAMP', 'Atingiu 90+ na UNICAMP', '🥇', 'unicamp', 'score', 90, 300, 10),

-- Lições UNICAMP
('unicamp_lessons_5', 'Iniciante UNICAMP', 'Completou 5 lições da UNICAMP', '📖', 'unicamp', 'lessons', 5, 50, 1),
('unicamp_lessons_15', 'Estudante UNICAMP', 'Completou 15 lições UNICAMP', '📚', 'unicamp', 'lessons', 15, 150, 3),
('unicamp_lessons_25', 'Mestre UNICAMP', 'Completou todas as lições UNICAMP', '🎓', 'unicamp', 'lessons', 25, 300, 5);

-- ==================== CONQUISTAS UNESP ====================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UNESP
('unesp_essays_1', 'Primeira Redação UNESP', 'Enviou sua primeira redação UNESP', '📝', 'unesp', 'essays_count', 1, 25, 0),
('unesp_essays_5', 'Escritor UNESP', 'Enviou 5 redações UNESP', '✍️', 'unesp', 'essays_count', 5, 50, 1),
('unesp_essays_10', 'Redator Dedicado UNESP', 'Enviou 10 redações UNESP', '📚', 'unesp', 'essays_count', 10, 100, 2),

-- Notas UNESP (0-100)
('unesp_bronze', 'Nota Bronze UNESP', 'Atingiu 60+ na UNESP', '🥉', 'unesp', 'score', 60, 100, 2),
('unesp_prata', 'Nota Prata UNESP', 'Atingiu 80+ na UNESP', '🥈', 'unesp', 'score', 80, 200, 5),
('unesp_ouro', 'Nota Ouro UNESP', 'Atingiu 90+ na UNESP', '🥇', 'unesp', 'score', 90, 300, 10),

-- Lições UNESP
('unesp_lessons_5', 'Iniciante UNESP', 'Completou 5 lições da UNESP', '📖', 'unesp', 'lessons', 5, 50, 1),
('unesp_lessons_15', 'Estudante UNESP', 'Completou 15 lições UNESP', '📚', 'unesp', 'lessons', 15, 150, 3),
('unesp_lessons_25', 'Mestre UNESP', 'Completou todas as lições UNESP', '🎓', 'unesp', 'lessons', 25, 300, 5);

-- ==================== CONQUISTAS ITA/IME ====================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações ITA
('ita_essays_1', 'Primeira Redação ITA', 'Enviou sua primeira redação ITA', '📝', 'ita', 'essays_count', 1, 25, 0),
('ita_essays_5', 'Escritor ITA', 'Enviou 5 redações ITA', '✍️', 'ita', 'essays_count', 5, 50, 1),
('ita_essays_10', 'Redator Dedicado ITA', 'Enviou 10 redações ITA', '📚', 'ita', 'essays_count', 10, 100, 2),

-- Notas ITA (0-100)
('ita_bronze', 'Nota Bronze ITA', 'Atingiu 60+ no ITA', '🥉', 'ita', 'score', 60, 100, 2),
('ita_prata', 'Nota Prata ITA', 'Atingiu 80+ no ITA', '🥈', 'ita', 'score', 80, 200, 5),
('ita_ouro', 'Nota Ouro ITA', 'Atingiu 90+ no ITA', '🥇', 'ita', 'score', 90, 300, 10),

-- Lições ITA
('ita_lessons_5', 'Iniciante ITA', 'Completou 5 lições do ITA', '📖', 'ita', 'lessons', 5, 50, 1),
('ita_lessons_15', 'Estudante ITA', 'Completou 15 lições ITA', '📚', 'ita', 'lessons', 15, 150, 3),
('ita_lessons_25', 'Mestre ITA', 'Completou todas as lições ITA', '🎓', 'ita', 'lessons', 25, 300, 5);

SELECT 'Criadas ' || COUNT(*) || ' conquistas!' as status FROM achievement;

-- ==================== LIÇÕES BASE POR VESTIBULAR ====================
-- Focando nas primeiras 3 lições de cada, estrutura escalável

DELETE FROM user_lesson;
DELETE FROM lesson;

-- ENEM já tem 25 lições no outro arquivo, vamos criar lições para os outros

-- ==================== LIÇÕES FUVEST ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
-- FUVEST usa 4 critérios: Tema/Texto, Estrutura, Expressão, Adequação

('fuvest', 1, 1, 'A Redação FUVEST', 'Entendendo a prova', 
'# A Redação da FUVEST

## Características
- **Formato:** Dissertação-argumentativa
- **Tema:** Geralmente filosófico/reflexivo
- **Extensão:** 20 a 30 linhas
- **Nota:** 0 a 100 pontos

## Critérios de Avaliação

| Critério | Peso |
|----------|------|
| Tema e Texto | 25% |
| Estrutura | 25% |
| Expressão | 25% |
| Adequação | 25% |

## Diferenças do ENEM
- Temas mais abstratos e filosóficos
- Coletânea mais complexa
- Não exige proposta de intervenção
- Valoriza repertório literário',
'[{"question": "A redação FUVEST exige proposta de intervenção?", "options": ["Sim", "Não"], "correct": 1}, {"question": "Qual a extensão recomendada?", "options": ["10-20 linhas", "20-30 linhas", "30-40 linhas"], "correct": 1}]',
30, 'free', 0),

('fuvest', 1, 2, 'Usando a Coletânea', 'Interpretando os textos', 
'# A Coletânea FUVEST

## O que é?
Conjunto de textos de apoio com diferentes perspectivas sobre o tema.

## Como usar?
1. Leia TODOS os textos
2. Identifique pontos de vista diferentes
3. NÃO COPIE trechos
4. Use como inspiração para SEUS argumentos

## Erro Comum
❌ Copiar frases da coletânea
✅ Parafrasear e desenvolver com suas palavras

## Dica de Ouro
A coletânea apresenta visões contraditórias. Você deve escolher um posicionamento e defender com argumentos próprios.',
'[{"question": "Pode copiar trechos da coletânea?", "options": ["Sim", "Não, deve parafrasear"], "correct": 1}]',
35, 'previous', 0),

('fuvest', 1, 3, 'Repertório Literário', 'O diferencial FUVEST', 
'# Repertório Literário FUVEST

## Por que é importante?
A FUVEST valoriza referências às obras da lista de leitura obrigatória.

## Como usar literatura?
1. Cite personagens e situações
2. Relacione com o tema proposto
3. Analise criticamente

## Exemplo
**Tema:** Solidão moderna
*"Assim como Bentinho em Dom Casmurro, muitos se isolam em suas certezas..."*

## Obras mais versáteis
- Machado de Assis (Dom Casmurro, Memórias Póstumas)
- Fernando Pessoa
- Clarice Lispector',
'[{"question": "A FUVEST valoriza referências a:", "options": ["Filmes americanos", "Obras literárias da lista", "Músicas populares"], "correct": 1}]',
40, 'previous', 0);

-- ==================== LIÇÕES UNICAMP ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unicamp', 1, 1, 'A Redação UNICAMP', 'Entendendo os gêneros', 
'# A Redação da UNICAMP

## Características Únicas
- **2 propostas diferentes** (você escolhe 1)
- **Gêneros variados:** carta, artigo, crônica, discurso
- **Interlocutor definido:** você escreve PARA alguém

## Diferencial
A UNICAMP cobra GÊNEROS TEXTUAIS específicos, não apenas dissertação!

## Gêneros Comuns
- Artigo de opinião
- Carta argumentativa
- Manifesto
- Crônica
- Discurso

## Critérios
| Aspecto | O que avalia |
|---------|--------------|
| Gênero | Adequação ao formato pedido |
| Interlocução | Consciência do leitor |
| Propósito | Objetivo comunicativo |
| Argumentação | Qualidade dos argumentos |',
'[{"question": "Quantas propostas a UNICAMP oferece?", "options": ["1", "2", "3"], "correct": 1}, {"question": "A UNICAMP cobra apenas dissertação?", "options": ["Sim", "Não, cobra gêneros variados"], "correct": 1}]',
30, 'free', 0),

('unicamp', 1, 2, 'Carta Argumentativa', 'Gênero mais cobrado', 
'# Carta Argumentativa

## Estrutura
1. **Local e data**
2. **Vocativo** (A quem se destina)
3. **Corpo** (Argumentação)
4. **Despedida**
5. **Assinatura**

## Exemplo de Início
*São Paulo, dezembro de 2024*

*Prezado Secretário de Educação,*

*Venho por meio desta...*

## Linguagem
- Formal, mas pessoal
- Verbos em 1ª pessoa
- Tom respeitoso mas firme',
'[{"question": "Carta argumentativa precisa de local e data?", "options": ["Sim", "Não"], "correct": 0}]',
35, 'previous', 0),

('unicamp', 1, 3, 'Artigo de Opinião', 'Outro gênero frequente', 
'# Artigo de Opinião

## Características
- Publicado em jornal/revista
- Autor se posiciona claramente
- Usa argumentos e dados
- Tom mais impessoal que carta

## Estrutura
1. **Título chamativo**
2. **Introdução** com contexto
3. **Desenvolvimento** com argumentos
4. **Conclusão** com proposta/reflexão

## Diferença da Carta
- Artigo: público geral
- Carta: destinatário específico',
'[{"question": "Artigo de opinião precisa de título?", "options": ["Sim", "Não"], "correct": 0}]',
40, 'previous', 0);

-- ==================== LIÇÕES UNESP ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unesp', 1, 1, 'A Redação UNESP', 'Formato e critérios', 
'# A Redação da UNESP

## Formato
- **Tipo:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Tema:** Baseado em textos de apoio

## Critérios de Correção
1. Desenvolvimento do tema
2. Organização textual
3. Coerência e coesão
4. Norma culta

## Características
- Temas atuais e sociais
- Textos de apoio mais curtos que FUVEST
- Valoriza posicionamento claro',
'[{"question": "A UNESP cobra dissertação-argumentativa?", "options": ["Sim", "Não"], "correct": 0}]',
30, 'free', 0),

('unesp', 1, 2, 'Estrutura Dissertativa', 'Organizando o texto', 
'# Estrutura UNESP

## Modelo Recomendado

### Introdução (5-7 linhas)
- Contextualização
- Tese clara

### Desenvolvimento (15-18 linhas)
- 2 parágrafos
- 1 argumento + exemplo cada
- Progressão lógica

### Conclusão (5-7 linhas)
- Retomada
- Proposta ou reflexão final',
'[{"question": "Quantos parágrafos de desenvolvimento são ideais?", "options": ["1", "2", "3"], "correct": 1}]',
35, 'previous', 0),

('unesp', 1, 3, 'Repertório UNESP', 'Usando referências', 
'# Repertório na UNESP

## O que funciona?
- Dados estatísticos
- Fatos históricos
- Referências culturais
- Exemplos concretos

## Evite
- Repertório clichê
- Citações sem análise
- Generalizações

## Dica
Use os textos de apoio como ponto de partida, mas VÁ ALÉM deles!',
'[{"question": "Deve usar apenas os textos de apoio?", "options": ["Sim", "Não, deve ir além"], "correct": 1}]',
40, 'previous', 0);

-- ==================== LIÇÕES ITA/IME ====================

INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ita', 1, 1, 'A Redação ITA', 'Rigor técnico', 
'# A Redação do ITA

## Características
- **Rigor técnico** na argumentação
- **Temas científicos/tecnológicos** frequentes
- **Extensão:** 20 a 30 linhas
- **Valoriza:** lógica e precisão

## Diferencial
O ITA espera argumentação precisa, quase científica. Evite generalizações!

## Perfil do avaliador
Busca:
- Clareza de raciocínio
- Argumentos bem fundamentados
- Linguagem objetiva',
'[{"question": "O ITA valoriza que tipo de argumentação?", "options": ["Emocional", "Lógica e precisa", "Literária"], "correct": 1}]',
30, 'free', 0),

('ita', 1, 2, 'Argumentação Técnica', 'Precisão nos argumentos', 
'# Argumentação Técnica

## Como argumentar para ITA

### Use:
- Dados quantitativos
- Exemplos específicos
- Causa e consequência clara
- Vocabulário preciso

### Evite:
- "Muitas pessoas pensam..."
- "Desde sempre..."
- Generalizações vagas

## Modelo de argumento
*"Segundo estudo da USP (2023), 73% dos engenheiros..."* [dado específico]',
'[{"question": "''Muitas pessoas pensam'' é bom para ITA?", "options": ["Sim", "Não, é vago"], "correct": 1}]',
35, 'previous', 0),

('ita', 1, 3, 'Temas Científicos', 'Preparando-se para o ITA', 
'# Temas Científicos no ITA

## Assuntos frequentes
- Tecnologia e sociedade
- Ética na ciência
- Desenvolvimento sustentável
- Inovação e progresso

## Como se preparar
1. Leia artigos científicos divulgação
2. Acompanhe notícias de tecnologia
3. Conheça debates éticos atuais

## Repertório útil
- Revoluções industriais
- Avanços tecnológicos recentes
- Impactos ambientais',
'[{"question": "Temas científicos são comuns no ITA?", "options": ["Sim", "Não"], "correct": 0}]',
40, 'previous', 0);

SELECT 'Criadas ' || COUNT(*) || ' lições!' as status FROM lesson;
