-- UFT (Universidade Federal do Tocantins) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/uft.sql

-- ============================================================================
-- CONQUISTAS UFT
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFT
('uft_essays_1', 'Primeira Redação UFT', 'Enviou sua primeira redação UFT', '📝', 'uft', 'essays_count', 1, 25, 0),
('uft_essays_5', 'Escritor UFT', 'Enviou 5 redações UFT', '✍️', 'uft', 'essays_count', 5, 50, 1),
('uft_essays_10', 'Redator Dedicado UFT', 'Enviou 10 redações UFT', '📚', 'uft', 'essays_count', 10, 100, 2),

-- Notas UFT (0-100)
('uft_bronze', 'Nota Bronze UFT', 'Atingiu 60+ na UFT', '🥉', 'uft', 'score', 60, 100, 2),
('uft_prata', 'Nota Prata UFT', 'Atingiu 80+ na UFT', '🥈', 'uft', 'score', 80, 200, 5),
('uft_ouro', 'Nota Ouro UFT', 'Atingiu 90+ na UFT', '🥇', 'uft', 'score', 90, 300, 10),

-- Lições UFT
('uft_lessons_5', 'Iniciante UFT', 'Completou 5 lições da UFT', '📖', 'uft', 'lessons', 5, 50, 1),
('uft_lessons_15', 'Estudante UFT', 'Completou 15 lições da UFT', '📚', 'uft', 'lessons', 15, 150, 3),
('uft_lessons_20', 'Mestre UFT', 'Completou todas as 20 lições UFT', '🎓', 'uft', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFT - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura e Coesão, 3-Argumentação, 4-Domínio Linguístico
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('uft', 1, 1, 'A Redação UFT', 'Conhecendo o vestibular', 
'# A Redação da UFT

## Universidade Federal do Tocantins
Localizada em Palmas, a UFT é a principal universidade do estado mais jovem do Brasil.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões regionais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coesão
3. Argumentação
4. Domínio linguístico

## Contexto Regional
Tocantins: estado mais jovem (1988), transição Amazônia-Cerrado.',
'[{"question": "A UFT está localizada em:", "options": ["Goiânia", "Palmas", "Brasília"], "correct": 1}]',
30, 'free', 0),

('uft', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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

('uft', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desenvolvimento sustentável no Tocantins

❌ "O desenvolvimento é importante"
✅ "O desenvolvimento do Tocantins demanda planejamento que concilie expansão agrícola com preservação do ecótono Amazônia-Cerrado"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('uft', 1, 4, 'Temas Regionais', 'Contexto tocantinense', 
'# Temas do Tocantins

## Assuntos Relevantes
- Estado mais jovem (1988)
- Jalapão (dunas e cerrado)
- Agronegócio (soja, gado)
- Hidrelétrica de Tucuruí
- Ilha do Bananal

## Repertório Útil
- Palmas (cidade planejada)
- Jalapão (ecoturismo)
- Ilha do Bananal (maior ilha fluvial)
- Transição Amazônia-Cerrado',
'[{"question": "O Tocantins foi criado em:", "options": ["1960", "1988"], "correct": 1}]',
45, 'previous', 0),

('uft', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UFT

## Tipos válidos
- Dados: IBGE, SEPLAN
- Ambiental: Cerrado e transição
- Histórico: Criação do estado
- Econômico: Agronegócio

## Conhecimentos úteis
- Jalapão (fervedouros)
- Ilha do Bananal
- Capim Dourado (artesanato)
- Povo Xerente e Karajá',
'[{"question": "O Capim Dourado é:", "options": ["Planta medicinal", "Artesanato típico do Jalapão"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA E COESÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('uft', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('uft', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
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

('uft', 2, 3, 'Coesão Textual', 'Conectando ideias', 
'# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo',
'[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]',
40, 'previous', 0),

('uft', 2, 4, 'Transições', 'Entre parágrafos', 
'# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."',
'[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]',
45, 'previous', 0),

('uft', 2, 5, 'Conclusão', 'Fechando o texto', 
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
('uft', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
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

('uft', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('uft', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
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

('uft', 3, 4, 'Progressão', 'Avançando ideias', 
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

('uft', 3, 5, 'Repertório', 'Usando referências', 
'# Repertório

## Fontes confiáveis
- IBGE, SEPLAN
- Constituição Federal
- Dados ambientais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente',
'[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO LINGUÍSTICO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('uft', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('uft', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Houve avanços'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
35, 'previous', 0),

('uft', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Ir a Palmas'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]',
40, 'previous', 0),

('uft', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('uft', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UFT

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

SELECT 'UFT: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'uft';
