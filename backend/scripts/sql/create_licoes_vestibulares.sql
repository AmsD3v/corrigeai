-- Lições Completas Multi-Vestibular
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/licoes_vestibulares.sql

-- Limpar lições antigas (exceto ENEM que está em outro arquivo)
DELETE FROM user_lesson WHERE lesson_id IN (SELECT id FROM lesson WHERE exam_type != 'enem');
DELETE FROM lesson WHERE exam_type != 'enem';

-- ============================================================================
-- FUVEST - 20 LIÇÕES (5 por critério)
-- Critérios: 1-Tema/Texto, 2-Estrutura, 3-Expressão, 4-Adequação
-- ============================================================================

-- CRITÉRIO 1: TEMA E TEXTO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
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

('fuvest', 1, 2, 'Interpretando a Coletânea', 'Como usar os textos de apoio', 
'# A Coletânea FUVEST

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
✅ Sintetizar visões diferentes',
'[{"question": "Pode copiar trechos da coletânea?", "options": ["Sim", "Não, deve parafrasear"], "correct": 1}, {"question": "Quantos textos deve usar da coletânea?", "options": ["Apenas 1", "Todos disponíveis", "Nenhum"], "correct": 1}]',
35, 'previous', 0),

('fuvest', 1, 3, 'Tese e Posicionamento', 'Defendendo seu ponto de vista', 
'# Construindo sua Tese

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
4. Formule de forma assertiva',
'[{"question": "A tese deve ser apresentada na:", "options": ["Introdução", "Conclusão", "Desenvolvimento"], "correct": 0}, {"question": "Uma boa tese é:", "options": ["Óbvia e simples", "Clara e defensável", "Vaga e genérica"], "correct": 1}]',
40, 'previous', 0),

('fuvest', 1, 4, 'Repertório Literário', 'O diferencial FUVEST', 
'# Usando Literatura na FUVEST

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

*"Como Bentinho em Dom Casmurro, que se isolou em suas certezas obsessivas, a sociedade contemporânea frequentemente confunde solidão com autonomia..."*',
'[{"question": "A FUVEST valoriza referências a:", "options": ["Filmes americanos", "Obras literárias da lista", "Músicas populares"], "correct": 1}]',
45, 'previous', 0),

('fuvest', 1, 5, 'Temas Filosóficos', 'Dominando a abstração', 
'# Temas Filosóficos na FUVEST

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
- Conclusão: Síntese reflexiva',
'[{"question": "Temas filosóficos devem ser abordados de forma:", "options": ["Apenas teórica", "Com exemplos concretos", "Superficial"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('fuvest', 2, 1, 'Estrutura Dissertativa', 'Organizando seu texto', 
'# Estrutura da Dissertação FUVEST

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

O importante é a **coerência interna**.',
'[{"question": "A FUVEST permite estrutura mais flexível que o ENEM?", "options": ["Sim", "Não"], "correct": 0}]',
30, 'free', 0),

('fuvest', 2, 2, 'Introdução Impactante', 'Capturando a atenção', 
'# A Introdução FUVEST

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
*"Em ''A República'', Platão já questionava os limites entre liberdade e ordem social. Milênios depois, essa tensão permanece no cerne das democracias contemporâneas, evidenciando que..."*',
'[{"question": "A introdução deve conter:", "options": ["Apenas a tese", "Contextualização + tese", "Apenas exemplos"], "correct": 1}]',
35, 'previous', 0),

('fuvest', 2, 3, 'Parágrafos de Desenvolvimento', 'Construindo argumentos', 
'# Desenvolvimento FUVEST

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
7-10 linhas por parágrafo',
'[{"question": "Um bom parágrafo começa com:", "options": ["Exemplo", "Tópico frasal", "Citação longa"], "correct": 1}]',
40, 'previous', 0),

