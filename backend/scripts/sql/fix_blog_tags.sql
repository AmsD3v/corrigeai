-- ============================================================
-- Script para corrigir problemas do blog:
-- 1. Remover tag duplicada FUVEST (USP) 
-- 2. Verificar e ajustar associações de tags
-- ============================================================

-- Ver as tags FUVEST existentes
SELECT id, name, slug FROM blog_tag WHERE slug LIKE '%fuvest%';

-- Remover a tag duplicada "FUVEST (USP)" se existir
-- Primeiro mover posts da tag duplicada para a tag principal
UPDATE blog_post_tag 
SET tag_id = (SELECT id FROM blog_tag WHERE slug = 'fuvest' LIMIT 1)
WHERE tag_id = (SELECT id FROM blog_tag WHERE slug = 'fuvest-usp' LIMIT 1)
AND (SELECT id FROM blog_tag WHERE slug = 'fuvest-usp' LIMIT 1) IS NOT NULL;

-- Deletar a tag duplicada
DELETE FROM blog_tag WHERE slug = 'fuvest-usp';

-- Verificar tag "As 5 Competências do ENEM Explicadas"
SELECT id, name, slug FROM blog_tag WHERE name LIKE '%Compet%' OR slug LIKE '%compet%';

-- Ver quantos posts existem com cada tag de competências
SELECT bt.id, bt.name, bt.slug, COUNT(bpt.post_id) as post_count
FROM blog_tag bt
LEFT JOIN blog_post_tag bpt ON bt.id = bpt.tag_id
WHERE bt.name LIKE '%Compet%' OR bt.slug LIKE '%compet%' OR bt.name LIKE '%ENEM%'
GROUP BY bt.id, bt.name, bt.slug
ORDER BY post_count DESC;

-- Ver todas as tags PUC
SELECT id, name, slug FROM blog_tag WHERE name LIKE '%PUC%' ORDER BY name;

-- Verificar se existem posts para PUC-SP
SELECT COUNT(*) as pucsp_posts FROM blog_post WHERE title LIKE '%PUC-SP%' OR title LIKE '%PUCSP%';
