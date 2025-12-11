import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import AdminLayout from '../../components/AdminLayout';
import api from '../../services/api';

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

const BlogAdmin = () => {
    const navigate = useNavigate();
    const [posts, setPosts] = useState<BlogPost[]>([]);
    const [loading, setLoading] = useState(true);
    const [deleting, setDeleting] = useState<number | null>(null);

    useEffect(() => {
        loadPosts();
    }, []);

    const loadPosts = async () => {
        try {
            setLoading(true);
            const response = await api.get('/blog/admin/posts');
            setPosts(response.data);
        } catch (error) {
            console.error('Erro ao carregar posts:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async (id: number) => {
        if (!confirm('Tem certeza que deseja excluir este post?')) return;

        try {
            setDeleting(id);
            await api.delete(`/blog/admin/posts/${id}`);
            setPosts(posts.filter(p => p.id !== id));
        } catch (error) {
            console.error('Erro ao deletar post:', error);
            alert('Erro ao deletar post');
        } finally {
            setDeleting(null);
        }
    };

    const handleTogglePublish = async (post: BlogPost) => {
        try {
            await api.put(`/blog/admin/posts/${post.id}`, {
                is_published: !post.is_published
            });
            setPosts(posts.map(p =>
                p.id === post.id ? { ...p, is_published: !p.is_published } : p
            ));
        } catch (error) {
            console.error('Erro ao alterar status:', error);
        }
    };

    const formatDate = (dateStr: string) => {
        return new Date(dateStr).toLocaleDateString('pt-BR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
    };

    return (
        <AdminLayout activePage="/admin/blog">
            <div style={{ marginBottom: '32px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                    <h1 style={{
                        fontSize: '32px',
                        fontWeight: '800',
                        color: '#fff',
                        marginBottom: '8px'
                    }}>
                        Gestão do Blog
                    </h1>
                    <p style={{ fontSize: '14px', color: '#94a3b8' }}>
                        Gerencie posts e conteúdo do blog
                    </p>
                </div>
                <button
                    onClick={() => navigate('/admin/blog/novo')}
                    style={{
                        padding: '12px 24px',
                        background: 'linear-gradient(135deg, #4F46E5, #7C3AED)',
                        border: 'none',
                        borderRadius: '8px',
                        color: '#fff',
                        fontSize: '14px',
                        fontWeight: '600',
                        cursor: 'pointer',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '8px'
                    }}
                >
                    ✏️ Novo Post
                </button>
            </div>

            {/* Stats */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))',
                gap: '16px',
                marginBottom: '24px'
            }}>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Total de Posts
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#10b981' }}>
                        {posts.length}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Publicados
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#3b82f6' }}>
                        {posts.filter(p => p.is_published).length}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Rascunhos
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#f59e0b' }}>
                        {posts.filter(p => !p.is_published).length}
                    </div>
                </div>
            </div>

            {/* Posts Table */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                overflow: 'hidden'
            }}>
                {loading ? (
                    <div style={{ padding: '60px', textAlign: 'center', color: '#94a3b8' }}>
                        Carregando posts...
                    </div>
                ) : posts.length === 0 ? (
                    <div style={{ padding: '60px', textAlign: 'center', color: '#94a3b8' }}>
                        <div style={{ fontSize: '48px', marginBottom: '16px' }}>📝</div>
                        <p>Nenhum post criado ainda</p>
                        <button
                            onClick={() => navigate('/admin/blog/novo')}
                            style={{
                                marginTop: '16px',
                                padding: '10px 20px',
                                background: '#4F46E5',
                                border: 'none',
                                borderRadius: '8px',
                                color: '#fff',
                                cursor: 'pointer'
                            }}
                        >
                            Criar Primeiro Post
                        </button>
                    </div>
                ) : (
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr style={{ background: '#0f1419' }}>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px' }}>Título</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px' }}>Tags</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px' }}>Status</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px' }}>Data</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px' }}>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            {posts.map(post => (
                                <tr key={post.id} style={{ borderTop: '1px solid #334155' }}>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ color: '#fff', fontWeight: '600', marginBottom: '4px' }}>
                                            {post.title}
                                        </div>
                                        <div style={{ fontSize: '12px', color: '#64748b' }}>
                                            /blog/{post.slug}
                                        </div>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ display: 'flex', gap: '4px', flexWrap: 'wrap' }}>
                                            {post.tags.map(tag => (
                                                <span
                                                    key={tag.id}
                                                    style={{
                                                        padding: '4px 8px',
                                                        borderRadius: '12px',
                                                        background: `${tag.color}20`,
                                                        color: tag.color,
                                                        fontSize: '11px',
                                                        fontWeight: '600'
                                                    }}
                                                >
                                                    {tag.name}
                                                </span>
                                            ))}
                                        </div>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <button
                                            onClick={() => handleTogglePublish(post)}
                                            style={{
                                                padding: '6px 12px',
                                                borderRadius: '12px',
                                                border: 'none',
                                                background: post.is_published ? '#10b98120' : '#f59e0b20',
                                                color: post.is_published ? '#10b981' : '#f59e0b',
                                                fontSize: '12px',
                                                fontWeight: '600',
                                                cursor: 'pointer'
                                            }}
                                        >
                                            {post.is_published ? '✓ Publicado' : '○ Rascunho'}
                                        </button>
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                        {formatDate(post.created_at)}
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ display: 'flex', gap: '8px' }}>
                                            <button
                                                onClick={() => window.open(`/blog/${post.slug}`, '_blank')}
                                                style={{
                                                    padding: '6px 12px',
                                                    background: '#334155',
                                                    border: 'none',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '12px',
                                                    cursor: 'pointer'
                                                }}
                                            >
                                                👁️
                                            </button>
                                            <button
                                                onClick={() => navigate(`/admin/blog/editar/${post.id}`)}
                                                style={{
                                                    padding: '6px 12px',
                                                    background: '#3b82f6',
                                                    border: 'none',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '12px',
                                                    cursor: 'pointer'
                                                }}
                                            >
                                                ✏️
                                            </button>
                                            <button
                                                onClick={() => handleDelete(post.id)}
                                                disabled={deleting === post.id}
                                                style={{
                                                    padding: '6px 12px',
                                                    background: '#ef4444',
                                                    border: 'none',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '12px',
                                                    cursor: deleting === post.id ? 'not-allowed' : 'pointer',
                                                    opacity: deleting === post.id ? 0.5 : 1
                                                }}
                                            >
                                                🗑️
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
            </div>
        </AdminLayout>
    );
};

export default BlogAdmin;