('fuvest', 2, 4, 'Transições e Conectivos', 'Fluidez entre parágrafos', 
'# Conectando Ideias

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
Retome palavras-chave do parágrafo anterior no início do próximo.',
'[{"question": "Parágrafos na FUVEST devem:", "options": ["Ser independentes", "Dialogar entre si", "Repetir informações"], "correct": 1}]',
45, 'previous', 0),

('fuvest', 2, 5, 'Conclusão Reflexiva', 'Fechando com maestria', 
'# A Conclusão FUVEST

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
❌ Repetir literalmente a introdução',
'[{"question": "A conclusão FUVEST exige proposta de intervenção?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: EXPRESSÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('fuvest', 3, 1, 'Clareza e Precisão', 'Escrevendo com exatidão', 
'# Expressão Clara

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
✅ "Tal postura intensifica a desigualdade social"',
'[{"question": "Expressão clara requer:", "options": ["Períodos longos", "Vocabulário preciso", "Repetição de ideias"], "correct": 1}]',
30, 'free', 0),

('fuvest', 3, 2, 'Vocabulário Sofisticado', 'Ampliando seu léxico', 
'# Vocabulário FUVEST

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
Leia editoriais de jornais de qualidade para absorver vocabulário naturalmente.',
'[{"question": "Vocabulário sofisticado deve ser:", "options": ["Forçado e pomposo", "Natural e preciso", "Repetitivo"], "correct": 1}]',
35, 'previous', 0),

('fuvest', 3, 3, 'Figuras de Linguagem', 'Enriquecendo o texto', 
'# Figuras de Linguagem

## Mais úteis para dissertação
- **Metáfora:** Comparação implícita
- **Antítese:** Oposição de ideias
- **Ironia:** Crítica sutil
- **Metonímia:** Substituição por associação

## Exemplos
*"O Planalto fechou os olhos..."* (metonímia)
*"Entre a tradição e a inovação..."* (antítese)

## Moderação
Use com parcimônia - excesso prejudica a clareza.',
'[{"question": "Figuras de linguagem em dissertação devem:", "options": ["Ser abundantes", "Ser usadas com moderação", "Ser evitadas"], "correct": 1}]',
40, 'previous', 0),

('fuvest', 3, 4, 'Variedade Sintática', 'Evitando monotonia', 
'# Variedade na Construção

## Tipos de período
- **Simples:** Uma oração
- **Composto por coordenação:** Orações independentes
- **Composto por subordinação:** Orações dependentes

## Técnica
Alterne tipos de período para criar ritmo.

## Exemplo
*"A liberdade é um valor fundamental. [simples] Contudo, quando exercida sem responsabilidade, ela se transforma em licenciosidade, o que prejudica o convívio social. [composto]"*',
'[{"question": "Variedade sintática significa:", "options": ["Repetir estruturas", "Alternar tipos de período", "Usar apenas períodos curtos"], "correct": 1}]',
45, 'previous', 0),

('fuvest', 3, 5, 'Estilo Autoral', 'Desenvolvendo sua voz', 
'# Encontrando seu Estilo

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
Textos com personalidade, não apenas corretos.',
'[{"question": "Estilo autoral é:", "options": ["Desnecessário", "Valorizado pela FUVEST", "Proibido em dissertação"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: ADEQUAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('fuvest', 4, 1, 'Norma Culta', 'Dominando a gramática', 
'# Norma Culta na FUVEST

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
Reserve os últimos 10 minutos para revisão gramatical.',
'[{"question": "Qual é o erro mais penalizado?", "options": ["Vocabulário simples", "Erros de concordância", "Parágrafos curtos"], "correct": 1}]',
30, 'free', 0),

('fuvest', 4, 2, 'Registros de Linguagem', 'Adequação ao contexto', 
'# Registro Formal

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
- Perguntas retóricas',
'[{"question": "Em dissertação formal, deve-se evitar:", "options": ["Terceira pessoa", "Gírias e contrações", "Vocabulário culto"], "correct": 1}]',
35, 'previous', 0),

