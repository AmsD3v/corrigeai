-- ============================================================
-- Artigo: Tema ENEM 2025 - Perspectivas sobre Envelhecimento
-- Execute no banco de dados para adicionar o post
-- ============================================================

-- Garantir que a tag existe
INSERT INTO blog_tags (name, slug, created_at)
SELECT 'ENEM 2025', 'enem-2025', NOW()
WHERE NOT EXISTS (SELECT 1 FROM blog_tags WHERE slug = 'enem-2025');

INSERT INTO blog_tags (name, slug, created_at)
SELECT 'Temas de Redação', 'temas-de-redacao', NOW()
WHERE NOT EXISTS (SELECT 1 FROM blog_tags WHERE slug = 'temas-de-redacao');

INSERT INTO blog_tags (name, slug, created_at)
SELECT 'Repertórios', 'repertorios', NOW()
WHERE NOT EXISTS (SELECT 1 FROM blog_tags WHERE slug = 'repertorios');

-- Inserir o artigo sobre o tema ENEM 2025
INSERT INTO blog_posts (
    title,
    slug,
    excerpt,
    content,
    is_published,
    published_at,
    author_name,
    created_at,
    updated_at
) VALUES (
    'Tema ENEM 2025: Perspectivas sobre o Envelhecimento na Sociedade Brasileira',
    'tema-enem-2025-envelhecimento-sociedade-brasileira',
    'Análise completa do tema da redação do ENEM 2025, com repertórios socioculturais, argumentos e dicas para sua redação sobre o envelhecimento populacional no Brasil.',
    '# Perspectivas Acerca do Envelhecimento na Sociedade Brasileira

O tema da **redação do ENEM 2025** trouxe uma discussão fundamental para a sociedade contemporânea: **"Perspectivas acerca do envelhecimento na sociedade brasileira"**. Este é um tema que reflete as transformações demográficas que o Brasil está vivenciando.

## Entendendo o Contexto

O Brasil está passando por uma **transição demográfica acelerada**. Segundo dados do IBGE (2023), a população idosa (60 anos ou mais) representa cerca de **15% da população total**, com projeção de alcançar **30% até 2050**. Essa mudança traz desafios e oportunidades que precisam ser discutidos.

### Dados Importantes para sua Redação

- **Expectativa de vida:** Aumentou de 45 anos (1940) para mais de 76 anos (2023)
- **Taxa de fecundidade:** Caiu de 6,3 filhos por mulher (1960) para 1,6 (2023)
- **Proporção de idosos:** Cresceu 56% nos últimos 20 anos

## Repertórios Socioculturais

### 1. Referências Filosóficas e Sociológicas

> **Simone de Beauvoir** (*A Velhice*, 1970): "É preciso preparar bem a velhice, mas também preparar uma sociedade que não afaste dela o ancião."

> **Zygmunt Bauman** (*Modernidade Líquida*): Discute como sociedades contemporâneas tendem a desconsiderar a experiência e sabedoria acumuladas pelos mais velhos.

### 2. Referências Literárias

- **"A Hora da Estrela"** (Clarice Lispector): Macabéa representa personagens marginalizados pela sociedade
- **"Memórias Póstumas de Brás Cubas"** (Machado de Assis): Reflexões sobre a passagem do tempo e envelhecimento

### 3. Referências Cinematográficas

- **"Amour"** (2012, Michael Haneke): Retrata os desafios do envelhecimento e dependência
- **"Up - Altas Aventuras"** (2009, Pixar): Mostra a importância de dar propósito à vida na terceira idade

### 4. Dados e Estatísticas

- **Estatuto do Idoso** (Lei nº 10.741/2003): Garante direitos fundamentais às pessoas idosas
- **Política Nacional do Idoso** (Lei nº 8.842/1994): Primeira lei específica para idosos no Brasil
- **OMS**: Classifica o Brasil como "envelhecendo rapidamente" até 2050

## Possíveis Abordagens

### Abordagem 1: Desafios Econômicos e Previdenciários
- Reforma da Previdência e seus impactos
- Sustentabilidade do sistema de aposentadorias
- Necessidade de políticas públicas adaptadas

### Abordagem 2: Exclusão Social e Etarismo
- Mercado de trabalho e discriminação por idade
- Isolamento social de idosos
- Importância da inclusão digital

### Abordagem 3: Saúde e Qualidade de Vida
- Sistema de saúde preparado para o envelhecimento
- Doenças crônicas e cuidados de longa duração
- Promoção do envelhecimento ativo

## Estrutura de Redação Modelo

### Introdução
Apresente a realidade demográfica brasileira e a tese sobre a necessidade de repensar políticas sociais.

### Desenvolvimento 1
Discuta os desafios atuais enfrentados pela população idosa (etarismo, exclusão, saúde).

### Desenvolvimento 2
Apresente soluções e exemplos de países que lidaram bem com o envelhecimento (Japão, países nórdicos).

### Conclusão
Proponha uma intervenção detalhada envolvendo agentes, ações, meios, finalidades e responsáveis.

## Como a IA do CorrigeAI Analisa Este Tema

Nossa inteligência artificial foi **treinada especificamente** para avaliar redações sobre temas contemporâneos como este. Ao submeter sua redação, você receberá:

1. **Análise da Competência 2**: Verificação se você compreendeu a proposta e aplicou repertório pertinente
2. **Avaliação de Repertórios**: Identificação de citações, dados e referências utilizadas
3. **Proposta de Intervenção**: Verificação dos 5 elementos obrigatórios (agente, ação, meio, finalidade, detalhamento)

## Dicas Finais

- ✅ Use dados atualizados do IBGE e IPEA
- ✅ Cite o Estatuto do Idoso como base legal
- ✅ Evite generalizações e estereótipos sobre idosos
- ✅ Proponha soluções práticas e viáveis
- ✅ Conecte o tema à realidade brasileira específica

---

**Pratique agora!** Use o CorrigeAI para corrigir sua redação sobre este tema e receba feedback detalhado em segundos.

[Começar Correção Gratuita](/cadastro)',
    true,
    NOW(),
    'CorrigeAI',
    NOW(),
    NOW()
) ON CONFLICT (slug) DO NOTHING;

