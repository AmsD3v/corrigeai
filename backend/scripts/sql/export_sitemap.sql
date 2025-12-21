-- ============================================================
-- Script para exportar todos os slugs dos posts para sitemap
-- Execute e copie a saída para criar o sitemap
-- ============================================================

-- Exportar slugs dos posts publicados
SELECT 
    '  <url>' || chr(10) ||
    '    <loc>https://corrigeai.online/blog/' || slug || '</loc>' || chr(10) ||
    '    <lastmod>' || TO_CHAR(COALESCE(updated_at, created_at), 'YYYY-MM-DD') || '</lastmod>' || chr(10) ||
    '    <changefreq>monthly</changefreq>' || chr(10) ||
    '    <priority>0.7</priority>' || chr(10) ||
    '  </url>' as sitemap_entry
FROM blog_post 
WHERE is_published = true
ORDER BY created_at DESC;