('fuvest', 4, 3, 'Pontução Avançada', 'Além da vírgula básica', 
'# Pontuação Sofisticada

## Ponto e vírgula
Separa orações coordenadas longas ou com vírgulas internas.

## Dois-pontos
Introduz explicação, citação ou enumeração.

## Travessão
Destaca informação - como este exemplo - no meio da frase.

## Exemplo integrado
*"A educação enfrenta dois desafios: a falta de investimento e a desvalorização profissional; ambos, entretanto - embora distintos -, têm raízes comuns."*',
'[{"question": "Ponto e vírgula serve para:", "options": ["Terminar frases", "Separar orações coordenadas longas", "Substituir ponto final"], "correct": 1}]',
40, 'previous', 0),

('fuvest', 4, 4, 'Coesão Referencial', 'Retomando ideias', 
'# Retomada de Termos

## Estratégias
1. **Pronomes:** ele, isso, tal
2. **Sinônimos:** substituição lexical
3. **Hiperônimos:** termo mais geral
4. **Expressões:** "essa questão", "tal fenômeno"

## Evitar repetição
❌ "A tecnologia... A tecnologia... A tecnologia..."
✅ "A tecnologia... Ela... Esse avanço... Tal fenômeno..."',
'[{"question": "Coesão referencial evita:", "options": ["Sinônimos", "Repetição excessiva", "Pronomes"], "correct": 1}]',
45, 'previous', 0),

('fuvest', 4, 5, 'Revisão Final', 'Polindo seu texto', 
'# Checklist de Revisão

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
Leia em voz baixa para identificar problemas de ritmo.',
'[{"question": "Quanto tempo dedicar à revisão?", "options": ["0 minutos", "5-15 minutos", "30 minutos"], "correct": 1}]',
50, 'previous', 0);

-- ============================================================================
-- UNICAMP - 20 LIÇÕES (5 por critério)
-- Critérios: 1-Gênero/Interlocução, 2-Propósito, 3-Argumentação, 4-Linguagem
-- ============================================================================

-- CRITÉRIO 1: GÊNERO E INTERLOCUÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unicamp', 1, 1, 'A Redação UNICAMP', 'Entendendo o diferencial', 
'# A Redação UNICAMP

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
A banca avalia se você domina o GÊNERO, não apenas a argumentação.',
'[{"question": "A UNICAMP oferece quantas propostas?", "options": ["1", "2", "3"], "correct": 1}, {"question": "A UNICAMP cobra apenas dissertação?", "options": ["Sim", "Não"], "correct": 1}]',
30, 'free', 0),

('unicamp', 1, 2, 'Carta Argumentativa', 'O gênero mais frequente', 
'# Carta Argumentativa

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
Formal, mas pessoal. Use primeira pessoa.',
'[{"question": "Carta argumentativa precisa de local e data?", "options": ["Sim", "Não"], "correct": 0}]',
35, 'previous', 0),

('unicamp', 1, 3, 'Artigo de Opinião', 'Gênero jornalístico', 
'# Artigo de Opinião

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
- Carta: destinatário específico',
'[{"question": "Artigo de opinião precisa de título?", "options": ["Sim", "Não"], "correct": 0}]',
40, 'previous', 0),

('unicamp', 1, 4, 'Manifesto', 'Gênero de mobilização', 
'# O Manifesto

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
*"Nós, estudantes brasileiros, diante da crise educacional que nos acomete..."*',
'[{"question": "Manifesto deve ter tom:", "options": ["Neutro e distante", "Engajado e mobilizador", "Acadêmico e formal"], "correct": 1}]',
45, 'previous', 0),

