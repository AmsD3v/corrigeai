import { useState, useEffect, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import AdminLayout from '../../components/AdminLayout';
import api from '../../services/api';
import { marked } from 'marked';

interface BlogTag {
    id: number;
    name: string;
    slug: string;
    color: string;
}

const BlogEditor = () => {
    const { id } = useParams<{ id: string }>();
    const navigate = useNavigate();
    const isEditing = Boolean(id);
    const fileInputRef = useRef<HTMLInputElement>(null);

    // Form state
    const [title, setTitle] = useState('');
    const [slug, setSlug] = useState('');
    const [excerpt, setExcerpt] = useState('');
    const [content, setContent] = useState('');
    const [coverImage, setCoverImage] = useState('');
    const [metaTitle, setMetaTitle] = useState('');
    const [metaDescription, setMetaDescription] = useState('');
    const [isPublished, setIsPublished] = useState(false);
    const [selectedTags, setSelectedTags] = useState<number[]>([]);

    // Tags available
    const [availableTags, setAvailableTags] = useState<BlogTag[]>([]);
    const [newTagName, setNewTagName] = useState('');
    const [showTagForm, setShowTagForm] = useState(false);

    // UI state
    const [loading, setLoading] = useState(false);
    const [saving, setSaving] = useState(false);
    const [uploading, setUploading] = useState(false);
    const [showPreview, setShowPreview] = useState(true);

    useEffect(() => {
        loadTags();
        if (isEditing) {
            loadPost();
        }
    }, [id]);

    // Auto-generate slug from title
    useEffect(() => {
        if (!isEditing && title) {
            const generatedSlug = title
                .toLowerCase()
                .normalize('NFD')
                .replace(/[\u0300-\u036f]/g, '')
                .replace(/[^a-z0-9]+/g, '-')
                .replace(/^-|-$/g, '');
            setSlug(generatedSlug);
        }
    }, [title, isEditing]);

    const loadTags = async () => {
        try {
            const response = await api.get('/api/blog/tags');
            setAvailableTags(response.data);
        } catch (error) {
            console.error('Erro ao carregar tags:', error);
        }
    };

    const loadPost = async () => {
        try {
            setLoading(true);
            const response = await api.get(`/api/blog/admin/posts/${id}`);
            const post = response.data;
            setTitle(post.title);
            setSlug(post.slug);
            setExcerpt(post.excerpt || '');
            setContent(post.content);
            setCoverImage(post.cover_image || '');
            setMetaTitle(post.meta_title || '');
            setMetaDescription(post.meta_description || '');
            setIsPublished(post.is_published);
            setSelectedTags(post.tags.map((t: BlogTag) => t.id));
        } catch (error) {
            console.error('Erro ao carregar post:', error);
            alert('Erro ao carregar post');
            navigate('/admin/blog');
        } finally {
            setLoading(false);
        }
    };

    const handleSave = async () => {
        if (!title.trim() || !slug.trim() || !content.trim()) {
            alert('Preencha título, slug e conteúdo');
            return;
        }

        try {
            setSaving(true);

            const postData = {
                title,
                slug,
                excerpt,
                content,
                cover_image: coverImage || null,
                meta_title: metaTitle || null,
                meta_description: metaDescription || null,
                is_published: isPublished,
                tag_ids: selectedTags
            };

            if (isEditing) {
                await api.put(`/api/blog/admin/posts/${id}`, postData);
            } else {
                await api.post('/api/blog/admin/posts', postData);
            }

            navigate('/admin/blog');
        } catch (error: any) {
            console.error('Erro ao salvar post:', error);
            alert(error.response?.data?.detail || 'Erro ao salvar post');
        } finally {
            setSaving(false);
        }
    };

    const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        try {
            setUploading(true);
            const formData = new FormData();
            formData.append('file', file);

            const response = await api.post('/api/blog/admin/upload-image', formData, {
                headers: { 'Content-Type': 'multipart/form-data' }
            });

            setCoverImage(response.data.url);
        } catch (error) {
            console.error('Erro ao fazer upload:', error);
            alert('Erro ao fazer upload da imagem');
        } finally {
            setUploading(false);
        }
    };

    const handleCreateTag = async () => {
        if (!newTagName.trim()) return;

        try {
            const tagSlug = newTagName
                .toLowerCase()
                .normalize('NFD')
                .replace(/[\u0300-\u036f]/g, '')
                .replace(/[^a-z0-9]+/g, '-')
                .replace(/^-|-$/g, '');

            const response = await api.post('/api/blog/admin/tags', {
                name: newTagName,
                slug: tagSlug,
                color: '#4F46E5'
            });

            setAvailableTags([...availableTags, response.data]);
            setSelectedTags([...selectedTags, response.data.id]);
            setNewTagName('');
            setShowTagForm(false);
        } catch (error) {
            console.error('Erro ao criar tag:', error);
            alert('Erro ao criar tag');
        }
    };

    const toggleTag = (tagId: number) => {
        if (selectedTags.includes(tagId)) {
            setSelectedTags(selectedTags.filter(id => id !== tagId));
        } else {
            setSelectedTags([...selectedTags, tagId]);
        }
    };

    const renderMarkdown = (text: string) => {
        return { __html: marked(text) };
    };

    if (loading) {
        return (
            <AdminLayout activePage="/admin/blog">
                <div style={{ textAlign: 'center', padding: '100px', color: '#94a3b8' }}>
                    Carregando post...
                </div>
            </AdminLayout>
        );
    }

    return (
        <AdminLayout activePage="/admin/blog">
            <div style={{ marginBottom: '24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#fff' }}>
                        {isEditing ? 'Editar Post' : 'Novo Post'}
                    </h1>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button
                        onClick={() => navigate('/admin/blog')}
                        style={{
                            padding: '10px 20px',
                            background: '#334155',
                            border: 'none',
                            borderRadius: '8px',
                            color: '#fff',
                            cursor: 'pointer'
                        }}
                    >
                        Cancelar
                    </button>
                    <button
                        onClick={handleSave}
                        disabled={saving}
                        style={{
                            padding: '10px 24px',
                            background: 'linear-gradient(135deg, #4F46E5, #7C3AED)',
                            border: 'none',
                            borderRadius: '8px',
                            color: '#fff',
                            fontWeight: '600',
                            cursor: saving ? 'not-allowed' : 'pointer',
                            opacity: saving ? 0.7 : 1
                        }}
                    >
                        {saving ? 'Salvando...' : (isEditing ? 'Salvar Alterações' : 'Publicar')}
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                {/* Editor Column */}
                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    {/* Title */}
                    <div>
                        <label style={{ display: 'block', color: '#94a3b8', marginBottom: '8px', fontSize: '14px' }}>
                            Título *
                        </label>
                        <input
                            type="text"
                            value={title}
                            onChange={(e) => setTitle(e.target.value)}
                            placeholder="Título do post"
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '16px'
                            }}
                        />
                    </div>

                    {/* Slug */}
                    <div>
                        <label style={{ display: 'block', color: '#94a3b8', marginBottom: '8px', fontSize: '14px' }}>
                            Slug (URL) *
                        </label>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <span style={{ color: '#64748b' }}>/blog/</span>
                            <input
                                type="text"
                                value={slug}
                                onChange={(e) => setSlug(e.target.value)}
                                placeholder="url-do-post"
                                style={{
                                    flex: 1,
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px'
                                }}
                            />
                        </div>
                    </div>

                    {/* Excerpt */}
                    <div>
                        <label style={{ display: 'block', color: '#94a3b8', marginBottom: '8px', fontSize: '14px' }}>
                            Resumo (para listagem)
                        </label>
                        <textarea
                            value={excerpt}
                            onChange={(e) => setExcerpt(e.target.value)}
                            placeholder="Breve descrição do post..."
                            rows={2}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px',
                                resize: 'vertical'
                            }}
                        />
                    </div>

                    {/* Cover Image */}
                    <div>
                        <label style={{ display: 'block', color: '#94a3b8', marginBottom: '8px', fontSize: '14px' }}>
                            Imagem de Capa
                        </label>
                        <div style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
                            <input
                                ref={fileInputRef}
                                type="file"
                                accept="image/*"
                                onChange={handleImageUpload}
                                style={{ display: 'none' }}
                            />
                            <button
                                onClick={() => fileInputRef.current?.click()}
                                disabled={uploading}
                                style={{
                                    padding: '10px 16px',
                                    background: '#334155',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    cursor: uploading ? 'not-allowed' : 'pointer',
                                    fontSize: '14px'
                                }}
                            >
                                {uploading ? 'Enviando...' : '📷 Upload'}
                            </button>
                            <input
                                type="text"
                                value={coverImage}
                                onChange={(e) => setCoverImage(e.target.value)}
                                placeholder="Ou cole a URL da imagem"
                                style={{
                                    flex: 1,
                                    padding: '10px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px'
                                }}
                            />
                        </div>
                        {coverImage && (
                            <img
                                src={coverImage}
                                alt="Capa"
                                style={{
                                    marginTop: '12px',
                                    maxHeight: '150px',
                                    borderRadius: '8px'
                                }}
                            />
                        )}
                    </div>

                    {/* Tags */}
                    <div>
                        <label style={{ display: 'block', color: '#94a3b8', marginBottom: '8px', fontSize: '14px' }}>
                            Tags
                        </label>
                        <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap', marginBottom: '8px' }}>
                            {availableTags.map(tag => (
                                <button
                                    key={tag.id}
                                    onClick={() => toggleTag(tag.id)}
                                    style={{
                                        padding: '6px 14px',
                                        borderRadius: '16px',
                                        border: 'none',
                                        background: selectedTags.includes(tag.id) ? tag.color : '#1a1f2e',
                                        color: selectedTags.includes(tag.id) ? '#fff' : '#94a3b8',
                                        fontSize: '13px',
                                        cursor: 'pointer',
                                        fontWeight: '500'
                                    }}
                                >
                                    {tag.name}
                                </button>
                            ))}
                            <button
                                onClick={() => setShowTagForm(!showTagForm)}
                                style={{
                                    padding: '6px 14px',
                                    borderRadius: '16px',
                                    border: '1px dashed #334155',
                                    background: 'transparent',
                                    color: '#94a3b8',
                                    fontSize: '13px',
                                    cursor: 'pointer'
                                }}
                            >
                                + Nova Tag
                            </button>
                        </div>
                        {showTagForm && (
                            <div style={{ display: 'flex', gap: '8px' }}>
                                <input
                                    type="text"
                                    value={newTagName}
                                    onChange={(e) => setNewTagName(e.target.value)}
                                    placeholder="Nome da tag"
                                    style={{
                                        flex: 1,
                                        padding: '8px 12px',
                                        background: '#0f1419',
                                        border: '1px solid #334155',
                                        borderRadius: '6px',
                                        color: '#fff',
                                        fontSize: '13px'
                                    }}
                                />
                                <button
                                    onClick={handleCreateTag}
                                    style={{
                                        padding: '8px 16px',
                                        background: '#4F46E5',
                                        border: 'none',
                                        borderRadius: '6px',
                                        color: '#fff',
                                        cursor: 'pointer'
                                    }}
                                >
                                    Criar
                                </button>
                            </div>
                        )}
                    </div>

                    {/* Content Editor */}
                    <div style={{ flex: 1 }}>
                        <label style={{ display: 'block', color: '#94a3b8', marginBottom: '8px', fontSize: '14px' }}>
                            Conteúdo (Markdown) *
                        </label>
                        <textarea
                            value={content}
                            onChange={(e) => setContent(e.target.value)}
                            placeholder="# Título&#10;&#10;Escreva seu conteúdo em Markdown..."
                            style={{
                                width: '100%',
                                minHeight: '400px',
                                padding: '16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px',
                                fontFamily: 'monospace',
                                lineHeight: '1.6',
                                resize: 'vertical'
                            }}
                        />
                    </div>

                    {/* SEO Fields */}
                    <div style={{ background: '#1a1f2e', padding: '16px', borderRadius: '8px', border: '1px solid #334155' }}>
                        <h3 style={{ color: '#fff', fontSize: '14px', marginBottom: '16px' }}>🔍 SEO</h3>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                            <input
                                type="text"
                                value={metaTitle}
                                onChange={(e) => setMetaTitle(e.target.value)}
                                placeholder="Meta Title (deixe vazio para usar o título)"
                                style={{
                                    width: '100%',
                                    padding: '10px 14px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '6px',
                                    color: '#fff',
                                    fontSize: '14px'
                                }}
                            />
                            <textarea
                                value={metaDescription}
                                onChange={(e) => setMetaDescription(e.target.value)}
                                placeholder="Meta Description (deixe vazio para usar o resumo)"
                                rows={2}
                                style={{
                                    width: '100%',
                                    padding: '10px 14px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '6px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    resize: 'none'
                                }}
                            />
                        </div>
                    </div>

                    {/* Publish Toggle */}
                    <div style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '12px',
                        padding: '16px',
                        background: '#1a1f2e',
                        borderRadius: '8px',
                        border: '1px solid #334155'
                    }}>
                        <button
                            onClick={() => setIsPublished(!isPublished)}
                            style={{
                                width: '50px',
                                height: '26px',
                                borderRadius: '13px',
                                border: 'none',
                                background: isPublished ? '#10b981' : '#334155',
                                position: 'relative',
                                cursor: 'pointer',
                                transition: 'background 0.2s'
                            }}
                        >
                            <div style={{
                                width: '22px',
                                height: '22px',
                                borderRadius: '50%',
                                background: '#fff',
                                position: 'absolute',
                                top: '2px',
                                left: isPublished ? '26px' : '2px',
                                transition: 'left 0.2s'
                            }} />
                        </button>
                        <span style={{ color: '#fff', fontWeight: '600' }}>
                            {isPublished ? 'Publicar agora' : 'Salvar como rascunho'}
                        </span>
                    </div>
                </div>

                {/* Preview Column */}
                <div style={{
                    background: '#1a1f2e',
                    borderRadius: '12px',
                    border: '1px solid #334155',
                    overflow: 'hidden'
                }}>
                    <div style={{
                        padding: '12px 16px',
                        background: '#0f1419',
                        borderBottom: '1px solid #334155',
                        display: 'flex',
                        justifyContent: 'space-between',
                        alignItems: 'center'
                    }}>
                        <span style={{ color: '#94a3b8', fontSize: '14px', fontWeight: '600' }}>
                            👁️ Preview
                        </span>
                        <button
                            onClick={() => setShowPreview(!showPreview)}
                            style={{
                                padding: '4px 12px',
                                background: '#334155',
                                border: 'none',
                                borderRadius: '4px',
                                color: '#94a3b8',
                                fontSize: '12px',
                                cursor: 'pointer'
                            }}
                        >
                            {showPreview ? 'Ocultar' : 'Mostrar'}
                        </button>
                    </div>

                    {showPreview && (
                        <div style={{ padding: '24px', maxHeight: 'calc(100vh - 250px)', overflowY: 'auto' }}>
                            {/* Preview Header */}
                            {coverImage && (
                                <img
                                    src={coverImage}
                                    alt="Preview"
                                    style={{
                                        width: '100%',
                                        maxHeight: '200px',
                                        objectFit: 'cover',
                                        borderRadius: '8px',
                                        marginBottom: '20px'
                                    }}
                                />
                            )}

                            {selectedTags.length > 0 && (
                                <div style={{ display: 'flex', gap: '6px', marginBottom: '12px' }}>
                                    {selectedTags.map(tagId => {
                                        const tag = availableTags.find(t => t.id === tagId);
                                        if (!tag) return null;
                                        return (
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
                                        );
                                    })}
                                </div>
                            )}

                            <h1 style={{
                                fontSize: '28px',
                                fontWeight: '800',
                                color: '#fff',
                                marginBottom: '16px',
                                lineHeight: '1.3'
                            }}>
                                {title || 'Título do Post'}
                            </h1>

                            {excerpt && (
                                <p style={{
                                    fontSize: '16px',
                                    color: '#94a3b8',
                                    marginBottom: '24px',
                                    fontStyle: 'italic'
                                }}>
                                    {excerpt}
                                </p>
                            )}

                            <div
                                className="blog-content"
                                style={{
                                    color: '#e2e8f0',
                                    fontSize: '16px',
                                    lineHeight: '1.7'
                                }}
                                dangerouslySetInnerHTML={renderMarkdown(content || '*Comece a escrever para ver o preview...*')}
                            />
                        </div>
                    )}
                </div>
            </div>

            {/* Markdown Styles (same as BlogPost.tsx) */}
            <style>{`
                .blog-content h1 { font-size: 1.8em; font-weight: 800; margin: 1em 0 0.5em; color: #fff; }
                .blog-content h2 { font-size: 1.4em; font-weight: 700; margin: 1em 0 0.5em; color: #fff; }
                .blog-content h3 { font-size: 1.2em; font-weight: 600; margin: 1em 0 0.4em; color: #fff; }
                .blog-content p { margin: 0.8em 0; }
                .blog-content ul, .blog-content ol { margin: 0.8em 0; padding-left: 1.5em; }
                .blog-content li { margin: 0.4em 0; }
                .blog-content blockquote {
                    border-left: 3px solid #4F46E5;
                    padding-left: 1em;
                    margin: 1em 0;
                    color: #94a3b8;
                    font-style: italic;
                }
                .blog-content code {
                    background: #0f1419;
                    padding: 0.2em 0.4em;
                    border-radius: 4px;
                    font-size: 0.9em;
                }
                .blog-content pre {
                    background: #0f1419;
                    padding: 1em;
                    border-radius: 6px;
                    overflow-x: auto;
                }
                .blog-content pre code { background: none; padding: 0; }
                .blog-content a { color: #4F46E5; }
                .blog-content img { max-width: 100%; border-radius: 6px; }
                .blog-content strong { font-weight: 700; }
            `}</style>
        </AdminLayout>
    );
};

export default BlogEditor;
