import { useState, useEffect, useRef } from 'react';

interface LazyImageProps {
    src: string;
    alt: string;
    className?: string;
    style?: React.CSSProperties;
    width?: number | string;
    height?: number | string;
    placeholder?: string;
    fetchPriority?: 'high' | 'low' | 'auto';
}

/**
 * LazyImage - Componente de imagem com lazy loading nativo
 * Carrega imagens apenas quando estão prestes a entrar na viewport
 */
const LazyImage = ({
    src,
    alt,
    className,
    style,
    width,
    height,
    placeholder = 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300"%3E%3Crect fill="%231a1f2e" width="400" height="300"/%3E%3C/svg%3E',
    fetchPriority = 'auto'
}: LazyImageProps) => {
    const [isLoaded, setIsLoaded] = useState(false);
    const [isInView, setIsInView] = useState(false);
    const imgRef = useRef<HTMLImageElement>(null);

    useEffect(() => {
        // Use Intersection Observer for lazy loading
        const observer = new IntersectionObserver(
            (entries) => {
                entries.forEach((entry) => {
                    if (entry.isIntersecting) {
                        setIsInView(true);
                        observer.unobserve(entry.target);
                    }
                });
            },
            {
                rootMargin: '100px', // Start loading 100px before entering viewport
                threshold: 0.01
            }
        );

        if (imgRef.current) {
            observer.observe(imgRef.current);
        }

        return () => observer.disconnect();
    }, []);

    // Try to use WebP version if available
    const getWebPSrc = (originalSrc: string) => {
        // If already webp, return as is
        if (originalSrc.endsWith('.webp')) return originalSrc;

        // Replace extension with .webp
        const webpSrc = originalSrc.replace(/\.(png|jpg|jpeg)$/i, '.webp');
        return webpSrc;
    };

    const webpSrc = getWebPSrc(src);

    return (
        <picture>
            {/* WebP source for modern browsers */}
            {isInView && (
                <source srcSet={webpSrc} type="image/webp" />
            )}
            <img
                ref={imgRef}
                src={isInView ? src : placeholder}
                alt={alt}
                className={className}
                style={{
                    ...style,
                    opacity: isLoaded ? 1 : 0.5,
                    transition: 'opacity 0.3s ease-in-out',
                    backgroundColor: '#1a1f2e'
                }}
                width={width}
                height={height}
                loading="lazy"
                decoding="async"
                fetchPriority={fetchPriority}
                onLoad={() => setIsLoaded(true)}
            />
        </picture>
    );
};

export default LazyImage;
