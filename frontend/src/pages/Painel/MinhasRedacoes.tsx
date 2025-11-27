import { useEffect, useState, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';
import api from '../../services/api';

interface Essay {
    id: number;
    title: string;
    submitted_at: string;
    status: string;
    theme?: string;
    score?: number;
}

const MinhasRedacoes = () => {
    const navigate = useNavigate();
    const [essays, setEssays] = useState<Essay[]>([]);
    const [loading, setLoading] = useState(false);
    const [hasMore, setHasMore] = useState(true);
    const [skip, setSkip] = useState(0);
    const LIMIT = 10;

    // Ref para o elemento observer
    const observerTarget = useRef<HTMLDivElement>(null);

    // Função para carregar redações
    const loadEssays = useCallback(async (currentSkip: number, append = false) => {
        if (loading) return;

        setLoading(true);
        try {
            const response = await api.get(`/my-submissions?skip=${currentSkip}&limit=${LIMIT}`);
            const data = response.data;

            if (append) {
                setEssays(prev => [...prev, ...data.items]);
            } else {
                setEssays(data.items);
            }

            setHasMore(data.has_more);
            setSkip(currentSkip + LIMIT);
        } catch (error) {
            console.error('Erro ao carregar redações:', error);
        } finally {
            setLoading(false);
        }
    }, [loading]);

    // Carregar primeira página
    useEffect(() => {
        loadEssays(0, false);
    }, []);

    // Intersection Observer para infinite scroll
    useEffect(() => {
        const observer = new IntersectionObserver(
            entries => {
                if (entries[0].isIntersecting && hasMore && !loading) {
                    loadEssays(skip, true);
                }
            },
            { threshold: 0.1 }
        );

        const currentTarget = observerTarget.current;
        if (currentTarget) {
            observer.observe(currentTarget);
        }

        return () => {
            if (currentTarget) {
                observer.unobserve(currentTarget);
            }
        };
    }, [hasMore, loading, skip, loadEssays]);

    const getStatusBadge = (status: string) => {
        const statusConfig = {
            pending: { label: 'Pendente', color: '#94a3b8' },
            processing: { label: 'Processando', color: '#f59e0b' },
            completed: { label: 'Concluída', color: '#10b981' },
            failed: { label: 'Erro', color: '#ef4444' }
        };

        const config = statusConfig[status as keyof typeof statusConfig] || statusConfig.pending;

        return (
            <span style={{
                padding: '4px 12px',
                borderRadius: '12px',
                fontSize: '12px',
                fontWeight: '600',
                background: `${config.color}20`,
                color: config.color
            }}>
                {config.label}
            </span>
        );
    };

    const formatDate = (dateString: string) => {
        const date = new Date(dateString);
        return date.toLocaleDateString('pt-BR');
    };

    return (
        <PanelLayout activePage="/painel/minhas-redacoes">
            {/* Header */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px',
                marginBottom: '32px'
            }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Minhas Redações
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Veja seu histórico completo de redações e acompanhe sua evolução.
                </p>
            </div>

            {/* Table */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                overflow: 'hidden'
            }}>
                {/* Table Header */}
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: '2fr 1fr 1fr 1fr 1fr',
                    padding: '16px 24px',
                    borderBottom: '1px solid #334155',
                    background: '#0f1419'
                }}>
                    <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                        Título
                    </div>
                    <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                        Data
                    </div>
                    <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                        Status
                    </div>
                    <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                        Nota
                    </div>
                    <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                        Ações
                    </div>
                </div>

                {/* Table Body */}
                {essays.length === 0 && !loading ? (
                    <div style={{
                        padding: '60px',
                        textAlign: 'center',
                        color: '#64748b'
                    }}>
                        Nenhuma redação encontrada.
                    </div>
                ) : (
                    <>
                        {essays.map((essay) => (
                            <div
                                key={essay.id}
                                style={{
                                    display: 'grid',
                                    gridTemplateColumns: '2fr 1fr 1fr 1fr 1fr',
                                    padding: '20px 24px',
                                    borderBottom: '1px solid #334155',
                                    alignItems: 'center',
                                    transition: 'background 0.2s'
                                }}
                                onMouseEnter={(e) => e.currentTarget.style.background = '#0f1419'}
                                onMouseLeave={(e) => e.currentTarget.style.background = 'transparent'}
                            >
                                <div>
                                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#fff', marginBottom: '4px' }}>
                                        {essay.title}
                                    </div>
                                    {essay.theme && (
                                        <div style={{ fontSize: '12px', color: '#64748b' }}>
                                            {essay.theme}
                                        </div>
                                    )}
                                </div>
                                <div style={{ fontSize: '14px', color: '#94a3b8' }}>
                                    {formatDate(essay.submitted_at)}
                                </div>
                                <div>
                                    {getStatusBadge(essay.status)}
                                </div>
                                <div>
                                    {essay.status === 'completed' && essay.score ? (
                                        <span style={{
                                            padding: '4px 12px',
                                            borderRadius: '12px',
                                            fontSize: '12px',
                                            fontWeight: '700',
                                            background: '#10b98120',
                                            color: '#10b981'
                                        }}>
                                            {essay.score}
                                        </span>
                                    ) : (
                                        <span style={{ fontSize: '14px', color: '#64748b' }}>-</span>
                                    )}
                                </div>
                                <div>
                                    {essay.status === 'completed' ? (
                                        <button
                                            onClick={() => navigate(`/painel/redacao/${essay.id}`)}
                                            style={{
                                                padding: '8px 20px',
                                                background: '#4F46E5',
                                                color: '#fff',
                                                border: 'none',
                                                borderRadius: '8px',
                                                fontSize: '13px',
                                                fontWeight: '600',
                                                cursor: 'pointer',
                                                transition: 'all 0.2s'
                                            }}
                                            onMouseEnter={(e) => {
                                                e.currentTarget.style.background = '#4338ca';
                                                e.currentTarget.style.transform = 'translateY(-1px)';
                                            }}
                                            onMouseLeave={(e) => {
                                                e.currentTarget.style.background = '#4F46E5';
                                                e.currentTarget.style.transform = 'translateY(0)';
                                            }}
                                        >
                                            Abrir
                                        </button>
                                    ) : (
                                        <span style={{
                                            padding: '8px 20px',
                                            background: '#33415520',
                                            color: '#64748b',
                                            border: 'none',
                                            borderRadius: '8px',
                                            fontSize: '13px',
                                            fontWeight: '600',
                                            display: 'inline-block'
                                        }}>
                                            Aguardando
                                        </span>
                                    )}
                                </div>
                            </div>
                        ))}

                        {/* Loading indicator + Observer target */}
                        {hasMore && (
                            <div
                                ref={observerTarget}
                                style={{
                                    padding: '24px',
                                    textAlign: 'center',
                                    color: '#64748b',
                                    fontSize: '14px'
                                }}
                            >
                                {loading ? (
                                    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}>
                                        <div style={{
                                            width: '16px',
                                            height: '16px',
                                            border: '2px solid #334155',
                                            borderTop: '2px solid #4F46E5',
                                            borderRadius: '50%',
                                            animation: 'spin 0.8s linear infinite'
                                        }} />
                                        <span>Carregando mais redações...</span>
                                    </div>
                                ) : (
                                    <span>Role para carregar mais</span>
                                )}
                            </div>
                        )}

                        {!hasMore && essays.length > 0 && (
                            <div style={{
                                padding: '24px',
                                textAlign: 'center',
                                color: '#64748b',
                                fontSize: '14px'
                            }}>
                                ✅ Todas as redações carregadas ({essays.length} no total)
                            </div>
                        )}
                    </>
                )}
            </div>

            {/* CSS for spin animation */}
            <style>{`
                @keyframes spin {
                    0% { transform: rotate(0deg); }
                    100% { transform: rotate(360deg); }
                }
            `}</style>
        </PanelLayout>
    );
};

export default MinhasRedacoes;
