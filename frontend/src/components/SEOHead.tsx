import { useEffect } from 'react';

interface SEOHeadProps {
    title: string;
    description: string;
    canonical?: string;
    ogImage?: string;
    keywords?: string;
    noindex?: boolean;
}

/**
 * Componente para gerenciar meta tags SEO dinamicamente
 * Usado em páginas que precisam de meta tags específicas
 */
const SEOHead = ({
    title,
    description,
    canonical,
    ogImage = 'https://corrigeai.online/og-image.png',
    keywords,
    noindex = false
}: SEOHeadProps) => {
    useEffect(() => {
        // Title
        document.title = title;

        // Meta description
        let metaDesc = document.querySelector('meta[name="description"]');
        if (metaDesc) {
            metaDesc.setAttribute('content', description);
        }

        // Meta keywords
        if (keywords) {
            let metaKeywords = document.querySelector('meta[name="keywords"]');
            if (metaKeywords) {
                metaKeywords.setAttribute('content', keywords);
            }
        }

        // Robots
        let metaRobots = document.querySelector('meta[name="robots"]');
        if (metaRobots) {
            metaRobots.setAttribute('content', noindex ? 'noindex, nofollow' : 'index, follow');
        }

        // Canonical
        let canonicalLink = document.querySelector('link[rel="canonical"]');
        if (canonicalLink && canonical) {
            canonicalLink.setAttribute('href', canonical);
        }

        // Open Graph
        const ogTags = [
            { property: 'og:title', content: title },
            { property: 'og:description', content: description },
            { property: 'og:image', content: ogImage },
            { property: 'og:url', content: canonical || window.location.href }
        ];

        ogTags.forEach(({ property, content }) => {
            let tag = document.querySelector(`meta[property="${property}"]`);
            if (tag) {
                tag.setAttribute('content', content);
            }
        });

        // Twitter
        const twitterTags = [
            { property: 'twitter:title', content: title },
            { property: 'twitter:description', content: description },
            { property: 'twitter:image', content: ogImage }
        ];

        twitterTags.forEach(({ property, content }) => {
            let tag = document.querySelector(`meta[property="${property}"]`);
            if (tag) {
                tag.setAttribute('content', content);
            }
        });

        // Cleanup: restore defaults on unmount
        return () => {
            document.title = 'CorrigeAI - Correção de Redação ENEM Grátis com IA | Feedback em Segundos';
        };
    }, [title, description, canonical, ogImage, keywords, noindex]);

    return null; // Este componente não renderiza nada
};

export default SEOHead;
