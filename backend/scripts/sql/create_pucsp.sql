-- PUC-SP (Pontifícia Universidade Católica de São Paulo) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/pucsp.sql

-- ============================================================================
-- CONQUISTAS PUC-SP
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações PUC-SP
('pucsp_essays_1', 'Primeira Redação PUC-SP', 'Enviou sua primeira redação PUC-SP', '📝', 'pucsp', 'essays_count', 1, 25, 0),
('pucsp_essays_5', 'Escritor PUC-SP', 'Enviou 5 redações PUC-SP', '✍️', 'pucsp', 'essays_count', 5, 50, 1),
('pucsp_essays_10', 'Redator Dedicado PUC-SP', 'Enviou 10 redações PUC-SP', '📚', 'pucsp', 'essays_count', 10, 100, 2),

-- Notas PUC-SP (0-100)
('pucsp_bronze', 'Nota Bronze PUC-SP', 'Atingiu 60+ na PUC-SP', '🥉', 'pucsp', 'score', 60, 100, 2),
('pucsp_prata', 'Nota Prata PUC-SP', 'Atingiu 80+ na PUC-SP', '🥈', 'pucsp', 'score', 80, 200, 5),
('pucsp_ouro', 'Nota Ouro PUC-SP', 'Atingiu 90+ na PUC-SP', '🥇', 'pucsp', 'score', 90, 300, 10),

-- Lições PUC-SP
('pucsp_lessons_5', 'Iniciante PUC-SP', 'Completou 5 lições da PUC-SP', '📖', 'pucsp', 'lessons', 5, 50, 1),
('pucsp_lessons_15', 'Estudante PUC-SP', 'Completou 15 lições da PUC-SP', '📚', 'pucsp', 'lessons', 15, 150, 3),
('pucsp_lessons_20', 'Mestre PUC-SP', 'Completou todas as 20 lições PUC-SP', '🎓', 'pucsp', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES PUC-SP - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura Textual, 3-Argumentação, 4-Domínio da Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('pucsp', 1, 1, 'A Redação PUC-SP', 'Conhecendo o vestibular', 
'# A Redação da PUC-SP

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
A PUC-SP valoriza reflexão crítica e posicionamento ético.',
'[{"question": "A PUC-SP é referência em:", "options": ["Engenharia", "Ciências Humanas e Direito"], "correct": 1}]',
30, 'free', 0),

('pucsp', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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

('pucsp', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Ética nas redes sociais

❌ "As redes sociais têm problemas"
✅ "A ética nas redes sociais demanda regulamentação que equilibre liberdade de expressão e responsabilidade digital"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('pucsp', 1, 4, 'Temas Humanísticos', 'Contexto PUC-SP', 
'# Temas da PUC-SP

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
- Teologia da Libertação',
'[{"question": "Paulo Freire era:", "options": ["Jurista", "Educador brasileiro"], "correct": 1}]',
45, 'previous', 0),

('pucsp', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para PUC-SP

## Tipos válidos
- Filosófico: pensadores clássicos
- Sociológico: autores contemporâneos
- Ético: direitos humanos
- Religioso: doutrina social

## Autores recomendados
- Paulo Freire
- Zygmunt Bauman
- Hannah Arendt
- Leonardo Boff',
'[{"question": "Bauman escreveu sobre:", "options": ["Biologia", "Modernidade líquida"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA TEXTUAL (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('pucsp', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('pucsp', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
'# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Citação filosófica
- Contextualização ética
- Pergunta reflexiva
- Dado social',
'[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]',
35, 'previous', 0),

('pucsp', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', 
'# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos.',
'[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]',
40, 'previous', 0),

('pucsp', 2, 4, 'Conectivos', 'Ligando ideias', 
'# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que',
'[{"question": "''Dessarte'' indica:", "options": ["Oposição", "Conclusão"], "correct": 1}]',
45, 'previous', 0),

('pucsp', 2, 5, 'Conclusão', 'Fechando o texto', 
'# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão ética

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: ARGUMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('pucsp', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
'# Argumentação

## Tipos principais
1. **Filosófico:** Pensadores
2. **Ético:** Valores e direitos
3. **Sociológico:** Análise social
4. **Autoridade:** Especialistas

## Estratégia
Use argumentos humanísticos.',
'[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]',
30, 'free', 0),

('pucsp', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Sob a ótica de Bauman..."

## Fórmula
AUTOR + conceito + aplicação ao tema',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('pucsp', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
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

('pucsp', 3, 4, 'Progressão', 'Avançando ideias', 
'# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento ético/filosófico
- D2: Argumento social/prático

## Conectivos
- "Além disso..."
- "Soma-se a isso..."',
'[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]',
45, 'previous', 0),

('pucsp', 3, 5, 'Repertório', 'Usando referências', 
'# Repertório

## Fontes confiáveis
- Filósofos: Kant, Arendt
- Sociólogos: Bauman, Durkheim
- Educadores: Paulo Freire
- Direitos Humanos: ONU

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente',
'[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO DA NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('pucsp', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('pucsp', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Houve mudanças'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
35, 'previous', 0),

('pucsp', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Referir-se à ética'' tem crase?", "options": ["Não", "Sim"], "correct": 1}]',
40, 'previous', 0),

('pucsp', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('pucsp', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist PUC-SP

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

**Reserve 10 minutos!**',
'[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]',
50, 'previous', 0);

SELECT 'PUC-SP: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'pucsp';
