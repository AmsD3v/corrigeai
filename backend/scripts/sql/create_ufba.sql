-- UFBA (Universidade Federal da Bahia) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/ufba.sql

-- ============================================================================
-- CONQUISTAS UFBA
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFBA
('ufba_essays_1', 'Primeira Redação UFBA', 'Enviou sua primeira redação UFBA', '📝', 'ufba', 'essays_count', 1, 25, 0),
('ufba_essays_5', 'Escritor UFBA', 'Enviou 5 redações UFBA', '✍️', 'ufba', 'essays_count', 5, 50, 1),
('ufba_essays_10', 'Redator Dedicado UFBA', 'Enviou 10 redações UFBA', '📚', 'ufba', 'essays_count', 10, 100, 2),

-- Notas UFBA (0-100)
('ufba_bronze', 'Nota Bronze UFBA', 'Atingiu 60+ na UFBA', '🥉', 'ufba', 'score', 60, 100, 2),
('ufba_prata', 'Nota Prata UFBA', 'Atingiu 80+ na UFBA', '🥈', 'ufba', 'score', 80, 200, 5),
('ufba_ouro', 'Nota Ouro UFBA', 'Atingiu 90+ na UFBA', '🥇', 'ufba', 'score', 90, 300, 10),

-- Lições UFBA
('ufba_lessons_5', 'Iniciante UFBA', 'Completou 5 lições da UFBA', '📖', 'ufba', 'lessons', 5, 50, 1),
('ufba_lessons_15', 'Estudante UFBA', 'Completou 15 lições da UFBA', '📚', 'ufba', 'lessons', 15, 150, 3),
('ufba_lessons_20', 'Mestre UFBA', 'Completou todas as 20 lições UFBA', '🎓', 'ufba', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFBA - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura e Coesão, 3-Argumentação, 4-Domínio Linguístico
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufba', 1, 1, 'A Redação UFBA', 'Conhecendo o vestibular', 
'# A Redação da UFBA

## Universidade Federal da Bahia
Localizada em Salvador, a UFBA é uma das mais importantes universidades do Nordeste.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coesão
3. Argumentação
4. Domínio linguístico

## Contexto Regional
A UFBA valoriza a cultura baiana e questões do Nordeste.',
'[{"question": "A UFBA está localizada em:", "options": ["Recife", "Salvador", "Fortaleza"], "correct": 1}]',
30, 'free', 0),

('ufba', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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

('ufba', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desigualdade social no Brasil

❌ "A desigualdade é ruim"
✅ "A desigualdade social brasileira resulta de processos históricos de exclusão que demandam políticas públicas integradas"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('ufba', 1, 4, 'Temas Regionais', 'Contexto baiano', 
'# Temas da Bahia/Nordeste

## Assuntos Recorrentes
- Cultura afro-brasileira
- Desigualdade regional
- Turismo e desenvolvimento
- Seca e recursos hídricos
- Patrimônio histórico

## Repertório Útil
- Jorge Amado (escritor)
- Caetano Veloso, Gilberto Gil
- Pelourinho, história colonial
- Candomblé e sincretismo',
'[{"question": "Jorge Amado é:", "options": ["Músico", "Escritor baiano"], "correct": 1}]',
45, 'previous', 0),

('ufba', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UFBA

## Tipos válidos
- Dados: IBGE, IPEA
- Histórico: Formação do Brasil
- Literário: Autores baianos
- Cultural: Música, arte

## Autores baianos
- Jorge Amado (Gabriela, Capitães da Areia)
- Castro Alves (poeta abolicionista)
- João Ubaldo Ribeiro
- Música: Tropicália, axé',
'[{"question": "Castro Alves foi poeta:", "options": ["Romântico", "Abolicionista"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA E COESÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufba', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('ufba', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
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

('ufba', 2, 3, 'Coesão Textual', 'Conectando ideias', 
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
'[{"question": "''Contudo'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]',
40, 'previous', 0),

('ufba', 2, 4, 'Transições', 'Entre parágrafos', 
'# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão, a educação..."',
'[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]',
45, 'previous', 0),

('ufba', 2, 5, 'Conclusão', 'Fechando o texto', 
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
('ufba', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
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

('ufba', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica a sociedade"
✅ Avançado: "Esse cenário revela falhas estruturais..."

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('ufba', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
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

('ufba', 3, 4, 'Progressão', 'Avançando ideias', 
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

('ufba', 3, 5, 'Repertório Baiano', 'Referências regionais', 
'# Repertório para UFBA

## Autores úteis
- Jorge Amado
- Castro Alves
- Gilberto Gil / Caetano

## Temas culturais
- Carnaval e axé
- Candomblé
- Culinária baiana
- Pelourinho e história',
'[{"question": "Gabriela, Cravo e Canela é de:", "options": ["Castro Alves", "Jorge Amado"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO LINGUÍSTICO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufba', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('ufba', 4, 2, 'Concordância', 'Verbal e nominal', 
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

('ufba', 4, 3, 'Regência e Crase', 'Preposições corretas', 
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

('ufba', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('ufba', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UFBA

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

SELECT 'UFBA: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'ufba';
