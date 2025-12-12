-- UFAM (Universidade Federal do Amazonas) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/ufam.sql

-- ============================================================================
-- CONQUISTAS UFAM
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações UFAM
('ufam_essays_1', 'Primeira Redação UFAM', 'Enviou sua primeira redação UFAM', '📝', 'ufam', 'essays_count', 1, 25, 0),
('ufam_essays_5', 'Escritor UFAM', 'Enviou 5 redações UFAM', '✍️', 'ufam', 'essays_count', 5, 50, 1),
('ufam_essays_10', 'Redator Dedicado UFAM', 'Enviou 10 redações UFAM', '📚', 'ufam', 'essays_count', 10, 100, 2),

-- Notas UFAM (0-100)
('ufam_bronze', 'Nota Bronze UFAM', 'Atingiu 60+ na UFAM', '🥉', 'ufam', 'score', 60, 100, 2),
('ufam_prata', 'Nota Prata UFAM', 'Atingiu 80+ na UFAM', '🥈', 'ufam', 'score', 80, 200, 5),
('ufam_ouro', 'Nota Ouro UFAM', 'Atingiu 90+ na UFAM', '🥇', 'ufam', 'score', 90, 300, 10),

-- Lições UFAM
('ufam_lessons_5', 'Iniciante UFAM', 'Completou 5 lições da UFAM', '📖', 'ufam', 'lessons', 5, 50, 1),
('ufam_lessons_15', 'Estudante UFAM', 'Completou 15 lições da UFAM', '📚', 'ufam', 'lessons', 15, 150, 3),
('ufam_lessons_20', 'Mestre UFAM', 'Completou todas as 20 lições UFAM', '🎓', 'ufam', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES UFAM - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura e Organização, 3-Argumentação, 4-Domínio da Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufam', 1, 1, 'A Redação UFAM', 'Conhecendo o vestibular', 
'# A Redação da UFAM

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
A UFAM valoriza conhecimentos sobre a Amazônia e questões socioambientais.',
'[{"question": "A UFAM está localizada em:", "options": ["Belém", "Manaus", "Rio Branco"], "correct": 1}, {"question": "A UFAM é a mais antiga do:", "options": ["Brasil", "Região Norte", "Nordeste"], "correct": 1}]',
30, 'free', 0),

('ufam', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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
❌ Tangenciar = nota muito baixa
❌ Copiar textos de apoio',
'[{"question": "Fugir do tema resulta em:", "options": ["Desconto", "Nota zero"], "correct": 1}]',
35, 'previous', 0),