('unicamp', 1, 5, 'Adaptação ao Interlocutor', 'Escrevendo para o leitor', 
'# Consciência do Interlocutor

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
✅ Manter consistência até o final',
'[{"question": "Adaptar ao interlocutor significa:", "options": ["Escrever sempre igual", "Ajustar linguagem ao destinatário", "Usar sempre linguagem formal"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: PROPÓSITO COMUNICATIVO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unicamp', 2, 1, 'Objetivo do Texto', 'O que você quer alcançar', 
'# Propósito Comunicativo

## O que é?
O objetivo que você quer alcançar com seu texto.

## Propósitos comuns
- **Convencer:** Mudar opinião
- **Informar:** Transmitir conhecimento
- **Mobilizar:** Chamar à ação
- **Criticar:** Apontar problemas
- **Propor:** Sugerir soluções

## Importante
Seu propósito deve estar claro desde o início e mantido até o final.',
'[{"question": "Propósito comunicativo é:", "options": ["O tema do texto", "O objetivo a alcançar", "A estrutura usada"], "correct": 1}]',
30, 'free', 0),

('unicamp', 2, 2, 'Leitura da Proposta', 'Entendendo o que pedem', 
'# Interpretando a Proposta

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
- Propósito: Propor soluções',
'[{"question": "Na proposta, identificamos:", "options": ["Apenas o tema", "Gênero, interlocutor, contexto e propósito", "Apenas o gênero"], "correct": 1}]',
35, 'previous', 0),

('unicamp', 2, 3, 'Tom e Registro', 'Adequando a voz', 
'# Tom do Texto

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
- O propósito',
'[{"question": "O tom do texto deve combinar com:", "options": ["Apenas o tema", "Gênero, interlocutor e propósito", "Suas preferências pessoais"], "correct": 1}]',
40, 'previous', 0),

('unicamp', 2, 4, 'Estratégias de Persuasão', 'Convencendo o leitor', 
'# Persuasão Eficaz

## Técnicas
1. **Apelo à razão:** Dados, estatísticas
2. **Apelo à emoção:** Histórias, exemplos
3. **Apelo à ética:** Valores compartilhados
4. **Apelo à autoridade:** Especialistas

## Combinação
Os melhores textos combinam múltiplas estratégias.

## Exemplo
*"Segundo a OMS [autoridade], 40% dos jovens [dados] enfrentam ansiedade - imagine seu próprio filho [emoção] nessa situação..."*',
'[{"question": "Persuasão eficaz usa:", "options": ["Apenas dados", "Múltiplas estratégias", "Apenas emoção"], "correct": 1}]',
45, 'previous', 0),

('unicamp', 2, 5, 'Coerência de Propósito', 'Mantendo o foco', 
'# Mantendo o Propósito

## Erro comum
Começar com um propósito e terminar com outro.

## Exemplo de incoerência
*Início: "Proponho melhorias..."*
*Fim: "Portanto, o problema é complexo..."*
❌ Prometeu propor, mas apenas analisou

## Checklist
- [ ] Propósito claro na introdução?
- [ ] Mantido no desenvolvimento?
- [ ] Cumprido na conclusão?',
'[{"question": "Coerência de propósito significa:", "options": ["Mudar o objetivo", "Manter o foco do início ao fim", "Ter várias conclusões"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: ARGUMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unicamp', 3, 1, 'Argumentação na UNICAMP', 'Especificidades', 
'# Argumentação UNICAMP

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
- Manifesto: Mais enfático',
'[{"question": "Argumentação na UNICAMP deve ser:", "options": ["Sempre igual", "Adaptada ao gênero", "Apenas com dados"], "correct": 1}]',
30, 'free', 0),

('unicamp', 3, 2, 'Uso da Coletânea', 'Dialogando com os textos', 
'# Coletânea UNICAMP

## Função
Fornecer informações e perspectivas sobre o tema.

## Como usar
1. **Leia tudo:** Todos os textos
2. **Identifique:** Posições diferentes
3. **Não copie:** Parafraseie
4. **Dialogue:** Concorde ou discorde

## Erro grave
❌ Ignorar a coletânea
✅ Incorporar informações naturalmente',
'[{"question": "A coletânea deve ser:", "options": ["Ignorada", "Usada e dialogada", "Copiada literalmente"], "correct": 1}]',
35, 'previous', 0),

