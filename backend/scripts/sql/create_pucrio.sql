-- PUC-Rio (Pontifícia Universidade Católica do Rio de Janeiro) - Conquistas e 20 Lições
-- Execute: docker exec -it prosaai_db psql -U user -d prosaai -f /tmp/pucrio.sql

-- ============================================================================
-- CONQUISTAS PUC-Rio
-- ============================================================================

INSERT INTO achievement (code, name, description, icon, exam_type, condition_type, condition_value, xp_reward, coin_reward) VALUES
-- Redações PUC-Rio
('pucrio_essays_1', 'Primeira Redação PUC-Rio', 'Enviou sua primeira redação PUC-Rio', '📝', 'pucrio', 'essays_count', 1, 25, 0),
('pucrio_essays_5', 'Escritor PUC-Rio', 'Enviou 5 redações PUC-Rio', '✍️', 'pucrio', 'essays_count', 5, 50, 1),
('pucrio_essays_10', 'Redator Dedicado PUC-Rio', 'Enviou 10 redações PUC-Rio', '📚', 'pucrio', 'essays_count', 10, 100, 2),

-- Notas PUC-Rio (0-100)
('pucrio_bronze', 'Nota Bronze PUC-Rio', 'Atingiu 60+ na PUC-Rio', '🥉', 'pucrio', 'score', 60, 100, 2),
('pucrio_prata', 'Nota Prata PUC-Rio', 'Atingiu 80+ na PUC-Rio', '🥈', 'pucrio', 'score', 80, 200, 5),
('pucrio_ouro', 'Nota Ouro PUC-Rio', 'Atingiu 90+ na PUC-Rio', '🥇', 'pucrio', 'score', 90, 300, 10),

-- Lições PUC-Rio
('pucrio_lessons_5', 'Iniciante PUC-Rio', 'Completou 5 lições da PUC-Rio', '📖', 'pucrio', 'lessons', 5, 50, 1),
('pucrio_lessons_15', 'Estudante PUC-Rio', 'Completou 15 lições da PUC-Rio', '📚', 'pucrio', 'lessons', 15, 150, 3),
('pucrio_lessons_20', 'Mestre PUC-Rio', 'Completou todas as 20 lições PUC-Rio', '🎓', 'pucrio', 'lessons', 20, 300, 5);

-- ============================================================================
-- LIÇÕES PUC-Rio - 20 (5 por critério)
-- Critérios: 1-Adequação ao Tema, 2-Estrutura Textual, 3-Argumentação, 4-Domínio da Norma Culta
-- ============================================================================

-- CRITÉRIO 1: ADEQUAÇÃO AO TEMA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('pucrio', 1, 1, 'A Redação PUC-Rio', 'Conhecendo o vestibular', 
'# A Redação da PUC-Rio

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
Excelência acadêmica e tradição carioca.',
'[{"question": "A PUC-Rio fica na:", "options": ["Zona Sul", "Gávea (Rio de Janeiro)"], "correct": 1}]',
30, 'free', 0),

