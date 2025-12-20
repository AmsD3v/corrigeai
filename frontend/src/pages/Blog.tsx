import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import Header from '../components/Header';
import SEOHead from '../components/SEOHead';
import api from '../services/api';

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
    cover_image: string | null;
    is_published: boolean;
    published_at: string | null;
    created_at: string;
    tags: BlogTag[];
}

const Blog = () => {
    const [posts, setPosts] = useState<BlogPost[]>([]);
    const [loading, setLoading] = useState(true);
    const [selectedTag, setSelectedTag] = useState<string | null>(null);
    const [tags, setTags] = useState<BlogTag[]>([]);

    useEffect(() => {
        loadPosts();
        loadTags();
    }, [selectedTag]);

    const loadPosts = async () => {
        try {
            setLoading(true);
            const params = selectedTag ? `?tag_slug=${selectedTag}` : '';
            const response = await api.get(`/api/blog/posts${params}`);
            setPosts(response.data);
        } catch (error) {
            console.error('Erro ao carregar posts:', error);
        } finally {
            setLoading(false);
        }
    };

    const loadTags = async () => {
        try {
            const response = await api.get('/api/blog/tags');
            setTags(response.data);
        } catch (error) {
            console.error('Erro ao carregar tags:', error);
        }
    };

    const formatDate = (dateStr: string) => {
        return new Date(dateStr).toLocaleDateString('pt-BR', {
            day: '2-digit',
            month: 'long',
            year: 'numeric'
        });
    };

    return (
        <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
            <SEOHead
                title="Blog CorrigeAI - Dicas de Redação ENEM e Vestibulares"
                description="Dicas, estratégias e conteúdos para você dominar a redação do ENEM e vestibulares. Aprenda técnicas de argumentação, estrutura textual e muito mais."
                canonical="https://corrigeai.online/blog"
                keywords="blog redação enem, dicas redação vestibular, como escrever redação, competências enem, proposta de intervenção, estrutura redação"
            />
            <Header />

            <main style={{ maxWidth: '1200px', margin: '0 auto', padding: '100px 20px 40px' }}>
                {/* Header */}
                <div style={{ textAlign: 'center', marginBottom: '48px' }}>
                    <h1 style={{
                        fontSize: '48px',
                        fontWeight: '800',
                        color: '#fff',
                        marginBottom: '16px'
                    }}>
                        Blog
                    </h1>
                    <p style={{
                        fontSize: '18px',
                        color: '#94a3b8',
                        maxWidth: '600px',
                        margin: '0 auto'
                    }}>
                        Dicas, estratégias e conteúdos para você dominar a redação do ENEM e vestibulares
                    </p>
                </div>

                {/* Tags Filter */}
                {tags.length > 0 && (
                    <div style={{
                        display: 'flex',
                        flexWrap: 'wrap',
                        gap: '12px',
                        justifyContent: 'center',
                        marginBottom: '40px'
                    }}>
                        <button
                            onClick={() => setSelectedTag(null)}
                            style={{
                                padding: '8px 20px',
                                borderRadius: '20px',
                                border: 'none',
                                background: !selectedTag ? '#4F46E5' : '#1a1f2e',
                                color: !selectedTag ? '#fff' : '#94a3b8',
                                fontSize: '14px',
                                fontWeight: '600',
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                        >
                            Todos
                        </button>
                        {tags.map(tag => (
                            <button
                                key={tag.id}
                                onClick={() => setSelectedTag(tag.slug)}
                                style={{
                                    padding: '8px 20px',
                                    borderRadius: '20px',
                                    border: 'none',
                                    background: selectedTag === tag.slug ? tag.color : '#1a1f2e',
                                    color: selectedTag === tag.slug ? '#fff' : '#94a3b8',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: 'pointer',
                                    transition: 'all 0.2s'
                                }}
                            >
                                {tag.name}
                            </button>
                        ))}
                    </div>
                )}

                {/* Loading */}
                {loading && (
                    <div style={{ textAlign: 'center', padding: '60px', color: '#94a3b8' }}>
                        Carregando posts...
                    </div>
                )}

                {/* Posts Grid */}
                {!loading && posts.length > 0 && (
                    <div style={{
                        display: 'grid',
                        gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))',
                        gap: '32px'
                    }}>
                        {posts.map(post => (
                            <Link
                                key={post.id}
                                to={`/blog/${post.slug}`}
                                style={{ textDecoration: 'none' }}
                            >
                                <article style={{
                                    background: '#1a1f2e',
                                    borderRadius: '16px',
                                    overflow: 'hidden',
                                    border: '1px solid #334155',
                                    transition: 'all 0.3s',
                                    cursor: 'pointer'
                                }}
                                    onMouseEnter={(e) => {
                                        e.currentTarget.style.transform = 'translateY(-4px)';
                                        e.currentTarget.style.borderColor = '#4F46E5';
                                    }}
                                    onMouseLeave={(e) => {
                                        e.currentTarget.style.transform = 'translateY(0)';
                                        e.currentTarget.style.borderColor = '#334155';
                                    }}
                                >
                                    {/* Cover Image */}
                                    {post.cover_image && (
                                        <div style={{
                                            height: '200px',
                                            background: `url(${post.cover_image}) center/cover no-repeat`,
                                            borderBottom: '1px solid #334155'
                                        }} />
                                    )}

                                    {/* Content */}
                                    <div style={{ padding: '24px' }}>
                                        {/* Tags */}
                                        {post.tags.length > 0 && (
                                            <div style={{
                                                display: 'flex',
                                                gap: '8px',
                                                marginBottom: '12px',
                                                flexWrap: 'wrap'
                                            }}>
                                                {post.tags.map(tag => (
                                                    <span
                                                        key={tag.id}
                                                        style={{
                                                            padding: '4px 10px',
                                                            borderRadius: '12px',
                                                            background: `${tag.color}20`,
                                                            color: tag.color,
                                                            fontSize: '12px',
                                                            fontWeight: '600'
                                                        }}
                                                    >
                                                        {tag.name}
                                                    </span>
                                                ))}
                                            </div>
                                        )}

                                        {/* Title */}
                                        <h2 style={{
                                            fontSize: '20px',
                                            fontWeight: '700',
                                            color: '#fff',
                                            marginBottom: '12px',
                                            lineHeight: '1.4'
                                        }}>
                                            {post.title}
                                        </h2>

                                        {/* Excerpt */}
                                        {post.excerpt && (
                                            <p style={{
                                                fontSize: '14px',
                                                color: '#94a3b8',
                                                lineHeight: '1.6',
                                                marginBottom: '16px'
                                            }}>
                                                {post.excerpt.length > 150
                                                    ? `${post.excerpt.substring(0, 150)}...`
                                                    : post.excerpt
                                                }
                                            </p>
                                        )}

                                        {/* Date */}
                                        <div style={{
                                            fontSize: '13px',
                                            color: '#64748b'
                                        }}>
                                            {post.published_at ? formatDate(post.published_at) : formatDate(post.created_at)}
                                        </div>
                                    </div>
                                </article>
                            </Link>
                        ))}
                    </div>
                )}

                {/* No Posts */}
                {!loading && posts.length === 0 && (
                    <div style={{
                        textAlign: 'center',
                        padding: '80px 20px',
                        color: '#64748b'
                    }}>
                        <div style={{ fontSize: '48px', marginBottom: '16px' }}>📝</div>
                        <p>Nenhum post encontrado</p>
                    </div>
                )}
            </main>

            {/* Footer */}
            <footer style={{
                padding: '40px 20px',
                textAlign: 'center',
                borderTop: '1px solid #334155'
            }}>
                <p style={{ color: '#64748b', fontSize: '14px' }}>
                    © {new Date().getFullYear()} CorrigeAI. Todos os direitos reservados.
                </p>
            </footer>
        </div>
    );
};

export default Blog;
