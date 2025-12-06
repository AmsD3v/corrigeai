-- Gamification Tables for CorrigeAI
-- Run: docker exec -it prosaai_db psql -U user -d prosaai -f /path/to/this/file.sql

-- User Gamification Profile
CREATE TABLE IF NOT EXISTS user_gamification (
    id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    xp_total INTEGER DEFAULT 0 NOT NULL,
    level INTEGER DEFAULT 1 NOT NULL,
    current_streak INTEGER DEFAULT 0 NOT NULL,
    max_streak INTEGER DEFAULT 0 NOT NULL,
    last_activity_date TIMESTAMP,
    lessons_completed INTEGER DEFAULT 0 NOT NULL,
    quizzes_perfect INTEGER DEFAULT 0 NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Achievements/Badges
CREATE TABLE IF NOT EXISTS achievement (
    id SERIAL PRIMARY KEY,
    code VARCHAR UNIQUE NOT NULL,
    name VARCHAR NOT NULL,
    description VARCHAR NOT NULL,
    icon VARCHAR DEFAULT '🏆',
    xp_reward INTEGER DEFAULT 0,
    coin_reward INTEGER DEFAULT 0,
    lessons_reward INTEGER DEFAULT 0,
    condition_type VARCHAR NOT NULL,
    condition_value INTEGER NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- User Achievements (unlocked badges)
CREATE TABLE IF NOT EXISTS user_achievement (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    achievement_id INTEGER NOT NULL REFERENCES achievement(id) ON DELETE CASCADE,
    unlocked_at TIMESTAMP DEFAULT NOW() NOT NULL,
    UNIQUE(user_id, achievement_id)
);

-- Lessons
CREATE TABLE IF NOT EXISTS lesson (
    id SERIAL PRIMARY KEY,
    exam_type VARCHAR NOT NULL,
    competency INTEGER NOT NULL,
    "order" INTEGER NOT NULL,
    title VARCHAR NOT NULL,
    description VARCHAR,
    content TEXT NOT NULL,
    quiz_data TEXT,
    xp_reward INTEGER DEFAULT 25,
    unlock_type VARCHAR DEFAULT 'previous',
    unlock_value INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- User Lesson Progress
CREATE TABLE IF NOT EXISTS user_lesson (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    lesson_id INTEGER NOT NULL REFERENCES lesson(id) ON DELETE CASCADE,
    is_unlocked BOOLEAN DEFAULT FALSE,
    is_completed BOOLEAN DEFAULT FALSE,
    quiz_score INTEGER,
    unlocked_at TIMESTAMP,
    completed_at TIMESTAMP,
    UNIQUE(user_id, lesson_id)
);

-- Challenges
CREATE TABLE IF NOT EXISTS challenge (
    id SERIAL PRIMARY KEY,
    challenge_type VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
    description VARCHAR NOT NULL,
    icon VARCHAR DEFAULT '🎯',
    action_type VARCHAR NOT NULL,
    target_count INTEGER DEFAULT 1,
    xp_reward INTEGER DEFAULT 10,
    coin_reward INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE
);

-- User Challenge Progress
CREATE TABLE IF NOT EXISTS user_challenge (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    challenge_id INTEGER NOT NULL REFERENCES challenge(id) ON DELETE CASCADE,
    progress INTEGER DEFAULT 0,
    is_completed BOOLEAN DEFAULT FALSE,
    period_start TIMESTAMP NOT NULL,
    completed_at TIMESTAMP
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_user_gamification_user_id ON user_gamification(user_id);
CREATE INDEX IF NOT EXISTS idx_user_achievement_user_id ON user_achievement(user_id);
CREATE INDEX IF NOT EXISTS idx_lesson_exam_type ON lesson(exam_type);
CREATE INDEX IF NOT EXISTS idx_user_lesson_user_id ON user_lesson(user_id);
CREATE INDEX IF NOT EXISTS idx_user_challenge_user_id ON user_challenge(user_id);

-- Insert default achievements
INSERT INTO achievement (code, name, description, icon, xp_reward, coin_reward, lessons_reward, condition_type, condition_value) VALUES
('first_essay', 'Primeira Redação', 'Enviou sua primeira redação', '🎯', 20, 0, 1, 'essays_count', 1),
('essays_5', 'Escritor Iniciante', 'Enviou 5 redações', '✍️', 50, 0, 1, 'essays_count', 5),
('essays_10', 'Escritor Regular', 'Enviou 10 redações', '📝', 100, 0, 2, 'essays_count', 10),
('essays_25', 'Escritor Experiente', 'Enviou 25 redações', '📖', 200, 0, 3, 'essays_count', 25),
('score_600', 'Nota Bronze', 'Tirou 600+ pontos', '🏅', 30, 0, 1, 'score', 600),
('score_800', 'Nota Prata', 'Tirou 800+ pontos', '🥈', 75, 0, 2, 'score', 800),
('score_900', 'Nota Ouro', 'Tirou 900+ pontos', '🥇', 150, 0, 3, 'score', 900),
('score_1000', 'Nota Diamante', 'Nota perfeita: 1000 pontos!', '💎', 300, 1, 5, 'score', 1000),
('streak_3', 'Consistente', '3 dias consecutivos', '🔥', 20, 0, 0, 'streak', 3),
('streak_7', 'Dedicado', '7 dias consecutivos', '🔥', 50, 1, 1, 'streak', 7),
('streak_30', 'Imparável', '30 dias consecutivos', '🔥', 200, 2, 3, 'streak', 30),
('lessons_5', 'Estudioso', 'Completou 5 lições', '📚', 50, 0, 1, 'lessons', 5),
('lessons_10', 'Dedicado aos Estudos', 'Completou 10 lições', '🎓', 100, 0, 2, 'lessons', 10)
ON CONFLICT (code) DO NOTHING;

-- Insert default challenges
INSERT INTO challenge (challenge_type, title, description, icon, action_type, target_count, xp_reward, coin_reward) VALUES
('daily', 'Redação Diária', 'Envie 1 redação hoje', '📝', 'submit_essay', 1, 15, 0),
('daily', 'Estudante Dedicado', 'Complete 1 lição hoje', '📚', 'complete_lesson', 1, 10, 0),
('daily', 'Reflexão', 'Leia o feedback de uma correção', '👁️', 'read_feedback', 1, 5, 0),
('weekly', 'Meta Semanal', 'Envie 3 redações esta semana', '🎯', 'submit_essay', 3, 50, 0),
('weekly', 'Maratona de Estudos', 'Complete 5 lições esta semana', '📖', 'complete_lesson', 5, 75, 0),
('weekly', 'Streak da Semana', 'Mantenha 7 dias de atividade', '🔥', 'streak', 7, 100, 1)
ON CONFLICT DO NOTHING;

-- Insert sample ENEM lessons (Competency 1)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('enem', 1, 1, 'Introdução à Norma Culta', 'Entenda o que é a norma culta e sua importância na redação do ENEM', 
'# Norma Culta na Redação do ENEM

A **Competência 1** avalia o domínio da modalidade escrita formal da língua portuguesa.

## O que é avaliado?

- ✅ Ortografia correta
- ✅ Acentuação adequada
- ✅ Concordância verbal e nominal
- ✅ Regência verbal e nominal
- ✅ Pontuação
- ✅ Uso correto de crase

## Dicas importantes

1. **Evite gírias e expressões coloquiais**
2. **Revise a ortografia** antes de entregar
3. **Atenção aos acentos** diferenciais
4. **Use conectivos** adequados

> "A norma culta é sua aliada na redação. Domine-a!"',
'[{"question": "O que a Competência 1 do ENEM avalia?", "options": ["Argumentação", "Norma culta", "Coesão", "Proposta"], "correct": 1, "explanation": "A C1 avalia o domínio da norma culta escrita."}, {"question": "É permitido usar gírias na redação do ENEM?", "options": ["Sim", "Não", "Às vezes", "Depende"], "correct": 1, "explanation": "Gírias devem ser evitadas na redação formal."}]',
25, 'free', 0),

('enem', 1, 2, 'Concordância Verbal', 'Aprenda as regras de concordância verbal para não errar', 
'# Concordância Verbal

O verbo deve concordar em **número** e **pessoa** com o sujeito.

## Regras principais

### 1. Sujeito simples
O verbo concorda com o núcleo do sujeito:
- *Os alunos **estudam** diariamente.*

### 2. Sujeito composto
- Antes do verbo: plural
  - *João e Maria **chegaram**.*
- Depois do verbo: pode ser singular ou plural
  - ***Chegou** João e Maria.* ou ***Chegaram** João e Maria.*

### 3. Casos especiais
- **A maioria de**: verbo no singular ou plural
- **Mais de um**: verbo no singular
- **Cerca de**: verbo concorda com o numeral',
'[{"question": "''A maioria dos estudantes passou.'' Está correto?", "options": ["Sim", "Não"], "correct": 0, "explanation": "Com expressões partitivas, o verbo pode ficar no singular."}, {"question": "Qual a concordância correta?", "options": ["Os alunos estuda", "Os alunos estudam", "Os alunos estudamos"], "correct": 1, "explanation": "O verbo concorda em pessoa e número com o sujeito."}]',
25, 'previous', 0),

('enem', 1, 3, 'Concordância Nominal', 'Domine as regras de concordância nominal', 
'# Concordância Nominal

Os **adjetivos**, **artigos**, **pronomes** e **numerais** concordam com o substantivo.

## Regras fundamentais

### Adjetivo + Substantivos
- Adjetivo posposto: concorda com o mais próximo ou com todos
  - *Casa e jardim **bonito***.
  - *Casa e jardim **bonitos***.

### Casos especiais

1. **É proibido / É necessário**
   - Sem artigo: invariável → *É proibido entrada.*
   - Com artigo: concorda → *É proibida a entrada.*

2. **Menos / Alerta / Pseudo**
   - São invariáveis
   - *Menos pessoas* ✅
   - *Menas pessoas* ❌',
'[{"question": "''É necessário paciência'' está correto?", "options": ["Sim", "Não"], "correct": 0, "explanation": "Sem artigo, a expressão fica invariável."}, {"question": "Qual é a forma correta?", "options": ["Menas pessoas", "Menos pessoas"], "correct": 1, "explanation": "''Menos'' é invariável."}]',
25, 'previous', 0),

('enem', 1, 4, 'Regência Verbal e Nominal', 'Entenda a regência para usar preposições corretamente', 
'# Regência Verbal e Nominal

A regência trata da relação entre verbos/nomes e seus complementos (preposições).

## Regência Verbal

| Verbo | Regência | Exemplo |
|-------|----------|---------|
| Assistir (ver) | a | Assisti **ao** filme |
| Visar (objetivar) | a | Visa **ao** sucesso |
| Obedecer | a | Obedeço **aos** pais |
| Preferir | a | Prefiro café **a** chá |
| Implicar (resultar) | - | Implica mudanças |

## Regência Nominal

| Nome | Preposição |
|------|------------|
| Apto | a, para |
| Ansioso | por, para |
| Compatível | com |
| Preferência | por, a |',
'[{"question": "Qual a regência correta de ''assistir'' (ver)?", "options": ["Assisti o filme", "Assisti ao filme", "Assisti no filme"], "correct": 1, "explanation": "Assistir no sentido de ver exige a preposição ''a''."}, {"question": "''Prefiro café do que chá'' está correto?", "options": ["Sim", "Não"], "correct": 1, "explanation": "O correto é: Prefiro café a chá."}]',
25, 'previous', 0)
ON CONFLICT DO NOTHING;

SELECT 'Gamification tables created successfully!' as status;