-- Associar tags ao post
INSERT INTO blog_post_tags (post_id, tag_id)
SELECT 
    (SELECT id FROM blog_posts WHERE slug = 'tema-enem-2025-envelhecimento-sociedade-brasileira'),
    (SELECT id FROM blog_tags WHERE slug = 'enem-2025')
WHERE NOT EXISTS (
    SELECT 1 FROM blog_post_tags 
    WHERE post_id = (SELECT id FROM blog_posts WHERE slug = 'tema-enem-2025-envelhecimento-sociedade-brasileira')
    AND tag_id = (SELECT id FROM blog_tags WHERE slug = 'enem-2025')
);

INSERT INTO blog_post_tags (post_id, tag_id)
SELECT 
    (SELECT id FROM blog_posts WHERE slug = 'tema-enem-2025-envelhecimento-sociedade-brasileira'),
    (SELECT id FROM blog_tags WHERE slug = 'temas-de-redacao')
WHERE NOT EXISTS (
    SELECT 1 FROM blog_post_tags 
    WHERE post_id = (SELECT id FROM blog_posts WHERE slug = 'tema-enem-2025-envelhecimento-sociedade-brasileira')
    AND tag_id = (SELECT id FROM blog_tags WHERE slug = 'temas-de-redacao')
);

INSERT INTO blog_post_tags (post_id, tag_id)
SELECT 
    (SELECT id FROM blog_posts WHERE slug = 'tema-enem-2025-envelhecimento-sociedade-brasileira'),
    (SELECT id FROM blog_tags WHERE slug = 'repertorios')
WHERE NOT EXISTS (
    SELECT 1 FROM blog_post_tags 
    WHERE post_id = (SELECT id FROM blog_posts WHERE slug = 'tema-enem-2025-envelhecimento-sociedade-brasileira')
    AND tag_id = (SELECT id FROM blog_tags WHERE slug = 'repertorios')
);

-- Verificar se foi criado
SELECT id, title, slug, is_published FROM blog_posts 
WHERE slug = 'tema-enem-2025-envelhecimento-sociedade-brasileira';
