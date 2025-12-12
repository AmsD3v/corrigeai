import { useState, useEffect } from 'react';
import { useParams, Link, useNavigate } from 'react-router-dom';
import Header from '../components/Header';
import api from '../services/api';
import { marked } from 'marked';

interface BlogTag {
    id: number;
    name: string;
    slug: string;
    color: string;
}

interface BlogPost {
    id: number;
    title: string;
    slug: string;
    excerpt: string | null;
    content: string;
    cover_image: string | null;
    meta_title: string | null;
    meta_description: string | null;
    is_published: boolean;
    published_at: string | null;
    created_at: string;
    updated_at: string;
    tags: BlogTag[];
}

const BlogPost = () => {
    const { slug } = useParams<{ slug: string }>();
    const navigate = useNavigate();
    const [post, setPost] = useState<BlogPost | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        if (slug) {
            loadPost();
        }
    }, [slug]);

    // Update document title and meta tags for SEO
    useEffect(() => {
        if (post) {
            // Title
            document.title = post.meta_title || `${post.title} | CorrigeAI Blog`;

            // Meta description
            const metaDesc = document.querySelector('meta[name="description"]');
            if (metaDesc) {
                metaDesc.setAttribute('content', post.meta_description || post.excerpt || '');
            }

            // OG tags
            const ogTitle = document.querySelector('meta[property="og:title"]');
            if (ogTitle) ogTitle.setAttribute('content', post.meta_title || post.title);

            const ogDesc = document.querySelector('meta[property="og:description"]');
            if (ogDesc) ogDesc.setAttribute('content', post.meta_description || post.excerpt || '');

            if (post.cover_image) {
                const ogImage = document.querySelector('meta[property="og:image"]');
                if (ogImage) ogImage.setAttribute('content', post.cover_image);
            }
        }

        // Cleanup: restore default title on unmount
        return () => {
            document.title = 'CorrigeAI - Correção de Redação ENEM Grátis com IA';
        };
    }, [post]);

    const loadPost = async () => {
        try {
            setLoading(true);
            const response = await api.get(`/api/blog/posts/${slug}`);
            setPost(response.data);
        } catch (error: any) {
            console.error('Erro ao carregar post:', error);
            if (error.response?.status === 404) {
                setError('Post não encontrado');
            } else {
                setError('Erro ao carregar post');
            }
        } finally {
            setLoading(false);
        }
    };

    const formatDate = (dateStr: string) => {
        return new Date(dateStr).toLocaleDateString('pt-BR', {
            day: '2-digit',
            month: 'long',
            year: 'numeric'
        });
    };

    const renderMarkdown = (content: string) => {
        return { __html: marked(content) };
    };

    if (loading) {
        return (
            <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
                <Header />
                <div style={{ textAlign: 'center', padding: '100px 20px', color: '#94a3b8' }}>
                    Carregando post...
                </div>
            </div>
        );
    }

    if (error || !post) {
        return (
            <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
                <Header />
                <div style={{ textAlign: 'center', padding: '100px 20px' }}>
                    <div style={{ fontSize: '64px', marginBottom: '24px' }}>😕</div>
                    <h1 style={{ color: '#fff', fontSize: '32px', marginBottom: '16px' }}>
                        {error || 'Post não encontrado'}
                    </h1>
                    <button
                        onClick={() => navigate('/blog')}
                        style={{
                            padding: '12px 32px',
                            background: '#4F46E5',
                            border: 'none',
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '16px',
                            fontWeight: '600',
                            cursor: 'pointer'
                        }}
                    >
                        Voltar ao Blog
                    </button>
                </div>
            </div>
        );
    }

    return (
        <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
            <Header />

            <main style={{ maxWidth: '800px', margin: '0 auto', padding: '40px 20px' }}>
                {/* Breadcrumb */}
                <nav style={{ marginBottom: '32px' }}>
                    <Link
                        to="/blog"
                        style={{
                            color: '#4F46E5',
                            textDecoration: 'none',
                            fontSize: '14px',
                            display: 'inline-flex',
                            alignItems: 'center',
                            gap: '8px'
                        }}
                    >
                        ← Voltar ao Blog
                    </Link>
                </nav>

                {/* Cover Image with Title Overlay */}
                {post.cover_image && (
                    <div style={{
                        borderRadius: '16px',
                        overflow: 'hidden',
                        marginBottom: '32px',
                        position: 'relative'
                    }}>
                        <img
                            src={post.cover_image}
                            alt={post.title}
                            style={{
                                width: '100%',
                                height: 'auto',
                                minHeight: '300px',
                                maxHeight: '400px',
                                objectFit: 'cover',
                                display: 'block'
                            }}
                        />
                        {/* Gradient Overlay */}
                        <div style={{
                            position: 'absolute',
                            inset: 0,
                            background: 'linear-gradient(to top, rgba(0,0,0,0.8) 0%, rgba(0,0,0,0.4) 50%, rgba(0,0,0,0.2) 100%)',
                            display: 'flex',
                            flexDirection: 'column',
                            justifyContent: 'flex-end',
                            padding: '32px'
                        }}>
                            {/* Title on image */}
                            <h1 style={{
                                fontSize: 'clamp(24px, 5vw, 40px)',
                                fontWeight: '800',
                                color: '#fff',
                                margin: 0,
                                lineHeight: '1.2',
                                textShadow: '0 2px 10px rgba(0,0,0,0.5)'
                            }}>
                                {post.title}
                            </h1>
                            {/* Tags below title */}
                            {post.tags.length > 0 && (
                                <div style={{
                                    display: 'flex',
                                    gap: '8px',
                                    marginTop: '16px',
                                    flexWrap: 'wrap'
                                }}>
                                    {post.tags.map(tag => (
                                        <span
                                            key={tag.id}
                                            style={{
                                                padding: '4px 12px',
                                                borderRadius: '12px',
                                                background: tag.color,
                                                color: '#fff',
                                                fontSize: '12px',
                                                fontWeight: '600'
                                            }}
                                        >
                                            {tag.name}
                                        </span>
                                    ))}
                                </div>
                            )}
                        </div>
                    </div>
                )}

                {/* Tags - only show here if no cover image (otherwise shown in overlay) */}
                {!post.cover_image && post.tags.length > 0 && (
                    <div style={{
                        display: 'flex',
                        gap: '8px',
                        marginBottom: '16px',
                        flexWrap: 'wrap'
                    }}>
                        {post.tags.map(tag => (
                            <Link
                                key={tag.id}
                                to={`/blog?tag=${tag.slug}`}
                                style={{
                                    padding: '6px 14px',
                                    borderRadius: '16px',
                                    background: `${tag.color}20`,
                                    color: tag.color,
                                    fontSize: '13px',
                                    fontWeight: '600',
                                    textDecoration: 'none'
                                }}
                            >
                                {tag.name}
                            </Link>
                        ))}
                    </div>
                )}

                {/* Title - only show here if no cover image (otherwise shown in overlay) */}
                {!post.cover_image && (
                    <h1 style={{
                        fontSize: '40px',
                        fontWeight: '800',
                        color: '#fff',
                        marginBottom: '16px',
                        lineHeight: '1.3'
                    }}>
                        {post.title}
                    </h1>
                )}

                {/* Date */}
                <div style={{
                    fontSize: '14px',
                    color: '#64748b',
                    marginBottom: '40px',
                    paddingBottom: '24px',
                    borderBottom: '1px solid #334155'
                }}>
                    Publicado em {post.published_at ? formatDate(post.published_at) : formatDate(post.created_at)}
                </div>

                {/* Content - Markdown Rendered */}
                <article
                    className="blog-content"
                    style={{
                        color: '#e2e8f0',
                        fontSize: '18px',
                        lineHeight: '1.8'
                    }}
                    dangerouslySetInnerHTML={renderMarkdown(post.content)}
                />

                {/* Share / CTA */}
                <div style={{
                    marginTop: '60px',
                    padding: '32px',
                    background: '#1a1f2e',
                    borderRadius: '16px',
                    border: '1px solid #334155',
                    textAlign: 'center'
                }}>
                    <h3 style={{
                        color: '#fff',
                        fontSize: '24px',
                        fontWeight: '700',
                        marginBottom: '12px'
                    }}>
                        Quer melhorar sua redação?
                    </h3>
                    <p style={{
                        color: '#94a3b8',
                        marginBottom: '24px'
                    }}>
                        Corrija suas redações gratuitamente com nossa IA
                    </p>
                    <Link
                        to="/cadastro"
                        style={{
                            display: 'inline-block',
                            padding: '14px 40px',
                            background: 'linear-gradient(135deg, #4F46E5, #7C3AED)',
                            borderRadius: '12px',
                            color: '#fff',
                            fontSize: '16px',
                            fontWeight: '600',
                            textDecoration: 'none'
                        }}
                    >
                        Começar Grátis
                    </Link>
                </div>
            </main>

            {/* Footer */}
            <footer style={{
                padding: '40px 20px',
                textAlign: 'center',
                borderTop: '1px solid #334155',
                marginTop: '60px'
            }}>
                <p style={{ color: '#64748b', fontSize: '14px' }}>
                    © {new Date().getFullYear()} CorrigeAI. Todos os direitos reservados.
                </p>
            </footer>

            {/* Markdown Styles */}
            <style>{`
                .blog-content h1 { font-size: 2em; font-weight: 800; margin: 1.5em 0 0.5em; color: #fff; }
                .blog-content h2 { font-size: 1.5em; font-weight: 700; margin: 1.5em 0 0.5em; color: #fff; }
                .blog-content h3 { font-size: 1.25em; font-weight: 600; margin: 1.2em 0 0.4em; color: #fff; }
                .blog-content p { margin: 1em 0; }
                .blog-content ul, .blog-content ol { margin: 1em 0; padding-left: 2em; }
                .blog-content li { margin: 0.5em 0; }
                .blog-content blockquote {
                    border-left: 4px solid #4F46E5;
                    padding-left: 1em;
                    margin: 1.5em 0;
                    color: #94a3b8;
                    font-style: italic;
                }
                .blog-content code {
                    background: #0f1419;
                    padding: 0.2em 0.5em;
                    border-radius: 4px;
                    font-family: 'Fira Code', monospace;
                    font-size: 0.9em;
                }
                .blog-content pre {
                    background: #0f1419;
                    padding: 1em;
                    border-radius: 8px;
                    overflow-x: auto;
                    margin: 1.5em 0;
                }
                .blog-content pre code {
                    background: none;
                    padding: 0;
                }
                .blog-content a {
                    color: #4F46E5;
                    text-decoration: underline;
                }
                .blog-content img {
                    max-width: 100%;
                    border-radius: 8px;
                    margin: 1em 0;
                }
                .blog-content strong { font-weight: 700; }
                .blog-content em { font-style: italic; }
            `}</style>
        </div>
    );
};

export default BlogPost;