('pucrio', 1, 2, 'Interpretando o Tema', 'Compreensão correta', 
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

('pucrio', 1, 3, 'Tese Clara', 'Posicionamento objetivo', 
'# Construindo a Tese

## O que é tese?
Seu posicionamento claro sobre o tema.

## Características
- Clara e objetiva
- Defensável com argumentos
- Presente na introdução

## Exemplo
**Tema:** Cultura e identidade carioca

❌ "A cultura carioca é importante"
✅ "A preservação da identidade cultural carioca demanda políticas que valorizem as manifestações populares enquanto integram a diversidade contemporânea"',
'[{"question": "A tese deve ser:", "options": ["Vaga", "Clara e defensável"], "correct": 1}]',
40, 'previous', 0),

('pucrio', 1, 4, 'Temas Cariocas', 'Contexto PUC-Rio', 
'# Temas da PUC-Rio

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
- Cristo Redentor (patrimônio)',
'[{"question": "Machado de Assis nasceu no:", "options": ["São Paulo", "Rio de Janeiro"], "correct": 1}]',
45, 'previous', 0),

('pucrio', 1, 5, 'Repertório Sociocultural', 'Fontes para argumentar', 
'# Repertório para PUC-Rio

## Tipos válidos
- Literário: autores cariocas
- Cultural: música e arte
- Histórico: capital do Brasil
- Social: urbanização

## Autores cariocas
- Machado de Assis
- Clarice Lispector
- Lima Barreto
- Rubem Fonseca',
'[{"question": "Clarice Lispector escreveu:", "options": ["Germinal", "A Hora da Estrela"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 2: ESTRUTURA TEXTUAL (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('pucrio', 2, 1, 'Estrutura Dissertativa', 'Organizando o texto', 
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

('pucrio', 2, 2, 'Introdução Eficaz', 'Abrindo o texto', 
'# A Introdução

## Elementos
1. Contextualização
2. Apresentação do tema
3. Tese clara

## Estratégias
- Citação literária
- Contextualização cultural
- Dado estatístico
- Pergunta retórica',
'[{"question": "Introdução deve ter:", "options": ["Apenas tese", "Contexto + tese"], "correct": 1}]',
35, 'previous', 0),

('pucrio', 2, 3, 'Parágrafos de Desenvolvimento', 'Argumentando', 
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

('pucrio', 2, 4, 'Conectivos', 'Ligando ideias', 
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

('pucrio', 2, 5, 'Conclusão', 'Fechando o texto', 
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
('pucrio', 3, 1, 'Tipos de Argumento', 'Construindo defesas', 
'# Argumentação

## Tipos principais
1. **Literário:** Obras e autores
2. **Cultural:** Música e arte
3. **Histórico:** Fatos e contextos
4. **Sociológico:** Análise social

## Estratégia
Use repertório cultural variado.',
'[{"question": "Quantos tipos usar:", "options": ["1", "2 ou mais"], "correct": 1}]',
30, 'free', 0),

('pucrio', 3, 2, 'Análise Crítica', 'Aprofundando', 
'# Análise Crítica

## Níveis
❌ Básico: "Isso é ruim"
⚠️ Médio: "Isso prejudica"
✅ Avançado: "Como observou Machado..."

## Fórmula
AUTOR + obra/conceito + aplicação',
'[{"question": "Análise crítica exige:", "options": ["Apenas citar", "Interpretar"], "correct": 1}]',
35, 'previous', 0),

('pucrio', 3, 3, 'Coerência Argumentativa', 'Lógica do texto', 
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

('pucrio', 3, 4, 'Progressão', 'Avançando ideias', 
'# Progressão Argumentativa

## Princípio
Cada parágrafo adiciona informação nova.

## Estrutura
- D1: Argumento cultural/literário
- D2: Argumento social/histórico

## Conectivos
- "Além disso..."
- "Soma-se a isso..."',
'[{"question": "Progressão significa:", "options": ["Repetir", "Avançar"], "correct": 1}]',
45, 'previous', 0),

('pucrio', 3, 5, 'Repertório', 'Usando referências', 
'# Repertório

## Fontes confiáveis
- Literatura brasileira
- História do Rio
- Música Popular Brasileira
- Artes visuais

## Como usar
1. Cite corretamente
2. Relacione com o tema
3. Analise criticamente',
'[{"question": "Repertório deve ser:", "options": ["Inventado", "De fontes confiáveis"], "correct": 1}]',
50, 'previous', 0);

-- CRITÉRIO 4: DOMÍNIO DA NORMA CULTA (5 lições)
INSERT INTO lesson (exam_type, competency, "order", title, description, content, quiz_data, xp_reward, unlock_type, unlock_value) VALUES
('pucrio', 4, 1, 'Norma Culta', 'Gramática essencial', 
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

('pucrio', 4, 2, 'Concordância', 'Verbal e nominal', 
'# Concordância

## Verbal
Verbo concorda com sujeito.

## Casos especiais
- Sujeito composto: plural
- Verbos impessoais: singular

## Nominal
Adjetivos concordam com substantivos.',
'[{"question": "''Houve manifestações'' é:", "options": ["Incorreto", "Correto"], "correct": 1}]',
35, 'previous', 0),

('pucrio', 4, 3, 'Regência e Crase', 'Preposições corretas', 
'# Regência

## Verbos importantes
- Assistir (ver): A
- Visar (objetivar): A
- Preferir: A (não "do que")

## Crase
a + a = à
Antes de femininas determinadas.',
'[{"question": "''Ir à Gávea'' tem crase?", "options": ["Não", "Sim (bairro feminino)"], "correct": 1}]',
40, 'previous', 0),

('pucrio', 4, 4, 'Pontuação', 'Vírgulas e mais', 
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

('pucrio', 4, 5, 'Revisão Final', 'Checklist', 
'# Checklist PUC-Rio

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

**Reserve 10 minutos!**',
'[{"question": "Tempo para revisão:", "options": ["0 min", "10 min"], "correct": 1}]',
50, 'previous', 0);

SELECT 'PUC-Rio: Criadas conquistas e ' || COUNT(*) || ' lições!' as status FROM lesson WHERE exam_type = 'pucrio';