('unicamp', 3, 3, 'Contra-argumentação', 'Fortalecendo sua posição', 
'# Contra-argumentação

## O que é?
Antecipar e refutar objeções à sua tese.

## Estrutura
1. Apresente objeção possível
2. Refute com argumentos
3. Reforce sua posição

## Exemplo
*"Poder-se-ia argumentar que... Entretanto, tal visão ignora que... Portanto, reafirma-se que..."*

## Benefício
Demonstra pensamento crítico e maturidade argumentativa.',
'[{"question": "Contra-argumentação serve para:", "options": ["Enfraquecer sua tese", "Fortalecer sua posição", "Mudar de opinião"], "correct": 1}]',
40, 'previous', 0),

('unicamp', 3, 4, 'Repertório Sociocultural', 'Conhecimento de mundo', 
'# Repertório na UNICAMP

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
Colete exemplos versáteis que sirvam para múltiplos temas.',
'[{"question": "Repertório inclui:", "options": ["Apenas literatura", "Conhecimentos variados", "Apenas dados estatísticos"], "correct": 1}]',
45, 'previous', 0),

('unicamp', 3, 5, 'Progressão Argumentativa', 'Construindo raciocínio', 
'# Progressão no Texto

## O que é?
Cada parágrafo deve avançar a argumentação - não repetir.

## Estrutura progressiva
1. **Introdução:** Tese
2. **D1:** Primeiro argumento (mais simples)
3. **D2:** Segundo argumento (mais complexo)
4. **Conclusão:** Síntese e projeção

## Dica
Use conectivos de progressão: "além disso", "mais ainda", "sobretudo".',
'[{"question": "Progressão significa:", "options": ["Repetir ideias", "Avançar a argumentação", "Voltar ao início"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: LINGUAGEM (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('unicamp', 4, 1, 'Linguagem por Gênero', 'Adaptando o registro', 
'# Linguagem e Gênero

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
- Linguagem direta',
'[{"question": "Carta usa qual pessoa?", "options": ["Sempre 3ª pessoa", "1ª pessoa", "Depende do tema"], "correct": 1}]',
30, 'free', 0),

('unicamp', 4, 2, 'Adequação ao Interlocutor', 'Quem lê seu texto', 
'# Linguagem e Destinatário

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
- Explicar termos técnicos',
'[{"question": "Para autoridades usa-se:", "options": ["Gírias", "Pronomes de tratamento", "Linguagem coloquial"], "correct": 1}]',
35, 'previous', 0),

('unicamp', 4, 3, 'Coesão Textual', 'Conectando o texto', 
'# Coesão na UNICAMP

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
Varie os mecanismos de coesão.',
'[{"question": "Coesão se faz com:", "options": ["Apenas conectivos", "Conectivos e referenciação", "Apenas repetição"], "correct": 1}]',
40, 'previous', 0),

('unicamp', 4, 4, 'Gramática Essencial', 'Erros que custam nota', 
'# Revisão Gramatical

## Erros mais graves
1. **Concordância:** "Os alunos vai..."
2. **Regência:** "Assistir o filme..."
3. **Crase:** "Vou à mercado..."
4. **Pontuação:** Vírgula entre sujeito e verbo

## Estratégia
Reserve 10 minutos finais para revisão.

## Dica
Leia em voz baixa para identificar erros.',
'[{"question": "Quanto tempo para revisão?", "options": ["0 minutos", "10 minutos", "30 minutos"], "correct": 1}]',
45, 'previous', 0),

('unicamp', 4, 5, 'Revisão por Gênero', 'Checklist final', 
'# Checklist por Gênero

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
- [ ] Tom engajado?',
'[{"question": "Carta deve ter:", "options": ["Apenas texto", "Local, data, vocativo, despedida", "Título"], "correct": 1}]',
50, 'previous', 0);

SELECT 'Criadas lições FUVEST e UNICAMP!' as status;

-- Continua no próximo arquivo para UNESP e ITA...