('ufam', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

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
✅ "O desenvolvimento sustentável amazônico requer equilíbrio entre preservação ambiental e geração de renda para comunidades locais"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('ufam', 1, 4, 'Temas Regionais', 'Contexto amazônico', 
'# Temas Relevantes para UFAM

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
- Dados do INPE/IBAMA',
'[{"question": "O Rio Negro encontra o Rio Solimões em:", "options": ["Belém", "Manaus", "Santarém"], "correct": 1}]',
45, 'previous', 0),

('ufam', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para UFAM

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
- Povos ribeirinhos',
'[{"question": "O Teatro Amazonas é símbolo de:", "options": ["Ciclo do café", "Ciclo da borracha"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA E ORGANIZAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufam', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('ufam', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
'# A Introdução

## Elementos
1. Contextualização do tema
2. Apresentação do assunto
3. Tese clara

## Estratégias de abertura
- Dado estatístico
- Citação relevante
- Contextualização histórica
- Pergunta retórica',
'[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]',
35, 'previous', 0),

('ufam', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', 
'# Desenvolvimento

## Estrutura do Parágrafo
1. Tópico frasal (ideia principal)
2. Fundamentação (argumento)
3. Exemplo ou dado
4. Análise crítica
5. Conexão com a tese

## Quantidade
2 parágrafos bem desenvolvidos são ideais.',
'[{"question": "Parágrafo começa com:", "options": ["Exemplo", "Tópico frasal"], "correct": 1}]',
40, 'previous', 0),

('ufam', 2, 4, 'Conectivos', 'Ligando ideias', 
'# Conectivos Essenciais

## Adição
Além disso, ademais, outrossim

## Oposição
Contudo, entretanto, todavia

## Conclusão
Portanto, logo, destarte

## Causa
Porque, visto que, uma vez que',
'[{"question": "''Todavia'' indica:", "options": ["Adição", "Oposição"], "correct": 1}]',
45, 'previous', 0),

('ufam', 2, 5, 'Conclusão', 'Fechando o texto', 
'# A Conclusão

## Elementos
1. Retomada da tese
2. Síntese dos argumentos
3. Proposta ou reflexão final

## Evite
- Novas informações
- Repetir a introdução
- Frases genéricas',
'[{"question": "Conclusão pode ter argumento novo?", "options": ["Sim", "Não"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 3: ARGUMENTAÇÃO (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufam', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
'# Argumentação

## Tipos principais
1. **Dados:** Estatísticas, pesquisas
2. **Exemplos:** Casos concretos
3. **Autoridade:** Especialistas
4. **Causa-consequência:** Relações lógicas

## Estratégia
Use ao menos 2 tipos diferentes.',
'[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]',
30, 'free', 0),

('ufam', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## O que diferencia notas altas
Não basta citar - é preciso ANALISAR.

## Níveis
❌ "O INPE mostra que..."
⚠️ "...o que é preocupante"
✅ "...revelando necessidade urgente de políticas de proteção"

## Fórmula
DADO + interpretação + consequência',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('ufam', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
'# Coerência

## Princípio
Argumentos devem apoiar a tese.

## Problemas comuns
❌ Argumentos contraditórios
❌ Exemplos que não comprovam
❌ Conclusão oposta ao defendido

## Teste
Pergunte: "Isso prova minha tese?"',
'[{"question": "Argumentos devem:", "options": ["Ser variados", "Apoiar a tese"], "correct": 1}]',
40, 'previous', 0),

('ufam', 3, 4, 'Progressão', 'Avançando ideias', 
'# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura sugerida
- D1: Argumento mais simples
- D2: Argumento mais complexo

## Conectivos
- "Além disso..."
- "Soma-se a isso..."',
'[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]',
45, 'previous', 0),

('ufam', 3, 5, 'Repertório Amazônico', 'Referências regionais', 
'# Repertório para UFAM

## Autores úteis
- Milton Hatoum (escritor amazonense)
- Thiago de Mello (poeta)
- Márcio Souza (escritor)

## Temas
- Encontro das águas
- Zona Franca
- Ciclo da borracha
- Boi-bumbá
- Ciência na Amazônia',
'[{"question": "Milton Hatoum é:", "options": ["Cientista", "Escritor amazonense"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO DA NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('ufam', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('ufam', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular (havia, faz)

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Faz dois anos'' é:", "options": ["Incorreto", "Correto (impessoal)"], "correct": 1}]',
35, 'previous', 0),

('ufam', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A → Assisti AO jogo
- Visar (objetivar): A → Visa AO sucesso
- Preferir: A → Prefiro café A chá

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Namorar com ela'' é:", "options": ["Correto", "Incorreto (verbo direto)"], "correct": 1}]',
40, 'previous', 0),

('ufam', 4, 4, 'Pontuação', 'Vírgulas e mais', 
'# Pontuação

## Vírgula - USA-SE
- Separar itens de lista
- Após advérbios deslocados
- Isolar apostos

## Vírgula - NÃO USA-SE
- Entre sujeito e verbo
- Entre verbo e complemento',
'[{"question": "Vírgula entre sujeito e verbo:", "options": ["Permitido", "Proibido"], "correct": 1}]',
45, 'previous', 0),

('ufam', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist UFAM

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

SELECT 'UFAM: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'ufam';
