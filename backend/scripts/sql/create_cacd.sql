-- CACD (Concurso de Admissão à Carreira de Diplomata) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/cacd.sql

-- ============================================================================
-- CONQUISTAS CACD
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações CACD
('cacd_essays_1', 'Primeira Redação CACD', 'Enviou sua primeira redação CACD', '📝', 'cacd', 'essays_count', 1, 25, 0),
('cacd_essays_5', 'Escritor Diplomático', 'Enviou 5 redações CACD', '✍️', 'cacd', 'essays_count', 5, 50, 1),
('cacd_essays_10', 'Diplomata em Formação', 'Enviou 10 redações CACD', '📚', 'cacd', 'essays_count', 10, 100, 2),

-- Notas CACD (0-100)
('cacd_bronze', 'Nota Bronze CACD', 'Atingiu 60+ no CACD', '🥉', 'cacd', 'score', 60, 100, 2),
('cacd_prata', 'Nota Prata CACD', 'Atingiu 80+ no CACD', '🥈', 'cacd', 'score', 80, 200, 5),
('cacd_ouro', 'Nota Ouro CACD', 'Atingiu 90+ no CACD', '🥇', 'cacd', 'score', 90, 300, 10),

-- Lições CACD
('cacd_lessons_5', 'Iniciante CACD', 'Completou 5 lições do CACD', '📖', 'cacd', 'lessons', 5, 50, 1),
('cacd_lessons_15', 'Estudante CACD', 'Completou 15 lições do CACD', '📚', 'cacd', 'lessons', 15, 150, 3),
('cacd_lessons_20', 'Mestre CACD', 'Completou todas as 20 lições CACD', '🎓', 'cacd', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES CACD - 20 (5 por critério)
-- Critérios: 1-Domínio do Tema, 2-Estrutura Argumentativa, 3-Linguagem Diplomática, 4-Conhecimento Específico
-- ============================================================================

-- CRITÉRIO 1: DOMÍNIO DO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('cacd', 1, 1, 'A Prova do CACD', 'Conhecendo o concurso', 
'# O Concurso de Admissão à Carreira de Diplomata

## O que é o CACD?
Concurso para ingresso na carreira diplomática brasileira (Itamaraty).

## Características da Prova
- **Formato:** Dissertação sobre temas de política externa
- **Extensão:** 60 a 90 linhas
- **Nível:** Altamente exigente
- **Avaliação:** Conteúdo + forma

## Critérios
1. Domínio do tema proposto
2. Estrutura argumentativa
3. Linguagem formal e diplomática
4. Conhecimento específico

## Diferencial
A prova exige conhecimento profundo de relações internacionais e política externa brasileira.',
'[{"question": "O CACD seleciona para qual carreira?", "options": ["Militar", "Diplomática", "Jurídica"], "correct": 1}, {"question": "Extensão aproximada:", "options": ["30 linhas", "60-90 linhas"], "correct": 1}]',
30, 'free', 0),

('cacd', 1, 2, 'Temas de Política Externa', 'O que é cobrado', 
'# Temas Recorrentes

## Áreas Principais
- Política externa brasileira
- Relações bilaterais
- Organizações internacionais
- Integração regional
- Comércio internacional
- Direitos humanos
- Meio ambiente global

## Histórico Valorizado
- Política externa desde o Império
- Era Vargas e alinhamento
- Política externa independente
- Redemocratização
- Governo Lula/Dilma/Temer/Bolsonaro

## Dica
Conheça as posições históricas do Brasil em fóruns internacionais.',
'[{"question": "O CACD cobra conhecimento de:", "options": ["Direito interno apenas", "Política externa brasileira"], "correct": 1}]',
35, 'previous', 0),

('cacd', 1, 3, 'Interpretando a Proposta', 'Análise precisa', 
'# Análise da Proposta CACD

## Elementos
1. **Tema:** Geralmente específico de política externa
2. **Recorte temporal:** Período delimitado
3. **Aspecto:** O que abordar

## Estratégia
1. Identifique o tema central
2. Note delimitações temporais
3. Observe o aspecto pedido
4. Defina posicionamento alinhado à PEB

## Erro fatal
Fugir do tema ou desconhecer posições brasileiras.',
'[{"question": "O posicionamento deve estar alinhado:", "options": ["À opinião pessoal", "À PEB (Política Externa Brasileira)"], "correct": 1}]',
40, 'previous', 0),

('cacd', 1, 4, 'Posicionamento e PEB', 'Alinhamento estratégico', 
'# Posicionamento no CACD

## Princípio fundamental
A redação deve refletir entendimento da Política Externa Brasileira (PEB).

## Princípios da PEB
- Não-intervenção
- Autodeterminação dos povos
- Solução pacífica de controvérsias
- Multilateralismo
- Desenvolvimento como objetivo

## Como posicionar-se
Não defenda posições contrárias aos princípios constitucionais de política externa.',
'[{"question": "A PEB valoriza:", "options": ["Intervencionismo", "Solução pacífica de controvérsias"], "correct": 1}]',
45, 'previous', 0),

('cacd', 1, 5, 'Atualidades e Conjuntura', 'Estar informado', 
'# Atualidades para o CACD

## Fontes Essenciais
- Site do Itamaraty (MRE)
- Discursos oficiais
- Funag (Fundação Alexandre de Gusmão)
- Imprensa internacional

## Temas atuais importantes
- BRICS e novas parcerias
- Reforma do Conselho de Segurança
- Mudanças climáticas
- Comércio e OMC
- Direitos humanos

## Dica
Acompanhe posições oficiais do Brasil em fóruns internacionais.',
'[{"question": "Fonte oficial da PEB:", "options": ["Jornais apenas", "Site do Itamaraty/MRE"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA ARGUMENTATIVA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('cacd', 2, 1, 'Estrutura da Dissertação', 'Organizando o texto', 
'# Estrutura CACD

## Modelo (60-90 linhas)
- **Introdução:** Contexto + tese (10-15 linhas)
- **D1:** Primeiro eixo argumentativo (15-20 linhas)
- **D2:** Segundo eixo argumentativo (15-20 linhas)
- **D3:** Terceiro eixo (opcional) (10-15 linhas)
- **Conclusão:** Síntese + projeção (10-15 linhas)

## Característica
Texto longo e denso - exige planejamento cuidadoso.',
'[{"question": "Texto CACD é:", "options": ["Curto (30 linhas)", "Longo (60-90 linhas)"], "correct": 1}]',
30, 'free', 0),

('cacd', 2, 2, 'Introdução Contextualizadora', 'Abrindo com propriedade', 
'# A Introdução CACD

## Elementos
1. Contextualização histórica
2. Apresentação do tema
3. Tese clara
4. Indicação do percurso

## Estilo
Formal, erudito, demonstrando conhecimento.

## Exemplo
"A política externa brasileira, desde Rio Branco, caracteriza-se pelo pragmatismo e pela busca de inserção internacional autônoma. [contexto] No que tange às relações com [tema], o Brasil tem historicamente... [desenvolvimento]"',
'[{"question": "Introdução CACD deve ter:", "options": ["Apenas tese", "Contexto histórico + tese"], "correct": 1}]',
35, 'previous', 0),

('cacd', 2, 3, 'Desenvolvimento Analítico', 'Argumentação densa', 
'# Parágrafos de Desenvolvimento

## Estrutura
1. **Tópico frasal:** Ideia-chave
2. **Contextualização:** Histórico/cenário
3. **Análise:** Interpretação fundamentada
4. **Exemplificação:** Casos concretos
5. **Fechamento:** Conexão com tese

## Extensão
15-20 linhas por parágrafo de desenvolvimento.

## Profundidade
Cada eixo deve trazer análise, não apenas informação.',
'[{"question": "Desenvolvimento CACD é:", "options": ["Superficial", "Analítico e denso"], "correct": 1}]',
40, 'previous', 0),

('cacd', 2, 4, 'Progressão e Coerência', 'Construindo o raciocínio', 
'# Progressão Argumentativa

## Princípio
Os eixos devem se complementar, não repetir.

## Modelos
- Cronológico: passado → presente → futuro
- Temático: aspecto A → aspecto B → síntese
- Problema-solução: diagnóstico → caminhos

## Coerência
Todos os eixos devem apoiar a tese central.',
'[{"question": "Os eixos devem:", "options": ["Repetir informações", "Complementar-se"], "correct": 1}]',
45, 'previous', 0),

('cacd', 2, 5, 'Conclusão Prospectiva', 'Fechando com visão', 
'# Conclusão CACD

## Elementos
1. Retomada sintética da tese
2. Síntese dos eixos
3. Projeção/perspectiva futura
4. Fechamento que valoriza a PEB

## Estilo
Conclusões que demonstrem visão estratégica e conhecimento de tendências.

## Evite
Conclusões simplistas ou que não dialoguem com o desenvolvimento.',
'[{"question": "Conclusão CACD deve ter:", "options": ["Apenas resumo", "Síntese + projeção futura"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: LINGUAGEM DIPLOMÁTICA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('cacd', 3, 1, 'Registro Diplomático', 'Formalidade e protocolo', 
'# Linguagem Diplomática

## Características
- Formalidade elevada
- Precisão terminológica
- Tom sereno e ponderado
- Evitar posições extremas

## Vocabulário
Use termos próprios das relações internacionais:
- "Inserção internacional"
- "Concertação"
- "Diálogo bilateral"
- "Multilateralismo efetivo"',
'[{"question": "Tom diplomático é:", "options": ["Extremo e apaixonado", "Sereno e ponderado"], "correct": 1}]',
30, 'free', 0),

('cacd', 3, 2, 'Terminologia Específica', 'Vocabulário do Itamaraty', 
'# Vocabulário Diplomático

## Termos Essenciais
| Termo | Significado |
|-------|-------------|
| Concertação | Coordenação entre países |
| Paragrapso Único | Art. 4º da CF |
| Geometria variável | Parcerias flexíveis |
| Soft power | Poder brando |
| Sul Global | Países em desenvolvimento |

## Uso
Empregue terminologia com precisão e naturalidade.',
'[{"question": "''Concertação'' significa:", "options": ["Concerto musical", "Coordenação entre países"], "correct": 1}]',
35, 'previous', 0),

('cacd', 3, 3, 'Impessoalidade e Ponderação', 'Tom adequado', 
'# Tom Adequado

## Impessoalidade
Evite primeira pessoa singular.
❌ "Eu penso que..."
✅ "Observa-se que..."

## Ponderação
Evite afirmações categóricas demais.
❌ "É absolutamente certo que..."
✅ "Constata-se uma tendência de..."

## Equilíbrio
Apresente nuances, não posições extremas.',
'[{"question": "Linguagem diplomática evita:", "options": ["Ponderação", "Afirmações categóricas"], "correct": 1}]',
40, 'previous', 0),

('cacd', 3, 4, 'Norma Culta Elevada', 'Gramática impecável', 
'# Norma Culta no CACD

## Exigência
O nível de correção gramatical deve ser impecável.

## Pontos críticos
- Concordância
- Regência
- Colocação pronominal
- Pontuação

## Diferencial
Use mesóclise quando cabível:
"Dir-se-ia que..." / "Tratar-se-á de..."',
'[{"question": "Mesóclise é:", "options": ["Proibida", "Valorizada no CACD"], "correct": 1}]',
45, 'previous', 0),

('cacd', 3, 5, 'Citações e Referências', 'Como citar', 
'# Citações no CACD

## Quem citar
- Teóricos de RI (Nye, Keohane)
- Diplomatas brasileiros (Rio Branco, San Tiago Dantas)
- Documentos oficiais

## Como citar
"Segundo Rio Branco, a diplomacia deve..."
"Conforme estabelece a Carta da ONU..."

## Cuidado
Cite apenas o que conhece bem.',
'[{"question": "Citações devem ser:", "options": ["Inventadas", "De fontes conhecidas"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: CONHECIMENTO ESPECÍFICO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('cacd', 4, 1, 'História da PEB', 'Política externa histórica', 
'# História da Política Externa Brasileira

## Períodos
- **Barão do Rio Branco:** Definição de fronteiras
- **Era Vargas:** Pragmatismo/equidistância
- **Política Externa Independente:** Anos 60
- **Pragmatismo Responsável:** Geisel
- **Redemocratização:** Integração regional
- **Século XXI:** Protagonismo Sul-Sul

## Importância
Conhecer história da PEB é fundamental para o CACD.',
'[{"question": "Rio Branco é conhecido por:", "options": ["Guerras", "Definição pacífica de fronteiras"], "correct": 1}]',
30, 'free', 0),

('cacd', 4, 2, 'Organizações Internacionais', 'ONU, OMC, OEA...', 
'# Organizações Internacionais

## ONU
- Conselho de Segurança (Brasil busca assento permanente)
- Assembleia Geral
- Agências especializadas

## OMC
- Comércio internacional
- Rodada Doha
- Solução de controvérsias

## Regionais
- OEA
- MERCOSUL
- CELAC
- UNASUL',
'[{"question": "Brasil busca assento permanente no:", "options": ["OMC", "Conselho de Segurança da ONU"], "correct": 1}]',
35, 'previous', 0),

('cacd', 4, 3, 'Integração Regional', 'América Latina', 
'# Integração Regional

## MERCOSUL
- Criação: 1991
- Membros: Brasil, Argentina, Paraguai, Uruguai
- Objetivo: Mercado comum

## Outros blocos
- UNASUL (em crise)
- CELAC
- Aliança do Pacífico (Brasil não participa)

## Posição brasileira
Brasil historicamente defende integração regional.',
'[{"question": "O MERCOSUL foi criado em:", "options": ["1985", "1991"], "correct": 1}]',
40, 'previous', 0),

('cacd', 4, 4, 'Relações Bilaterais', 'Parceiros estratégicos', 
'# Relações Bilaterais do Brasil

## Parceiros tradicionais
- EUA: Complexa, oscilante
- Argentina: Essencial para região
- Portugal: Histórica e cultural

## Parcerias estratégicas
- China: Maior parceiro comercial
- Índia: BRICS
- África do Sul: BRICS, IBAS

## BRICS
Brasil, Rússia, Índia, China, África do Sul',
'[{"question": "Maior parceiro comercial do Brasil:", "options": ["EUA", "China"], "correct": 1}]',
45, 'previous', 0),

('cacd', 4, 5, 'Temas Contemporâneos', 'Agenda atual', 
'# Agenda Contemporânea

## Temas prioritários
- Mudanças climáticas
- Reforma do Conselho de Segurança
- Comércio e protecionismo
- Direitos humanos
- Migração

## Posições brasileiras
Conheça as posições oficiais do Brasil em cada tema.

## Fonte
Site do MRE e discursos oficiais.',
'[{"question": "Fonte oficial de posições brasileiras:", "options": ["Redes sociais", "Site do MRE/Itamaraty"], "correct": 1}]',
50, 'previous', 0);

SELECT 'CACD: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'cacd';
