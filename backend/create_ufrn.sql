-- UFRN (Universidade Federal do Rio Grande do Norte) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/ufrn.sql

-- ============================================================================
-- CONQUISTAS UFRN
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFRN
('ufrn_essays_1', 'Primeira Redação UFRN', 'Enviou sua primeira redação UFRN', '📝', 'ufrn', 'essays_count', 1, 25, 0),
('ufrn_essays_5', 'Escritor UFRN', 'Enviou 5 redações UFRN', '✍️', 'ufrn', 'essays_count', 5, 50, 1),
('ufrn_essays_10', 'Redator Dedicado UFRN', 'Enviou 10 redações UFRN', '📚', 'ufrn', 'essays_count', 10, 100, 2),

-- Notas UFRN (0-100)
('ufrn_bronze', 'Nota Bronze UFRN', 'Atingiu 60+ na UFRN', '🥉', 'ufrn', 'score', 60, 100, 2),
('ufrn_prata', 'Nota Prata UFRN', 'Atingiu 80+ na UFRN', '🥈', 'ufrn', 'score', 80, 200, 5),
('ufrn_ouro', 'Nota Ouro UFRN', 'Atingiu 90+ na UFRN', '🥇', 'ufrn', 'score', 90, 300, 10),

-- Lições UFRN
('ufrn_lessons_5', 'Iniciante UFRN', 'Completou 5 lições da UFRN', '📖', 'ufrn', 'lessons', 5, 50, 1),
('ufrn_lessons_15', 'Estudante UFRN', 'Completou 15 lições da UFRN', '📚', 'ufrn', 'lessons', 15, 150, 3),
('ufrn_lessons_20', 'Mestre UFRN', 'Completou todas as 20 lições UFRN', '🎓', 'ufrn', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFRN - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura e Coesão, 3-Argumentação, 4-Domínio Linguístico
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufrn', 1, 1, 'A Redação UFRN', 'Conhecendo o vestibular', 
'# A Redação da UFRN

## Universidade Federal do Rio Grande do Norte
Localizada em Natal, a UFRN é a principal universidade do estado.

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
A UFRN pode abordar temas do RN e Nordeste.',
'[{"question": "A UFRN está localizada em:", "options": ["João Pessoa", "Natal", "Recife"], "correct": 1}]',
30, 'free', 0),

('ufrn', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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

('ufrn', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Turismo sustentável no litoral

❌ "O turismo é importante"
✅ "O turismo sustentável no litoral potiguar demanda políticas que conciliem desenvolvimento econômico e preservação ambiental"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('ufrn', 1, 4, 'Temas Regionais', 'Contexto potiguar', 
'# Temas do Rio Grande do Norte

## Assuntos Relevantes
- Turismo (praias, dunas)
- Energia eólica e solar
- Sal marinho
- Petróleo (Mossoró)
- Carnaúba

## Repertório Útil
- Câmara Cascudo (folclorista)
- Ponta Negra e Genipabu
- Maior cajueiro do mundo
- Forte dos Reis Magos',
'[{"question": "Câmara Cascudo era:", "options": ["Pintor", "Folclorista potiguar"], "correct": 1}]',
45, 'previous', 0),

('ufrn', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UFRN

## Tipos válidos
- Dados: IBGE, SUDENE
- Histórico: Formação do RN
- Literário: Autores potiguares
- Econômico: Turismo e energia

## Autores potiguares
- Câmara Cascudo
- Zila Mamede (poeta)
- Hélio Galvão
- Música: Sivuca',
'[{"question": "O RN é líder em:", "options": ["Café", "Energia eólica"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA E COESÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufrn', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('ufrn', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
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

('ufrn', 2, 3, 'Coesão Textual', 'Conectando ideias', 
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
'[{"question": "''Outrossim'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]',
40, 'previous', 0),

('ufrn', 2, 4, 'Transições', 'Entre parágrafos', 
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

('ufrn', 2, 5, 'Conclusão', 'Fechando o texto', 
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
('ufrn', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
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

('ufrn', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('ufrn', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
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

('ufrn', 3, 4, 'Progressão', 'Avançando ideias', 
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

('ufrn', 3, 5, 'Repertório', 'Usando referências', 
'# Repertório

## Fontes confiáveis
- IBGE, SUDENE
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente',
'[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO LINGUÍSTICO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufrn', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('ufrn', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Fazem anos'' é:", "options": ["Correto", "Incorreto (faz anos)"], "correct": 1}]',
35, 'previous', 0),

('ufrn', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Ir a Natal'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]',
40, 'previous', 0),

('ufrn', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('ufrn', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UFRN

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

SELECT 'UFRN: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'ufrn';
