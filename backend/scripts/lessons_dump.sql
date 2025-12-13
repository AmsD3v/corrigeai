--
-- PostgreSQL database dump
--

\restrict kDFB1aZ6ICJ16l7s9BqaNV2vp5QJ8JdPhZabzCY6Y3xdLAIhlgwN1MMOUbknZNf

-- Dumped from database version 16.11
-- Dumped by pg_dump version 16.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: lesson; Type: TABLE DATA; Schema: public; Owner: user
--

INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (448, 'unifap', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta ao defendido

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.908911');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (251, 'unesp', 1, 1, 'A Redação UNESP', 'Conhecendo a prova', '# A Redação da UNESP

## Características
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Tema:** Baseado em textos de apoio
- **Nota:** 0 a 100 pontos

## Critérios
1. Desenvolvimento do tema
2. Organização textual
3. Coerência e coesão
4. Norma culta

## Diferenças de outros vestibulares
- Temas mais diretos e sociais
- Textos de apoio mais curtos
- Valoriza posicionamento claro', '[{"question": "A UNESP cobra dissertação-argumentativa?", "options": ["Sim", "Não"], "correct": 0}, {"question": "Extensão recomendada:", "options": ["10-15 linhas", "25-30 linhas"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:20.018054');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (252, 'unesp', 1, 2, 'Textos de Apoio', 'Usando o material fornecido', '# Textos de Apoio UNESP

## Características
- 2 a 4 textos curtos
- Perspectivas variadas
- Dados e opiniões

## Como usar
1. Leia todos atentamente
2. Identifique a questão central
3. Encontre argumentos
4. NÃO COPIE - parafraseie

## Estratégia
Use os textos como ponto de partida, mas VÁ ALÉM com seu repertório.', '[{"question": "Deve usar apenas os textos de apoio?", "options": ["Sim", "Não, deve ir além"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:20.018054');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (253, 'unesp', 1, 3, 'Tese Clara', 'Posicionando-se sobre o tema', '# Construindo a Tese

## O que é uma boa tese?
- Posicionamento claro
- Defensável com argumentos
- Presente na introdução
- Retomada na conclusão

## Exemplos
**Tema:** Impactos das redes sociais

❌ "As redes sociais têm pontos positivos e negativos"
✅ "Embora facilitem a comunicação, as redes sociais aprofundam a superficialidade das relações"', '[{"question": "Uma boa tese é:", "options": ["Vaga e genérica", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.018054');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (254, 'unesp', 1, 4, 'Argumentação Sólida', 'Construindo defesas', '# Argumentos na UNESP

## Tipos valorizados
- **Dados:** Estatísticas confiáveis
- **Exemplos:** Casos concretos
- **Autoridade:** Especialistas
- **Históricos:** Contexto temporal

## Estrutura do argumento
1. Afirmação (tópico frasal)
2. Fundamentação (evidência)
3. Análise (interpretação)
4. Conexão com a tese

## Quantidade ideal
2-3 argumentos bem desenvolvidos', '[{"question": "Quantos argumentos são ideais?", "options": ["1", "2-3", "5+"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.018054');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (255, 'unesp', 1, 5, 'Repertório Atualizado', 'Conhecimentos contemporâneos', '# Repertório para UNESP

## Fontes recomendadas
- Jornais de qualidade
- Revistas científicas
- Documentários
- Dados oficiais (IBGE, OMS)

## Temas recorrentes
- Meio ambiente
- Tecnologia
- Educação
- Desigualdade social
- Saúde pública

## Dica de ouro
Mantenha fichas de repertório por tema para consulta rápida.', '[{"question": "Repertório atualizado vem de:", "options": ["Redes sociais apenas", "Fontes confiáveis variadas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.018054');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (256, 'unesp', 2, 1, 'Estrutura da Dissertação', 'Organizando o texto', '# Estrutura UNESP

## Modelo recomendado

### Introdução (5-7 linhas)
- Contextualização
- Tese clara

### Desenvolvimento (15-18 linhas)
- 2 parágrafos
- 1 argumento + exemplo cada
- Progressão lógica

### Conclusão (5-7 linhas)
- Retomada da tese
- Proposta ou reflexão final', '[{"question": "Quantos parágrafos de desenvolvimento?", "options": ["1", "2", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:20.021326');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (257, 'unesp', 2, 2, 'Introdução Eficiente', 'Abrindo bem o texto', '# A Introdução

## Elementos
1. Frase de abertura (contexto)
2. Delimitação do tema
3. Apresentação da tese

## Estratégias de abertura
- Dado estatístico
- Citação relevante
- Fato histórico
- Pergunta retórica

## Exemplo
*"Segundo o IBGE, 70% dos brasileiros... [dado] Esse cenário revela que... [tema] Portanto, é urgente... [tese]"*', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto, tema e tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:20.021326');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (258, 'unesp', 2, 3, 'Desenvolvimento Progressivo', 'Avançando ideias', '# Parágrafos de Desenvolvimento

## Estrutura do parágrafo
1. **Tópico frasal:** Ideia principal
2. **Desenvolvimento:** Argumentação
3. **Exemplificação:** Caso concreto
4. **Fechamento:** Conexão com a tese

## Progressão
D1 → D2: crescente em complexidade

## Conectivos de progressão
- "Além disso..."
- "Mais ainda..."
- "Soma-se a isso..."', '[{"question": "Parágrafos devem:", "options": ["Repetir ideias", "Progredir em complexidade"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.021326');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (259, 'unesp', 2, 4, 'Conclusão Propositiva', 'Fechando com força', '# A Conclusão UNESP

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## O que evitar
❌ Iniciar com "Portanto, conclui-se..."
❌ Introduzir argumento novo
❌ Ser repetitivo

## Dica
Faça uma projeção futura ou chamado à reflexão.', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.021326');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (260, 'unesp', 2, 5, 'Proporção e Equilíbrio', 'Balanceando o texto', '# Equilíbrio Textual

## Proporção ideal
- Introdução: ~20%
- Desenvolvimento: ~60%
- Conclusão: ~20%

## Checklist de equilíbrio
- [ ] Parágrafos de tamanho similar?
- [ ] Argumentos igualmente desenvolvidos?
- [ ] Transições claras?

## Erro comum
Desenvolvimento 1 extenso, Desenvolvimento 2 curto.', '[{"question": "Desenvolvimento deve ocupar:", "options": ["20%", "60%", "90%"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.021326');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (261, 'unesp', 3, 1, 'Coerência Textual', 'Sentido do texto', '# Coerência

## O que é?
Sentido global do texto - as ideias fazem sentido juntas.

## Tipos
- **Interna:** Entre partes do texto
- **Externa:** Com a realidade
- **Argumentativa:** Lógica das ideias

## Problemas comuns
❌ Contradição entre parágrafos
❌ Afirmações sem fundamento
❌ Conclusão oposta à tese', '[{"question": "Coerência é:", "options": ["Conexão entre frases", "Sentido global do texto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:20.0232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (262, 'unesp', 3, 2, 'Coesão Referencial', 'Retomando termos', '# Coesão Referencial

## Mecanismos
1. **Pronomes:** ele, isso, tal
2. **Sinônimos:** variação lexical
3. **Hiperônimos:** termo mais geral
4. **Elipse:** omissão intencional

## Exemplo
*"A tecnologia... Ela... Esse avanço... Tal fenômeno..."*

## Evite
❌ Repetição excessiva do mesmo termo', '[{"question": "Coesão referencial usa:", "options": ["Repetição", "Pronomes e sinônimos"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:20.0232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (263, 'unesp', 3, 3, 'Conectivos', 'Ligando ideias', '# Conectivos

## Por função

### Adição
Além disso, ademais, outrossim

### Oposição
Contudo, entretanto, não obstante

### Conclusão
Portanto, logo, destarte

### Explicação
Ou seja, isto é, a saber

### Causa
Porque, visto que, uma vez que

### Consequência
Por isso, assim, de modo que', '[{"question": "''Contudo'' indica:", "options": ["Adição", "Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.0232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (487, 'ufba', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica a sociedade"
✅ Avançado: "Esse cenário revela falhas estruturais..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:05:53.194977');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (264, 'unesp', 3, 4, 'Transições entre Parágrafos', 'Fluidez textual', '# Transições

## Técnicas
1. Retomar palavra-chave do parágrafo anterior
2. Usar conectivo adequado
3. Fazer ponte temática

## Exemplo
*"...impacta a educação."*
*"Além da educação, a economia também sofre..."*

## Erro comum
❌ Parágrafos desconexos
✅ Referência ao anterior', '[{"question": "Transições conectam:", "options": ["Frases apenas", "Parágrafos entre si"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.0232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (265, 'unesp', 3, 5, 'Progressão Temática', 'Avançando o tema', '# Progressão

## O que é?
Cada parte do texto acrescenta informação nova.

## Tipos
- **Linear:** Cada frase adiciona info
- **Constante:** Retoma tema e expande
- **Derivada:** Tema gera subtemas

## Checklist
- [ ] Há informação nova em cada parágrafo?
- [ ] As ideias avançam logicamente?
- [ ] Não há redundância?', '[{"question": "Progressão significa:", "options": ["Repetir ideias", "Avançar com informações novas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.0232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (266, 'unesp', 4, 1, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
O verbo concorda com o sujeito.

*"Os alunos estudam" ✅*
*"Os alunos estuda" ❌*

## Nominal
Adjetivos concordam com substantivos.

*"Questões importantes" ✅*
*"Questões importante" ❌*

## Casos especiais
- Sujeito composto posposto
- Expressões partitivas
- Verbos impessoais', '[{"question": "Concordância verbal é entre:", "options": ["Verbo e objeto", "Verbo e sujeito"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:20.024693');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (267, 'unesp', 4, 2, 'Regência', 'Verbal e nominal', '# Regência

## Verbal
*"Assistir ao filme" ✅*
*"Assistir o filme" ❌*

## Verbos problemáticos
- Preferir: A a B (não "do que")
- Visar: A algo (com preposição)
- Obedecer: A algo/alguém

## Nominal
*"Capacidade de..." ✅*
*"Capacidade em..." ❌*', '[{"question": "''Assistir'' (ver) rege:", "options": ["Objeto direto", "Objeto indireto (a)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:20.024693');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (268, 'unesp', 4, 3, 'Crase', 'Quando usar', '# Crase

## Regra básica
a (preposição) + a (artigo) = à

## Usa-se
- Antes de palavras femininas
- Com locuções femininas
- Indicando hora

*"Vou à escola" ✅*

## Não usa-se
- Antes de masculinos
- Antes de verbos
- Antes de "a distância"

*"Vou a pé" ✅*', '[{"question": "Crase é:", "options": ["Acento", "Fusão de preposição + artigo"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.024693');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (269, 'unesp', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens de lista
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
❌ Entre sujeito e verbo
❌ Entre verbo e complemento

## Outros sinais
- Ponto e vírgula: orações coordenadas longas
- Dois-pontos: explicação, citação
- Travessão: destaque', '[{"question": "Pode usar vírgula entre sujeito e verbo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.024693');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (270, 'unesp', 4, 5, 'Revisão Gramatical', 'Polindo o texto', '# Checklist de Revisão

## Concordância
- [ ] Verbos concordam com sujeitos?
- [ ] Adjetivos concordam?

## Regência
- [ ] Preposições corretas?
- [ ] Crases adequadas?

## Pontuação
- [ ] Vírgulas bem colocadas?
- [ ] Pontos finais presentes?

## Dica
Leia em voz baixa para identificar erros.', '[{"question": "Revisão deve ser feita:", "options": ["Nunca", "Nos últimos 10 minutos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.024693');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (271, 'ita', 1, 1, 'A Redação ITA', 'Rigor técnico', '# A Redação do ITA

## Características
- **Rigor técnico** na argumentação
- **Temas científicos/tecnológicos** frequentes
- **Extensão:** 20 a 30 linhas
- **Valoriza:** lógica e precisão

## Diferencial
O ITA espera argumentação precisa, quase científica.

## O que a banca busca
- Clareza de raciocínio
- Argumentos fundamentados
- Linguagem objetiva
- Pensamento analítico', '[{"question": "O ITA valoriza:", "options": ["Argumentação emocional", "Argumentação lógica e precisa"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:20.026216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (272, 'ita', 1, 2, 'Argumentação Científica', 'Método e rigor', '# Argumentação Científica

## Características
- Baseada em evidências
- Lógica causa-consequência
- Dados quantitativos
- Fontes confiáveis

## Estrutura
1. Premissa verificável
2. Desenvolvimento lógico
3. Conclusão fundamentada

## Evite
❌ "Muitas pessoas pensam..."
❌ "Desde os primórdios..."
✅ "Segundo estudo da USP (2023), 73%..."', '[{"question": "Argumento científico é baseado em:", "options": ["Opiniões pessoais", "Evidências e dados"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:20.026216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (273, 'ita', 1, 3, 'Dados e Estatísticas', 'Usando números', '# Uso de Dados

## Por que usar?
O ITA valoriza argumentação quantitativa.

## Como usar corretamente
1. Cite a fonte
2. Contextualize o dado
3. Analise o significado
4. Conecte com a tese

## Exemplo
*"De acordo com o IPCC (2023), a temperatura global aumentou 1,1°C desde a era pré-industrial. Este dado evidencia que..."*

## Cuidados
- Use fontes confiáveis
- Não invente números', '[{"question": "Ao citar dados, deve:", "options": ["Inventar números", "Citar a fonte"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.026216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (274, 'ita', 1, 4, 'Raciocínio Lógico', 'Construindo deduções', '# Lógica na Argumentação

## Tipos de raciocínio
- **Dedutivo:** Geral → Particular
- **Indutivo:** Particular → Geral
- **Analógico:** Comparação

## Exemplo dedutivo
*"Toda tecnologia gera impactos ambientais. [premissa geral] A IA é uma tecnologia. [premissa específica] Logo, a IA gera impactos ambientais. [conclusão]"*

## Evite falácias
- Generalização apressada
- Falsa causa
- Apelo à autoridade inválida', '[{"question": "Raciocínio dedutivo vai do:", "options": ["Particular ao geral", "Geral ao particular"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.026216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (275, 'ita', 1, 5, 'Contra-argumentação Técnica', 'Antecipando objeções', '# Contra-argumentação

## Por que fazer?
Demonstra maturidade intelectual e domínio do tema.

## Estrutura
1. Apresente a objeção
2. Reconheça sua validade parcial
3. Refute com evidências
4. Reforce sua posição

## Exemplo
*"Poder-se-ia argumentar que a energia nuclear é perigosa. De fato, acidentes como Chernobyl ocorreram. Entretanto, dados recentes mostram que... Portanto, quando bem gerida..."*', '[{"question": "Contra-argumentação demonstra:", "options": ["Fraqueza", "Maturidade intelectual"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.026216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (276, 'ita', 2, 1, 'Estrutura Analítica', 'Organizando logicamente', '# Estrutura para ITA

## Modelo recomendado
1. **Introdução:** Contexto + tese clara
2. **D1:** Argumento principal
3. **D2:** Argumento secundário ou contra-argumentação
4. **Conclusão:** Síntese lógica

## Diferencial
A estrutura deve refletir um raciocínio, não apenas organização.', '[{"question": "Estrutura no ITA deve refletir:", "options": ["Apenas organização", "Raciocínio lógico"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:20.027639');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (277, 'ita', 2, 2, 'Introdução Precisa', 'Abrindo com clareza', '# Introdução ITA

## Elementos
1. Contextualização objetiva
2. Delimitação do problema
3. Tese clara e direta

## Evite
- Introduções vagas
- Frases de efeito vazias
- Contextualizações longas

## Ideal
Ir direto ao ponto com precisão.', '[{"question": "Introdução no ITA deve ser:", "options": ["Longa e detalhada", "Precisa e direta"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:20.027639');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (278, 'ita', 2, 3, 'Desenvolvimento Estruturado', 'Parágrafos analíticos', '# Parágrafos Analíticos

## Estrutura PEAL
- **P**onto: Afirmação central
- **E**vidência: Dado/exemplo
- **A**nálise: Interpretação
- **L**ink: Conexão com tese

## Exemplo
*"A IA transforma a indústria [P]. Segundo relatório da McKinsey, 50% das tarefas podem ser automatizadas [E]. Isso significa redução de custos e aumento de eficiência [A]. Portanto, a adoção de IA é estratégica [L]."*', '[{"question": "PEAL significa:", "options": ["Ponto, Evidência, Análise, Link", "Parágrafo, Estrutura, Argumento, Lógica"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.027639');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (279, 'ita', 2, 4, 'Progressão Lógica', 'Avançando o raciocínio', '# Progressão no ITA

## Princípio
Cada parte do texto deve avançar o raciocínio.

## Técnicas
- Do simples ao complexo
- Da premissa à conclusão
- Do geral ao específico

## Conectivos de progressão
- "Consequentemente..."
- "A partir disso..."
- "Tal análise revela..."', '[{"question": "Progressão lógica vai:", "options": ["Do complexo ao simples", "Do simples ao complexo"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.027639');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (280, 'ita', 2, 5, 'Conclusão Sintética', 'Fechando com precisão', '# Conclusão ITA

## Elementos
1. Retomada sintética da tese
2. Síntese das evidências
3. Projeção ou implicação

## Evite
- Novas informações
- Conclusões desconectadas
- Frases vazias

## Modelo
*"A análise evidenciou que... [síntese] Isso implica... [consequência] Portanto... [conclusão final]"*', '[{"question": "Conclusão pode ter informação nova?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.027639');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (281, 'ita', 3, 1, 'Precisão Lexical', 'Escolha de palavras', '# Vocabulário Preciso

## Princípio
Cada palavra deve ter função clara.

## Substituições
| Vago | Preciso |
|------|---------|
| Coisa | Fator, elemento, aspecto |
| Muito | Significativo, expressivo |
| Problema | Desafio, entrave, impasse |

## Evite
- "Basicamente..."
- "Na verdade..."
- "De certa forma..."', '[{"question": "Linguagem precisa evita:", "options": ["Termos específicos", "Termos vagos"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:20.029216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (282, 'ita', 3, 2, 'Vocabulário Técnico', 'Termos especializados', '# Termos Técnicos

## Quando usar
- Se dominar o conceito
- Se for relevante ao tema
- Se puder explicar se necessário

## Áreas úteis
- Economia: PIB, inflação, recessão
- Tecnologia: algoritmo, machine learning
- Ciência: hipótese, variável, correlação

## Cuidado
Use apenas termos que conhece bem.', '[{"question": "Vocabulário técnico deve ser:", "options": ["Usado sempre", "Usado com domínio"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:20.029216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (283, 'ita', 3, 3, 'Objetividade', 'Sem rodeios', '# Linguagem Objetiva

## Características
- Frases diretas
- Voz ativa preferível
- Sem redundâncias

## Exemplos
❌ "Pode-se dizer que é possível afirmar que..."
✅ "Os dados indicam que..."

❌ "É importante ressaltar o fato de que..."
✅ "Destaca-se que..."', '[{"question": "Objetividade usa:", "options": ["Muitos rodeios", "Frases diretas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.029216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (284, 'ita', 3, 4, 'Impessoalidade', 'Tom acadêmico', '# Tom Impessoal

## Técnicas
- Terceira pessoa
- Verbos impessoais
- Construções passivas

## Exemplos
❌ "Eu penso que..."
✅ "Evidencia-se que..."

❌ "Na minha opinião..."
✅ "A análise revela..."

## Exceção
Primeira pessoa do plural científico: "Observamos que..."', '[{"question": "No ITA, evita-se:", "options": ["Impessoalidade", "Primeira pessoa singular"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.029216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (285, 'ita', 3, 5, 'Revisão de Estilo', 'Polindo a linguagem', '# Checklist de Linguagem

## Precisão
- [ ] Todas as palavras são necessárias?
- [ ] Há termos vagos para substituir?

## Objetividade
- [ ] As frases são diretas?
- [ ] Há redundâncias?

## Impessoalidade
- [ ] Evitei "eu acho"?
- [ ] Usei construções impessoais?

## Dica final
Cada frase deve ter função clara.', '[{"question": "Revisão de estilo foca em:", "options": ["Tamanho do texto", "Precisão e objetividade"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.029216');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (286, 'ita', 4, 1, 'Temas Científicos', 'Preparando-se', '# Repertório Científico

## Áreas frequentes
- Inteligência artificial
- Mudanças climáticas
- Biotecnologia
- Energia e sustentabilidade
- Espaço e astronomia

## Fontes
- Scientific American Brasil
- Nature (divulgação)
- Pesquisa FAPESP
- Relatórios ONU/IPCC', '[{"question": "Temas científicos são comuns no ITA?", "options": ["Sim", "Não"], "correct": 0}]', 3, 'free', 0, true, '2025-12-05 10:18:20.030626');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (287, 'ita', 4, 2, 'Ética na Ciência', 'Debates contemporâneos', '# Dilemas Éticos

## Temas
- Privacidade de dados
- Edição genética (CRISPR)
- Armas autônomas
- Clonagem
- Experimentação animal

## Abordagem
1. Apresente o dilema
2. Mostre os lados
3. Analise criticamente
4. Posicione-se com fundamentação', '[{"question": "Dilemas éticos devem ser:", "options": ["Ignorados", "Analisados criticamente"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:20.030626');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (288, 'ita', 4, 3, 'Tecnologia e Sociedade', 'Impactos sociais', '# Tecnologia e Sociedade

## Tópicos
- Automação e emprego
- Redes sociais e democracia
- Vigilância digital
- Fake news e desinformação
- Digital divide

## Análise
Considere sempre:
- Benefícios
- Riscos
- Desafios
- Soluções', '[{"question": "Análise de tecnologia considera:", "options": ["Apenas benefícios", "Benefícios, riscos e soluções"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.030626');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (289, 'ita', 4, 4, 'Inovação e Progresso', 'História da ciência', '# Contexto Histórico

## Marcos úteis
- Revoluções industriais (1ª a 4ª)
- Revolução digital
- Lei de Moore
- Corrida espacial
- Desenvolvimento de vacinas

## Como usar
Conecte eventos históricos com debates atuais.

## Exemplo
*"Assim como a 1ª Revolução Industrial transformou o trabalho, a IA promove nova transformação..."*', '[{"question": "Contexto histórico serve para:", "options": ["Preencher espaço", "Conectar com debates atuais"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.030626');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (290, 'ita', 4, 5, 'Construindo Repertório', 'Estudo contínuo', '# Mantendo-se Atualizado

## Rotina sugerida
- Diariamente: 15 min de notícias científicas
- Semanalmente: 1 artigo de divulgação
- Mensalmente: 1 documentário

## Organização
Crie fichas:
- Tema
- Dados principais
- Autores/fontes
- Aplicações possíveis

## Dica final
Repertório se constrói ao longo do tempo, não na véspera.', '[{"question": "Repertório se constrói:", "options": ["Na véspera da prova", "Ao longo do tempo"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:20.030626');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (389, 'sisu', 4, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnica
Retome algo do parágrafo anterior:

**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão estrutural, a negligência..."

## Conectivos de transição
- "Diante desse cenário..."
- "Nessa perspectiva..."
- "Além desse aspecto..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.226499');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (291, 'uerj', 1, 1, 'A Redação UERJ', 'Conhecendo a prova', '# A Redação da UERJ

## Características
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Tema:** Questões sociais e atualidades
- **Nota:** 0 a 10 pontos (multiplicado por fator)

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Desenvolvimento argumentativo
3. Progressão textual
4. Adequação linguística

## Diferencial UERJ
- Temas voltados à realidade carioca/brasileira
- Valoriza posicionamento crítico
- Aceita referências culturais diversas', '[{"question": "A redação UERJ avalia quantos critérios?", "options": ["3", "4", "5"], "correct": 1}, {"question": "Qual a extensão recomendada?", "options": ["10-20 linhas", "20-30 linhas", "30-40 linhas"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:31:16.58083');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (292, 'uerj', 1, 2, 'Interpretando a Proposta', 'Como entender o tema', '# Análise da Proposta

## Elementos da Proposta UERJ
1. **Comando:** O que é pedido
2. **Tema:** Assunto delimitado
3. **Coletânea:** Textos de apoio

## Estratégia de Leitura
1. Leia o comando primeiro
2. Identifique palavras-chave
3. Leia a coletânea buscando argumentos
4. Defina seu posicionamento

## Armadilhas
❌ Responder apenas parte do tema
❌ Fugir para assunto relacionado
❌ Copiar a coletânea', '[{"question": "O comando deve ser lido:", "options": ["Após a coletânea", "Antes da coletânea"], "correct": 1}, {"question": "Copiar coletânea:", "options": ["É permitido", "Prejudica a nota"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:31:16.58083');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (293, 'uerj', 1, 3, 'Recorte Temático', 'Delimitando o assunto', '# Recorte Temático

## O que é?
A delimitação específica dentro de um assunto amplo.

## Exemplo
**Assunto:** Educação
**Tema UERJ:** "Os impactos da pandemia na educação pública carioca"

## Como identificar
- Leia todas as condições do tema
- Note especificadores: "no Brasil", "hoje", "jovens"
- Relacione com a coletânea

## Erro grave
Falar do assunto geral sem abordar o recorte específico = tangenciamento', '[{"question": "Tangenciamento ocorre quando:", "options": ["Foge do tema", "Aborda só o assunto geral", "Copia textos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.58083');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (294, 'uerj', 1, 4, 'Posicionamento Crítico', 'Defendendo sua tese', '# Posicionamento na UERJ

## Tese Clara
- Apresente sua opinião de forma explícita
- Seja defensável com argumentos
- Evite senso comum

## Exemplo
**Tema:** Cotas raciais

❌ "As cotas são um tema polêmico"
✅ "As cotas raciais constituem reparação histórica necessária para reduzir desigualdades estruturais"

## Onde posicionar
- Final da introdução
- Retomar na conclusão', '[{"question": "Tese deve ser:", "options": ["Vaga e neutra", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.58083');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (295, 'uerj', 1, 5, 'Temas Recorrentes', 'O que a UERJ costuma cobrar', '# Temas Frequentes UERJ

## Áreas
- Questões sociais brasileiras
- Cidadania e direitos
- Cultura e identidade
- Meio ambiente urbano
- Educação e trabalho

## Dica
A UERJ valoriza olhar crítico sobre a realidade carioca e brasileira.

## Repertório útil
- Constituição Federal
- Estatutos (ECA, Idoso)
- Dados sobre RJ
- Autores brasileiros', '[{"question": "A UERJ valoriza:", "options": ["Repertório internacional apenas", "Olhar crítico sobre realidade brasileira"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.58083');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (296, 'uerj', 2, 1, 'Argumentação Sólida', 'Construindo argumentos', '# Argumentação na UERJ

## Tipos de Argumento
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas, autores
4. **Causa-consequência:** Relações lógicas

## Estrutura
1. Afirmação (tópico frasal)
2. Fundamentação
3. Exemplo/dado
4. Análise crítica
5. Conexão com tese', '[{"question": "Quantos elementos tem um bom argumento?", "options": ["2", "3-5", "7+"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:31:16.582608');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (297, 'uerj', 2, 2, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório na UERJ

## Fontes Valorizadas
- Dados oficiais (IBGE, IPEA)
- Leis e documentos
- Autores e pensadores
- Fatos históricos
- Obras artísticas

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente
4. Não apenas "decoreba"

## Repertório local
A UERJ valoriza conhecimento sobre Rio de Janeiro e Brasil.', '[{"question": "Repertório deve ser:", "options": ["Apenas citado", "Citado e analisado"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:31:16.582608');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (298, 'uerj', 2, 3, 'Análise Crítica', 'Aprofundando argumentos', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica a sociedade"
✅ Avançado: "Esse cenário perpetua desigualdades estruturais, uma vez que..."

## Fórmula
DADO + "isso revela/demonstra" + INTERPRETAÇÃO + CONEXÃO

## Exemplo
"Segundo o IBGE, 40% dos jovens não concluem o ensino médio. Esse dado evidencia uma falha sistêmica na retenção escolar, perpetuando o ciclo de exclusão social."', '[{"question": "Análise crítica vai além de:", "options": ["Citar dados", "Apenas descrever"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.582608');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (299, 'uerj', 2, 4, 'Contra-argumentação', 'Fortalecendo sua posição', '# Contra-argumentação

## O que é?
Antecipar objeções e refutá-las.

## Estrutura
1. Apresente visão contrária
2. Reconheça parcialmente
3. Refute com argumentos
4. Reforce sua tese

## Exemplo
"Alguns argumentam que... Entretanto, tal visão desconsidera que... Portanto, mantém-se que..."

## Benefício
Demonstra maturidade e domínio do tema.', '[{"question": "Contra-argumentação serve para:", "options": ["Enfraquecer sua tese", "Fortalecer sua posição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.582608');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (300, 'uerj', 2, 5, 'Autoria', 'Desenvolvendo voz própria', '# Autoria na Redação

## O que é?
Sua capacidade de interpretar, não apenas reproduzir.

## Características
- Opinião fundamentada
- Análise original
- Conexões criativas
- Vocabulário próprio

## Como desenvolver
1. Leia diversos gêneros
2. Pratique interpretação
3. Forme opinião sobre temas
4. Escreva com regularidade', '[{"question": "Autoria significa:", "options": ["Copiar bem", "Interpretar e criar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.582608');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (301, 'uerj', 3, 1, 'Estrutura do Texto', 'Organizando parágrafos', '# Estrutura Dissertativa

## Modelo UERJ
- **Introdução:** Contexto + tese
- **D1:** Primeiro argumento
- **D2:** Segundo argumento
- **Conclusão:** Retomada + fechamento

## Proporção
- Intro: ~20% do texto
- Desenvolvimento: ~60%
- Conclusão: ~20%', '[{"question": "Desenvolvimento ocupa:", "options": ["20%", "40%", "60%"], "correct": 2}]', 3, 'free', 0, true, '2025-12-05 10:31:16.583893');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (302, 'uerj', 3, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Frase de abertura (contexto)
2. Delimitação do tema
3. Tese clara

## Estratégias
- Citação relevante
- Dado estatístico
- Contextualização histórica
- Pergunta retórica

## Evite
- Introduções longas demais
- Ir direto à tese sem contexto
- Frases vazias', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tema + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:31:16.583893');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (303, 'uerj', 3, 3, 'Parágrafos Progressivos', 'Avançando ideias', '# Progressão Textual

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura do parágrafo
1. Tópico frasal
2. Desenvolvimento
3. Exemplificação
4. Análise
5. Conexão

## Conexão entre parágrafos
Use conectivos e retomadas para criar fluidez.', '[{"question": "Progressão significa:", "options": ["Repetir ideias", "Adicionar informações novas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.583893');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (304, 'uerj', 3, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Por função

### Adição
Além disso, ademais, outrossim

### Oposição
Contudo, entretanto, todavia

### Conclusão
Portanto, logo, destarte

### Causa
Porque, visto que, uma vez que

### Consequência
De modo que, assim, por isso', '[{"question": "''Contudo'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.583893');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (305, 'uerj', 3, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Reflexão final ou proposta

## Estratégias
- Projeção futura
- Questionamento
- Chamado à reflexão

## Evite
- Novas informações
- Repetir literalmente a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.583893');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (306, 'uerj', 4, 1, 'Norma Culta', 'Domínio gramatical', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro isso do que aquilo" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Correto", "Incorreto"], "correct": 0}]', 3, 'free', 0, true, '2025-12-05 10:31:16.585368');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (307, 'uerj', 4, 2, 'Registro Formal', 'Linguagem adequada', '# Registro Formal

## Características
- Terceira pessoa predominante
- Vocabulário culto
- Construções completas
- Ausência de gírias

## Evite
- "A gente vê que..."
- "Tipo assim..."
- Contrações orais: "pra", "tá"', '[{"question": "''A gente'' é adequado?", "options": ["Sim", "Não, usar nós"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:31:16.585368');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (308, 'uerj', 4, 3, 'Vocabulário', 'Escolha de palavras', '# Vocabulário Adequado

## Substituições úteis
| Simples | Sofisticado |
|---------|-------------|
| Mostrar | Evidenciar |
| Problema | Impasse |
| Importante | Fundamental |
| Fazer | Realizar |

## Cuidado
Use apenas palavras que conhece bem.', '[{"question": "Vocabulário deve ser:", "options": ["Complexo sempre", "Adequado e preciso"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.585368');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (309, 'uerj', 4, 4, 'Coesão', 'Amarrando o texto', '# Coesão Textual

## Mecanismos
1. Pronomes: ele, isso, tal
2. Sinônimos: variação lexical
3. Conectivos: ligação de ideias
4. Elipse: omissão intencional

## Evite
Repetição excessiva do mesmo termo.', '[{"question": "Coesão usa:", "options": ["Apenas conectivos", "Vários mecanismos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.585368');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (310, 'uerj', 4, 5, 'Revisão Final', 'Polindo o texto', '# Checklist de Revisão

## Gramática
- [ ] Concordâncias corretas?
- [ ] Regências adequadas?
- [ ] Pontuação correta?

## Conteúdo
- [ ] Tese clara?
- [ ] Argumentos desenvolvidos?
- [ ] Conclusão coerente?

## Forma
- [ ] Parágrafos equilibrados?
- [ ] Conectivos variados?
- [ ] Vocabulário adequado?

## Dica
Reserve 10 minutos para revisão!', '[{"question": "Revisão deve levar:", "options": ["0 minutos", "10 minutos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:31:16.585368');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (390, 'sisu', 4, 5, 'Checklist C4', 'Coesão nota 200', '# Checklist C4

## Antes de finalizar
- [ ] Conectivos variados?
- [ ] Sem repetições excessivas?
- [ ] Parágrafos conectados?
- [ ] Referências claras?
- [ ] Texto fluido?

## Dica
Releia buscando "buracos" entre ideias.', '[{"question": "C4 avalia:", "options": ["Conteúdo", "Conexão textual"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.226499');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (391, 'sisu', 5, 1, 'Os 5 Elementos', 'Estrutura obrigatória', '# C5: Proposta de Intervenção

## 5 Elementos Obrigatórios
1. **AGENTE:** Quem faz? (Governo, MEC...)
2. **AÇÃO:** O que fazer?
3. **MODO/MEIO:** Como fazer?
4. **DETALHAMENTO:** Especificação
5. **FINALIDADE:** Para quê?

## Impacto
Falta de elementos = nota proporcional', '[{"question": "Quantos elementos obrigatórios?", "options": ["3", "5"], "correct": 1}]', 2, 'free', 0, true, '2025-12-05 10:54:46.227719');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (392, 'sisu', 5, 2, 'Agentes Eficazes', 'Quem pode agir?', '# Escolhendo o Agente

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
Escolha agente que PODE agir no problema.', '[{"question": "Problema educacional → agente:", "options": ["Ministério da Saúde", "MEC"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.227719');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (393, 'sisu', 5, 3, 'Direitos Humanos', 'Evitando ZERO', '# Proposta e Direitos Humanos

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
- Apoio a vítimas', '[{"question": "Propor censura:", "options": ["É válido", "Pode zerar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.227719');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (394, 'sisu', 5, 4, 'Proposta Completa', 'Exemplo nota 200', '# Modelo de Proposta

## Exemplo completo
"O **MEC** [agente] deve **criar campanhas educativas** [ação] **por meio de parcerias com influenciadores digitais** [modo] **nas redes sociais, semanalmente, alcançando jovens de 15 a 25 anos** [detalhamento], **a fim de conscientizar sobre os riscos das fake news e promover o pensamento crítico** [finalidade]."

## Estrutura
AGENTE + AÇÃO + MODO + DETALHAMENTO + FINALIDADE', '[{"question": "Proposta completa tem:", "options": ["3 elementos", "5 elementos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.227719');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (395, 'sisu', 5, 5, 'Checklist C5', 'Proposta nota 200', '# Checklist C5 - SISU

## Antes de finalizar
- [ ] Agente específico?
- [ ] Ação concreta?
- [ ] Modo/meio claro?
- [ ] Detalhamento presente?
- [ ] Finalidade explícita?
- [ ] Respeita direitos humanos?
- [ ] Conectada aos argumentos?

## Impacto no SISU
C5 = diferencial para nota de corte!', '[{"question": "C5 completa impacta:", "options": ["Pouco", "Significativamente na nota"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.227719');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (416, 'ufal', 1, 1, 'A Redação UFAL', 'Conhecendo o vestibular', '# A Redação da UFAL

## Universidade Federal de Alagoas
Localizada em Maceió, a UFAL é a principal universidade do estado.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coesão
3. Argumentação
4. Domínio da norma culta

## Contexto Regional
A UFAL pode abordar temas do Nordeste brasileiro.', '[{"question": "A UFAL está localizada em:", "options": ["Recife", "Maceió", "Salvador"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:34:59.029997');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (311, 'ufmg', 1, 1, 'A Redação UFMG', 'Conhecendo a prova', '# A Redação da UFMG

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
- Foco em questões sociais brasileiras', '[{"question": "A UFMG pode cobrar diferentes gêneros?", "options": ["Sim", "Não, só dissertação"], "correct": 0}, {"question": "Extensão recomendada:", "options": ["15-20 linhas", "25-30 linhas"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:37:33.203672');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (312, 'ufmg', 1, 2, 'Gêneros Textuais', 'Dominando formatos', '# Gêneros na UFMG

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
Cada gênero tem estrutura própria!', '[{"question": "Carta argumentativa precisa de:", "options": ["Título", "Vocativo e saudação"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:37:33.203672');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (313, 'ufmg', 1, 3, 'Interpretando a Proposta', 'Análise cuidadosa', '# Análise da Proposta

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
Escrever gênero diferente do pedido = nota muito baixa', '[{"question": "O que ler primeiro?", "options": ["Coletânea", "Comando da proposta"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.203672');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (314, 'ufmg', 1, 4, 'Coletânea UFMG', 'Usando textos de apoio', '# A Coletânea

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
A coletânea é ponto de partida, não limite.', '[{"question": "Pode copiar a coletânea?", "options": ["Sim", "Não, deve parafrasear"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.203672');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (315, 'ufmg', 1, 5, 'Temas Recorrentes', 'O que a UFMG cobra', '# Temas Frequentes

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
- Constituição e leis', '[{"question": "A UFMG pode abordar temas regionais?", "options": ["Sim", "Não"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.203672');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (316, 'ufmg', 2, 1, 'Coerência Textual', 'Sentido global', '# Coerência

## O que é?
O sentido global do texto - ideias fazem sentido juntas.

## Tipos
- **Interna:** Entre partes do texto
- **Externa:** Com a realidade
- **Temática:** Com o tema proposto

## Problemas
❌ Contradição entre parágrafos
❌ Conclusão oposta à tese
❌ Informações sem fundamento', '[{"question": "Coerência é:", "options": ["Conexão entre frases", "Sentido global do texto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:37:33.205633');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (317, 'ufmg', 2, 2, 'Coesão Referencial', 'Retomando termos', '# Coesão Referencial

## Mecanismos
1. **Pronomes:** ele, isso, aquele
2. **Sinônimos:** variação lexical
3. **Hiperônimos:** termo mais geral
4. **Elipse:** omissão intencional

## Exemplo
"O Brasil enfrenta desafios. **O país** precisa de reformas. **Essa nação** tem potencial..."

## Benefício
Evita repetição e cria fluidez.', '[{"question": "Substituir ''Brasil'' por ''o país'' é:", "options": ["Erro", "Coesão referencial"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:37:33.205633');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (318, 'ufmg', 2, 3, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Por função
| Função | Conectivos |
|--------|------------|
| Adição | Além disso, ademais |
| Oposição | Contudo, entretanto |
| Conclusão | Portanto, logo |
| Causa | Porque, visto que |
| Consequência | De modo que, assim |

## Variação
Não repita o mesmo conectivo várias vezes!', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.205633');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (319, 'ufmg', 2, 4, 'Progressão Textual', 'Avançando ideias', '# Progressão

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura progressiva
1. Introdução: Tese
2. D1: Primeiro argumento
3. D2: Segundo argumento (aprofunda)
4. Conclusão: Síntese

## Erro comum
Repetir a mesma ideia com palavras diferentes.', '[{"question": "Progressão significa:", "options": ["Repetir ideias", "Adicionar informações novas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.205633');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (320, 'ufmg', 2, 5, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave do anterior
2. Usar conectivo adequado
3. Fazer referência ao já dito

## Exemplo
Final D1: "...perpetua desigualdades."
Início D2: "**Além dessa questão estrutural**, a educação..."

## Benefício
Texto fluido e bem articulado.', '[{"question": "Transições conectam:", "options": ["Frases apenas", "Parágrafos entre si"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.205633');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (321, 'ufmg', 3, 1, 'Vocabulário Adequado', 'Escolha de palavras', '# Vocabulário

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
Use apenas palavras que domina.', '[{"question": "Vocabulário deve ser:", "options": ["Complexo sempre", "Preciso e adequado"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:37:33.207268');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (322, 'ufmg', 3, 2, 'Estrutura Sintática', 'Variando períodos', '# Variedade Sintática

## Tipos de período
- **Simples:** Uma oração
- **Composto por coordenação:** Orações independentes
- **Composto por subordinação:** Orações dependentes

## Técnica
Alterne tipos para criar ritmo e fluidez.

## Exemplo
"A educação é fundamental. [simples] Contudo, quando negligenciada pelo Estado, ela falha em cumprir seu papel transformador. [composto]"', '[{"question": "Variar períodos melhora:", "options": ["Apenas estética", "Ritmo e fluidez"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:37:33.207268');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (323, 'ufmg', 3, 3, 'Figuras de Linguagem', 'Recursos estilísticos', '# Figuras de Linguagem

## Úteis em dissertação
- **Metáfora:** Comparação implícita
- **Antítese:** Oposição de ideias
- **Ironia:** Crítica sutil
- **Metonímia:** Substituição

## Uso moderado
Figuras enriquecem, mas em excesso prejudicam a clareza.

## Exemplo
"O Planalto silencia..." (metonímia)', '[{"question": "Figuras de linguagem devem:", "options": ["Ser abundantes", "Ser usadas com moderação"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.207268');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (324, 'ufmg', 3, 4, 'Argumentação Linguística', 'Modalização', '# Modalização

## O que é?
Marcas linguísticas que indicam posição do autor.

## Tipos
- **Certeza:** "É evidente que..."
- **Possibilidade:** "Possivelmente..."
- **Necessidade:** "É preciso que..."
- **Avaliação:** "Lamentavelmente..."

## Uso estratégico
Modalize para fortalecer ou atenuar afirmações.', '[{"question": "Modalização indica:", "options": ["Tamanho do texto", "Posição do autor"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.207268');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (325, 'ufmg', 3, 5, 'Estilo e Autoria', 'Voz própria', '# Desenvolvendo Estilo

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
4. Experimente abordagens', '[{"question": "Autoria é:", "options": ["Copiar bem", "Ter voz própria"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.207268');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (326, 'ufmg', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌ → "Havia pessoas" ✅
- "Prefiro isso do que aquilo" ❌ → "Prefiro isso a aquilo" ✅
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:37:33.208552');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (327, 'ufmg', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.
"Os alunos estudam" ✅

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular
- "A maioria de": singular ou plural

## Nominal
Adjetivos concordam com substantivos.
"Questões importantes" ✅', '[{"question": "Sujeito composto pede verbo:", "options": ["Singular", "Plural"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:37:33.208552');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (328, 'ufmg', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
| Verbo | Regência |
|-------|----------|
| Assistir (ver) | a |
| Visar (objetivar) | a |
| Preferir | a (não "do que") |

## Crase
a + a = à
- Antes de femininas: à escola ✅
- Antes de masculinas: a pé ✅ (sem crase)', '[{"question": "''Assisti o filme'' é:", "options": ["Correto", "Incorreto - assistir A"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.208552');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (329, 'ufmg', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens de lista
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento

## Outros sinais
- Ponto e vírgula: orações coordenadas longas
- Dois-pontos: explicação, enumeração', '[{"question": "Pode usar vírgula entre sujeito e verbo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.208552');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (330, 'ufmg', 4, 5, 'Revisão Final', 'Checklist', '# Checklist de Revisão

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

**Reserve 10-12 minutos para revisão!**', '[{"question": "Revisão deve levar:", "options": ["0 minutos", "10-12 minutos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:37:33.208552');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (396, 'ufac', 1, 1, 'A Redação UFAC', 'Conhecendo o vestibular', '# A Redação da UFAC

## Universidade Federal do Acre
Localizada em Rio Branco, a UFAC é a principal instituição de ensino superior do Acre.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Linguagem e norma culta

## Contexto Regional
A UFAC pode abordar temas relacionados à Amazônia e ao Norte do Brasil.', '[{"question": "A UFAC está localizada em:", "options": ["Manaus", "Rio Branco", "Belém"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:27:36.404187');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (397, 'ufac', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

## Elementos da Proposta
1. **Tema central:** O assunto
2. **Recorte:** Delimitação específica
3. **Textos de apoio:** Contextualização

## Estratégia
1. Leia a proposta completa
2. Identifique palavras-chave
3. Note delimitações
4. Defina posicionamento

## Evite
❌ Fugir do tema
❌ Tangenciar (abordar parcialmente)
❌ Copiar textos de apoio', '[{"question": "Tangenciar o tema significa:", "options": ["Desenvolver bem", "Abordar parcialmente"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:27:36.404187');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (398, 'ufac', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desmatamento na Amazônia

❌ "O desmatamento é ruim"
✅ "O desmatamento amazônico resulta de falhas na fiscalização e demanda políticas integradas de desenvolvimento sustentável"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.404187');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (399, 'ufac', 1, 4, 'Temas Regionais', 'Contexto amazônico', '# Temas Relevantes para UFAC

## Contexto Regional
- Preservação da Amazônia
- Povos indígenas e tradicionais
- Desenvolvimento sustentável
- Biodiversidade
- Queimadas e desmatamento

## Repertório Útil
- Chico Mendes e seringueiros
- Floresta Amazônica
- Tratados ambientais
- Dados do INPE/IBAMA', '[{"question": "Chico Mendes lutou por:", "options": ["Indústria", "Seringueiros e floresta"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.404187');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (400, 'ufac', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFAC

## Tipos válidos
- Dados: IBGE, INPE, IBAMA
- Histórico: Ciclo da borracha, Chico Mendes
- Filosófico: Pensadores ambientais
- Legal: Constituição, Código Florestal

## Repertório local
- História do Acre
- Povos da floresta
- Economia regional
- Desafios amazônicos', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.404187');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (401, 'ufac', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Total
20 a 30 linhas bem distribuídas.', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:27:36.407233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (402, 'ufac', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Citação relevante
- Dado estatístico
- Contextualização histórica

## Evite
Introduções longas demais ou sem tese.', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:27:36.407233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (331, 'afa', 1, 1, 'A Redação AFA', 'Conhecendo a prova militar', '# A Redação da AFA

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
Valoriza postura ética e conhecimento de valores da carreira militar.', '[{"question": "A AFA forma oficiais de qual força?", "options": ["Exército", "Marinha", "Aeronáutica"], "correct": 2}, {"question": "Extensão recomendada:", "options": ["15-20 linhas", "20-30 linhas"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:42:39.306243');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (332, 'afa', 1, 2, 'Temas Militares', 'Assuntos frequentes', '# Temas na AFA

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
- Fatos históricos brasileiros', '[{"question": "A AFA valoriza postura:", "options": ["Neutra", "Ética e fundamentada"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:42:39.306243');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (333, 'afa', 1, 3, 'Interpretando a Proposta', 'Análise cuidadosa', '# Análise da Proposta

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
Fugir do tema ou tangenciar = nota muito baixa', '[{"question": "Tangenciar o tema significa:", "options": ["Desenvolver bem", "Abordar parcialmente"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.306243');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (334, 'afa', 1, 4, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Liderança na sociedade atual

❌ "A liderança é importante"
✅ "A liderança eficaz combina competência técnica e inteligência emocional, sendo essencial para organizações contemporâneas"

## Posição na AFA
Tese assertiva, sem rodeios.', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e objetiva"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.306243');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (335, 'afa', 1, 5, 'Valores e Ética', 'Base da argumentação AFA', '# Valores na Redação AFA

## Valores da FAB
- Integridade
- Profissionalismo
- Comprometimento
- Disciplina
- Patriotismo

## Como usar
Não cite diretamente, mas deixe transparecer em sua argumentação.

## Exemplo
Ao discutir liderança, demonstre valorização de responsabilidade e ética - não apenas cite que são importantes.', '[{"question": "Valores devem:", "options": ["Ser citados diretamente", "Transparecer na argumentação"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.306243');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (336, 'afa', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura para AFA

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + fechamento (5-7 linhas)

## Característica AFA
Estrutura clara e objetiva, sem rodeios.', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:42:39.308232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (337, 'afa', 2, 2, 'Introdução Direta', 'Abrindo com clareza', '# A Introdução AFA

## Elementos
1. Contextualização breve
2. Apresentação do tema
3. Tese clara

## Estilo
Direto e objetivo - sem floreios.

## Exemplo
"A liderança constitui elemento fundamental para o sucesso de qualquer organização. [contexto] No cenário contemporâneo, marcado por rápidas transformações, [tema] é imperativo que líderes desenvolvam tanto competências técnicas quanto habilidades interpessoais. [tese]"', '[{"question": "Introdução AFA deve ser:", "options": ["Longa e detalhada", "Direta e objetiva"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:42:39.308232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (338, 'afa', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. **Tópico frasal:** Ideia principal
2. **Fundamentação:** Argumento
3. **Exemplo:** Caso ou dado
4. **Análise:** Interpretação
5. **Fechamento:** Link com tese

## Quantidade
2 parágrafos bem desenvolvidos > 3 superficiais', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.308232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (339, 'afa', 2, 4, 'Progressão Textual', 'Avançando ideias', '# Progressão

## Princípio
Cada parágrafo adiciona informação nova.

## Técnica
- D1: Argumento mais acessível
- D2: Argumento mais complexo ou complementar

## Conectivos de progressão
- "Além disso..."
- "Soma-se a isso..."
- "Em complemento..."', '[{"question": "Progressão significa:", "options": ["Repetir ideias", "Adicionar informações"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.308232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (340, 'afa', 2, 5, 'Conclusão Objetiva', 'Fechando o texto', '# Conclusão AFA

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Reflexão final ou projeção

## Estilo
Objetiva e assertiva.

## Evite
- Novas informações
- Repetir literalmente a introdução
- Frases vazias como "conclui-se que"', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.308232');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (341, 'afa', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos Valorizados
1. **Dados:** Estatísticas confiáveis
2. **Exemplos:** Casos históricos
3. **Autoridade:** Especialistas
4. **Lógica:** Causa e consequência

## Na AFA
Valoriza argumentação fundamentada, não opinativa.', '[{"question": "AFA valoriza argumento:", "options": ["Opinativo", "Fundamentado"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:42:39.309833');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (342, 'afa', 3, 2, 'Repertório para AFA', 'Conhecimento útil', '# Repertório

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
- Pensadores reconhecidos', '[{"question": "Repertório AFA deve incluir:", "options": ["Só entretenimento", "História, ética, atualidades"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:42:39.309833');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (343, 'afa', 3, 3, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é importante"
⚠️ Médio: "Isso afeta a sociedade"
✅ Avançado: "Esse cenário revela desafios estruturais que demandam..."

## Fórmula
DADO + interpretação + consequência + conexão com tese', '[{"question": "Análise crítica vai além de:", "options": ["Descrever", "Citar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.309833');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (344, 'afa', 3, 4, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese, não contradizê-la.

## Problemas comuns
❌ Tese X, argumento Y
❌ Conclusão diferente do defendido
❌ Exemplos que não comprovam

## Solução
Sempre pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.309833');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (345, 'afa', 3, 5, 'Fundamentação Sólida', 'Provas concretas', '# Fundamentação

## O que é?
Provas concretas para suas afirmações.

## Tipos
- Dados estatísticos
- Exemplos históricos
- Casos concretos
- Citações de autoridade

## Na AFA
Evite afirmações sem fundamento. Toda opinião deve ter base.', '[{"question": "Opinião sem fundamento é:", "options": ["Válida", "Problemática"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.309833');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (346, 'afa', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos Críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros Graves
- "Haviam pessoas" ❌
- "Prefiro isso do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia muitas pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:42:39.311235');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (347, 'afa', 4, 2, 'Registro Formal', 'Linguagem adequada', '# Registro Formal

## Características
- Terceira pessoa
- Vocabulário culto
- Frases completas
- Tom objetivo

## Evite
- "A gente" → use "nós"
- Gírias e coloquialismos
- Contrações: "pra", "tá"', '[{"question": "Registro formal usa:", "options": ["Gírias", "Terceira pessoa"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:42:39.311235');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (348, 'afa', 4, 3, 'Objetividade', 'Clareza na expressão', '# Clareza e Objetividade

## Princípios
- Uma ideia por período
- Vocabulário preciso
- Evitar ambiguidades

## Na AFA
Estilo militar: claro, direto, sem rodeios.

## Exemplo
❌ "Pode-se dizer que talvez seja possível..."
✅ "É necessário que..."', '[{"question": "Texto AFA deve ser:", "options": ["Rebuscado", "Claro e direto"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.311235');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (349, 'afa', 4, 4, 'Vocabulário', 'Escolha de palavras', '# Vocabulário Adequado

## Substituições
| Simples | Sofisticado |
|---------|-------------|
| Mostrar | Evidenciar |
| Problema | Desafio |
| Importante | Fundamental |

## Cuidado
Use apenas palavras que domina.', '[{"question": "Vocabulário deve ser:", "options": ["Complexo sempre", "Preciso e adequado"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.311235');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (350, 'afa', 4, 5, 'Revisão Final', 'Checklist', '# Checklist AFA

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

**Reserve 10 minutos para revisão!**', '[{"question": "Revisão deve levar:", "options": ["0 minutos", "10 minutos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:42:39.311235');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (403, 'ufac', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos são suficientes.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.407233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (404, 'ufac', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Contudo'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.407233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (405, 'ufac', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão final

## Evite
- Novas informações
- Repetir literalmente a introdução
- Frases vazias', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.407233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (406, 'ufac', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas
5. **Comparação:** Paralelos

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos de argumento usar:", "options": ["1", "Ao menos 2"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:27:36.408761');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (407, 'ufac', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica a sociedade"
✅ Avançado: "Esse cenário perpetua desigualdades estruturais..."

## Fórmula
DADO + "isso revela" + INTERPRETAÇÃO', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:27:36.408761');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (408, 'ufac', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão diferente do defendido

## Solução
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados apenas", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.408761');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (409, 'ufac', 3, 4, 'Progressão Argumentativa', 'Avançando ideias', '# Progressão

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais acessível
- D2: Argumento mais complexo

## Conectivos de progressão
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Adicionar informações"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.408761');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (410, 'ufac', 3, 5, 'Contra-argumentação', 'Fortalecendo posição', '# Contra-argumentação

## O que é?
Antecipar objeções e refutá-las.

## Estrutura
1. Apresente visão contrária
2. Reconheça parcialmente
3. Refute com argumentos
4. Reforce sua tese

## Benefício
Demonstra maturidade argumentativa.', '[{"question": "Contra-argumentação:", "options": ["Enfraquece", "Fortalece a posição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.408761');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (411, 'ufac', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro isso do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:27:36.410074');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (412, 'ufac', 4, 2, 'Registro Formal', 'Linguagem adequada', '# Registro Formal

## Características
- Terceira pessoa
- Vocabulário culto
- Frases completas

## Evite
- "A gente" → use "nós"
- Gírias e coloquialismos
- Contrações: "pra", "tá"', '[{"question": "''A gente'' é adequado?", "options": ["Sim", "Não"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:27:36.410074');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (413, 'ufac', 4, 3, 'Vocabulário', 'Escolha de palavras', '# Vocabulário Adequado

## Substituições
| Simples | Sofisticado |
|---------|-------------|
| Mostrar | Evidenciar |
| Problema | Impasse |
| Importante | Fundamental |

## Cuidado
Use apenas palavras que conhece.', '[{"question": "Vocabulário deve ser:", "options": ["Complexo sempre", "Preciso e adequado"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.410074');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (351, 'cacd', 1, 1, 'A Prova do CACD', 'Conhecendo o concurso', '# O Concurso de Admissão à Carreira de Diplomata

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
A prova exige conhecimento profundo de relações internacionais e política externa brasileira.', '[{"question": "O CACD seleciona para qual carreira?", "options": ["Militar", "Diplomática", "Jurídica"], "correct": 1}, {"question": "Extensão aproximada:", "options": ["30 linhas", "60-90 linhas"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:47:17.819909');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (352, 'cacd', 1, 2, 'Temas de Política Externa', 'O que é cobrado', '# Temas Recorrentes

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
Conheça as posições históricas do Brasil em fóruns internacionais.', '[{"question": "O CACD cobra conhecimento de:", "options": ["Direito interno apenas", "Política externa brasileira"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:47:17.819909');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (353, 'cacd', 1, 3, 'Interpretando a Proposta', 'Análise precisa', '# Análise da Proposta CACD

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
Fugir do tema ou desconhecer posições brasileiras.', '[{"question": "O posicionamento deve estar alinhado:", "options": ["À opinião pessoal", "À PEB (Política Externa Brasileira)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.819909');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (354, 'cacd', 1, 4, 'Posicionamento e PEB', 'Alinhamento estratégico', '# Posicionamento no CACD

## Princípio fundamental
A redação deve refletir entendimento da Política Externa Brasileira (PEB).

## Princípios da PEB
- Não-intervenção
- Autodeterminação dos povos
- Solução pacífica de controvérsias
- Multilateralismo
- Desenvolvimento como objetivo

## Como posicionar-se
Não defenda posições contrárias aos princípios constitucionais de política externa.', '[{"question": "A PEB valoriza:", "options": ["Intervencionismo", "Solução pacífica de controvérsias"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.819909');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (355, 'cacd', 1, 5, 'Atualidades e Conjuntura', 'Estar informado', '# Atualidades para o CACD

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
Acompanhe posições oficiais do Brasil em fóruns internacionais.', '[{"question": "Fonte oficial da PEB:", "options": ["Jornais apenas", "Site do Itamaraty/MRE"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.819909');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (356, 'cacd', 2, 1, 'Estrutura da Dissertação', 'Organizando o texto', '# Estrutura CACD

## Modelo (60-90 linhas)
- **Introdução:** Contexto + tese (10-15 linhas)
- **D1:** Primeiro eixo argumentativo (15-20 linhas)
- **D2:** Segundo eixo argumentativo (15-20 linhas)
- **D3:** Terceiro eixo (opcional) (10-15 linhas)
- **Conclusão:** Síntese + projeção (10-15 linhas)

## Característica
Texto longo e denso - exige planejamento cuidadoso.', '[{"question": "Texto CACD é:", "options": ["Curto (30 linhas)", "Longo (60-90 linhas)"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:47:17.821695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (357, 'cacd', 2, 2, 'Introdução Contextualizadora', 'Abrindo com propriedade', '# A Introdução CACD

## Elementos
1. Contextualização histórica
2. Apresentação do tema
3. Tese clara
4. Indicação do percurso

## Estilo
Formal, erudito, demonstrando conhecimento.

## Exemplo
"A política externa brasileira, desde Rio Branco, caracteriza-se pelo pragmatismo e pela busca de inserção internacional autônoma. [contexto] No que tange às relações com [tema], o Brasil tem historicamente... [desenvolvimento]"', '[{"question": "Introdução CACD deve ter:", "options": ["Apenas tese", "Contexto histórico + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:47:17.821695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (358, 'cacd', 2, 3, 'Desenvolvimento Analítico', 'Argumentação densa', '# Parágrafos de Desenvolvimento

## Estrutura
1. **Tópico frasal:** Ideia-chave
2. **Contextualização:** Histórico/cenário
3. **Análise:** Interpretação fundamentada
4. **Exemplificação:** Casos concretos
5. **Fechamento:** Conexão com tese

## Extensão
15-20 linhas por parágrafo de desenvolvimento.

## Profundidade
Cada eixo deve trazer análise, não apenas informação.', '[{"question": "Desenvolvimento CACD é:", "options": ["Superficial", "Analítico e denso"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.821695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (359, 'cacd', 2, 4, 'Progressão e Coerência', 'Construindo o raciocínio', '# Progressão Argumentativa

## Princípio
Os eixos devem se complementar, não repetir.

## Modelos
- Cronológico: passado → presente → futuro
- Temático: aspecto A → aspecto B → síntese
- Problema-solução: diagnóstico → caminhos

## Coerência
Todos os eixos devem apoiar a tese central.', '[{"question": "Os eixos devem:", "options": ["Repetir informações", "Complementar-se"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.821695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (360, 'cacd', 2, 5, 'Conclusão Prospectiva', 'Fechando com visão', '# Conclusão CACD

## Elementos
1. Retomada sintética da tese
2. Síntese dos eixos
3. Projeção/perspectiva futura
4. Fechamento que valoriza a PEB

## Estilo
Conclusões que demonstrem visão estratégica e conhecimento de tendências.

## Evite
Conclusões simplistas ou que não dialoguem com o desenvolvimento.', '[{"question": "Conclusão CACD deve ter:", "options": ["Apenas resumo", "Síntese + projeção futura"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.821695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (361, 'cacd', 3, 1, 'Registro Diplomático', 'Formalidade e protocolo', '# Linguagem Diplomática

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
- "Multilateralismo efetivo"', '[{"question": "Tom diplomático é:", "options": ["Extremo e apaixonado", "Sereno e ponderado"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:47:17.822881');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (362, 'cacd', 3, 2, 'Terminologia Específica', 'Vocabulário do Itamaraty', '# Vocabulário Diplomático

## Termos Essenciais
| Termo | Significado |
|-------|-------------|
| Concertação | Coordenação entre países |
| Paragrapso Único | Art. 4º da CF |
| Geometria variável | Parcerias flexíveis |
| Soft power | Poder brando |
| Sul Global | Países em desenvolvimento |

## Uso
Empregue terminologia com precisão e naturalidade.', '[{"question": "''Concertação'' significa:", "options": ["Concerto musical", "Coordenação entre países"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:47:17.822881');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (363, 'cacd', 3, 3, 'Impessoalidade e Ponderação', 'Tom adequado', '# Tom Adequado

## Impessoalidade
Evite primeira pessoa singular.
❌ "Eu penso que..."
✅ "Observa-se que..."

## Ponderação
Evite afirmações categóricas demais.
❌ "É absolutamente certo que..."
✅ "Constata-se uma tendência de..."

## Equilíbrio
Apresente nuances, não posições extremas.', '[{"question": "Linguagem diplomática evita:", "options": ["Ponderação", "Afirmações categóricas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.822881');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (364, 'cacd', 3, 4, 'Norma Culta Elevada', 'Gramática impecável', '# Norma Culta no CACD

## Exigência
O nível de correção gramatical deve ser impecável.

## Pontos críticos
- Concordância
- Regência
- Colocação pronominal
- Pontuação

## Diferencial
Use mesóclise quando cabível:
"Dir-se-ia que..." / "Tratar-se-á de..."', '[{"question": "Mesóclise é:", "options": ["Proibida", "Valorizada no CACD"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.822881');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (365, 'cacd', 3, 5, 'Citações e Referências', 'Como citar', '# Citações no CACD

## Quem citar
- Teóricos de RI (Nye, Keohane)
- Diplomatas brasileiros (Rio Branco, San Tiago Dantas)
- Documentos oficiais

## Como citar
"Segundo Rio Branco, a diplomacia deve..."
"Conforme estabelece a Carta da ONU..."

## Cuidado
Cite apenas o que conhece bem.', '[{"question": "Citações devem ser:", "options": ["Inventadas", "De fontes conhecidas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.822881');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (366, 'cacd', 4, 1, 'História da PEB', 'Política externa histórica', '# História da Política Externa Brasileira

## Períodos
- **Barão do Rio Branco:** Definição de fronteiras
- **Era Vargas:** Pragmatismo/equidistância
- **Política Externa Independente:** Anos 60
- **Pragmatismo Responsável:** Geisel
- **Redemocratização:** Integração regional
- **Século XXI:** Protagonismo Sul-Sul

## Importância
Conhecer história da PEB é fundamental para o CACD.', '[{"question": "Rio Branco é conhecido por:", "options": ["Guerras", "Definição pacífica de fronteiras"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:47:17.824224');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (367, 'cacd', 4, 2, 'Organizações Internacionais', 'ONU, OMC, OEA...', '# Organizações Internacionais

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
- UNASUL', '[{"question": "Brasil busca assento permanente no:", "options": ["OMC", "Conselho de Segurança da ONU"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:47:17.824224');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (368, 'cacd', 4, 3, 'Integração Regional', 'América Latina', '# Integração Regional

## MERCOSUL
- Criação: 1991
- Membros: Brasil, Argentina, Paraguai, Uruguai
- Objetivo: Mercado comum

## Outros blocos
- UNASUL (em crise)
- CELAC
- Aliança do Pacífico (Brasil não participa)

## Posição brasileira
Brasil historicamente defende integração regional.', '[{"question": "O MERCOSUL foi criado em:", "options": ["1985", "1991"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.824224');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (369, 'cacd', 4, 4, 'Relações Bilaterais', 'Parceiros estratégicos', '# Relações Bilaterais do Brasil

## Parceiros tradicionais
- EUA: Complexa, oscilante
- Argentina: Essencial para região
- Portugal: Histórica e cultural

## Parcerias estratégicas
- China: Maior parceiro comercial
- Índia: BRICS
- África do Sul: BRICS, IBAS

## BRICS
Brasil, Rússia, Índia, China, África do Sul', '[{"question": "Maior parceiro comercial do Brasil:", "options": ["EUA", "China"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.824224');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (370, 'cacd', 4, 5, 'Temas Contemporâneos', 'Agenda atual', '# Agenda Contemporânea

## Temas prioritários
- Mudanças climáticas
- Reforma do Conselho de Segurança
- Comércio e protecionismo
- Direitos humanos
- Migração

## Posições brasileiras
Conheça as posições oficiais do Brasil em cada tema.

## Fonte
Site do MRE e discursos oficiais.', '[{"question": "Fonte oficial de posições brasileiras:", "options": ["Redes sociais", "Site do MRE/Itamaraty"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:47:17.824224');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (414, 'ufac', 4, 4, 'Coesão Textual', 'Amarrando o texto', '# Coesão

## Mecanismos
1. Pronomes: ele, isso
2. Sinônimos: variação lexical
3. Conectivos: ligação de ideias
4. Elipse: omissão intencional

## Evite
Repetição excessiva do mesmo termo.', '[{"question": "Coesão usa:", "options": ["Apenas conectivos", "Vários mecanismos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.410074');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (415, 'ufac', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFAC

## Conteúdo
- [ ] Tema atendido?
- [ ] Tese clara?
- [ ] Argumentos desenvolvidos?

## Gramática
- [ ] Concordâncias corretas?
- [ ] Pontuação adequada?

## Estrutura
- [ ] 4 parágrafos?
- [ ] Transições claras?

**Reserve 10 minutos para revisão!**', '[{"question": "Revisão deve levar:", "options": ["0 minutos", "10 minutos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:27:36.410074');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (417, 'ufal', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

## Elementos da Proposta
1. **Tema central:** O assunto principal
2. **Recorte:** Delimitação específica
3. **Textos de apoio:** Contextualização

## Estratégia
1. Leia a proposta completa
2. Identifique palavras-chave
3. Note delimitações temporais/espaciais
4. Defina seu posicionamento

## Evite
❌ Fugir do tema = nota zero
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:34:59.029997');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (418, 'ufal', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução
- Retomada na conclusão

## Exemplo
**Tema:** Desigualdade social no Nordeste

❌ "A desigualdade é ruim"
✅ "A desigualdade no Nordeste reflete históricas políticas excludentes que demandam investimentos em educação e infraestrutura"', '[{"question": "A tese deve estar:", "options": ["Na conclusão apenas", "Na introdução"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.029997');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (419, 'ufal', 1, 4, 'Temas Regionais', 'Contexto nordestino', '# Temas do Nordeste

## Assuntos Recorrentes
- Seca e recursos hídricos
- Desenvolvimento regional
- Turismo e economia
- Cultura nordestina
- Desigualdade social

## Repertório Útil
- Graciliano Ramos (Vidas Secas)
- Transposição do São Francisco
- SUDENE
- Economia do turismo', '[{"question": "Vidas Secas é de:", "options": ["Machado de Assis", "Graciliano Ramos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.029997');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (420, 'ufal', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFAL

## Tipos válidos
- Dados: IBGE, IPEA
- Histórico: Formação do Nordeste
- Literário: Autores regionais
- Legal: Constituição, políticas públicas

## Autores nordestinos
- Graciliano Ramos
- Rachel de Queiroz
- Jorge Amado
- Ariano Suassuna', '[{"question": "Rachel de Queiroz escreveu:", "options": ["O Quinze", "Capitães da Areia"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.029997');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (371, 'sisu', 1, 1, 'O SISU e a Redação', 'Como a redação impacta sua vaga', '# O SISU e a Importância da Redação

## O que é o SISU?
Sistema de Seleção Unificada que usa a nota do ENEM para acesso a universidades públicas.

## Impacto da Redação
- Peso pode chegar a 40% em alguns cursos
- Nota zero elimina o candidato
- Diferencial para cursos concorridos

## Média ENEM vs Nota de Corte
A redação pode ser o diferencial entre conseguir ou não a vaga!

## Nota mínima exigida
Alguns cursos exigem nota mínima de 400 ou 500 na redação.', '[{"question": "O SISU usa nota de qual prova?", "options": ["Vestibular próprio", "ENEM"], "correct": 1}, {"question": "Nota zero na redação:", "options": ["Reduz a média", "Elimina o candidato"], "correct": 1}]', 2, 'free', 0, true, '2025-12-05 10:54:46.22201');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (372, 'sisu', 1, 2, 'Erros que Custam Pontos', 'Desvios gramaticais penalizados', '# Erros que Reduzem sua Nota

## Mais Penalizados (C1)
1. **Concordância:** "Os alunos vai..."
2. **Crase:** Uso incorreto
3. **Pontuação:** Vírgula entre sujeito e verbo
4. **Ortografia:** Erros primários

## Impacto
Cada erro pode custar 20-40 pontos na C1!

## Estratégia
Reserve 10 minutos para revisar gramática.', '[{"question": "Quanto tempo para revisão gramatical?", "options": ["0 minutos", "10 minutos"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.22201');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (373, 'sisu', 1, 3, 'Concordância Perfeita', 'Dominando concordância', '# Concordância para Nota 200

## Verbal
- Sujeito composto: verbo no plural
- Verbos impessoais: sempre singular
- "Haver" existindo: HAVIA (nunca "haviam")

## Nominal
- Adjetivo concorda com substantivo
- "Menos" é invariável (nunca "menas")
- "Anexo" concorda (anexas as fotos)', '[{"question": "''Havia muitas pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.22201');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (374, 'sisu', 1, 4, 'Regência e Crase', 'Preposições certas', '# Regência para SISU

## Verbos importantes
| Verbo | Regência |
|-------|----------|
| Assistir (ver) | A - Assisti AO filme |
| Visar (objetivar) | A - Visa AO sucesso |
| Preferir | A - Prefiro café A chá |

## Crase
- Antes de femininas determinadas: à escola ✅
- Antes de masculinas: a pé ✅ (sem crase)', '[{"question": "''Prefiro isso do que aquilo'' é:", "options": ["Correto", "Incorreto - usar A"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.22201');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (375, 'sisu', 1, 5, 'Checklist Gramatical', 'Revisão final C1', '# Checklist C1 - Nota 200

## Antes de finalizar
- [ ] Concordâncias verbais corretas?
- [ ] Concordâncias nominais corretas?
- [ ] Regências adequadas?
- [ ] Crases corretas?
- [ ] Pontuação adequada?

## Dica de ouro
Leia em voz baixa - erros "soam" estranhos.', '[{"question": "Checklist ajuda a:", "options": ["Perder tempo", "Evitar erros"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.22201');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (376, 'sisu', 2, 1, 'Entendendo o Tema', 'Não fuja do tema!', '# C2: Compreensão do Tema

## O que é avaliado
- Compreensão correta do tema
- Desenvolvimento completo
- Uso de repertório pertinente

## Perigos
❌ Fugir do tema = ZERO na C2
❌ Tangenciar = Nota muito baixa
❌ Copiar motivadores = Pode zerar

## Estratégia
Leia a proposta 3 vezes antes de escrever.', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "ZERO na C2"], "correct": 1}]', 2, 'free', 0, true, '2025-12-05 10:54:46.223912');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (377, 'sisu', 2, 2, 'Tema vs Assunto', 'A diferença crucial', '# Tema ≠ Assunto

## Assunto
Amplo, genérico: "Educação", "Saúde"

## Tema
Específico, delimitado: "Desafios da educação inclusiva no Brasil"

## Como identificar
1. Leia o comando
2. Identifique o RECORTE
3. Note condições: "no Brasil", "atualmente"

## Erro
Falar do assunto sem o recorte = tangenciar', '[{"question": "Tema é:", "options": ["Genérico", "Específico e delimitado"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.223912');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (378, 'sisu', 2, 3, 'Repertório Legitimado', 'Fontes confiáveis', '# Repertório para C2

## Tipos válidos
- Dados: IBGE, ONU, pesquisas
- Histórico: Fatos relevantes
- Filosófico: Pensadores
- Cultural: Obras, filmes
- Legal: Leis, Constituição

## Requisitos
✅ Legitimado (fonte confiável)
✅ Pertinente (relacionado ao tema)
✅ Produtivo (usado na argumentação)', '[{"question": "Repertório deve ser:", "options": ["Qualquer informação", "Legitimado e pertinente"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.223912');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (379, 'sisu', 2, 4, 'Repertório Versátil', 'Referências multiuso', '# Repertório Coringa

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
Monte fichas de repertório por tema!', '[{"question": "Bauman é útil para falar de:", "options": ["Matemática", "Modernidade e sociedade"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.223912');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (380, 'sisu', 2, 5, 'Checklist C2', 'Garantindo nota máxima', '# Checklist C2

## Antes de finalizar
- [ ] Tema corretamente compreendido?
- [ ] Recorte temático respeitado?
- [ ] Repertório é legitimado?
- [ ] Repertório conectado ao tema?
- [ ] Não copiei os motivadores?

## Impacto
C2 mal avaliada = nota total prejudicada', '[{"question": "Copiar motivadores:", "options": ["É permitido", "Pode zerar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.223912');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (381, 'sisu', 3, 1, 'Argumentação ENEM', 'O que é avaliado', '# C3: Argumentação

## Critérios
- Seleção de argumentos
- Organização das ideias
- Análise crítica

## Níveis
- 200: Argumentação consistente, repertório diversificado
- 160: Bom, mas com falhas pontuais
- 120: Superficial
- 80 ou menos: Problemas sérios', '[{"question": "Nota 200 em C3 exige:", "options": ["Argumentação superficial", "Argumentação consistente"], "correct": 1}]', 2, 'free', 0, true, '2025-12-05 10:54:46.225274');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (382, 'sisu', 3, 2, 'Tipos de Argumento', 'Variedade argumentativa', '# Tipos de Argumento

## Os mais eficazes
1. **Dados:** Estatísticas, pesquisas
2. **Autoridade:** Especialistas, autores
3. **Exemplificação:** Casos concretos
4. **Comparação:** Paralelos
5. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos por redação.', '[{"question": "Quantos tipos de argumento usar:", "options": ["1 tipo só", "Ao menos 2"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.225274');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (454, 'unifap', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.910335');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (194, 'enem', 2, 4, 'Tese e Posicionamento', 'Defendendo seu ponto', '# Construindo sua Tese

## O que é Tese?
Seu posicionamento claro sobre o tema.

## Características de uma boa tese
- Clara e objetiva
- Defensável com argumentos
- Não óbvia ou superficial

## Exemplos

**Tema:** Violência contra a mulher

❌ *A violência é ruim.* (Óbvio)
✅ *A violência contra a mulher reflete estruturas patriarcais enraizadas que demandam ações educacionais e punitivas.*

## Onde colocar?
- Final da introdução
- Após a contextualização', '[{"question": "A tese deve ser:", "options": ["Óbvia e simples", "Clara e defensável"], "correct": 1}, {"question": "Onde a tese aparece?", "options": ["No desenvolvimento", "Na introdução"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:01.825288');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (186, 'enem', 1, 1, 'Introdução à Norma Culta', 'O que é avaliado na Competência 1', '# Competência 1: Norma Culta

A **Competência 1** avalia o domínio da modalidade escrita formal da língua portuguesa.

## O que é avaliado?
- Ortografia e acentuação
- Concordância verbal e nominal
- Regência verbal e nominal
- Pontuação e crase

## Níveis de pontuação
| Nota | Descrição |
|------|-----------|
| 200 | Excelente domínio, desvios mínimos |
| 160 | Bom domínio, poucos desvios |
| 120 | Domínio mediano |
| 80 | Domínio insuficiente |

> **Dica:** Revise sua redação ao menos 2 vezes!', '[{"question": "O que a Competência 1 avalia?", "options": ["Argumentação", "Norma culta escrita", "Coesão", "Proposta"], "correct": 1}, {"question": "Qual a nota máxima por competência?", "options": ["100", "200", "1000"], "correct": 1}]', 2, 'free', 0, true, '2025-12-05 10:18:01.822983');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (187, 'enem', 1, 2, 'Concordância Verbal', 'Regras essenciais', '# Concordância Verbal

O verbo concorda em número e pessoa com o sujeito.

## Regras Fundamentais

**Sujeito Simples:** *Os alunos **estudam**.*
**Sujeito Composto antes do verbo:** Plural → *João e Maria **chegaram**.*
**Sujeito Composto depois do verbo:** Singular ou plural → ***Chegou/Chegaram** João e Maria.*

## Verbos Impessoais (sempre singular)
- **Haver** (existir): *Havia muitas pessoas.* ✅
- **Fazer** (tempo): *Faz dois anos.* ✅

## Casos Especiais
| Expressão | Concordância |
|-----------|--------------|
| A maioria de | Singular ou plural |
| Mais de um | Singular |
| Cerca de | Com o numeral |', '[{"question": "Qual está CORRETO?", "options": ["Haviam muitos erros", "Havia muitos erros", "Houveram erros"], "correct": 1}, {"question": "Faz ou fazem cinco anos?", "options": ["Faz (impessoal)", "Fazem"], "correct": 0}, {"question": "A maioria estudou/estudaram?", "options": ["Só estudou", "Só estudaram", "Ambos corretos"], "correct": 2}]', 3, 'previous', 0, true, '2025-12-05 10:18:01.822983');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (188, 'enem', 1, 3, 'Concordância Nominal', 'Casos complexos', '# Concordância Nominal

## Casos Especiais

### É proibido / É necessário
- Sem artigo: invariável → *É proibido entrada.*
- Com artigo: concorda → *É proibida a entrada.*

### Palavras Invariáveis
- **Menos**: *Menos pessoas* ✅ (*Menas* ❌)
- **Alerta**: *Estavam alerta* ✅
- **Pseudo**: *Pseudocientistas* ✅

### Palavras Variáveis
- **Anexo/Incluso**: *Seguem **anexas** as fotos.*
- **Obrigado/a**: *Ela disse **obrigada**.*

### Meio/Bastante
- Adjetivo (variável): *Ela estava **meia** triste.*
- Advérbio (invariável): *Está **meio** cansada.* (um pouco)', '[{"question": "Qual está CORRETO?", "options": ["Segue anexo as fotos", "Seguem anexas as fotos"], "correct": 1}, {"question": "Menas pessoas?", "options": ["Correto", "Incorreto - menos é invariável"], "correct": 1}, {"question": "Ela está meia ou meio cansada?", "options": ["Meia (concorda)", "Meio (advérbio invariável)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:01.822983');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (189, 'enem', 1, 4, 'Regência Verbal', 'Preposições corretas', '# Regência Verbal

## Verbos Importantes

| Verbo | Regência | Exemplo |
|-------|----------|---------|
| Assistir (ver) | a | Assisti **ao** filme |
| Visar (objetivar) | a | Visa **ao** sucesso |
| Obedecer | a | Obedeço **aos** pais |
| Preferir | a | Prefiro café **a** chá |
| Implicar | - | Implica mudanças |
| Namorar | - | Namorou Maria |
| Aspirar (desejar) | a | Aspiro **ao** cargo |

## Erros Comuns

❌ *Prefiro café **do que** chá.*
✅ *Prefiro café **a** chá.*

❌ *Namorei **com** ela.*
✅ *Namorei ela.*

❌ *Assisti **o** jogo.*
✅ *Assisti **ao** jogo.*', '[{"question": "Assistir (ver) pede qual preposição?", "options": ["Nenhuma", "A", "Em"], "correct": 1}, {"question": "Prefiro café... chá", "options": ["do que", "a", "que"], "correct": 1}, {"question": "Namorar usa preposição?", "options": ["Sim, com", "Não, é transitivo direto"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.822983');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (190, 'enem', 1, 5, 'Crase Definitiva', 'Domine a crase', '# Crase: Guia Completo

Crase = preposição A + artigo A = À

## USA-SE CRASE

1. **Antes de femininas com artigo**: Fui **à** escola.
2. **Expressões femininas**: à noite, à tarde, à vontade
3. **Horas determinadas**: Cheguei **às** 10h.

## NÃO USA-SE CRASE

1. **Antes de masculinas**: Fui a pé.
2. **Antes de verbos**: Começou a estudar.
3. **Antes de pronomes**: Referi-me a ela.

## Truque Infalível

Substitua por palavra masculina:
- Se aparecer **AO** → use crase
- Se aparecer **A** ou **O** → não use

*Fui à escola* → *Fui ao colégio* ✅', '[{"question": "Fui à pé ou a pé?", "options": ["à pé", "a pé (masculina)"], "correct": 1}, {"question": "Cheguei... 8 horas", "options": ["a", "às"], "correct": 1}, {"question": "Referi-me... aquela situação", "options": ["a", "àquela"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.822983');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (191, 'enem', 2, 1, 'Compreendendo a Proposta', 'Interpretar o tema', '# Competência 2: Compreensão do Tema

## O que é avaliado?
A capacidade de compreender a proposta e desenvolver o tema dissertativo-argumentativo.

## Elementos da Proposta
1. **Tema central** - O assunto principal
2. **Recorte temático** - A delimitação específica
3. **Textos motivadores** - Contextualização

## Erros Graves
| Erro | Consequência |
|------|-------------|
| Tangenciar o tema | Nota muito baixa |
| Fugir do tema | ZERO na C2 |
| Copiar motivadores | ZERO na redação |

## Como garantir boa nota
1. Leia a proposta 3 vezes
2. Identifique palavras-chave
3. Use motivadores como inspiração apenas', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Zero na C2", "Zero total"], "correct": 1}, {"question": "Copiar motivadores resulta em:", "options": ["Desconto", "Zero na C2", "Zero na redação"], "correct": 2}]', 3, 'free', 0, true, '2025-12-05 10:18:01.825288');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (192, 'enem', 2, 2, 'Repertório Sociocultural', 'Como usar referências', '# Repertório Sociocultural

## Tipos de Repertório

1. **Dados/Estatísticas**: IBGE, ONU, pesquisas
2. **Referências Históricas**: Fatos relevantes
3. **Citações**: Filósofos, sociólogos
4. **Obras**: Livros, filmes, músicas
5. **Leis**: Constituição, ECA

## Como usar corretamente

✅ **Legitimado** - Fontes confiáveis
✅ **Pertinente** - Relacionado ao tema
✅ **Produtivo** - Usado para argumentar

❌ Repertório "decoreba" sem conexão
❌ Citações inventadas
❌ Dados sem fonte', '[{"question": "Inventar citação de filósofo é:", "options": ["Permitido", "Fraude que pode zerar"], "correct": 1}, {"question": "Repertório deve ser:", "options": ["Só estatísticas", "Legitimado, pertinente e produtivo", "Só citações"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:01.825288');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (193, 'enem', 2, 3, 'Estrutura Dissertativa', 'Organização do texto', '# Estrutura Dissertativo-Argumentativa

## Estrutura Obrigatória

### INTRODUÇÃO (1 parágrafo)
- Contextualização do tema
- Apresentação da tese
- Indicação dos argumentos

### DESENVOLVIMENTO (2+ parágrafos)
- Um argumento por parágrafo
- Tópico frasal + Repertório + Análise

### CONCLUSÃO (1 parágrafo)
- Retomada da tese
- Proposta de intervenção

## Conectivos Essenciais
| Função | Conectivos |
|--------|-----------|
| Adicionar | Além disso, Ademais |
| Contrastar | Entretanto, Contudo |
| Concluir | Portanto, Logo |', '[{"question": "Quantos parágrafos mínimos no desenvolvimento?", "options": ["1", "2", "3"], "correct": 1}, {"question": "A introdução deve ter:", "options": ["Proposta de intervenção", "Tese e contextualização"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.825288');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (195, 'enem', 2, 5, 'Tema vs Assunto', 'Diferença crucial', '# Tema vs Assunto

## A diferença que te separa de 200

**Assunto**: Amplo, genérico
*Ex: Educação, Meio ambiente, Violência*

**Tema**: Específico, delimitado
*Ex: Desafios da educação inclusiva no Brasil contemporâneo*

## Como identificar o TEMA

1. Leia o comando da proposta
2. Identifique o RECORTE
3. Note as CONDIÇÕES (no Brasil, hoje, etc.)

## Exemplo Prático

**Proposta:** "A invisibilidade do trabalho doméstico no Brasil"

- **Assunto:** Trabalho doméstico
- **Tema:** A INVISIBILIDADE (recorte específico)

Erro: Falar só sobre trabalho doméstico sem abordar a invisibilidade.', '[{"question": "Tema é igual a assunto?", "options": ["Sim", "Não, tema é mais específico"], "correct": 1}, {"question": "Abordar só o assunto configura:", "options": ["Boa nota", "Tangenciamento"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.825288');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (196, 'enem', 3, 1, 'Tipos de Argumentos', 'Construindo argumentos sólidos', '# Tipos de Argumentos

## 1. Argumento de Autoridade
*"Segundo o sociólogo Zygmunt Bauman..."*

## 2. Argumento por Exemplificação
*"Um exemplo disso é a cidade de Curitiba, onde..."*

## 3. Argumento por Dados
*"Dados do IBGE mostram que 70%..."*

## 4. Argumento por Comparação
*"Diferentemente da Alemanha, o Brasil..."*

## 5. Argumento por Causa/Consequência
*"Isso ocorre porque... Resultando em..."*

## Estrutura do Parágrafo
1. Tópico frasal
2. Desenvolvimento
3. Repertório
4. Análise crítica
5. Fechamento', '[{"question": "Citar dados do IBGE é:", "options": ["Arg. de autoridade", "Arg. por dados", "Arg. por comparação"], "correct": 1}, {"question": "Tópico frasal serve para:", "options": ["Concluir", "Apresentar ideia principal"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:01.826825');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (197, 'enem', 3, 2, 'Análise Crítica', 'Desenvolvendo autoria', '# Análise Crítica

## O que diferencia nota 120 de 200?
A capacidade de INTERPRETAR, não só citar.

## Níveis de Análise

❌ **Básico**: *"O IBGE mostra que 11% são analfabetos."*

⚠️ **Intermediário**: *"...o que é um problema sério."*

✅ **Avançado**: *"...Esse dado revela uma falha sistêmica na educação básica, perpetuando o ciclo de exclusão social, uma vez que esses indivíduos têm acesso limitado ao mercado qualificado."*

## Fórmula
DADO + "isso revela/demonstra que" + INTERPRETAÇÃO + CONEXÃO COM TESE', '[{"question": "O que caracteriza análise crítica?", "options": ["Só citar dados", "Interpretar e relacionar"], "correct": 1}, {"question": "''Isso é ruim'' é boa análise?", "options": ["Sim", "Não, muito superficial"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.826825');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (198, 'enem', 3, 3, 'Falácias Argumentativas', 'Evitando erros de lógica', '# Falácias a Evitar

## 1. Generalização Apressada
❌ *"Todos os políticos são corruptos."*

## 2. Apelo à Emoção
❌ *"Pense nas criancinhas que sofrem..."*

## 3. Falsa Causa
❌ *"Depois que X aconteceu, veio Y, logo X causou Y."*

## 4. Ataque Pessoal (Ad Hominem)
❌ *"Fulano disse X, mas ele é corrupto, logo X é mentira."*

## 5. Falso Dilema
❌ *"Ou acabamos com a pobreza ou acabamos com a violência."*

## Como evitar?
- Base seus argumentos em FATOS
- Use LÓGICA, não emoção
- Considere NUANCES', '[{"question": "''Todos os jovens são assim'' é:", "options": ["Argumento válido", "Generalização apressada"], "correct": 1}, {"question": "Usar emoção é:", "options": ["Sempre bom", "Falácia se for único argumento"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:01.826825');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (199, 'enem', 3, 4, 'Progressão Argumentativa', 'Desenvolvendo o raciocínio', '# Progressão Argumentativa

## O que é?
O aprofundamento das ideias ao longo do texto.

## Como fazer?

### Parágrafo de Desenvolvimento

1. **Tópico Frasal** - Apresenta o argumento
2. **Explicação** - Desenvolve a ideia
3. **Repertório** - Prova com dados/citação
4. **Análise** - Interpreta criticamente
5. **Link** - Conecta à tese

## Exemplo

*Primeiramente, a negligência estatal contribui para o problema.* [Tópico]
*O Estado brasileiro falha em...*  [Explicação]
*Segundo dados do IPEA...*  [Repertório]
*Esse cenário revela a omissão...*  [Análise]
*perpetuando o problema discutido.*  [Link]', '[{"question": "Progressão argumentativa é:", "options": ["Repetir a mesma ideia", "Aprofundar o raciocínio"], "correct": 1}, {"question": "O link serve para:", "options": ["Iniciar novo assunto", "Conectar à tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.826825');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (200, 'enem', 3, 5, 'Projeto de Texto', 'Planejando antes de escrever', '# Projeto de Texto

## Por que planejar?
Evita tangenciamento e garante organização.

## Passo a Passo

### 1. Análise da Proposta (5 min)
- Identifique o TEMA exato
- Note o RECORTE específico

### 2. Brainstorm (5 min)
- Liste possíveis CAUSAS
- Liste possíveis CONSEQUÊNCIAS
- Anote REPERTÓRIOS que conhece

### 3. Seleção (5 min)
- Escolha 2 argumentos fortes
- Defina sua TESE
- Esboce a PROPOSTA

### 4. Estrutura
- INTRO: Contexto + Tese
- D1: Argumento 1 + Repertório
- D2: Argumento 2 + Repertório
- CONCLUSÃO: Retomada + Proposta', '[{"question": "Projeto de texto ajuda a evitar:", "options": ["Erros de português", "Tangenciamento e desorganização"], "correct": 1}, {"question": "Quantos argumentos são ideais?", "options": ["1 muito desenvolvido", "2 bem desenvolvidos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.826825');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (201, 'enem', 4, 1, 'Coesão Referencial', 'Evitando repetições', '# Coesão Referencial

## O que é?
Mecanismos para retomar elementos sem repetir.

## Tipos

### 1. Pronomes
*O Brasil tem problemas. **Ele** precisa melhorar.*

### 2. Sinônimos
*O Brasil tem problemas. **O país** precisa melhorar.*

### 3. Hiperônimos
*O cão fugiu. **O animal** foi encontrado.*

### 4. Elipse
*João estudou. [Ø] Passou no vestibular.*

## Exemplo Ruim vs Bom

❌ *O Brasil tem problemas. O Brasil precisa mudar. O Brasil é um país...*

✅ *O Brasil tem problemas. **O país** precisa mudar. **A nação** é capaz...*', '[{"question": "Substituir Brasil por ''o país'' é:", "options": ["Coesão sequencial", "Coesão referencial"], "correct": 1}, {"question": "Por que evitar repetições?", "options": ["Estética apenas", "Melhor fluidez e nota"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:01.828363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (202, 'enem', 4, 2, 'Conectivos Essenciais', 'Ligando as ideias', '# Conectivos Essenciais

## Por Função

| Função | Conectivos |
|--------|-----------|
| Adição | além disso, ademais, outrossim |
| Oposição | entretanto, contudo, todavia, no entanto |
| Conclusão | portanto, logo, destarte, assim |
| Causa | pois, porque, uma vez que, visto que |
| Consequência | de modo que, de forma que |
| Tempo | posteriormente, em seguida, então |

## Erros Comuns

❌ Usar o mesmo conectivo várias vezes
❌ Usar conectivo que não combina com a ideia
❌ Não usar conectivos (texto solto)

## Dica de Ouro
Varie os conectivos! Se usou "além disso", use "ademais" depois.', '[{"question": "Ademais indica:", "options": ["Oposição", "Adição"], "correct": 1}, {"question": "Destarte indica:", "options": ["Conclusão", "Tempo"], "correct": 0}, {"question": "Todavia indica:", "options": ["Adição", "Oposição"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:01.828363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (504, 'ufc', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Destarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.966342');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (203, 'enem', 4, 3, 'Coesão entre Parágrafos', 'Amarrando o texto', '# Coesão entre Parágrafos

## Como conectar parágrafos?

### 1. Retomada
*"**Esse problema** mencionado..."* (retoma anterior)

### 2. Adição
*"**Além desse aspecto**, cabe ressaltar..."*

### 3. Contraste
*"**Em contrapartida**, observa-se..."*

### 4. Consequência
*"**Em decorrência disso**..."*

## Modelo de Transição

**Final do D1:** *...perpetuando desigualdades.*

**Início do D2:** *Além dessa questão estrutural, a negligência do Estado...*

O "além dessa questão estrutural" conecta os dois parágrafos.', '[{"question": "''Esse problema'' serve para:", "options": ["Adicionar ideia nova", "Retomar parágrafo anterior"], "correct": 1}, {"question": "Parágrafos devem ter:", "options": ["Conexão entre si", "Ideias isoladas"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.828363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (204, 'enem', 4, 4, 'Operadores Argumentativos', 'Direcionando interpretação', '# Operadores Argumentativos

## Tipos

### 1. Ênfase
*Sobretudo, principalmente, especialmente*
*"O Estado deve atuar, **sobretudo** na educação."*

### 2. Atenuação
*Talvez, possivelmente, em certa medida*

### 3. Contraste
*No entanto, porém, todavia*

### 4. Conclusão
*Portanto, logo, assim, destarte*

### 5. Esclarecimento
*Ou seja, isto é, em outras palavras*

## Uso Estratégico
- Use ênfase no ponto mais importante
- Use atenuação em afirmações fortes
- Use esclarecimento para garantir clareza', '[{"question": "Sobretudo serve para:", "options": ["Atenuar", "Enfatizar"], "correct": 1}, {"question": "Ou seja serve para:", "options": ["Esclarecer", "Contrastar"], "correct": 0}]', 3, 'previous', 0, true, '2025-12-05 10:18:01.828363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (205, 'enem', 4, 5, 'Coesão Avançada', 'Técnicas de alto nível', '# Coesão Avançada

## Técnicas Sofisticadas

### 1. Encapsulamento
Resumir ideia anterior em um substantivo:
*"...o governo falha na saúde e educação. **Essa negligência** afeta milhões."*

### 2. Catáfora
Anunciar o que virá:
*"O problema é **este**: falta investimento."*

### 3. Antonímia
Usar opostos para contrastar:
*"Enquanto uns têm **excesso**, outros vivem na **escassez**."*

### 4. Paralelismo
Repetir estruturas:
*"Não basta **criar** leis, é preciso **fiscalizar** seu cumprimento e **punir** as violações."*

## Impacto na Nota
Coesão sofisticada = diferencial para nota 200!', '[{"question": "Encapsulamento é:", "options": ["Resumir ideia em substantivo", "Usar sinônimos apenas"], "correct": 0}, {"question": "Paralelismo melhora:", "options": ["Só estética", "Fluidez e argumentação"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.828363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (206, 'enem', 5, 1, 'Os 5 Elementos', 'Estrutura obrigatória', '# Os 5 Elementos da Proposta

## Obrigatórios para nota máxima

### 1. 👤 AGENTE
**Quem** executa? (Governo, MEC, Mídia, ONGs...)

### 2. 🎯 AÇÃO
**O que** será feito? (Criar, implementar, fiscalizar...)

### 3. 🔧 MODO/MEIO
**Como** será feito? (Por meio de, através de...)

### 4. 📋 DETALHAMENTO
**Especificação** (Onde, quando, com quem...)

### 5. 📌 FINALIDADE
**Para que** fazer? (A fim de, com objetivo de...)

## Modelo Completo

*"O **MEC** [agente] deve **criar campanhas** [ação] **por meio de parcerias com influenciadores** [modo] **nas redes sociais, semanalmente** [detalhamento], **a fim de conscientizar sobre fake news** [finalidade]."*', '[{"question": "Quantos elementos obrigatórios?", "options": ["3", "4", "5"], "correct": 2}, {"question": "Agente responde:", "options": ["O que fazer", "Quem faz"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:01.829987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (207, 'enem', 5, 2, 'Direitos Humanos', 'Evitando nota zero', '# Proposta e Direitos Humanos

## ⚠️ PODE ZERAR SUA REDAÇÃO

### ❌ Propostas PROIBIDAS:
1. Pena de morte
2. Tortura ou violência
3. Discriminação
4. Censura
5. Trabalho forçado

### ✅ Propostas ADEQUADAS:
1. Educação e conscientização
2. Políticas públicas inclusivas
3. Fiscalização e punição LEGAL
4. Apoio a vítimas
5. Integração social

## Exemplos

**Tema:** Violência contra mulheres

❌ *"Agressores devem ser linchados."*
✅ *"Aplicação rigorosa da Lei Maria da Penha."*', '[{"question": "Defender pena de morte:", "options": ["É permitido", "Pode zerar"], "correct": 1}, {"question": "Propor censura:", "options": ["É válido", "Viola liberdade de expressão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.829987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (208, 'enem', 5, 3, 'Coerência com Argumentos', 'Conectando conclusão', '# Coerência na Proposta

## A Proposta deve resolver o problema discutido!

### ❌ Incoerente

**Argumentou:** Falta de educação financeira nas escolas.
**Proposta:** "Investir mais em saúde."

### ✅ Coerente

**Argumentou:** Falta de educação financeira nas escolas.
**Proposta:** "MEC deve incluir educação financeira como disciplina obrigatória."

## Estrutura da Conclusão

1. Retomada da tese (1-2 linhas)
2. Proposta 1 → Ligada ao Argumento 1
3. Proposta 2 (opcional) → Ligada ao Arg. 2', '[{"question": "Proposta deve se relacionar a:", "options": ["Qualquer tema", "Argumentos desenvolvidos"], "correct": 1}, {"question": "Proposta genérica é suficiente?", "options": ["Sim", "Não, faltam elementos"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:01.829987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (209, 'enem', 5, 4, 'Agentes Específicos', 'Quem pode agir?', '# Escolhendo o Agente Correto

## Agentes Comuns

### Governo
- **Poder Executivo**: Ministérios, Prefeituras
- **Poder Legislativo**: Criar/modificar leis
- **Poder Judiciário**: Fiscalizar, punir

### Sociedade Civil
- **Mídia**: Campanhas, divulgação
- **ONGs**: Projetos sociais
- **Escolas**: Educação, formação
- **Empresas**: Responsabilidade social
- **Famílias**: Educação doméstica

## Dica de Ouro
Escolha agentes que PODEM agir sobre o problema!

**Problema ambiental** → Ministério do Meio Ambiente
**Problema educacional** → MEC, Escolas
**Problema de saúde** → Ministério da Saúde', '[{"question": "Para problemas educacionais, o melhor agente é:", "options": ["Ministério da Saúde", "MEC ou Escolas"], "correct": 1}, {"question": "ONGs podem ser agentes?", "options": ["Não", "Sim"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.829987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (210, 'enem', 5, 5, 'Proposta Nota 200', 'Exemplo completo', '# Construindo a Proposta Perfeita

## Checklist Final

☐ AGENTE específico e capaz
☐ AÇÃO concreta e realizável
☐ MODO/MEIO de execução claro
☐ DETALHAMENTO suficiente
☐ FINALIDADE conectada ao tema
☐ RESPEITA direitos humanos
☐ COERENTE com argumentos

## Exemplo Nota 200

**Tema:** Evasão escolar no Brasil

*"Portanto, medidas são necessárias. O **Ministério da Educação** [agente], em parceria com as secretarias estaduais, deve **implementar programas de bolsa-permanência** [ação] **por meio de transferência de renda condicionada à frequência** [modo], **destinados a famílias de baixa renda em todo território nacional** [detalhamento], **a fim de garantir que jovens em vulnerabilidade permaneçam na escola e concluam o ensino básico** [finalidade]."*', '[{"question": "Uma boa proposta deve ter:", "options": ["Apenas agente e ação", "Todos os 5 elementos"], "correct": 1}, {"question": "A proposta deve ser:", "options": ["Genérica", "Específica e detalhada"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:01.829987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (505, 'ufc', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.966342');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (211, 'fuvest', 1, 1, 'A Redação FUVEST', 'Entendendo a prova', '# A Redação da FUVEST

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
- Valoriza repertório literário', '[{"question": "A redação FUVEST exige proposta de intervenção?", "options": ["Sim", "Não"], "correct": 1}, {"question": "Qual a extensão recomendada?", "options": ["10-20 linhas", "20-30 linhas", "30-40 linhas"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:10.815026');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (212, 'fuvest', 1, 2, 'Interpretando a Coletânea', 'Como usar os textos de apoio', '# A Coletânea FUVEST

## O que é?
Conjunto de 3 a 5 textos de diferentes perspectivas sobre o tema.

## Estratégias de Leitura
1. **Primeira leitura:** Visão geral
2. **Segunda leitura:** Identificar argumentos
3. **Terceira leitura:** Encontrar conexões

## Como usar?
- NÃO copie trechos
- Parafraseie ideias
- Use como inspiração
- Dialogue com os textos

## Armadilhas
❌ Copiar frases literalmente
❌ Ignorar textos contraditórios
❌ Usar apenas um texto
✅ Sintetizar visões diferentes', '[{"question": "Pode copiar trechos da coletânea?", "options": ["Sim", "Não, deve parafrasear"], "correct": 1}, {"question": "Quantos textos deve usar da coletânea?", "options": ["Apenas 1", "Todos disponíveis", "Nenhum"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:10.815026');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (213, 'fuvest', 1, 3, 'Tese e Posicionamento', 'Defendendo seu ponto de vista', '# Construindo sua Tese

## O que é tese?
É sua opinião central sobre o tema, apresentada de forma clara e defensável.

## Características da boa tese
- Clara e específica
- Defensável com argumentos
- Não óbvia nem absurda
- Presente na introdução

## Exemplos

**Tema:** Limites da liberdade individual

❌ Ruim: "A liberdade é importante"
✅ Boa: "A liberdade individual encontra seu limite quando interfere no bem-estar coletivo"

## Como formular
1. Leia a coletânea
2. Identifique diferentes posições
3. Escolha um lado
4. Formule de forma assertiva', '[{"question": "A tese deve ser apresentada na:", "options": ["Introdução", "Conclusão", "Desenvolvimento"], "correct": 0}, {"question": "Uma boa tese é:", "options": ["Óbvia e simples", "Clara e defensável", "Vaga e genérica"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.815026');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (214, 'fuvest', 1, 4, 'Repertório Literário', 'O diferencial FUVEST', '# Usando Literatura na FUVEST

## Por que é importante?
A FUVEST valoriza referências às obras da lista obrigatória.

## Como usar literatura?
1. **Cite personagens:** "Assim como Capitu..."
2. **Relacione situações:** "Tal qual em Vidas Secas..."
3. **Analise criticamente:** Não apenas cite, interprete

## Obras versáteis
- **Machado de Assis:** Dom Casmurro, Memórias Póstumas
- **Fernando Pessoa:** Heterônimos e identidade
- **Clarice Lispector:** Busca interior
- **Guimarães Rosa:** Linguagem e sertão

## Exemplo de uso
**Tema:** Solidão moderna

*"Como Bentinho em Dom Casmurro, que se isolou em suas certezas obsessivas, a sociedade contemporânea frequentemente confunde solidão com autonomia..."*', '[{"question": "A FUVEST valoriza referências a:", "options": ["Filmes americanos", "Obras literárias da lista", "Músicas populares"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.815026');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (215, 'fuvest', 1, 5, 'Temas Filosóficos', 'Dominando a abstração', '# Temas Filosóficos na FUVEST

## Característica
A FUVEST frequentemente propõe temas abstratos e filosóficos.

## Temas recorrentes
- Liberdade vs. responsabilidade
- Indivíduo vs. sociedade
- Tradição vs. modernidade
- Natureza vs. cultura
- Aparência vs. essência

## Como abordar
1. **Concretize:** Use exemplos reais
2. **Historicize:** Contextualize no tempo
3. **Diversifique:** Diferentes áreas do conhecimento

## Estrutura recomendada
- Introdução: Definição + tese
- D1: Argumento histórico/filosófico
- D2: Argumento social/contemporâneo
- Conclusão: Síntese reflexiva', '[{"question": "Temas filosóficos devem ser abordados de forma:", "options": ["Apenas teórica", "Com exemplos concretos", "Superficial"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.815026');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (216, 'fuvest', 2, 1, 'Estrutura Dissertativa', 'Organizando seu texto', '# Estrutura da Dissertação FUVEST

## Modelo clássico
1. **Introdução** (5-7 linhas)
2. **Desenvolvimento 1** (7-10 linhas)
3. **Desenvolvimento 2** (7-10 linhas)
4. **Conclusão** (5-7 linhas)

## Diferencial FUVEST
- Permite mais liberdade estrutural
- Valoriza fluidez textual
- Menos rígida que ENEM

## Variações aceitas
- 3 parágrafos densos
- 5 parágrafos curtos
- Estrutura ensaística

O importante é a **coerência interna**.', '[{"question": "A FUVEST permite estrutura mais flexível que o ENEM?", "options": ["Sim", "Não"], "correct": 0}]', 3, 'free', 0, true, '2025-12-05 10:18:10.817357');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (217, 'fuvest', 2, 2, 'Introdução Impactante', 'Capturando a atenção', '# A Introdução FUVEST

## Elementos essenciais
1. Contextualização do tema
2. Apresentação da tese
3. Indicação do percurso

## Estratégias de abertura
- **Citação:** De filósofos ou autores
- **Pergunta:** Retórica instigante
- **Dado:** Estatística ou fato
- **Alusão:** Referência histórica/literária

## Exemplo
*"Em ''A República'', Platão já questionava os limites entre liberdade e ordem social. Milênios depois, essa tensão permanece no cerne das democracias contemporâneas, evidenciando que..."*', '[{"question": "A introdução deve conter:", "options": ["Apenas a tese", "Contextualização + tese", "Apenas exemplos"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:10.817357');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (449, 'unifap', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais complexo

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.908911');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (924, 'ufpa', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Porquanto'' indica:", "options": ["Oposição", "Causa"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.617701');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (218, 'fuvest', 2, 3, 'Parágrafos de Desenvolvimento', 'Construindo argumentos', '# Desenvolvimento FUVEST

## Estrutura do parágrafo
1. **Tópico frasal:** Ideia principal
2. **Fundamentação:** Argumento + evidência
3. **Análise:** Sua interpretação
4. **Conexão:** Link com a tese

## Tipos de argumento
- **Autoridade:** Citação de especialistas
- **Exemplificação:** Casos concretos
- **Comparação:** Paralelos históricos
- **Causa-consequência:** Relações lógicas

## Extensão ideal
7-10 linhas por parágrafo', '[{"question": "Um bom parágrafo começa com:", "options": ["Exemplo", "Tópico frasal", "Citação longa"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.817357');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (219, 'fuvest', 2, 4, 'Transições e Conectivos', 'Fluidez entre parágrafos', '# Conectando Ideias

## Importância
A FUVEST valoriza a fluidez textual - parágrafos devem dialogar.

## Conectivos por função

### Adição
- Além disso, ademais, outrossim

### Oposição
- Contudo, entretanto, não obstante

### Conclusão
- Portanto, destarte, assim sendo

### Explicação
- Ou seja, isto é, em outras palavras

## Técnica avançada
Retome palavras-chave do parágrafo anterior no início do próximo.', '[{"question": "Parágrafos na FUVEST devem:", "options": ["Ser independentes", "Dialogar entre si", "Repetir informações"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.817357');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (572, 'ufes', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Havia'' é impessoal?", "options": ["Não", "Sim"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:41:56.985927');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (220, 'fuvest', 2, 5, 'Conclusão Reflexiva', 'Fechando com maestria', '# A Conclusão FUVEST

## Diferencial
Diferente do ENEM, não precisa de proposta de intervenção!

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Reflexão final ampliada

## Estratégias
- **Projeção futura:** Consequências possíveis
- **Questionamento:** Pergunta para reflexão
- **Alusão:** Retomar citação inicial
- **Síntese poética:** Frase de efeito

## Evite
❌ Iniciar com "Portanto, conclui-se que..."
❌ Introduzir ideias novas
❌ Repetir literalmente a introdução', '[{"question": "A conclusão FUVEST exige proposta de intervenção?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.817357');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (221, 'fuvest', 3, 1, 'Clareza e Precisão', 'Escrevendo com exatidão', '# Expressão Clara

## Princípios
- Uma ideia por período
- Vocabulário preciso
- Evitar ambiguidades

## Problemas comuns
❌ Períodos muito longos
❌ Palavras vagas ("coisa", "algo")
❌ Sujeito oculto em excesso

## Exemplo de revisão
❌ "Isso pode causar alguns problemas na sociedade"
✅ "Tal postura intensifica a desigualdade social"', '[{"question": "Expressão clara requer:", "options": ["Períodos longos", "Vocabulário preciso", "Repetição de ideias"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:10.819045');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (222, 'fuvest', 3, 2, 'Vocabulário Sofisticado', 'Ampliando seu léxico', '# Vocabulário FUVEST

## Substituições úteis
| Simples | Sofisticado |
|---------|-------------|
| Mostrar | Evidenciar |
| Fazer | Realizar, efetuar |
| Problema | Impasse, entrave |
| Importante | Crucial, fundamental |

## Cuidados
- Use apenas palavras que conhece bem
- Evite erudição forçada
- Priorize precisão sobre pompasidade

## Dica
Leia editoriais de jornais de qualidade para absorver vocabulário naturalmente.', '[{"question": "Vocabulário sofisticado deve ser:", "options": ["Forçado e pomposo", "Natural e preciso", "Repetitivo"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:10.819045');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (223, 'fuvest', 3, 3, 'Figuras de Linguagem', 'Enriquecendo o texto', '# Figuras de Linguagem

## Mais úteis para dissertação
- **Metáfora:** Comparação implícita
- **Antítese:** Oposição de ideias
- **Ironia:** Crítica sutil
- **Metonímia:** Substituição por associação

## Exemplos
*"O Planalto fechou os olhos..."* (metonímia)
*"Entre a tradição e a inovação..."* (antítese)

## Moderação
Use com parcimônia - excesso prejudica a clareza.', '[{"question": "Figuras de linguagem em dissertação devem:", "options": ["Ser abundantes", "Ser usadas com moderação", "Ser evitadas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.819045');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (224, 'fuvest', 3, 4, 'Variedade Sintática', 'Evitando monotonia', '# Variedade na Construção

## Tipos de período
- **Simples:** Uma oração
- **Composto por coordenação:** Orações independentes
- **Composto por subordinação:** Orações dependentes

## Técnica
Alterne tipos de período para criar ritmo.

## Exemplo
*"A liberdade é um valor fundamental. [simples] Contudo, quando exercida sem responsabilidade, ela se transforma em licenciosidade, o que prejudica o convívio social. [composto]"*', '[{"question": "Variedade sintática significa:", "options": ["Repetir estruturas", "Alternar tipos de período", "Usar apenas períodos curtos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.819045');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (450, 'unifap', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, INPE, ONU
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.908911');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (225, 'fuvest', 3, 5, 'Estilo Autoral', 'Desenvolvendo sua voz', '# Encontrando seu Estilo

## O que é estilo?
Sua forma única de expressar ideias - marca pessoal no texto.

## Como desenvolver
1. Leia muito e variado
2. Experimente diferentes abordagens
3. Revise e refine
4. Mantenha autenticidade

## Elementos de estilo
- Escolhas lexicais
- Ritmo das frases
- Tom (formal, reflexivo, crítico)
- Estratégias argumentativas preferidas

## FUVEST valoriza
Textos com personalidade, não apenas corretos.', '[{"question": "Estilo autoral é:", "options": ["Desnecessário", "Valorizado pela FUVEST", "Proibido em dissertação"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.819045');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (226, 'fuvest', 4, 1, 'Norma Culta', 'Dominando a gramática', '# Norma Culta na FUVEST

## Pontos críticos
1. **Concordância verbal e nominal**
2. **Regência verbal e nominal**
3. **Crase**
4. **Pontuação**

## Erros mais penalizados
- Concordância com sujeito composto
- Regência de verbos problemáticos
- Uso incorreto da vírgula

## Estratégia
Reserve os últimos 10 minutos para revisão gramatical.', '[{"question": "Qual é o erro mais penalizado?", "options": ["Vocabulário simples", "Erros de concordância", "Parágrafos curtos"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:10.820472');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (227, 'fuvest', 4, 2, 'Registros de Linguagem', 'Adequação ao contexto', '# Registro Formal

## Características
- Terceira pessoa
- Vocabulário culto
- Construções completas
- Ausência de gírias

## Evitar
❌ "A gente vê que..."
❌ "Tipo assim..."
❌ Contrações orais: "pra", "tá"

## Permitido com moderação
- Primeira pessoa do plural ("observamos")
- Perguntas retóricas', '[{"question": "Em dissertação formal, deve-se evitar:", "options": ["Terceira pessoa", "Gírias e contrações", "Vocabulário culto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:10.820472');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (228, 'fuvest', 4, 3, 'Pontução Avançada', 'Além da vírgula básica', '# Pontuação Sofisticada

## Ponto e vírgula
Separa orações coordenadas longas ou com vírgulas internas.

## Dois-pontos
Introduz explicação, citação ou enumeração.

## Travessão
Destaca informação - como este exemplo - no meio da frase.

## Exemplo integrado
*"A educação enfrenta dois desafios: a falta de investimento e a desvalorização profissional; ambos, entretanto - embora distintos -, têm raízes comuns."*', '[{"question": "Ponto e vírgula serve para:", "options": ["Terminar frases", "Separar orações coordenadas longas", "Substituir ponto final"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.820472');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (229, 'fuvest', 4, 4, 'Coesão Referencial', 'Retomando ideias', '# Retomada de Termos

## Estratégias
1. **Pronomes:** ele, isso, tal
2. **Sinônimos:** substituição lexical
3. **Hiperônimos:** termo mais geral
4. **Expressões:** "essa questão", "tal fenômeno"

## Evitar repetição
❌ "A tecnologia... A tecnologia... A tecnologia..."
✅ "A tecnologia... Ela... Esse avanço... Tal fenômeno..."', '[{"question": "Coesão referencial evita:", "options": ["Sinônimos", "Repetição excessiva", "Pronomes"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.820472');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (230, 'fuvest', 4, 5, 'Revisão Final', 'Polindo seu texto', '# Checklist de Revisão

## Conteúdo (5 min)
- [ ] Tese clara e defendida?
- [ ] Argumentos bem desenvolvidos?
- [ ] Coerência com a coletânea?

## Estrutura (3 min)
- [ ] Parágrafos equilibrados?
- [ ] Transições fluidas?
- [ ] Conclusão retoma a tese?

## Gramática (7 min)
- [ ] Concordâncias corretas?
- [ ] Pontuação adequada?
- [ ] Ortografia revisada?

## Dica de ouro
Leia em voz baixa para identificar problemas de ritmo.', '[{"question": "Quanto tempo dedicar à revisão?", "options": ["0 minutos", "5-15 minutos", "30 minutos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.820472');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (383, 'sisu', 3, 3, 'Projeto de Texto', 'Planejando antes', '# Projeto de Texto

## Por que planejar?
Evita tangenciamento e desorganização.

## Estrutura (5 min)
1. Identifique o tema
2. Defina a tese
3. Escolha 2 argumentos
4. Selecione repertório
5. Esboce a proposta

## Tempo SISU
90 min total → 5 min planejando', '[{"question": "Planejar leva:", "options": ["30 minutos", "5 minutos"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.225274');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (231, 'unicamp', 1, 1, 'A Redação UNICAMP', 'Entendendo o diferencial', '# A Redação UNICAMP

## O que a torna única?
- **2 propostas** diferentes (escolha 1)
- **Gêneros variados:** carta, artigo, manifesto, discurso
- **Interlocutor definido:** você escreve PARA alguém

## Gêneros mais cobrados
1. Carta argumentativa
2. Artigo de opinião
3. Manifesto
4. Texto de divulgação
5. Discurso

## Avaliação
A banca avalia se você domina o GÊNERO, não apenas a argumentação.', '[{"question": "A UNICAMP oferece quantas propostas?", "options": ["1", "2", "3"], "correct": 1}, {"question": "A UNICAMP cobra apenas dissertação?", "options": ["Sim", "Não"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:10.821993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (232, 'unicamp', 1, 2, 'Carta Argumentativa', 'O gênero mais frequente', '# Carta Argumentativa

## Estrutura obrigatória
1. **Local e data** (canto superior direito)
2. **Vocativo** (A quem se destina)
3. **Corpo** (Argumentação)
4. **Despedida formal**
5. **Assinatura** (nome fictício ou "X")

## Exemplo de abertura
*São Paulo, 5 de dezembro de 2024.*

*Prezado Secretário de Educação,*

*Venho por meio desta...*

## Tom
Formal, mas pessoal. Use primeira pessoa.', '[{"question": "Carta argumentativa precisa de local e data?", "options": ["Sim", "Não"], "correct": 0}]', 3, 'previous', 0, true, '2025-12-05 10:18:10.821993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (233, 'unicamp', 1, 3, 'Artigo de Opinião', 'Gênero jornalístico', '# Artigo de Opinião

## Características
- Publicado em jornal/revista
- **Título obrigatório**
- Autor se posiciona claramente
- Tom mais impessoal que carta

## Estrutura
1. **Título:** Chamativo e relacionado à tese
2. **Introdução:** Contexto + posição
3. **Desenvolvimento:** Argumentos
4. **Conclusão:** Proposta/reflexão

## Diferença da carta
- Artigo: público geral
- Carta: destinatário específico', '[{"question": "Artigo de opinião precisa de título?", "options": ["Sim", "Não"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.821993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (234, 'unicamp', 1, 4, 'Manifesto', 'Gênero de mobilização', '# O Manifesto

## O que é?
Texto de convocação que defende uma causa e chama à ação.

## Características
- **Tom:** Engajado, mobilizador
- **Linguagem:** Pode usar 1ª pessoa do plural
- **Estrutura:** Mais livre
- **Final:** Chamado à ação

## Elementos típicos
- Apresentação do problema
- Posicionamento claro
- Argumentos de convicção
- Convocação do leitor

## Exemplo de abertura
*"Nós, estudantes brasileiros, diante da crise educacional que nos acomete..."*', '[{"question": "Manifesto deve ter tom:", "options": ["Neutro e distante", "Engajado e mobilizador", "Acadêmico e formal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.821993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (451, 'unifap', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:48:38.910335');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (235, 'unicamp', 1, 5, 'Adaptação ao Interlocutor', 'Escrevendo para o leitor', '# Consciência do Interlocutor

## Por que importa?
A UNICAMP avalia se você ajusta a linguagem ao destinatário.

## Exemplos de adaptação

### Para autoridade
*"Vossa Excelência certamente reconhece..."*

### Para jovens
*"Como você, jovem leitor, já deve ter percebido..."*

### Para público geral
*"A sociedade brasileira enfrenta..."*

## Erro comum
❌ Esquecer o interlocutor no meio do texto
✅ Manter consistência até o final', '[{"question": "Adaptar ao interlocutor significa:", "options": ["Escrever sempre igual", "Ajustar linguagem ao destinatário", "Usar sempre linguagem formal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.821993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (236, 'unicamp', 2, 1, 'Objetivo do Texto', 'O que você quer alcançar', '# Propósito Comunicativo

## O que é?
O objetivo que você quer alcançar com seu texto.

## Propósitos comuns
- **Convencer:** Mudar opinião
- **Informar:** Transmitir conhecimento
- **Mobilizar:** Chamar à ação
- **Criticar:** Apontar problemas
- **Propor:** Sugerir soluções

## Importante
Seu propósito deve estar claro desde o início e mantido até o final.', '[{"question": "Propósito comunicativo é:", "options": ["O tema do texto", "O objetivo a alcançar", "A estrutura usada"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:10.823437');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (237, 'unicamp', 2, 2, 'Leitura da Proposta', 'Entendendo o que pedem', '# Interpretando a Proposta

## Elementos-chave
1. **Gênero:** Que tipo de texto?
2. **Interlocutor:** Para quem?
3. **Contexto:** Em que situação?
4. **Propósito:** Para quê?

## Exemplo de proposta
*"Escreva uma carta ao prefeito propondo melhorias no transporte público..."*

- Gênero: Carta
- Interlocutor: Prefeito
- Contexto: Problemas de mobilidade
- Propósito: Propor soluções', '[{"question": "Na proposta, identificamos:", "options": ["Apenas o tema", "Gênero, interlocutor, contexto e propósito", "Apenas o gênero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:10.823437');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (238, 'unicamp', 2, 3, 'Tom e Registro', 'Adequando a voz', '# Tom do Texto

## Variações
- **Formal:** Para autoridades
- **Engajado:** Para manifestos
- **Didático:** Para divulgação
- **Crítico:** Para artigos

## Registro
Nível de formalidade: coloquial, padrão ou erudito.

## Dica
O tom deve combinar com:
- O gênero
- O interlocutor
- O propósito', '[{"question": "O tom do texto deve combinar com:", "options": ["Apenas o tema", "Gênero, interlocutor e propósito", "Suas preferências pessoais"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.823437');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (239, 'unicamp', 2, 4, 'Estratégias de Persuasão', 'Convencendo o leitor', '# Persuasão Eficaz

## Técnicas
1. **Apelo à razão:** Dados, estatísticas
2. **Apelo à emoção:** Histórias, exemplos
3. **Apelo à ética:** Valores compartilhados
4. **Apelo à autoridade:** Especialistas

## Combinação
Os melhores textos combinam múltiplas estratégias.

## Exemplo
*"Segundo a OMS [autoridade], 40% dos jovens [dados] enfrentam ansiedade - imagine seu próprio filho [emoção] nessa situação..."*', '[{"question": "Persuasão eficaz usa:", "options": ["Apenas dados", "Múltiplas estratégias", "Apenas emoção"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.823437');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (240, 'unicamp', 2, 5, 'Coerência de Propósito', 'Mantendo o foco', '# Mantendo o Propósito

## Erro comum
Começar com um propósito e terminar com outro.

## Exemplo de incoerência
*Início: "Proponho melhorias..."*
*Fim: "Portanto, o problema é complexo..."*
❌ Prometeu propor, mas apenas analisou

## Checklist
- [ ] Propósito claro na introdução?
- [ ] Mantido no desenvolvimento?
- [ ] Cumprido na conclusão?', '[{"question": "Coerência de propósito significa:", "options": ["Mudar o objetivo", "Manter o foco do início ao fim", "Ter várias conclusões"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.823437');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (241, 'unicamp', 3, 1, 'Argumentação na UNICAMP', 'Especificidades', '# Argumentação UNICAMP

## Diferencial
A UNICAMP valoriza argumentação contextualizada no gênero.

## Tipos de argumento
- **Autoridade:** Citações, dados
- **Exemplificação:** Casos concretos
- **Causa-consequência:** Relações lógicas
- **Comparação:** Paralelos

## Importante
Adapte o estilo argumentativo ao gênero!
- Carta: Mais pessoal
- Artigo: Mais analítico
- Manifesto: Mais enfático', '[{"question": "Argumentação na UNICAMP deve ser:", "options": ["Sempre igual", "Adaptada ao gênero", "Apenas com dados"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:10.824874');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (486, 'ufba', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:05:53.194977');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (242, 'unicamp', 3, 2, 'Uso da Coletânea', 'Dialogando com os textos', '# Coletânea UNICAMP

## Função
Fornecer informações e perspectivas sobre o tema.

## Como usar
1. **Leia tudo:** Todos os textos
2. **Identifique:** Posições diferentes
3. **Não copie:** Parafraseie
4. **Dialogue:** Concorde ou discorde

## Erro grave
❌ Ignorar a coletânea
✅ Incorporar informações naturalmente', '[{"question": "A coletânea deve ser:", "options": ["Ignorada", "Usada e dialogada", "Copiada literalmente"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:10.824874');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (243, 'unicamp', 3, 3, 'Contra-argumentação', 'Fortalecendo sua posição', '# Contra-argumentação

## O que é?
Antecipar e refutar objeções à sua tese.

## Estrutura
1. Apresente objeção possível
2. Refute com argumentos
3. Reforce sua posição

## Exemplo
*"Poder-se-ia argumentar que... Entretanto, tal visão ignora que... Portanto, reafirma-se que..."*

## Benefício
Demonstra pensamento crítico e maturidade argumentativa.', '[{"question": "Contra-argumentação serve para:", "options": ["Enfraquecer sua tese", "Fortalecer sua posição", "Mudar de opinião"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.824874');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (244, 'unicamp', 3, 4, 'Repertório Sociocultural', 'Conhecimento de mundo', '# Repertório na UNICAMP

## O que conta?
- Fatos históricos
- Dados atuais
- Referências culturais
- Conhecimento científico

## Fontes
- Jornais de qualidade
- Documentários
- Livros não-ficção
- Debates públicos

## Dica
Colete exemplos versáteis que sirvam para múltiplos temas.', '[{"question": "Repertório inclui:", "options": ["Apenas literatura", "Conhecimentos variados", "Apenas dados estatísticos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.824874');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (245, 'unicamp', 3, 5, 'Progressão Argumentativa', 'Construindo raciocínio', '# Progressão no Texto

## O que é?
Cada parágrafo deve avançar a argumentação - não repetir.

## Estrutura progressiva
1. **Introdução:** Tese
2. **D1:** Primeiro argumento (mais simples)
3. **D2:** Segundo argumento (mais complexo)
4. **Conclusão:** Síntese e projeção

## Dica
Use conectivos de progressão: "além disso", "mais ainda", "sobretudo".', '[{"question": "Progressão significa:", "options": ["Repetir ideias", "Avançar a argumentação", "Voltar ao início"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.824874');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (246, 'unicamp', 4, 1, 'Linguagem por Gênero', 'Adaptando o registro', '# Linguagem e Gênero

## Carta argumentativa
- 1ª pessoa
- Vocativo adequado
- Tom respeitoso

## Artigo de opinião
- 3ª pessoa ou 1ª do plural
- Título chamativo
- Tom analítico

## Manifesto
- 1ª pessoa do plural
- Tom mobilizador
- Linguagem direta', '[{"question": "Carta usa qual pessoa?", "options": ["Sempre 3ª pessoa", "1ª pessoa", "Depende do tema"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 10:18:10.826394');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (247, 'unicamp', 4, 2, 'Adequação ao Interlocutor', 'Quem lê seu texto', '# Linguagem e Destinatário

## Para autoridades
- Pronomes de tratamento
- Linguagem formal
- Deferência adequada

## Para público jovem
- Linguagem acessível
- Exemplos contemporâneos
- Evitar excesso de formalidade

## Para público geral
- Clareza prioritária
- Evitar jargões
- Explicar termos técnicos', '[{"question": "Para autoridades usa-se:", "options": ["Gírias", "Pronomes de tratamento", "Linguagem coloquial"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:18:10.826394');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (248, 'unicamp', 4, 3, 'Coesão Textual', 'Conectando o texto', '# Coesão na UNICAMP

## Conectivos
- **Adição:** Além disso, outrossim
- **Oposição:** Contudo, não obstante
- **Conclusão:** Portanto, destarte
- **Explicação:** Ou seja, isto é

## Referenciação
- Pronomes
- Sinônimos
- Hiperônimos
- Elipse

## Dica
Varie os mecanismos de coesão.', '[{"question": "Coesão se faz com:", "options": ["Apenas conectivos", "Conectivos e referenciação", "Apenas repetição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.826394');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (249, 'unicamp', 4, 4, 'Gramática Essencial', 'Erros que custam nota', '# Revisão Gramatical

## Erros mais graves
1. **Concordância:** "Os alunos vai..."
2. **Regência:** "Assistir o filme..."
3. **Crase:** "Vou à mercado..."
4. **Pontuação:** Vírgula entre sujeito e verbo

## Estratégia
Reserve 10 minutos finais para revisão.

## Dica
Leia em voz baixa para identificar erros.', '[{"question": "Quanto tempo para revisão?", "options": ["0 minutos", "10 minutos", "30 minutos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.826394');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (250, 'unicamp', 4, 5, 'Revisão por Gênero', 'Checklist final', '# Checklist por Gênero

## Carta
- [ ] Local e data?
- [ ] Vocativo adequado?
- [ ] Despedida formal?
- [ ] Assinatura?

## Artigo
- [ ] Título presente?
- [ ] Fonte indicada?
- [ ] Tom adequado?

## Manifesto
- [ ] Causa clara?
- [ ] Convocação final?
- [ ] Tom engajado?', '[{"question": "Carta deve ter:", "options": ["Apenas texto", "Local, data, vocativo, despedida", "Título"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:18:10.826394');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (384, 'sisu', 3, 4, 'Análise Crítica', 'O diferencial', '# Análise Crítica

## O que diferencia
Não basta citar - é preciso ANALISAR.

## Níveis
❌ "O IBGE mostra que 11% são analfabetos."
⚠️ "...o que é um problema."
✅ "...revelando falha sistêmica que perpetua exclusão social."

## Fórmula
DADO + "isso revela/demonstra que" + INTERPRETAÇÃO', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar e relacionar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.225274');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (385, 'sisu', 3, 5, 'Checklist C3', 'Argumentação nota 200', '# Checklist C3

## Antes de finalizar
- [ ] Tese clara e defendida?
- [ ] 2+ argumentos desenvolvidos?
- [ ] Repertório diversificado?
- [ ] Análise crítica presente?
- [ ] Progressão entre parágrafos?

## Diferencial
Argumentação autoral = nota alta', '[{"question": "Autoria significa:", "options": ["Copiar bem", "Interpretar com originalidade"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 10:54:46.225274');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (386, 'sisu', 4, 1, 'Coesão Textual', 'Ligando as partes', '# C4: Coesão

## O que é avaliado
- Uso de conectivos
- Referenciação
- Fluidez entre parágrafos

## Impacto
Texto "solto" = nota baixa em C4', '[{"question": "Coesão avalia:", "options": ["Gramática apenas", "Conexão entre partes"], "correct": 1}]', 2, 'free', 0, true, '2025-12-05 10:54:46.226499');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (387, 'sisu', 4, 2, 'Conectivos Essenciais', 'O vocabulário da coesão', '# Conectivos por Função

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia, não obstante

## Conclusão
Portanto, logo, destarte, assim

## Causa
Porque, visto que, uma vez que, porquanto

## Consequência
De modo que, de forma que, por conseguinte', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.226499');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (388, 'sisu', 4, 3, 'Referenciação', 'Evitando repetição', '# Coesão Referencial

## Mecanismos
1. **Pronomes:** ele, isso, aquele
2. **Sinônimos:** "Brasil" → "o país"
3. **Hiperônimos:** termo mais geral
4. **Elipse:** omissão intencional

## Evite
❌ "O Brasil... O Brasil... O Brasil..."
✅ "O Brasil... O país... A nação..."', '[{"question": "Repetição excessiva:", "options": ["É boa", "Prejudica a nota"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 10:54:46.226499');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (421, 'ufal', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
- Intro: 20%
- Desenvolvimento: 60%
- Conclusão: 20%', '[{"question": "Desenvolvimento ocupa:", "options": ["40%", "60%"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:34:59.031695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (422, 'ufal', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização do tema
2. Apresentação do assunto
3. Tese clara

## Estratégias de abertura
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:34:59.031695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (423, 'ufal', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações e parágrafos
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.031695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (424, 'ufal', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave do anterior
2. Usar conectivo adequado
3. Fazer referência ao já dito

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão, a educação..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.031695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (425, 'ufal', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada sintética da tese
2. Síntese dos argumentos
3. Proposta ou reflexão final

## Evite
- Novas informações
- Repetir literalmente a introdução
- Frases genéricas como "conclui-se que"', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.031695');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (426, 'ufal', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes por redação.', '[{"question": "Quantos tipos de argumento usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:34:59.033425');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (427, 'ufal', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## O que diferencia notas altas
Não basta citar - é preciso ANALISAR.

## Níveis
❌ "O IBGE mostra que..."
⚠️ "...o que é um problema"
✅ "...revelando falha estrutural que perpetua exclusão"

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar dados"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:34:59.033425');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (428, 'ufal', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Todos os argumentos devem apoiar a tese.

## Problemas comuns
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta ao defendido

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados apenas", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.033425');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (429, 'ufal', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura sugerida
- D1: Argumento mais acessível
- D2: Argumento mais complexo

## Conectivos
- "Além disso..."
- "Soma-se a isso..."
- "Outrossim..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar ideias"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.033425');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (430, 'ufal', 3, 5, 'Repertório', 'Usando referências', '# Repertório Argumentativo

## Fontes confiáveis
- IBGE, IPEA, ONU
- Constituição Federal
- Autores reconhecidos
- Fatos históricos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.033425');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (431, 'ufal', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro isso do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:34:59.034632');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (432, 'ufal', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.
"Os alunos estudam" ✅

## Casos especiais
- Sujeito composto: verbo no plural
- Verbos impessoais: singular (havia, faz)

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Havia'' com sujeito plural:", "options": ["Haviam", "Havia (impessoal)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:34:59.034632');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (433, 'ufal', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A → Assisti AO filme
- Visar (objetivar): A → Visa AO sucesso
- Preferir: A → Prefiro café A chá

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Prefiro isso do que aquilo'' é:", "options": ["Correto", "Incorreto"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.034632');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (434, 'ufal', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens de lista
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.034632');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (435, 'ufal', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFAL

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:34:59.034632');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (436, 'unifap', 1, 1, 'A Redação UNIFAP', 'Conhecendo o vestibular', '# A Redação da UNIFAP

## Universidade Federal do Amapá
Localizada em Macapá, a UNIFAP é a principal universidade do estado.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Linguagem e norma culta

## Contexto Regional
O Amapá é um estado amazônico com rica biodiversidade.', '[{"question": "A UNIFAP está localizada em:", "options": ["Belém", "Macapá", "Manaus"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:48:38.905643');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (437, 'unifap', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Fugir do tema
❌ Tangenciar
❌ Copiar textos de apoio', '[{"question": "Tangenciar o tema é:", "options": ["Desenvolver bem", "Abordar parcialmente"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:48:38.905643');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (438, 'unifap', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Preservação da biodiversidade amazônica

❌ "A preservação é importante"
✅ "A biodiversidade amazônica demanda políticas integradas de preservação e desenvolvimento sustentável"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.905643');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (439, 'unifap', 1, 4, 'Temas Regionais', 'Contexto amazônico', '# Temas Relevantes

## Contexto Amapá/Amazônia
- Biodiversidade amazônica
- Povos indígenas e quilombolas
- Fronteira e geopolítica
- Recursos naturais
- Desenvolvimento sustentável

## Repertório Útil
- Floresta Amazônica
- Rio Amazonas
- Tratados ambientais
- Dados do INPE/IBAMA', '[{"question": "O Amapá faz fronteira com:", "options": ["Peru", "Guiana Francesa", "Colômbia"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.905643');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (440, 'unifap', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UNIFAP

## Tipos válidos
- Dados: IBGE, INPE, IBAMA
- Histórico: Formação do Amapá
- Ambiental: Biodiversidade
- Legal: Constituição, Código Florestal

## Conhecimentos regionais
- Território Federal até 1988
- Zona de fronteira
- Economia extrativista
- Riqueza mineral', '[{"question": "O Amapá virou estado em:", "options": ["1960", "1988", "2000"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.905643');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (441, 'unifap', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção ideal
Intro 20% | Desenvolvimento 60% | Conclusão 20%', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:48:38.907605');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (442, 'unifap', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:48:38.907605');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (443, 'unifap', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos são suficientes.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.907605');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (444, 'unifap', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.907605');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (445, 'unifap', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão final

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.907605');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (446, 'unifap', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:48:38.908911');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (447, 'unifap', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica a sociedade"
✅ Avançado: "Esse cenário revela falhas estruturais..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:48:38.908911');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (452, 'unifap', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Havia'' é impessoal?", "options": ["Não", "Sim"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:48:38.910335');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (453, 'unifap', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Prefiro café do que chá'' é:", "options": ["Correto", "Incorreto"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.910335');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (455, 'unifap', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UNIFAP

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:48:38.910335');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (456, 'ufam', 1, 1, 'A Redação UFAM', 'Conhecendo o vestibular', '# A Redação da UFAM

## Universidade Federal do Amazonas
Localizada em Manaus, a UFAM é a universidade mais antiga da Região Norte.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões regionais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e organização
3. Argumentação
4. Domínio da norma culta

## Contexto Regional
A UFAM valoriza conhecimentos sobre a Amazônia e questões socioambientais.', '[{"question": "A UFAM está localizada em:", "options": ["Belém", "Manaus", "Rio Branco"], "correct": 1}, {"question": "A UFAM é a mais antiga do:", "options": ["Brasil", "Região Norte", "Nordeste"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:56:29.20505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (457, 'ufam', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa
❌ Copiar textos de apoio', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:56:29.20505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (458, 'ufam', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução
- Retomada na conclusão

## Exemplo
**Tema:** Desenvolvimento sustentável na Amazônia

❌ "O desenvolvimento é importante"
✅ "O desenvolvimento sustentável amazônico requer equilíbrio entre preservação ambiental e geração de renda para comunidades locais"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.20505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (459, 'ufam', 1, 4, 'Temas Regionais', 'Contexto amazônico', '# Temas Relevantes para UFAM

## Contexto Amazônia
- Preservação florestal
- Rios e recursos hídricos
- Povos indígenas
- Zona Franca de Manaus
- Biodiversidade
- Mudanças climáticas

## Repertório Útil
- Floresta Amazônica
- Rio Amazonas e Negro
- INPA (pesquisa)
- Dados do INPE/IBAMA', '[{"question": "O Rio Negro encontra o Rio Solimões em:", "options": ["Belém", "Manaus", "Santarém"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.20505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (460, 'ufam', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFAM

## Tipos válidos
- Dados: IBGE, INPE, INPA
- Histórico: Ciclo da borracha
- Ambiental: Biodiversidade
- Econômico: Zona Franca

## Conhecimentos regionais
- Encontro das águas
- Teatro Amazonas
- Ciclo da borracha
- Indústria em Manaus
- Povos ribeirinhos', '[{"question": "O Teatro Amazonas é símbolo de:", "options": ["Ciclo do café", "Ciclo da borracha"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.20505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (461, 'ufam', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:56:29.207108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (462, 'ufam', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização do tema
2. Apresentação do assunto
3. Tese clara

## Estratégias de abertura
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:56:29.207108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (463, 'ufam', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos são ideais.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.207108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (464, 'ufam', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Todavia'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.207108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (465, 'ufam', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão final

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.207108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (466, 'ufam', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:56:29.208568');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (467, 'ufam', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## O que diferencia notas altas
Não basta citar - é preciso ANALISAR.

## Níveis
❌ "O INPE mostra que..."
⚠️ "...o que é preocupante"
✅ "...revelando necessidade urgente de políticas de proteção"

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:56:29.208568');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (468, 'ufam', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas comuns
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta ao defendido

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.208568');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (469, 'ufam', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura sugerida
- D1: Argumento mais simples
- D2: Argumento mais complexo

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.208568');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (470, 'ufam', 3, 5, 'Repertório Amazônico', 'Referências regionais', '# Repertório para UFAM

## Autores úteis
- Milton Hatoum (escritor amazonense)
- Thiago de Mello (poeta)
- Márcio Souza (escritor)

## Temas
- Encontro das águas
- Zona Franca
- Ciclo da borracha
- Boi-bumbá
- Ciência na Amazônia', '[{"question": "Milton Hatoum é:", "options": ["Cientista", "Escritor amazonense"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.208568');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (471, 'ufam', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 18:56:29.209932');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (472, 'ufam', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular (havia, faz)

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Faz dois anos'' é:", "options": ["Incorreto", "Correto (impessoal)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 18:56:29.209932');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (473, 'ufam', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A → Assisti AO jogo
- Visar (objetivar): A → Visa AO sucesso
- Preferir: A → Prefiro café A chá

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Namorar com ela'' é:", "options": ["Correto", "Incorreto (verbo direto)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.209932');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (474, 'ufam', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens de lista
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.209932');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (475, 'ufam', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFAM

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 18:56:29.209932');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (476, 'ufba', 1, 1, 'A Redação UFBA', 'Conhecendo o vestibular', '# A Redação da UFBA

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
A UFBA valoriza a cultura baiana e questões do Nordeste.', '[{"question": "A UFBA está localizada em:", "options": ["Recife", "Salvador", "Fortaleza"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:05:53.19205');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (477, 'ufba', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:05:53.19205');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (478, 'ufba', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desigualdade social no Brasil

❌ "A desigualdade é ruim"
✅ "A desigualdade social brasileira resulta de processos históricos de exclusão que demandam políticas públicas integradas"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.19205');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (479, 'ufba', 1, 4, 'Temas Regionais', 'Contexto baiano', '# Temas da Bahia/Nordeste

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
- Candomblé e sincretismo', '[{"question": "Jorge Amado é:", "options": ["Músico", "Escritor baiano"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.19205');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (480, 'ufba', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFBA

## Tipos válidos
- Dados: IBGE, IPEA
- Histórico: Formação do Brasil
- Literário: Autores baianos
- Cultural: Música, arte

## Autores baianos
- Jorge Amado (Gabriela, Capitães da Areia)
- Castro Alves (poeta abolicionista)
- João Ubaldo Ribeiro
- Música: Tropicália, axé', '[{"question": "Castro Alves foi poeta:", "options": ["Romântico", "Abolicionista"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.19205');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (481, 'ufba', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:05:53.193722');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (482, 'ufba', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:05:53.193722');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (483, 'ufba', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Contudo'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.193722');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (484, 'ufba', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão, a educação..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.193722');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (485, 'ufba', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.193722');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (488, 'ufba', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.194977');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (489, 'ufba', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais complexo

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.194977');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (490, 'ufba', 3, 5, 'Repertório Baiano', 'Referências regionais', '# Repertório para UFBA

## Autores úteis
- Jorge Amado
- Castro Alves
- Gilberto Gil / Caetano

## Temas culturais
- Carnaval e axé
- Candomblé
- Culinária baiana
- Pelourinho e história', '[{"question": "Gabriela, Cravo e Canela é de:", "options": ["Castro Alves", "Jorge Amado"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.194977');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (491, 'ufba', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:05:53.196318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (492, 'ufba', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Havia'' é impessoal?", "options": ["Não", "Sim"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:05:53.196318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (493, 'ufba', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Prefiro café do que chá'' é:", "options": ["Correto", "Incorreto"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.196318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (494, 'ufba', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.196318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (495, 'ufba', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFBA

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:05:53.196318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (496, 'ufc', 1, 1, 'A Redação UFC', 'Conhecendo o vestibular', '# A Redação da UFC

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
A UFC pode abordar temas do Nordeste e do Ceará.', '[{"question": "A UFC está localizada em:", "options": ["Recife", "Fortaleza", "Salvador"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:16:10.964505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (497, 'ufc', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:16:10.964505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (498, 'ufc', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Seca no Nordeste

❌ "A seca é um problema"
✅ "A seca nordestina demanda políticas públicas integradas de convivência com o semiárido, não apenas ações emergenciais"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.964505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (499, 'ufc', 1, 4, 'Temas Regionais', 'Contexto cearense', '# Temas do Ceará/Nordeste

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
- Transposição do São Francisco', '[{"question": "Rachel de Queiroz escreveu:", "options": ["O Quinze", "Vidas Secas"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.964505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (500, 'ufc', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFC

## Tipos válidos
- Dados: IBGE, IPEA
- Histórico: Formação do Nordeste
- Literário: Autores cearenses
- Cultural: Tradições populares

## Autores cearenses
- Rachel de Queiroz (O Quinze)
- Patativa do Assaré (cordel)
- José de Alencar (Iracema)
- Humor: Renato Aragão', '[{"question": "Patativa do Assaré é:", "options": ["Novelista", "Poeta popular"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.964505');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (501, 'ufc', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:16:10.966342');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (502, 'ufc', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:16:10.966342');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (503, 'ufc', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.966342');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (506, 'ufc', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:16:10.967454');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (507, 'ufc', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas estruturais..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:16:10.967454');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (508, 'ufc', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.967454');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (509, 'ufc', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais complexo

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.967454');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (510, 'ufc', 3, 5, 'Repertório Nordestino', 'Referências regionais', '# Repertório para UFC

## Autores úteis
- Rachel de Queiroz
- Patativa do Assaré
- José de Alencar

## Temas regionais
- Seca e semiárido
- Cultura popular
- Forró e tradições
- Artesanato', '[{"question": "Iracema é de:", "options": ["Machado de Assis", "José de Alencar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.967454');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (511, 'ufc', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:16:10.96873');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (512, 'ufc', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Faz dois anos'' é:", "options": ["Incorreto", "Correto (impessoal)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:16:10.96873');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (513, 'ufc', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Obedecer o pai'' é:", "options": ["Correto", "Incorreto (obedecer A)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.96873');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (514, 'ufc', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.96873');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (515, 'ufc', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFC

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:16:10.96873');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (516, 'unb', 1, 1, 'A Redação UnB', 'Conhecendo o vestibular', '# A Redação da UnB

## Universidade de Brasília
Localizada na capital federal, a UnB é uma das melhores universidades do país.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades, política, sociedade

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coerência
3. Argumentação
4. Domínio linguístico

## Diferencial
Por estar em Brasília, temas políticos e de gestão pública são frequentes.', '[{"question": "A UnB está localizada em:", "options": ["São Paulo", "Brasília", "Rio de Janeiro"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:28:09.716952');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (517, 'unb', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:28:09.716952');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (518, 'unb', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Reforma política no Brasil

❌ "A reforma é importante"
✅ "A reforma política brasileira deve priorizar a redução do número de partidos e o financiamento público de campanhas"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.716952');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (519, 'unb', 1, 4, 'Temas de Brasília', 'Contexto político', '# Temas Recorrentes na UnB

## Assuntos Frequentes
- Política e democracia
- Administração pública
- Federalismo
- Cidadania e direitos
- Corrupção e transparência

## Repertório Útil
- Constituição Federal
- Três Poderes
- História de Brasília
- Políticas públicas', '[{"question": "Brasília foi inaugurada em:", "options": ["1950", "1960", "1970"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.716952');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (554, 'udf', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.433124');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (520, 'unb', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UnB

## Tipos válidos
- Dados: IBGE, IPEA, TCU
- Histórico: República brasileira
- Legal: Constituição Federal
- Político: Teorias de Estado

## Pensadores úteis
- Sérgio Buarque de Holanda
- Raymundo Faoro
- Darcy Ribeiro (fundador da UnB)
- Celso Furtado', '[{"question": "Darcy Ribeiro foi:", "options": ["Presidente", "Fundador da UnB"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.716952');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (521, 'unb', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:28:09.718683');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (522, 'unb', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias para UnB
- Referência histórica
- Dado político/social
- Citação de pensadores
- Contexto constitucional', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:28:09.718683');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (523, 'unb', 2, 3, 'Coerência Textual', 'Sentido global', '# Coerência

## O que é?
Sentido global do texto - ideias conectadas logicamente.

## Problemas
❌ Contradição entre parágrafos
❌ Conclusão oposta à tese
❌ Argumentos desconexos

## Solução
Cada parte deve sustentar a tese.', '[{"question": "Coerência é:", "options": ["Gramática", "Sentido global"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.718683');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (524, 'unb', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Outrossim'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.718683');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (525, 'unb', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Para UnB
Propostas ligadas a políticas públicas são bem-vindas.

## Evite
- Novas informações
- Repetir a introdução', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.718683');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (526, 'unb', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Para UnB
Argumentos baseados em dados oficiais e legislação.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:28:09.720166');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (527, 'unb', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas institucionais..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:28:09.720166');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (528, 'unb', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.720166');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (529, 'unb', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais direto
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.720166');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (530, 'unb', 3, 5, 'Repertório Político', 'Referências para UnB', '# Repertório para UnB

## Autores úteis
- Sérgio Buarque de Holanda
- Raymundo Faoro
- Darcy Ribeiro
- Celso Furtado

## Temas
- Democracia
- Federalismo
- Políticas públicas
- Cidadania', '[{"question": "Raízes do Brasil é de:", "options": ["Darcy Ribeiro", "Sérgio Buarque de Holanda"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.720166');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (531, 'unb', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:28:09.721333');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (532, 'unb', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Fazem dois anos'' é:", "options": ["Correto", "Incorreto (faz)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:28:09.721333');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (533, 'unb', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Aspiro o cargo'' é:", "options": ["Correto", "Incorreto (aspirar A)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.721333');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (534, 'unb', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.721333');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (535, 'unb', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UnB

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:28:09.721333');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (536, 'udf', 1, 1, 'A Redação UDF', 'Conhecendo o vestibular', '# A Redação da UDF

## Centro Universitário do Distrito Federal
Localizada em Brasília, a UDF oferece cursos em diversas áreas.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Contexto
Como instituição do DF, pode abordar temas relacionados à capital federal.', '[{"question": "A UDF está localizada em:", "options": ["São Paulo", "Brasília", "Goiânia"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:35:06.427982');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (537, 'udf', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Fugir do tema
❌ Tangenciar
❌ Copiar textos de apoio', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota muito baixa"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:35:06.427982');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (538, 'udf', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Mobilidade urbana em Brasília

❌ "O trânsito é ruim"
✅ "A mobilidade urbana no DF demanda integração entre transporte público e alternativas sustentáveis"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.427982');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (539, 'udf', 1, 4, 'Temas Recorrentes', 'Contexto do DF', '# Temas Frequentes

## Assuntos do DF
- Mobilidade urbana
- Administração pública
- Desigualdade regional
- Meio ambiente (Cerrado)
- Educação

## Repertório Útil
- Constituição Federal
- História de Brasília
- Lucio Costa e Oscar Niemeyer
- Políticas públicas', '[{"question": "Brasília foi projetada por:", "options": ["Oscar Niemeyer apenas", "Lucio Costa e Oscar Niemeyer"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.427982');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (540, 'udf', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UDF

## Tipos válidos
- Dados: IBGE, CODEPLAN
- Histórico: Construção de Brasília
- Legal: Constituição
- Urbanístico: Plano Piloto

## Conhecimentos úteis
- Patrimônio da Humanidade (UNESCO)
- Cerrado
- Arquitetura modernista
- Três Poderes', '[{"question": "Brasília é Patrimônio da:", "options": ["OEA", "UNESCO"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.427982');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (541, 'udf', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:35:06.430228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (542, 'udf', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:35:06.430228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (543, 'udf', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.430228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (544, 'udf', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Todavia'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.430228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (545, 'udf', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.430228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (546, 'udf', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:35:06.431756');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (547, 'udf', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:35:06.431756');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (548, 'udf', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.431756');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (549, 'udf', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais direto
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.431756');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (550, 'udf', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, CODEPLAN
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.431756');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (551, 'udf', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:35:06.433124');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (552, 'udf', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Havia'' é impessoal?", "options": ["Não", "Sim"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:35:06.433124');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (553, 'udf', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Assistir o filme'' é:", "options": ["Correto", "Incorreto (assistir A)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.433124');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (555, 'udf', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UDF

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:35:06.433124');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (573, 'ufes', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Implicar em algo'' é:", "options": ["Correto", "Incorreto (implicar algo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.985927');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (556, 'ufes', 1, 1, 'A Redação UFES', 'Conhecendo o vestibular', '# A Redação da UFES

## Universidade Federal do Espírito Santo
Localizada em Vitória, a UFES é a principal universidade do estado.

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
A UFES pode abordar temas do Espírito Santo e região Sudeste.', '[{"question": "A UFES está localizada em:", "options": ["Belo Horizonte", "Vitória", "Rio de Janeiro"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:41:56.980943');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (557, 'ufes', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:41:56.980943');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (558, 'ufes', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Turismo sustentável no litoral

❌ "O turismo é importante"
✅ "O turismo sustentável no litoral capixaba demanda equilíbrio entre desenvolvimento econômico e preservação ambiental"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.980943');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (559, 'ufes', 1, 4, 'Temas Regionais', 'Contexto capixaba', '# Temas do Espírito Santo

## Assuntos Relevantes
- Economia (portos, mineração)
- Turismo litorâneo
- Imigração (italiana, alemã)
- Meio ambiente (Mata Atlântica)
- Desenvolvimento regional

## Repertório Útil
- Rubem Braga (escritor capixaba)
- Porto de Vitória
- Convento da Penha
- Imigração europeia', '[{"question": "Rubem Braga era:", "options": ["Pintor", "Cronista/escritor"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.980943');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (560, 'ufes', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFES

## Tipos válidos
- Dados: IBGE, IJSN
- Histórico: Colonização do ES
- Literário: Autores capixabas
- Econômico: Indústria e portos

## Conhecimentos úteis
- Rubem Braga
- Congo capixaba
- Paneleiras de Goiabeiras
- Moqueca capixaba', '[{"question": "Paneleiras de Goiabeiras são:", "options": ["Pescadoras", "Artesãs de barro"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.980943');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (561, 'ufes', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:41:56.983015');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (562, 'ufes', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:41:56.983015');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (563, 'ufes', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Entretanto'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.983015');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (564, 'ufes', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão, o aspecto..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.983015');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (565, 'ufes', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.983015');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (566, 'ufes', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:41:56.984489');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (567, 'ufes', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:41:56.984489');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (568, 'ufes', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.984489');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (569, 'ufes', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.984489');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (570, 'ufes', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, IJSN
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.984489');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (571, 'ufes', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:41:56.985927');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (574, 'ufes', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.985927');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (575, 'ufes', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFES

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:41:56.985927');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (576, 'ufg', 1, 1, 'A Redação UFG', 'Conhecendo o vestibular', '# A Redação da UFG

## Universidade Federal de Goiás
Localizada em Goiânia, a UFG é a principal universidade do Centro-Oeste.

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
A UFG pode abordar temas do Cerrado e Centro-Oeste.', '[{"question": "A UFG está localizada em:", "options": ["Brasília", "Goiânia", "Cuiabá"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:49:01.878223');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (577, 'ufg', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:49:01.878223');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (578, 'ufg', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Agronegócio e sustentabilidade

❌ "O agronegócio é importante"
✅ "O agronegócio brasileiro precisa conciliar produtividade e preservação ambiental para garantir desenvolvimento sustentável"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.878223');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (579, 'ufg', 1, 4, 'Temas Regionais', 'Contexto goiano', '# Temas de Goiás/Centro-Oeste

## Assuntos Relevantes
- Agronegócio e agricultura
- Cerrado e preservação
- Desenvolvimento regional
- Recursos hídricos
- Cidades do agro

## Repertório Útil
- Bioma Cerrado
- Cora Coralina (poetisa)
- Goiânia: cidade planejada
- Hidrovia Tietê-Paraná', '[{"question": "Cora Coralina era:", "options": ["Cantora", "Poetisa goiana"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.878223');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (580, 'ufg', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFG

## Tipos válidos
- Dados: IBGE, EMBRAPA
- Ambiental: Cerrado
- Literário: Autores goianos
- Econômico: Agronegócio

## Conhecimentos úteis
- Cora Coralina
- Hugo de Carvalho Ramos
- Cerrado: "caixa d''água" do Brasil
- Chapadas e veredas', '[{"question": "O Cerrado é chamado de:", "options": ["Pulmão", "Caixa d''água do Brasil"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.878223');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (581, 'ufg', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:49:01.879805');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (582, 'ufg', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:49:01.879805');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (583, 'ufg', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.879805');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (584, 'ufg', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Porquanto'' indica:", "options": ["Oposição", "Causa"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.879805');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (585, 'ufg', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.879805');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (586, 'ufg', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:49:01.881106');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (587, 'ufg', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:49:01.881106');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (588, 'ufg', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.881106');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (589, 'ufg', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.881106');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (590, 'ufg', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, EMBRAPA
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.881106');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (591, 'ufg', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:49:01.882712');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (592, 'ufg', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Existem problemas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:49:01.882712');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (593, 'ufg', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir à escola'' tem crase?", "options": ["Não", "Sim"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.882712');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (594, 'ufg', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.882712');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (595, 'ufg', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFG

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:49:01.882712');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (596, 'ufma', 1, 1, 'A Redação UFMA', 'Conhecendo o vestibular', '# A Redação da UFMA

## Universidade Federal do Maranhão
Localizada em São Luís, a UFMA é a principal universidade do estado.

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
São Luís é Patrimônio da Humanidade - temas culturais são frequentes.', '[{"question": "A UFMA está localizada em:", "options": ["Teresina", "São Luís", "Fortaleza"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:54:33.30818');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (597, 'ufma', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:54:33.30818');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (598, 'ufma', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Preservação do patrimônio histórico

❌ "A preservação é importante"
✅ "A preservação do patrimônio histórico de São Luís demanda políticas que conciliem turismo e manutenção da identidade cultural"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.30818');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (599, 'ufma', 1, 4, 'Temas Regionais', 'Contexto maranhense', '# Temas do Maranhão

## Assuntos Relevantes
- Patrimônio histórico (São Luís)
- Bumba-meu-boi
- Lençóis Maranhenses
- Desenvolvimento regional
- Cultura afro-brasileira

## Repertório Útil
- Ferreira Gullar (poeta)
- Gonçalves Dias (poeta romântico)
- Centro histórico de São Luís
- Reggae maranhense', '[{"question": "Gonçalves Dias escreveu:", "options": ["Canção do Exílio", "Vidas Secas"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.30818');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (600, 'ufma', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFMA

## Tipos válidos
- Dados: IBGE, IMESC
- Histórico: Colonização do MA
- Literário: Autores maranhenses
- Cultural: Festas populares

## Autores maranhenses
- Gonçalves Dias
- Ferreira Gullar
- Josué Montello
- Aluísio Azevedo', '[{"question": "Ferreira Gullar era:", "options": ["Pintor", "Poeta maranhense"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.30818');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (601, 'ufma', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:54:33.31028');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (602, 'ufma', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:54:33.31028');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (603, 'ufma', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.31028');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (604, 'ufma', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.31028');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (605, 'ufma', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.31028');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (606, 'ufma', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:54:33.31175');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (607, 'ufma', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:54:33.31175');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (608, 'ufma', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.31175');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (609, 'ufma', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.31175');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (610, 'ufma', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, IMESC
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.31175');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (611, 'ufma', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 19:54:33.313444');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (612, 'ufma', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Há problemas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 19:54:33.313444');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (613, 'ufma', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Chegar em casa'' é:", "options": ["Correto", "Incorreto (chegar A)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.313444');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (614, 'ufma', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.313444');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (615, 'ufma', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFMA

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 19:54:33.313444');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (616, 'ufmt', 1, 1, 'A Redação UFMT', 'Conhecendo o vestibular', '# A Redação da UFMT

## Universidade Federal de Mato Grosso
Localizada em Cuiabá, a UFMT é a principal universidade do estado.

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
Mato Grosso: agronegócio e Pantanal.', '[{"question": "A UFMT está localizada em:", "options": ["Campo Grande", "Cuiabá", "Goiânia"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 20:02:28.881545');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (617, 'ufmt', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 20:02:28.881545');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (618, 'ufmt', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Preservação do Pantanal

❌ "O Pantanal é importante"
✅ "A preservação do Pantanal demanda equilíbrio entre atividade pecuária e conservação da biodiversidade"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.881545');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (619, 'ufmt', 1, 4, 'Temas Regionais', 'Contexto mato-grossense', '# Temas de Mato Grosso

## Assuntos Relevantes
- Pantanal e biodiversidade
- Agronegócio e sustentabilidade
- Queimadas e desmatamento
- Povos indígenas
- Recursos hídricos

## Repertório Útil
- Bioma Pantanal
- Onça-pintada
- Chapada dos Guimarães
- Economia agrícola', '[{"question": "O Pantanal é:", "options": ["Floresta", "Maior planície alagável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.881545');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (620, 'ufmt', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFMT

## Tipos válidos
- Dados: IBGE, EMBRAPA
- Ambiental: Pantanal, Cerrado
- Econômico: Agronegócio
- Cultural: Povos tradicionais

## Conhecimentos úteis
- Pantanal: Patrimônio Natural
- Fauna: onça, tuiuiú
- Economia: soja, gado
- Chapada dos Guimarães', '[{"question": "A ave símbolo do Pantanal é:", "options": ["Arara", "Tuiuiú"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.881545');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (621, 'ufmt', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 20:02:28.883675');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (622, 'ufmt', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 20:02:28.883675');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (623, 'ufmt', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.883675');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (624, 'ufmt', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Todavia'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.883675');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (625, 'ufmt', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.883675');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (626, 'ufmt', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 20:02:28.885102');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (627, 'ufmt', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 20:02:28.885102');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (628, 'ufmt', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.885102');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (629, 'ufmt', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.885102');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (630, 'ufmt', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, EMBRAPA
- Constituição Federal
- Dados ambientais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.885102');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (631, 'ufmt', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 20:02:28.886527');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (632, 'ufmt', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Existe problemas'' é:", "options": ["Correto", "Incorreto (existem)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 20:02:28.886527');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (633, 'ufmt', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''A partir de'' tem crase?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.886527');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (634, 'ufmt', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.886527');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (635, 'ufmt', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFMT

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:02:28.886527');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (636, 'ufms', 1, 1, 'A Redação UFMS', 'Conhecendo o vestibular', '# A Redação da UFMS

## Universidade Federal de Mato Grosso do Sul
Localizada em Campo Grande, a UFMS é a principal universidade do estado.

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
MS: Pantanal, fronteira com Paraguai e Bolívia.', '[{"question": "A UFMS está localizada em:", "options": ["Cuiabá", "Campo Grande", "Goiânia"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 20:08:55.174422');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (637, 'ufms', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 20:08:55.174422');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (638, 'ufms', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Fronteiras e integração regional

❌ "As fronteiras são importantes"
✅ "A integração fronteiriça entre Brasil, Paraguai e Bolívia exige políticas que conciliem segurança e desenvolvimento econômico"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.174422');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (639, 'ufms', 1, 4, 'Temas Regionais', 'Contexto sul-mato-grossense', '# Temas de Mato Grosso do Sul

## Assuntos Relevantes
- Pantanal e biodiversidade
- Fronteira (Paraguai, Bolívia)
- Agronegócio
- Povos indígenas
- Integração regional

## Repertório Útil
- Pantanal sul
- Bonito (ecoturismo)
- Serra da Bodoquena
- Fronteira seca', '[{"question": "MS faz fronteira com:", "options": ["Argentina", "Paraguai e Bolívia"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.174422');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (640, 'ufms', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFMS

## Tipos válidos
- Dados: IBGE, SEMADE
- Ambiental: Pantanal, Cerrado
- Econômico: Agronegócio
- Cultural: Tradições locais

## Conhecimentos úteis
- Manoel de Barros (poeta)
- Pantanal: turismo
- Bonito: ecoturismo
- Tereré (bebida típica)', '[{"question": "Manoel de Barros era:", "options": ["Cantor", "Poeta sul-mato-grossense"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.174422');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (641, 'ufms', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 20:08:55.176522');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (642, 'ufms', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 20:08:55.176522');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (643, 'ufms', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Outrossim'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.176522');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (644, 'ufms', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.176522');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (645, 'ufms', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.176522');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (646, 'ufms', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 20:08:55.177824');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (647, 'ufms', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 20:08:55.177824');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (648, 'ufms', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.177824');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (649, 'ufms', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.177824');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (650, 'ufms', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, SEMADE
- Constituição Federal
- Dados ambientais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.177824');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (651, 'ufms', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 20:08:55.179131');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (652, 'ufms', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Faz anos'' é impessoal?", "options": ["Não", "Sim"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 20:08:55.179131');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (653, 'ufms', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a pé'' tem crase?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.179131');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (654, 'ufms', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.179131');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (655, 'ufms', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFMS

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 20:08:55.179131');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (916, 'ufpa', 1, 1, 'A Redação UFPA', 'Conhecendo o vestibular', '# A Redação da UFPA

## Universidade Federal do Pará
Localizada em Belém, a UFPA é a maior universidade da Amazônia.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões regionais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Contexto Amazônico
A UFPA valoriza conhecimentos sobre a região Norte.', '[{"question": "A UFPA está localizada em:", "options": ["Manaus", "Belém", "Macapá"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:01:27.615373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (917, 'ufpa', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:01:27.615373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (918, 'ufpa', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desenvolvimento sustentável na Amazônia

❌ "A Amazônia é importante"
✅ "O desenvolvimento sustentável amazônico requer integração entre preservação ambiental e geração de renda para comunidades ribeirinhas"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.615373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (919, 'ufpa', 1, 4, 'Temas Regionais', 'Contexto paraense', '# Temas do Pará/Amazônia

## Assuntos Relevantes
- Floresta Amazônica
- Povos ribeirinhos e indígenas
- Mineração (Carajás)
- Hidrelétricas (Belo Monte)
- Cultura paraense

## Repertório Útil
- Círio de Nazaré
- Ver-o-Peso
- Carimbó
- Açaí e gastronomia', '[{"question": "O Círio de Nazaré é:", "options": ["Festa junina", "Maior procissão católica do Brasil"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.615373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (920, 'ufpa', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFPA

## Tipos válidos
- Dados: IBGE, INPE
- Ambiental: Amazônia
- Literário: Autores paraenses
- Cultural: Tradições locais

## Autores paraenses
- Dalcídio Jurandir
- Benedito Monteiro
- Bruno de Menezes
- Música: Brega paraense', '[{"question": "Dalcídio Jurandir era:", "options": ["Pintor", "Escritor paraense"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.615373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (921, 'ufpa', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:01:27.617701');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (922, 'ufpa', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:01:27.617701');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (923, 'ufpa', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.617701');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (925, 'ufpa', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.617701');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (926, 'ufpa', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:01:27.619154');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (927, 'ufpa', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:01:27.619154');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (928, 'ufpa', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.619154');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (929, 'ufpa', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.619154');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (930, 'ufpa', 3, 5, 'Repertório Amazônico', 'Referências regionais', '# Repertório para UFPA

## Fontes confiáveis
- IBGE, INPE, INPA
- Dados ambientais
- Constituição Federal

## Conhecimentos locais
- Círio de Nazaré
- Ver-o-Peso
- Ilha de Marajó
- Carajás (mineração)', '[{"question": "Ver-o-Peso é:", "options": ["Museu", "Mercado tradicional de Belém"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.619154');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (931, 'ufpa', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:01:27.620623');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (932, 'ufpa', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Há problemas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:01:27.620623');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (933, 'ufpa', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Referir-se a algo'' tem crase?", "options": ["Sim", "Depende"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.620623');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (934, 'ufpa', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.620623');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (935, 'ufpa', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFPA

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:27.620623');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (936, 'ufpb', 1, 1, 'A Redação UFPB', 'Conhecendo o vestibular', '# A Redação da UFPB

## Universidade Federal da Paraíba
Localizada em João Pessoa, a UFPB é a principal universidade do estado.

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
A UFPB pode abordar temas do Nordeste e cultura paraibana.', '[{"question": "A UFPB está localizada em:", "options": ["Recife", "João Pessoa", "Natal"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:01:41.49953');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (937, 'ufpb', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:01:41.49953');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (938, 'ufpb', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Turismo no litoral nordestino

❌ "O turismo é importante"
✅ "O desenvolvimento turístico do litoral paraibano requer equilíbrio entre crescimento econômico e preservação ambiental"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.49953');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (939, 'ufpb', 1, 4, 'Temas Regionais', 'Contexto paraibano', '# Temas da Paraíba/Nordeste

## Assuntos Relevantes
- Seca e semiárido
- Turismo litorâneo
- Cultura popular
- Desenvolvimento regional
- Forró e São João

## Repertório Útil
- Ariano Suassuna
- Jackson do Pandeiro
- Augusto dos Anjos
- Maior São João do Mundo', '[{"question": "Ariano Suassuna era:", "options": ["Cantor", "Escritor paraibano"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.49953');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (940, 'ufpb', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFPB

## Tipos válidos
- Dados: IBGE, SUDENE
- Histórico: Formação do NE
- Literário: Autores paraibanos
- Cultural: Tradições locais

## Autores paraibanos
- Ariano Suassuna
- Augusto dos Anjos
- José Américo de Almeida
- Música: Elba Ramalho', '[{"question": "Augusto dos Anjos escreveu:", "options": ["O Auto da Compadecida", "Eu e Outras Poesias"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.49953');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (941, 'ufpb', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:01:41.502853');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (942, 'ufpb', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:01:41.502853');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (943, 'ufpb', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.502853');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (944, 'ufpb', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.502853');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (945, 'ufpb', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.502853');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (946, 'ufpb', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:01:41.504306');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (947, 'ufpb', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:01:41.504306');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (948, 'ufpb', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.504306');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (949, 'ufpb', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.504306');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (950, 'ufpb', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, SUDENE
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.504306');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (951, 'ufpb', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:01:41.505798');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (952, 'ufpb', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Existe problemas'' é:", "options": ["Correto", "Incorreto (existem)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:01:41.505798');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (953, 'ufpb', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir à praia'' tem crase?", "options": ["Não", "Sim"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.505798');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (954, 'ufpb', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.505798');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (955, 'ufpb', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFPB

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:01:41.505798');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1016, 'ufpr', 1, 1, 'A Redação UFPR', 'Conhecendo o vestibular', '# A Redação da UFPR

## Universidade Federal do Paraná
Localizada em Curitiba, a UFPR é a mais antiga universidade federal do Brasil.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Diferencial
UFPR: primeira federal do Brasil (1912).', '[{"question": "A UFPR está localizada em:", "options": ["Porto Alegre", "Curitiba", "Florianópolis"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:23:42.626819');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1017, 'ufpr', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:23:42.626819');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1018, 'ufpr', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Sustentabilidade urbana

❌ "A sustentabilidade é importante"
✅ "O modelo de urbanização curitibano demonstra que planejamento integrado de transporte e áreas verdes pode conciliar desenvolvimento e qualidade de vida"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.626819');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1019, 'ufpr', 1, 4, 'Temas Regionais', 'Contexto paranaense', '# Temas do Paraná/Sul

## Assuntos Relevantes
- Urbanização de Curitiba
- Agronegócio (soja, trigo)
- Imigração europeia
- Meio ambiente (Araucárias)
- Cooperativismo

## Repertório Útil
- Dalton Trevisan (escritor)
- Paulo Leminski (poeta)
- Curitiba: modelo urbano
- Cataratas do Iguaçu', '[{"question": "Paulo Leminski era:", "options": ["Pintor", "Poeta curitibano"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.626819');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1020, 'ufpr', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFPR

## Tipos válidos
- Dados: IBGE, IPARDES
- Histórico: Imigração no Sul
- Literário: Autores paranaenses
- Urbanístico: Curitiba

## Autores paranaenses
- Dalton Trevisan
- Paulo Leminski
- Helena Kolody
- Emiliano Perneta', '[{"question": "Dalton Trevisan é conhecido como:", "options": ["Poeta maldito", "Vampiro de Curitiba"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.626819');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1021, 'ufpr', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:23:42.628883');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1022, 'ufpr', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:23:42.628883');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1023, 'ufpr', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.628883');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1024, 'ufpr', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Destarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.628883');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1025, 'ufpr', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.628883');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1026, 'ufpr', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:23:42.630378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1027, 'ufpr', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:23:42.630378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1028, 'ufpr', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.630378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1029, 'ufpr', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.630378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1030, 'ufpr', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, IPARDES
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.630378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1031, 'ufpr', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:23:42.631916');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1032, 'ufpr', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve problemas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:23:42.631916');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1033, 'ufpr', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir à Curitiba'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.631916');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1034, 'ufpr', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.631916');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1035, 'ufpr', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFPR

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:23:42.631916');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1056, 'ufpi', 1, 1, 'A Redação UFPI', 'Conhecendo o vestibular', '# A Redação da UFPI

## Universidade Federal do Piauí
Localizada em Teresina, a UFPI é a principal universidade do estado.

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
A UFPI pode abordar temas do Piauí e Nordeste.', '[{"question": "A UFPI está localizada em:", "options": ["Fortaleza", "Teresina", "São Luís"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:46:42.184318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1057, 'ufpi', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:46:42.184318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1058, 'ufpi', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desenvolvimento do semiárido

❌ "O semiárido é difícil"
✅ "O desenvolvimento do semiárido piauiense requer políticas de convivência com a seca, não apenas ações emergenciais"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.184318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1059, 'ufpi', 1, 4, 'Temas Regionais', 'Contexto piauiense', '# Temas do Piauí

## Assuntos Relevantes
- Seca e semiárido
- Cerrado piauiense
- Parque Nacional Serra da Capivara
- Desenvolvimento regional
- Carnaúba e extrativismo

## Repertório Útil
- Serra da Capivara (patrimônio)
- Delta do Parnaíba
- Da Costa e Silva (poeta)
- Torquato Neto', '[{"question": "A Serra da Capivara tem:", "options": ["Praias", "Pinturas rupestres"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.184318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1060, 'ufpi', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFPI

## Tipos válidos
- Dados: IBGE, SUDENE
- Histórico: Formação do PI
- Ambiental: Caatinga e Cerrado
- Cultural: Tradições locais

## Autores piauienses
- Da Costa e Silva
- Torquato Neto
- H. Dobal
- Fontes Ibiapina', '[{"question": "Torquato Neto foi:", "options": ["Pintor", "Poeta tropicalista"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.184318');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1061, 'ufpi', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:46:42.186233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1062, 'ufpi', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:46:42.186233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1063, 'ufpi', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.186233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1064, 'ufpi', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Porquanto'' indica:", "options": ["Oposição", "Causa"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.186233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1065, 'ufpi', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.186233');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1066, 'ufpi', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:46:42.187823');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1067, 'ufpi', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:46:42.187823');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1068, 'ufpi', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.187823');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1069, 'ufpi', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.187823');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1070, 'ufpi', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, SUDENE
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.187823');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1071, 'ufpi', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:46:42.189363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1072, 'ufpi', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Existe soluções'' é:", "options": ["Correto", "Incorreto (existem)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:46:42.189363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1073, 'ufpi', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Teresina'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.189363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1074, 'ufpi', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.189363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1075, 'ufpi', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFPI

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:46:42.189363');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1076, 'ufrn', 1, 1, 'A Redação UFRN', 'Conhecendo o vestibular', '# A Redação da UFRN

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
A UFRN pode abordar temas do RN e Nordeste.', '[{"question": "A UFRN está localizada em:", "options": ["João Pessoa", "Natal", "Recife"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:56:08.959382');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1077, 'ufrn', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:56:08.959382');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1078, 'ufrn', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Turismo sustentável no litoral

❌ "O turismo é importante"
✅ "O turismo sustentável no litoral potiguar demanda políticas que conciliem desenvolvimento econômico e preservação ambiental"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.959382');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1079, 'ufrn', 1, 4, 'Temas Regionais', 'Contexto potiguar', '# Temas do Rio Grande do Norte

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
- Forte dos Reis Magos', '[{"question": "Câmara Cascudo era:", "options": ["Pintor", "Folclorista potiguar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.959382');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1080, 'ufrn', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFRN

## Tipos válidos
- Dados: IBGE, SUDENE
- Histórico: Formação do RN
- Literário: Autores potiguares
- Econômico: Turismo e energia

## Autores potiguares
- Câmara Cascudo
- Zila Mamede (poeta)
- Hélio Galvão
- Música: Sivuca', '[{"question": "O RN é líder em:", "options": ["Café", "Energia eólica"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.959382');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1081, 'ufrn', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:56:08.961308');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1082, 'ufrn', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:56:08.961308');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1083, 'ufrn', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Outrossim'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.961308');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1084, 'ufrn', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.961308');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1085, 'ufrn', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.961308');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1086, 'ufrn', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:56:08.96888');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1087, 'ufrn', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:56:08.96888');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1088, 'ufrn', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.96888');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1089, 'ufrn', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.96888');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1090, 'ufrn', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, SUDENE
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.96888');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1091, 'ufrn', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 21:56:08.978062');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1092, 'ufrn', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Fazem anos'' é:", "options": ["Correto", "Incorreto (faz anos)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 21:56:08.978062');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1093, 'ufrn', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Natal'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.978062');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1094, 'ufrn', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.978062');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1095, 'ufrn', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFRN

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 21:56:08.978062');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1096, 'ufrgs', 1, 1, 'A Redação UFRGS', 'Conhecendo o vestibular', '# A Redação da UFRGS

## Universidade Federal do Rio Grande do Sul
Localizada em Porto Alegre, a UFRGS é uma das melhores universidades do Brasil.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Diferencial
UFRGS: tradição de excelência acadêmica.', '[{"question": "A UFRGS está localizada em:", "options": ["Curitiba", "Porto Alegre", "Florianópolis"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:01:49.748128');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1097, 'ufrgs', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:01:49.748128');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1098, 'ufrgs', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Imigração e identidade cultural

❌ "A imigração é importante"
✅ "A imigração europeia no Rio Grande do Sul forjou uma identidade cultural que demanda preservação aliada à integração com a diversidade contemporânea"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.748128');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1099, 'ufrgs', 1, 4, 'Temas Regionais', 'Contexto gaúcho', '# Temas do Rio Grande do Sul

## Assuntos Relevantes
- Imigração (italiana, alemã)
- Cultura gaúcha
- Agronegócio
- Indústria e tecnologia
- Questões ambientais (Guaíba)

## Repertório Útil
- Erico Verissimo
- Mário Quintana
- Simões Lopes Neto
- Revolução Farroupilha', '[{"question": "Erico Verissimo escreveu:", "options": ["O Tempo e o Vento", "Vidas Secas"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.748128');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1100, 'ufrgs', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFRGS

## Tipos válidos
- Dados: IBGE, FEE
- Histórico: Formação do RS
- Literário: Autores gaúchos
- Cultural: Tradições locais

## Autores gaúchos
- Erico Verissimo
- Mário Quintana
- Simões Lopes Neto
- Caio Fernando Abreu', '[{"question": "Mário Quintana era:", "options": ["Pintor", "Poeta gaúcho"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.748128');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1101, 'ufrgs', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:01:49.749781');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1102, 'ufrgs', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:01:49.749781');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1103, 'ufrgs', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.749781');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1104, 'ufrgs', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Dessarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.749781');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1105, 'ufrgs', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.749781');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1106, 'ufrgs', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:01:49.751115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1107, 'ufrgs', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:01:49.751115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1108, 'ufrgs', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.751115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1109, 'ufrgs', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.751115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1110, 'ufrgs', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, FEE
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.751115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1111, 'ufrgs', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:01:49.752409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1112, 'ufrgs', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve problemas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:01:49.752409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1113, 'ufrgs', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir à Porto Alegre'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.752409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1114, 'ufrgs', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.752409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1115, 'ufrgs', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFRGS

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:01:49.752409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1132, 'unir', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Existe problemas'' é:", "options": ["Correto", "Incorreto (existem)"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:07:40.712155');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1116, 'unir', 1, 1, 'A Redação UNIR', 'Conhecendo o vestibular', '# A Redação da UNIR

## Universidade Federal de Rondônia
Localizada em Porto Velho, a UNIR é a principal universidade do estado.

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
Rondônia: fronteira agrícola e Amazônia.', '[{"question": "A UNIR está localizada em:", "options": ["Rio Branco", "Porto Velho", "Manaus"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:07:40.705867');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1117, 'unir', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:07:40.705867');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1118, 'unir', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desenvolvimento sustentável na Amazônia

❌ "O desenvolvimento é importante"
✅ "O desenvolvimento sustentável em Rondônia demanda equilíbrio entre expansão agropecuária e conservação da floresta amazônica"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.705867');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1119, 'unir', 1, 4, 'Temas Regionais', 'Contexto rondoniense', '# Temas de Rondônia

## Assuntos Relevantes
- Desmatamento e agropecuária
- Hidrelétricas (Jirau, Santo Antônio)
- Fronteira agrícola
- Povos indígenas
- BR-364 e colonização

## Repertório Útil
- Rio Madeira
- Ciclo da borracha
- Usinas hidrelétricas
- Migração sulista', '[{"question": "O Rio Madeira tem:", "options": ["Praias", "Usinas hidrelétricas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.705867');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1120, 'unir', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UNIR

## Tipos válidos
- Dados: IBGE, INPE
- Ambiental: Amazônia
- Histórico: Colonização
- Econômico: Agropecuária

## Conhecimentos úteis
- Ciclo da borracha
- Ferrovia Madeira-Mamoré
- Hidrelétricas do Madeira
- Fronteira agrícola', '[{"question": "A Madeira-Mamoré era:", "options": ["Rodovia", "Ferrovia histórica"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.705867');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1121, 'unir', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:07:40.709115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1122, 'unir', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:07:40.709115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1123, 'unir', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.709115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1124, 'unir', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.709115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1125, 'unir', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.709115');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1126, 'unir', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:07:40.710742');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1127, 'unir', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:07:40.710742');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1128, 'unir', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.710742');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1129, 'unir', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.710742');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1130, 'unir', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, INPE
- Constituição Federal
- Dados ambientais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.710742');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1131, 'unir', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:07:40.712155');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1133, 'unir', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Porto Velho'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.712155');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1134, 'unir', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.712155');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1135, 'unir', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UNIR

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:07:40.712155');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1136, 'uerr', 1, 1, 'A Redação UERR', 'Conhecendo o vestibular', '# A Redação da UERR

## Universidade Estadual de Roraima
Localizada em Boa Vista, a UERR é uma importante universidade do estado.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões regionais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Contexto Regional
Roraima: extremo norte, fronteiras internacionais.', '[{"question": "A UERR está localizada em:", "options": ["Manaus", "Boa Vista", "Macapá"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:13:20.775228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1137, 'uerr', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:13:20.775228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1138, 'uerr', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desenvolvimento fronteiriço

❌ "As fronteiras são importantes"
✅ "O desenvolvimento de Roraima demanda políticas de integração com Venezuela e Guiana que valorizem a soberania nacional"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.775228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1139, 'uerr', 1, 4, 'Temas Regionais', 'Contexto roraimense', '# Temas de Roraima

## Assuntos Relevantes
- Fronteira internacional
- Povos indígenas (Yanomami)
- Monte Roraima
- Imigração venezuelana
- Mineração ilegal

## Repertório Útil
- Monte Roraima (marco tríplice)
- Terra Yanomami
- Crise venezuelana
- Lavrado roraimense', '[{"question": "O Monte Roraima é:", "options": ["Vulcão", "Marco tríplice Brasil-Venezuela-Guiana"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.775228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1140, 'uerr', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UERR

## Tipos válidos
- Dados: IBGE, FUNAI
- Histórico: Colonização
- Ambiental: Amazônia e lavrado
- Social: Imigração

## Conhecimentos úteis
- Terra indígena Yanomami
- Imigração venezuelana
- Monte Roraima (tepui)
- Fronteira norte', '[{"question": "Os Yanomami são:", "options": ["Cidade", "Povo indígena"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.775228');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1141, 'uerr', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:13:20.777273');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1142, 'uerr', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:13:20.777273');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1143, 'uerr', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.777273');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1144, 'uerr', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Porquanto'' indica:", "options": ["Oposição", "Causa"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.777273');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1145, 'uerr', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.777273');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1146, 'uerr', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:13:20.778534');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1147, 'uerr', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:13:20.778534');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1148, 'uerr', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.778534');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1149, 'uerr', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.778534');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1150, 'uerr', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, FUNAI
- Constituição Federal
- Dados ambientais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.778534');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1151, 'uerr', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:13:20.780053');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1152, 'uerr', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve conflitos'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:13:20.780053');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1153, 'uerr', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Boa Vista'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.780053');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1154, 'uerr', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.780053');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1155, 'uerr', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UERR

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:13:20.780053');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1156, 'ufsc', 1, 1, 'A Redação UFSC', 'Conhecendo o vestibular', '# A Redação da UFSC

## Universidade Federal de Santa Catarina
Localizada em Florianópolis, a UFSC é uma das melhores universidades do Sul.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 20 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coesão
3. Argumentação
4. Domínio linguístico

## Diferencial
UFSC: excelência em pesquisa e inovação.', '[{"question": "A UFSC está localizada em:", "options": ["Curitiba", "Florianópolis", "Porto Alegre"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:19:11.98108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1157, 'ufsc', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:19:11.98108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1158, 'ufsc', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Turismo sustentável em ilhas

❌ "O turismo é importante"
✅ "O turismo sustentável na Ilha de Santa Catarina demanda políticas que conciliem desenvolvimento econômico e preservação dos ecossistemas costeiros"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.98108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1159, 'ufsc', 1, 4, 'Temas Regionais', 'Contexto catarinense', '# Temas de Santa Catarina

## Assuntos Relevantes
- Turismo (praias, serra)
- Indústria e tecnologia
- Imigração (alemã, italiana)
- Meio ambiente (Mata Atlântica)
- Polo têxtil

## Repertório Útil
- Cruz e Sousa (poeta)
- Ponte Hercílio Luz
- Oktoberfest de Blumenau
- Baleias-francas', '[{"question": "Cruz e Sousa era:", "options": ["Pintor", "Poeta catarinense"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.98108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1160, 'ufsc', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFSC

## Tipos válidos
- Dados: IBGE, FIESC
- Histórico: Imigração no Sul
- Literário: Autores catarinenses
- Ambiental: Mata Atlântica

## Autores catarinenses
- Cruz e Sousa
- Harry Laus
- Lindolf Bell
- Franklin Cascaes (folclore)', '[{"question": "Franklin Cascaes estudou:", "options": ["Economia", "Folclore açoriano"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.98108');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1161, 'ufsc', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:19:11.982907');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1162, 'ufsc', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:19:11.982907');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1163, 'ufsc', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Outrossim'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.982907');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1164, 'ufsc', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.982907');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1165, 'ufsc', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.982907');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1166, 'ufsc', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:19:11.984523');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1167, 'ufsc', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:19:11.984523');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1168, 'ufsc', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.984523');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1169, 'ufsc', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.984523');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1170, 'ufsc', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, FIESC
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.984523');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1171, 'ufsc', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:19:11.98601');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1172, 'ufsc', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve festivais'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:19:11.98601');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1173, 'ufsc', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir à Florianópolis'' tem crase?", "options": ["Sim (artigo)", "Não"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.98601');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1174, 'ufsc', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.98601');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1175, 'ufsc', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFSC

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:19:11.98601');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1176, 'ufs', 1, 1, 'A Redação UFS', 'Conhecendo o vestibular', '# A Redação da UFS

## Universidade Federal de Sergipe
Localizada em São Cristóvão/Aracaju, a UFS é a principal universidade do estado.

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
Sergipe: menor estado brasileiro, rica cultura.', '[{"question": "A UFS está localizada em:", "options": ["Salvador", "Aracaju", "Maceió"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:27:08.186894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1177, 'ufs', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:27:08.186894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1178, 'ufs', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Turismo no litoral sergipano

❌ "O turismo é importante"
✅ "O desenvolvimento turístico do litoral sergipano demanda infraestrutura que preserve os ecossistemas costeiros enquanto gera renda para comunidades locais"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.186894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1179, 'ufs', 1, 4, 'Temas Regionais', 'Contexto sergipano', '# Temas de Sergipe

## Assuntos Relevantes
- Menor estado do Brasil
- Cultura (forró, São João)
- Rio São Francisco
- Cânion do Xingó
- Patrimônio histórico

## Repertório Útil
- Tobias Barreto (filósofo)
- Sílvio Romero (crítico)
- São Cristóvão (4ª cidade mais antiga)
- Mangue Seco', '[{"question": "Sergipe é:", "options": ["O maior estado", "O menor estado do Brasil"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.186894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1180, 'ufs', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFS

## Tipos válidos
- Dados: IBGE, SEPLAG
- Histórico: Colonização
- Literário: Autores sergipanos
- Cultural: Tradições locais

## Autores sergipanos
- Tobias Barreto
- Sílvio Romero
- Amado Ribas
- João Ribeiro', '[{"question": "Tobias Barreto era:", "options": ["Cantor", "Filósofo e poeta sergipano"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.186894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1231, 'pucsp', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:39:25.18438');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1181, 'ufs', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:27:08.189686');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1182, 'ufs', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:27:08.189686');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1183, 'ufs', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.189686');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1184, 'ufs', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Dessarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.189686');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1185, 'ufs', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.189686');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1186, 'ufs', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:27:08.192811');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1187, 'ufs', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:27:08.192811');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1188, 'ufs', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.192811');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1189, 'ufs', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.192811');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1190, 'ufs', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, SEPLAG
- Constituição Federal
- Autores reconhecidos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.192811');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1191, 'ufs', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:27:08.194674');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1192, 'ufs', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Existem soluções'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:27:08.194674');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1193, 'ufs', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Aracaju'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.194674');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1194, 'ufs', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.194674');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1195, 'ufs', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFS

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:27:08.194674');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1196, 'uft', 1, 1, 'A Redação UFT', 'Conhecendo o vestibular', '# A Redação da UFT

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
Tocantins: estado mais jovem (1988), transição Amazônia-Cerrado.', '[{"question": "A UFT está localizada em:", "options": ["Goiânia", "Palmas", "Brasília"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:32:17.704512');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1197, 'uft', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:32:17.704512');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1198, 'uft', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Desenvolvimento sustentável no Tocantins

❌ "O desenvolvimento é importante"
✅ "O desenvolvimento do Tocantins demanda planejamento que concilie expansão agrícola com preservação do ecótono Amazônia-Cerrado"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.704512');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1199, 'uft', 1, 4, 'Temas Regionais', 'Contexto tocantinense', '# Temas do Tocantins

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
- Transição Amazônia-Cerrado', '[{"question": "O Tocantins foi criado em:", "options": ["1960", "1988"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.704512');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1200, 'uft', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFT

## Tipos válidos
- Dados: IBGE, SEPLAN
- Ambiental: Cerrado e transição
- Histórico: Criação do estado
- Econômico: Agronegócio

## Conhecimentos úteis
- Jalapão (fervedouros)
- Ilha do Bananal
- Capim Dourado (artesanato)
- Povo Xerente e Karajá', '[{"question": "O Capim Dourado é:", "options": ["Planta medicinal", "Artesanato típico do Jalapão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.704512');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1201, 'uft', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:32:17.706511');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1202, 'uft', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:32:17.706511');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1203, 'uft', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.706511');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1204, 'uft', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.706511');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1205, 'uft', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.706511');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1206, 'uft', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:32:17.708202');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1207, 'uft', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:32:17.708202');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1208, 'uft', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.708202');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1209, 'uft', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.708202');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1210, 'uft', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, SEPLAN
- Constituição Federal
- Dados ambientais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.708202');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1211, 'uft', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:32:17.709848');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1212, 'uft', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve avanços'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:32:17.709848');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1213, 'uft', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Palmas'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.709848');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1214, 'uft', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.709848');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1215, 'uft', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFT

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:32:17.709848');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1216, 'pucsp', 1, 1, 'A Redação PUC-SP', 'Conhecendo o vestibular', '# A Redação da PUC-SP

## Pontifícia Universidade Católica de São Paulo
Tradicional universidade privada, referência em Ciências Humanas e Direito.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Temas:** Atualidades, ética e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Diferencial
A PUC-SP valoriza reflexão crítica e posicionamento ético.', '[{"question": "A PUC-SP é referência em:", "options": ["Engenharia", "Ciências Humanas e Direito"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:39:25.166993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1217, 'pucsp', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:39:25.166993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1218, 'pucsp', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Ética nas redes sociais

❌ "As redes sociais têm problemas"
✅ "A ética nas redes sociais demanda regulamentação que equilibre liberdade de expressão e responsabilidade digital"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.166993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1219, 'pucsp', 1, 4, 'Temas Humanísticos', 'Contexto PUC-SP', '# Temas da PUC-SP

## Assuntos Frequentes
- Ética e valores
- Direitos humanos
- Justiça social
- Comunicação e mídia
- Filosofia aplicada

## Repertório Útil
- Paulo Freire (educador)
- Hannah Arendt (filósofa)
- Declaração dos Direitos Humanos
- Teologia da Libertação', '[{"question": "Paulo Freire era:", "options": ["Jurista", "Educador brasileiro"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.166993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1220, 'pucsp', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para PUC-SP

## Tipos válidos
- Filosófico: pensadores clássicos
- Sociológico: autores contemporâneos
- Ético: direitos humanos
- Religioso: doutrina social

## Autores recomendados
- Paulo Freire
- Zygmunt Bauman
- Hannah Arendt
- Leonardo Boff', '[{"question": "Bauman escreveu sobre:", "options": ["Biologia", "Modernidade líquida"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.166993');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1221, 'pucsp', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:39:25.173378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1222, 'pucsp', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Citação filosófica
- Contextualização ética
- Pergunta reflexiva
- Dado social', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:39:25.173378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1223, 'pucsp', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.173378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1224, 'pucsp', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Dessarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.173378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1225, 'pucsp', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão ética

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.173378');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1226, 'pucsp', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Filosófico:** Pensadores
2. **Ético:** Valores e direitos
3. **Sociológico:** Análise social
4. **Autoridade:** Especialistas

## Estratégia
Use argumentos humanísticos.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:39:25.179097');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1227, 'pucsp', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Sob a ótica de Bauman..."

## Fórmula
AUTOR + conceito + aplicação ao tema', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:39:25.179097');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1228, 'pucsp', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.179097');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1229, 'pucsp', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento ético/filosófico
- D2: Argumento social/prático

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.179097');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1230, 'pucsp', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- Filósofos: Kant, Arendt
- Sociólogos: Bauman, Durkheim
- Educadores: Paulo Freire
- Direitos Humanos: ONU

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.179097');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1232, 'pucsp', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve mudanças'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:39:25.18438');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1233, 'pucsp', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Referir-se à ética'' tem crase?", "options": ["Não", "Sim"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.18438');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1234, 'pucsp', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.18438');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1235, 'pucsp', 4, 5, 'Revisão Final', 'Checklist', '# Checklist PUC-SP

## Conteúdo
- [ ] Tema atendido?
- [ ] Tese clara e ética?
- [ ] Argumentos desenvolvidos?

## Gramática
- [ ] Concordâncias?
- [ ] Regências?
- [ ] Pontuação?

## Estrutura
- [ ] 4 parágrafos?
- [ ] Reflexão humanística?

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:39:25.18438');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1236, 'puccampinas', 1, 1, 'A Redação PUC-Campinas', 'Conhecendo o vestibular', '# A Redação da PUC-Campinas

## Pontifícia Universidade Católica de Campinas
Tradicional universidade do interior paulista, com forte atuação em pesquisa.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coesão
3. Argumentação
4. Domínio linguístico

## Diferencial
Foco em temas atuais e reflexão crítica.', '[{"question": "A PUC-Campinas fica no:", "options": ["Litoral", "Interior de SP"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:46:43.49171');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1237, 'puccampinas', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:46:43.49171');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1238, 'puccampinas', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Tecnologia e educação

❌ "A tecnologia é importante"
✅ "A integração tecnológica na educação demanda formação docente e infraestrutura que garantam inclusão digital"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.49171');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1239, 'puccampinas', 1, 4, 'Temas Contemporâneos', 'Contexto PUC-Campinas', '# Temas da PUC-Campinas

## Assuntos Frequentes
- Educação e tecnologia
- Meio ambiente
- Saúde pública
- Urbanização
- Ética profissional

## Repertório Útil
- Dados do IBGE
- Pesquisas acadêmicas
- Autores contemporâneos
- Legislação brasileira', '[{"question": "Campinas é conhecida como:", "options": ["Capital do café", "Vale do Silício brasileiro"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.49171');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1240, 'puccampinas', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para PUC-Campinas

## Tipos válidos
- Dados: IBGE, UNICAMP
- Científico: pesquisas
- Filosófico: pensadores
- Legal: leis e direitos

## Fontes recomendadas
- Constituição Federal
- OMS e ONU
- Pesquisas universitárias
- Autores brasileiros', '[{"question": "Repertório científico vem de:", "options": ["Redes sociais", "Pesquisas acadêmicas"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.49171');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1241, 'puccampinas', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:46:43.497457');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1242, 'puccampinas', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:46:43.497457');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1243, 'puccampinas', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.497457');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1244, 'puccampinas', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.497457');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1245, 'puccampinas', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.497457');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1246, 'puccampinas', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:46:43.502566');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1247, 'puccampinas', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:46:43.502566');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1248, 'puccampinas', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.502566');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1249, 'puccampinas', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.502566');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1250, 'puccampinas', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, UNICAMP
- Constituição Federal
- Pesquisas científicas

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.502566');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1251, 'puccampinas', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:46:43.507731');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1252, 'puccampinas', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve avanços'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:46:43.507731');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1253, 'puccampinas', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Campinas'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.507731');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1254, 'puccampinas', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.507731');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1255, 'puccampinas', 4, 5, 'Revisão Final', 'Checklist', '# Checklist PUC-Campinas

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:46:43.507731');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1256, 'pucminas', 1, 1, 'A Redação PUC-Minas', 'Conhecendo o vestibular', '# A Redação da PUC-Minas

## Pontifícia Universidade Católica de Minas Gerais
Maior universidade católica do Brasil, com sede em Belo Horizonte.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Diferencial
Maior PUC do Brasil, tradição mineira.', '[{"question": "A PUC-Minas é a maior:", "options": ["Do Sudeste", "Católica do Brasil"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:51:13.721358');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1257, 'pucminas', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:51:13.721358');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1275, 'pucminas', 4, 5, 'Revisão Final', 'Checklist', '# Checklist PUC-Minas

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.77409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1258, 'pucminas', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Patrimônio histórico e memória

❌ "O patrimônio é importante"
✅ "A preservação do patrimônio histórico mineiro demanda políticas que integrem educação patrimonial e desenvolvimento turístico sustentável"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.721358');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1259, 'pucminas', 1, 4, 'Temas Mineiros', 'Contexto PUC-Minas', '# Temas da PUC-Minas

## Assuntos Frequentes
- Patrimônio histórico
- Mineração e meio ambiente
- Cultura mineira
- Desenvolvimento regional
- Questões sociais

## Repertório Útil
- Cidades históricas (Ouro Preto)
- Tragédias de Mariana e Brumadinho
- Guimarães Rosa
- Carlos Drummond de Andrade', '[{"question": "Guimarães Rosa escreveu:", "options": ["Grande Sertão: Veredas", "Dom Casmurro"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.721358');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1260, 'pucminas', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para PUC-Minas

## Tipos válidos
- Literário: autores mineiros
- Histórico: ciclo do ouro
- Ambiental: mineração
- Cultural: barroco mineiro

## Autores mineiros
- Guimarães Rosa
- Drummond de Andrade
- Fernando Sabino
- Adélia Prado', '[{"question": "Drummond era:", "options": ["Pintor", "Poeta mineiro"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.721358');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1261, 'pucminas', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:51:13.730799');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1262, 'pucminas', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação literária
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:51:13.730799');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1263, 'pucminas', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.730799');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1264, 'pucminas', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Dessarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.730799');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1265, 'pucminas', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.730799');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1266, 'pucminas', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:51:13.768538');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1267, 'pucminas', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:51:13.768538');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1268, 'pucminas', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.768538');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1269, 'pucminas', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.768538');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1270, 'pucminas', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, IPHAN
- Constituição Federal
- Autores mineiros

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.768538');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1271, 'pucminas', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:51:13.77409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1272, 'pucminas', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve tragédias'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:51:13.77409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1273, 'pucminas', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Belo Horizonte'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.77409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1274, 'pucminas', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:51:13.77409');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1276, 'pucpr', 1, 1, 'A Redação PUCPR', 'Conhecendo o vestibular', '# A Redação da PUCPR

## Pontifícia Universidade Católica do Paraná
Tradicional universidade de Curitiba, referência no Sul do Brasil.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coesão
3. Argumentação
4. Domínio linguístico

## Diferencial
Tradição paranaense e inovação.', '[{"question": "A PUCPR fica em:", "options": ["Porto Alegre", "Curitiba"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:55:48.409095');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1277, 'pucpr', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:55:48.409095');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1278, 'pucpr', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Mobilidade urbana sustentável

❌ "O trânsito é um problema"
✅ "A mobilidade urbana sustentável em Curitiba demanda ampliação do transporte público integrado e incentivo a modais não poluentes"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.409095');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1279, 'pucpr', 1, 4, 'Temas Paranaenses', 'Contexto PUCPR', '# Temas da PUCPR

## Assuntos Frequentes
- Urbanismo (Curitiba modelo)
- Meio ambiente
- Inovação e tecnologia
- Agricultura sustentável
- Imigração no Paraná

## Repertório Útil
- Paulo Leminski (poeta)
- Dalton Trevisan (contista)
- BRT de Curitiba
- Parques urbanos', '[{"question": "Paulo Leminski era:", "options": ["Arquiteto", "Poeta curitibano"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.409095');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1280, 'pucpr', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para PUCPR

## Tipos válidos
- Urbanístico: Curitiba modelo
- Literário: autores paranaenses
- Ambiental: sustentabilidade
- Tecnológico: inovação

## Autores paranaenses
- Paulo Leminski
- Dalton Trevisan
- Helena Kolody
- Wilson Bueno', '[{"question": "Dalton Trevisan escreve:", "options": ["Romances épicos", "Contos curitibanos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.409095');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1281, 'pucpr', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:55:48.414194');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1282, 'pucpr', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:55:48.414194');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1283, 'pucpr', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Outrossim'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.414194');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1284, 'pucpr', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.414194');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1285, 'pucpr', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.414194');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1286, 'pucpr', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:55:48.423428');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1287, 'pucpr', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:55:48.423428');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1288, 'pucpr', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.423428');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1289, 'pucpr', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.423428');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1290, 'pucpr', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, IPARDES
- Constituição Federal
- Autores paranaenses

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.423428');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1291, 'pucpr', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 22:55:48.428263');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1292, 'pucpr', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve melhorias'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 22:55:48.428263');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1293, 'pucpr', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Curitiba'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.428263');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1294, 'pucpr', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.428263');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1295, 'pucpr', 4, 5, 'Revisão Final', 'Checklist', '# Checklist PUCPR

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 22:55:48.428263');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1296, 'pucrio', 1, 1, 'A Redação PUC-Rio', 'Conhecendo o vestibular', '# A Redação da PUC-Rio

## Pontifícia Universidade Católica do Rio de Janeiro
Uma das mais prestigiadas universidades privadas do Brasil.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Temas:** Atualidades, cultura e sociedade

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Diferencial
Excelência acadêmica e tradição carioca.', '[{"question": "A PUC-Rio fica na:", "options": ["Zona Sul", "Gávea (Rio de Janeiro)"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:00:15.959621');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1297, 'pucrio', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:00:15.959621');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1298, 'pucrio', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Cultura e identidade carioca

❌ "A cultura carioca é importante"
✅ "A preservação da identidade cultural carioca demanda políticas que valorizem as manifestações populares enquanto integram a diversidade contemporânea"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.959621');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1299, 'pucrio', 1, 4, 'Temas Cariocas', 'Contexto PUC-Rio', '# Temas da PUC-Rio

## Assuntos Frequentes
- Cultura e identidade
- Desigualdade urbana
- Violência e segurança
- Meio ambiente (Mata Atlântica)
- Arte e literatura

## Repertório Útil
- Machado de Assis
- Clarice Lispector
- Bossa Nova, Samba
- Cristo Redentor (patrimônio)', '[{"question": "Machado de Assis nasceu no:", "options": ["São Paulo", "Rio de Janeiro"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.959621');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1300, 'pucrio', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para PUC-Rio

## Tipos válidos
- Literário: autores cariocas
- Cultural: música e arte
- Histórico: capital do Brasil
- Social: urbanização

## Autores cariocas
- Machado de Assis
- Clarice Lispector
- Lima Barreto
- Rubem Fonseca', '[{"question": "Clarice Lispector escreveu:", "options": ["Germinal", "A Hora da Estrela"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.959621');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1301, 'pucrio', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:00:15.972975');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1302, 'pucrio', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Citação literária
- Contextualização cultural
- Dado estatístico
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:00:15.972975');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1303, 'pucrio', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.972975');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1304, 'pucrio', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Dessarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.972975');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1305, 'pucrio', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.972975');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1306, 'pucrio', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Literário:** Obras e autores
2. **Cultural:** Música e arte
3. **Histórico:** Fatos e contextos
4. **Sociológico:** Análise social

## Estratégia
Use repertório cultural variado.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:00:15.97814');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1307, 'pucrio', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Como observou Machado..."

## Fórmula
AUTOR + obra/conceito + aplicação', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:00:15.97814');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1308, 'pucrio', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.97814');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1309, 'pucrio', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento cultural/literário
- D2: Argumento social/histórico

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.97814');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1310, 'pucrio', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- Literatura brasileira
- História do Rio
- Música Popular Brasileira
- Artes visuais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.97814');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1311, 'pucrio', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:00:15.983305');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1312, 'pucrio', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve manifestações'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:00:15.983305');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1313, 'pucrio', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir à Gávea'' tem crase?", "options": ["Não", "Sim (bairro feminino)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.983305');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1314, 'pucrio', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.983305');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1347, 'pucrs', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Como escreveu Quintana..."

## Fórmula
AUTOR + obra/conceito + aplicação', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:11:53.414111');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1315, 'pucrio', 4, 5, 'Revisão Final', 'Checklist', '# Checklist PUC-Rio

## Conteúdo
- [ ] Tema atendido?
- [ ] Tese clara?
- [ ] Repertório cultural?

## Gramática
- [ ] Concordâncias?
- [ ] Regências?
- [ ] Pontuação?

## Estrutura
- [ ] 4 parágrafos?
- [ ] Transições claras?

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:00:15.983305');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1316, 'pucgoias', 1, 1, 'A Redação PUC-Goiás', 'Conhecendo o vestibular', '# A Redação da PUC-Goiás

## Pontifícia Universidade Católica de Goiás
Tradicional universidade de Goiânia, referência no Centro-Oeste.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Temas:** Atualidades e questões regionais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura e coesão
3. Argumentação
4. Domínio linguístico

## Diferencial
Tradição goiana e valores humanísticos.', '[{"question": "A PUC-Goiás fica em:", "options": ["Brasília", "Goiânia"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:04:37.071146');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1317, 'pucgoias', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:04:37.071146');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1318, 'pucgoias', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Agronegócio e sustentabilidade

❌ "O agronegócio é importante"
✅ "O agronegócio goiano demanda práticas sustentáveis que conciliem produtividade e preservação do Cerrado"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.071146');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1319, 'pucgoias', 1, 4, 'Temas Goianos', 'Contexto PUC-Goiás', '# Temas da PUC-Goiás

## Assuntos Frequentes
- Cerrado e meio ambiente
- Agronegócio
- Cultura goiana
- Desenvolvimento regional
- Questões sociais

## Repertório Útil
- Cora Coralina (poetisa)
- Goiânia (cidade planejada)
- Cerrado (hotspot)
- Música sertaneja raiz', '[{"question": "Cora Coralina era:", "options": ["Pintora", "Poetisa goiana"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.071146');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1320, 'pucgoias', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para PUC-Goiás

## Tipos válidos
- Literário: autores goianos
- Ambiental: Cerrado
- Econômico: agronegócio
- Cultural: tradições

## Autores goianos
- Cora Coralina
- Hugo de Carvalho Ramos
- Bernardo Élis
- José J. Veiga', '[{"question": "O Cerrado é considerado:", "options": ["Deserto", "Hotspot de biodiversidade"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.071146');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1321, 'pucgoias', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:04:37.073096');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1322, 'pucgoias', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:04:37.073096');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1323, 'pucgoias', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.073096');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1324, 'pucgoias', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.073096');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1325, 'pucgoias', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.073096');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1326, 'pucgoias', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:04:37.074894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1327, 'pucgoias', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:04:37.074894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1328, 'pucgoias', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.074894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1329, 'pucgoias', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.074894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1330, 'pucgoias', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, IMB-GO
- Constituição Federal
- Autores goianos

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.074894');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1331, 'pucgoias', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:04:37.076261');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1332, 'pucgoias', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve avanços'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:04:37.076261');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1333, 'pucgoias', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Goiânia'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.076261');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1334, 'pucgoias', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.076261');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1335, 'pucgoias', 4, 5, 'Revisão Final', 'Checklist', '# Checklist PUC-Goiás

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:04:37.076261');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1336, 'pucrs', 1, 1, 'A Redação PUCRS', 'Conhecendo o vestibular', '# A Redação da PUCRS

## Pontifícia Universidade Católica do Rio Grande do Sul
Tradicional universidade de Porto Alegre, referência no Sul do Brasil.

## Características da Redação
- **Formato:** Dissertação-argumentativa
- **Extensão:** 25 a 30 linhas
- **Temas:** Atualidades e questões sociais

## Critérios de Avaliação
1. Adequação ao tema proposto
2. Estrutura textual
3. Argumentação
4. Domínio da norma culta

## Diferencial
Tradição gaúcha e excelência acadêmica.', '[{"question": "A PUCRS fica em:", "options": ["Curitiba", "Porto Alegre"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:11:53.410373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1337, 'pucrs', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:11:53.410373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1338, 'pucrs', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Identidade cultural gaúcha

❌ "A cultura gaúcha é importante"
✅ "A preservação da identidade cultural gaúcha demanda políticas que valorizem tradições enquanto dialogam com a contemporaneidade"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.410373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1339, 'pucrs', 1, 4, 'Temas Gaúchos', 'Contexto PUCRS', '# Temas da PUCRS

## Assuntos Frequentes
- Cultura gaúcha
- Imigração europeia
- Meio ambiente (Pampa)
- Tecnologia e inovação
- Questões sociais

## Repertório Útil
- Erico Verissimo
- Mário Quintana
- Centro histórico de POA
- Tradições gaúchas', '[{"question": "Mário Quintana era:", "options": ["Pintor", "Poeta gaúcho"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.410373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1340, 'pucrs', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para PUCRS

## Tipos válidos
- Literário: autores gaúchos
- Histórico: imigração
- Cultural: tradições
- Científico: pesquisas

## Autores gaúchos
- Erico Verissimo
- Mário Quintana
- Simões Lopes Neto
- Caio Fernando Abreu', '[{"question": "Erico Verissimo escreveu:", "options": ["Grande Sertão", "O Tempo e o Vento"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.410373');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1341, 'pucrs', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:11:53.412637');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1342, 'pucrs', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Citação literária gaúcha
- Contextualização histórica
- Dado estatístico
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:11:53.412637');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1343, 'pucrs', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', '# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.', '[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.412637');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1344, 'pucrs', 2, 4, 'Conectivos', 'Ligando ideias', '# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que', '[{"question": "''Dessarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.412637');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1345, 'pucrs', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.412637');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1346, 'pucrs', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Literário:** Obras e autores

## Estratégia
Use repertório cultural gaúcho.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:11:53.414111');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1348, 'pucrs', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.414111');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1349, 'pucrs', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento cultural/literário
- D2: Argumento social/histórico

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.414111');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1350, 'pucrs', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, FEE
- Literatura gaúcha
- Pesquisas universitárias
- História do RS

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.414111');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1351, 'pucrs', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:11:53.415618');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1352, 'pucrs', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve mudanças'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:11:53.415618');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1353, 'pucrs', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir à Serra Gaúcha'' tem crase?", "options": ["Não", "Sim (região feminina)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.415618');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1354, 'pucrs', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.415618');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1355, 'pucrs', 4, 5, 'Revisão Final', 'Checklist', '# Checklist PUCRS

## Conteúdo
- [ ] Tema atendido?
- [ ] Tese clara?
- [ ] Repertório gaúcho?

## Gramática
- [ ] Concordâncias?
- [ ] Regências?
- [ ] Pontuação?

## Estrutura
- [ ] 4 parágrafos?
- [ ] Transições claras?

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:11:53.415618');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1356, 'ufrr', 1, 1, 'A Redação UFRR', 'Conhecendo o vestibular', '# A Redação da UFRR

## Universidade Federal de Roraima
Principal universidade do estado mais ao norte do Brasil, em Boa Vista.

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
Roraima: estado mais setentrional, fronteira com Venezuela e Guiana.', '[{"question": "A UFRR fica em:", "options": ["Manaus", "Boa Vista"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:35:22.920079');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1357, 'ufrr', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:35:22.920079');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1358, 'ufrr', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Migração venezuelana em Roraima

❌ "A imigração é um problema"
✅ "O fluxo migratório venezuelano em Roraima demanda políticas integradas de acolhimento e distribuição que conciliem direitos humanos e capacidade estatal"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.920079');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1359, 'ufrr', 1, 4, 'Temas Regionais', 'Contexto roraimense', '# Temas de Roraima

## Assuntos Relevantes
- Monte Roraima (tepui)
- Povos indígenas (Yanomami)
- Migração venezuelana
- Amazônia e desmatamento
- Fronteiras internacionais

## Repertório Útil
- Terra indígena Yanomami
- Crise humanitária Venezuela
- Monte Roraima (formação geológica)
- Linha do Equador', '[{"question": "O Monte Roraima é um:", "options": ["Vulcão", "Tepui (montanha de topo plano)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.920079');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1360, 'ufrr', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFRR

## Tipos válidos
- Dados: IBGE, ACNUR
- Ambiental: Amazônia
- Indígena: direitos originários
- Migratório: fluxos fronteiriços

## Conhecimentos úteis
- Operação Acolhida (ONU)
- Raposa Serra do Sol
- Biodiversidade amazônica
- Integração sul-americana', '[{"question": "A Operação Acolhida é:", "options": ["Militar", "Humanitária para venezuelanos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.920079');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1361, 'ufrr', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:35:22.921987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1362, 'ufrr', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:35:22.921987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1363, 'ufrr', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Ademais'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.921987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1364, 'ufrr', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.921987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1365, 'ufrr', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.921987');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1366, 'ufrr', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:35:22.923372');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1367, 'ufrr', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:35:22.923372');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1368, 'ufrr', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.923372');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1369, 'ufrr', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.923372');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1370, 'ufrr', 3, 5, 'Repertório', 'Usando referências', '# Repertório

## Fontes confiáveis
- IBGE, ACNUR, ONU
- Constituição Federal
- Dados ambientais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente', '[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.923372');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1371, 'ufrr', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:35:22.924685');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1372, 'ufrr', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve avanços'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:35:22.924685');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1373, 'ufrr', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Boa Vista'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.924685');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1374, 'ufrr', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.924685');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1375, 'ufrr', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFRR

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:35:22.924685');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1376, 'ufpe', 1, 1, 'A Redação UFPE', 'Conhecendo o vestibular', '# A Redação da UFPE

## Universidade Federal de Pernambuco
Principal universidade federal do Nordeste, localizada em Recife.

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
A UFPE valoriza a cultura pernambucana e nordestina.', '[{"question": "A UFPE fica em:", "options": ["Salvador", "Recife"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:38:48.411922');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1377, 'ufpe', 1, 2, 'Interpretando o Tema', 'Compreensão correta', '# Análise do Tema

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
❌ Tangenciar = nota muito baixa', '[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:38:48.411922');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1378, 'ufpe', 1, 3, 'Tese Clara', 'Posicionamento objetivo', '# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Carnaval e identidade cultural

❌ "O carnaval é importante"
✅ "O carnaval pernambucano, do frevo ao maracatu, constitui patrimônio imaterial que demanda políticas de preservação e valorização"', '[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.411922');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1379, 'ufpe', 1, 4, 'Temas Regionais', 'Contexto pernambucano', '# Temas de Pernambuco

## Assuntos Relevantes
- Cultura popular (frevo, maracatu)
- Seca e semiárido
- Turismo (Recife, Olinda, Fernando de Noronha)
- História colonial
- Desigualdade regional

## Repertório Útil
- Ariano Suassuna
- Gilberto Freyre
- João Cabral de Melo Neto
- Luiz Gonzaga', '[{"question": "Gilberto Freyre escreveu:", "options": ["Casa-Grande & Senzala", "O Auto da Compadecida"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.411922');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1380, 'ufpe', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', '# Repertório para UFPE

## Tipos válidos
- Dados: IBGE, SUDENE
- Histórico: Formação do NE
- Literário: Autores pernambucanos
- Cultural: Tradições locais

## Autores pernambucanos
- Gilberto Freyre
- João Cabral de Melo Neto
- Manuel Bandeira
- Clarice Lispector (nasceu em Recife)', '[{"question": "João Cabral escreveu:", "options": ["Morte e Vida Severina", "Vidas Secas"], "correct": 0}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.411922');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1381, 'ufpe', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', '# Estrutura da Dissertação

## Modelo
- **Introdução:** Contexto + tese (5-7 linhas)
- **D1:** Primeiro argumento (7-10 linhas)
- **D2:** Segundo argumento (7-10 linhas)
- **Conclusão:** Síntese + proposta (5-7 linhas)

## Proporção
20% intro | 60% desenvolvimento | 20% conclusão', '[{"question": "Quantos parágrafos mínimos?", "options": ["3", "4"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:38:48.41376');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1382, 'ufpe', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', '# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica', '[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:38:48.41376');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1383, 'ufpe', 2, 3, 'Coesão Textual', 'Conectando ideias', '# Coesão

## Mecanismos
1. **Conectivos:** ligam orações
2. **Pronomes:** retomam termos
3. **Sinônimos:** evitam repetição
4. **Elipse:** omissão estratégica

## Conectivos principais
- Adição: além disso, ademais
- Oposição: contudo, entretanto
- Conclusão: portanto, logo', '[{"question": "''Outrossim'' indica:", "options": ["Oposição", "Adição"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.41376');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1384, 'ufpe', 2, 4, 'Transições', 'Entre parágrafos', '# Transições Fluidas

## Técnicas
1. Retomar palavra-chave
2. Usar conectivo adequado
3. Fazer referência ao anterior

## Exemplo
**Final D1:** "...perpetua desigualdades."
**Início D2:** "Além dessa questão..."', '[{"question": "Transições conectam:", "options": ["Apenas frases", "Parágrafos"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.41376');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1385, 'ufpe', 2, 5, 'Conclusão', 'Fechando o texto', '# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas', '[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.41376');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1386, 'ufpe', 3, 1, 'Tipos de Argumento', 'Construindo defesas', '# Argumentação

## Tipos principais
1. **Dados:** Estatísticas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.', '[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:38:48.41495');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1387, 'ufpe', 3, 2, 'Análise Crítica', 'Aprofundando', '# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Esse cenário revela falhas..."

## Fórmula
DADO + interpretação + consequência', '[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:38:48.41495');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1388, 'ufpe', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', '# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta

## Teste
Pergunte: "Isso prova minha tese?"', '[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.41495');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1389, 'ufpe', 3, 4, 'Progressão', 'Avançando ideias', '# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento mais simples
- D2: Argumento mais elaborado

## Conectivos
- "Além disso..."
- "Soma-se a isso..."', '[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.41495');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1390, 'ufpe', 3, 5, 'Repertório Pernambucano', 'Referências regionais', '# Repertório para UFPE

## Fontes confiáveis
- IBGE, SUDENE
- Constituição Federal
- Autores reconhecidos

## Conhecimentos locais
- Frevo (Patrimônio Imaterial)
- Maracatu
- Olinda (Patrimônio da Humanidade)
- Fernando de Noronha', '[{"question": "O frevo é Patrimônio:", "options": ["Natural", "Imaterial da Humanidade"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.41495');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1391, 'ufpe', 4, 1, 'Norma Culta', 'Gramática essencial', '# Norma Culta

## Pontos críticos
1. Concordância verbal e nominal
2. Regência verbal e nominal
3. Crase
4. Pontuação

## Erros graves
- "Haviam pessoas" ❌
- "Prefiro do que" ❌
- Vírgula entre sujeito e verbo ❌', '[{"question": "''Havia pessoas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'free', 0, true, '2025-12-05 23:38:48.416889');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1392, 'ufpe', 4, 2, 'Concordância', 'Verbal e nominal', '# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.', '[{"question": "''Houve festas'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]', 3, 'previous', 0, true, '2025-12-05 23:38:48.416889');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1393, 'ufpe', 4, 3, 'Regência e Crase', 'Preposições corretas', '# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.', '[{"question": "''Ir a Recife'' tem crase?", "options": ["Sim", "Não (cidade sem artigo)"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.416889');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1394, 'ufpe', 4, 4, 'Pontuação', 'Vírgulas e mais', '# Pontuação

## Vírgula - USA-SE
- Separar itens
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento', '[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.416889');
INSERT INTO public.lesson (id, exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value, is_active, created_at) VALUES (1395, 'ufpe', 4, 5, 'Revisão Final', 'Checklist', '# Checklist UFPE

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

**Reserve 10 minutos!**', '[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]', 4, 'previous', 0, true, '2025-12-05 23:38:48.416889');


--
-- Name: lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.lesson_id_seq', 1395, true);


--
-- PostgreSQL database dump complete
--

\unrestrict kDFB1aZ6ICJ16l7s9BqaNV2vp5QJ8JdPhZabzCY6Y3xdLAIhlgwN1MMOUbknZNf

