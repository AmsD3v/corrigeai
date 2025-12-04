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
    correction_type?: string;
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
            <span className="px-3 py-1 rounded-xl text-xs font-semibold" style={{
                background: `${config.color}20`,
                color: config.color
            }}>
                {config.label}
            </span>
        );
    };

    const getCorrectionTypeBadge = (type?: string) => {
        if (!type) return <span className="text-sm text-[#64748b]">-</span>;

        const typeConfig = {
            advanced: { label: 'Avançada', color: '#3b82f6' },
            premium: { label: 'Premium', color: '#f59e0b' }
        };

        const config = typeConfig[type as keyof typeof typeConfig] || typeConfig.advanced;

        return (
            <span className="px-3 py-1 rounded-xl text-xs font-semibold" style={{
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
            <div className="bg-[#1a1f2e] border border-[#334155] rounded-2xl p-6 md:p-8 mb-8">
                <h1 className="text-2xl md:text-3xl font-extrabold text-white mb-2">
                    Minhas Redações
                </h1>
                <p className="text-sm md:text-base text-[#94a3b8]">
                    Veja seu histórico completo de redações e acompanhe sua evolução.
                </p>
            </div>

            {/* Table */}
            <div className="bg-[#1a1f2e] border border-[#334155] rounded-2xl overflow-hidden">
                {/* Table Header - Hidden on mobile */}
                <div className="hidden lg:grid lg:grid-cols-[2fr_1fr_1fr_1fr_1fr_1fr] px-6 py-4 border-b border-[#334155] bg-[#0f1419]">
                    <div className="text-xs font-semibold text-[#94a3b8] uppercase">
                        Título
                    </div>
                    <div className="text-xs font-semibold text-[#94a3b8] uppercase">
                        Data
                    </div>
                    <div className="text-xs font-semibold text-[#94a3b8] uppercase">
                        Tipo
                    </div>
                    <div className="text-xs font-semibold text-[#94a3b8] uppercase">
                        Status
                    </div>
                    <div className="text-xs font-semibold text-[#94a3b8] uppercase">
                        Nota
                    </div>
                    <div className="text-xs font-semibold text-[#94a3b8] uppercase">
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
                                className="p-5 lg:px-6 lg:py-5 lg:grid lg:grid-cols-[2fr_1fr_1fr_1fr_1fr_1fr] lg:items-center border-b border-[#334155] transition-colors hover:bg-[#0f1419]"
                            >
                                {/* MOBILE CARD LAYOUT */}
                                <div className="lg:hidden space-y-3">
                                    <div>
                                        <div className="text-sm font-semibold text-white mb-1">
                                            {essay.title}
                                        </div>
                                        {essay.theme && (
                                            <div className="text-xs text-[#64748b]">
                                                {essay.theme}
                                            </div>
                                        )}
                                    </div>

                                    <div className="flex flex-wrap gap-2 items-center text-xs text-[#94a3b8]">
                                        <span>📅 {formatDate(essay.submitted_at)}</span>
                                        <span>•</span>
                                        {getCorrectionTypeBadge(essay.correction_type)}
                                        {essay.status === 'completed' && essay.score && (
                                            <>
                                                <span>•</span>
                                                <span className="px-5.5 py-1 rounded-xl text-xs font-bold bg-[#10b98120] text-[#10b981]">
                                                    Nota: {essay.score}
                                                </span>
                                            </>
                                        )}
                                    </div>

                                    <div className="flex items-center justify-between pt-2">
                                        <div>
                                            {getStatusBadge(essay.status)}
                                        </div>
                                        <div>
                                            {essay.status === 'completed' ? (
                                                <button
                                                    onClick={() => navigate(`/painel/redacao/${essay.id}`)}
                                                    className="px-5 py-2 bg-[#4F46E5] hover:bg-[#4338ca] text-white rounded-lg text-xs font-semibold transition-all hover:-translate-y-0.5"
                                                >
                                                    Abrir
                                                </button>
                                            ) : (
                                                <span className="px-5 py-2 bg-[#33415520] text-[#64748b] rounded-lg text-xs font-semibold inline-block">
                                                    Aguardando
                                                </span>
                                            )}
                                        </div>
                                    </div>
                                </div>

                                {/* DESKTOP TABLE LAYOUT */}
                                <div className="hidden lg:block">
                                    <div className="text-sm font-semibold text-white mb-1">
                                        {essay.title}
                                    </div>
                                    {essay.theme && (
                                        <div className="text-xs text-[#64748b]">
                                            {essay.theme}
                                        </div>
                                    )}
                                </div>
                                <div className="hidden lg:block text-sm text-[#94a3b8]">
                                    {formatDate(essay.submitted_at)}
                                </div>
                                <div className="hidden lg:block">
                                    {getCorrectionTypeBadge(essay.correction_type)}
                                </div>
                                <div className="hidden lg:block">
                                    {getStatusBadge(essay.status)}
                                </div>
                                <div className="hidden lg:block">
                                    {essay.status === 'completed' && essay.score ? (
                                        <span className="px-3 py-1 rounded-xl text-xs font-bold bg-[#10b98120] text-[#10b981]">
                                            {essay.score}
                                        </span>
                                    ) : (
                                        <span className="text-sm text-[#64748b]">-</span>
                                    )}
                                </div>
                                <div className="hidden lg:block">
                                    {essay.status === 'completed' ? (
                                        <button
                                            onClick={() => navigate(`/painel/redacao/${essay.id}`)}
                                            className="px-5 py-2 bg-[#4F46E5] hover:bg-[#4338ca] text-white rounded-lg text-xs font-semibold transition-all hover:-translate-y-0.5"
                                        >
                                            Abrir
                                        </button>
                                    ) : (
                                        <span className="px-5 py-2 bg-[#33415520] text-[#64748b] rounded-lg text-xs font-semibold inline-block">
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
