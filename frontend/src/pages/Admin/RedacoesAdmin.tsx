import { useState, useEffect, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import AdminLayout from '../../components/AdminLayout';
import api from '../../services/api';

interface Submission {
    id: number;
    title: string;
    theme: string;
    content: string;
    created_at: string;
    status: 'pending' | 'processing' | 'completed' | 'error';
    correction_type: 'advanced' | 'premium';
    owner: {
        id: number;
        full_name: string;
        email: string;
    };
    correction?: {
        total_score: number;
        competence_1_score: number;
        competence_2_score: number;
        competence_3_score: number;
        competence_4_score: number;
        competence_5_score: number;
    };
}

const RedacoesAdmin = () => {
    const navigate = useNavigate();
    const [submissions, setSubmissions] = useState<Submission[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState('');
    const [hasMore, setHasMore] = useState(true);
    const [skip, setSkip] = useState(0);
    const LIMIT = 10;

    const observerTarget = useRef<HTMLDivElement>(null);

    // Estados para seleção múltipla
    const [selectedIds, setSelectedIds] = useState<Set<number>>(new Set());
    const [deleting, setDeleting] = useState(false);

    // Função para carregar submissões com paginação
    const loadSubmissions = useCallback(async (currentSkip: number, append = false) => {
        if (loading) return;

        setLoading(true);
        try {
            const response = await api.get(`/admin/submissions?skip=${currentSkip}&limit=${LIMIT}`);
            const data = response.data;

            if (append) {
                setSubmissions(prev => [...prev, ...(data.items || data)]);
            } else {
                setSubmissions(data.items || data);
            }

            // Check if has more
            const items = data.items || data;
            setHasMore(items.length === LIMIT);
            setSkip(currentSkip + LIMIT);
            setError('');
        } catch (err: any) {
            console.error('Erro ao carregar redações:', err);
            setError('Erro ao carregar redações');
        } finally {
            setLoading(false);
        }
    }, [loading, LIMIT]);

    // Carregar primeira página
    useEffect(() => {
        loadSubmissions(0, false);
    }, []);

    // Intersection Observer para infinite scroll
    useEffect(() => {
        const observer = new IntersectionObserver(
            entries => {
                // PROTEÇÃO: não carrega mais se estiver deletando
                if (entries[0].isIntersecting && hasMore && !loading && !deleting) {
                    loadSubmissions(skip, true);
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
    }, [hasMore, loading, skip, loadSubmissions, deleting]);

    const filteredSubmissions = submissions.filter(sub =>
        sub.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        sub.theme?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        sub.owner.full_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        sub.owner.email.toLowerCase().includes(searchTerm.toLowerCase())
    );

    const stats = {
        total: submissions.length,
        corrected: submissions.filter(s => s.status === 'completed').length,
        pending: submissions.filter(s => s.status === 'pending').length,
        processing: submissions.filter(s => s.status === 'processing').length,
        avgScore: submissions.filter(s => s.correction?.total_score).length > 0
            ? Math.round(
                submissions
                    .filter(s => s.correction?.total_score)
                    .reduce((sum, s) => sum + (s.correction?.total_score || 0), 0) /
                submissions.filter(s => s.correction?.total_score).length
            )
            : 0
    };

    const getStatusLabel = (status: string) => {
        const labels: Record<string, string> = {
            'pending': 'Pendente',
            'processing': 'Processando',
            'completed': 'Concluída',
            'error': 'Erro'
        };
        return labels[status] || status;
    };

    const getStatusColor = (status: string) => {
        const colors: Record<string, { bg: string; text: string }> = {
            'pending': { bg: '#f59e0b20', text: '#f59e0b' },
            'processing': { bg: '#3b82f620', text: '#3b82f6' },
            'completed': { bg: '#10b98120', text: '#10b981' },
            'error': { bg: '#ef444420', text: '#ef4444' }
        };
        return colors[status] || colors['pending'];
    };

    const handleView = (submissionId: number) => {
        navigate(`/painel/redacao/${submissionId}`);
    };

    // Toggle seleção individual
    const toggleSelection = (id: number) => {
        const newSelected = new Set(selectedIds);
        if (newSelected.has(id)) {
            newSelected.delete(id);
        } else {
            newSelected.add(id);
        }
        setSelectedIds(newSelected);
    };

    // Toggle selecionar todos visíveis
    const toggleSelectAll = () => {
        if (selectedIds.size === filteredSubmissions.length) {
            setSelectedIds(new Set());
        } else {
            setSelectedIds(new Set(filteredSubmissions.map(s => s.id)));
        }
    };

    // Deletar única redação
    const handleDelete = async (id: number) => {
        if (!confirm('Tem certeza que deseja excluir esta redação?')) return;

        // Proteção: não permite delete se já está deletando
        if (deleting) {
            console.warn('Já existe uma operação de delete em andamento');
            return;
        }

        console.log(`[DELETE] Iniciando exclusão da redação #${id}`);
        console.log('[DELETE] Estado selectedIds antes:', Array.from(selectedIds));

        try {
            setDeleting(true);

            // 1. DELETE na API
            console.log(`[DELETE] Chamando API DELETE /admin/submissions/${id}`);
            await api.delete(`/admin/submissions/${id}`);
            console.log(`[DELETE] API respondeu com sucesso`);

            // 2. Remove da lista local
            setSubmissions(prev => {
                const filtered = prev.filter(s => s.id !== id);
                console.log(`[DELETE] Removido da lista. Antes: ${prev.length}, Depois: ${filtered.length}`);
                return filtered;
            });

            // 3. Remove da seleção
            setSelectedIds(prev => {
                const updated = new Set(prev);
                const wasSelected = updated.has(id);
                updated.delete(id);
                console.log(`[DELETE] Estava selecionado: ${wasSelected}, selectedIds após: ${Array.from(updated)}`);
                return updated;
            });

            console.log(`[DELETE] Exclusão da redação #${id} concluída com sucesso`);
        } catch (error) {
            console.error('[DELETE] Erro ao deletar:', error);
            alert('Erro ao deletar redação. Tente novamente.');
        } finally {
            setDeleting(false);
            console.log('[DELETE] Estado deleting resetado para false');
        }
    };

    // Deletar múltiplas redações
    const handleDeleteSelected = async () => {
        if (selectedIds.size === 0) return;

        if (!confirm(`Tem certeza que deseja excluir ${selectedIds.size} redação(ões)?`)) return;

        try {
            setDeleting(true);
            const idsToDelete = Array.from(selectedIds);

            // Deleta todas as selecionadas
            await Promise.all(
                idsToDelete.map(id => api.delete(`/admin/submissions/${id}`))
            );

            // Força atualização removendo todas da lista
            setSubmissions(prev => prev.filter(s => !selectedIds.has(s.id)));


            // Limpa seleção
            setSelectedIds(new Set());
        } catch (error) {
            console.error('Erro ao deletar:', error);
            alert('Erro ao deletar redações');
        } finally {
            setDeleting(false);
        }
    };

    if (loading) {
        return (
            <AdminLayout activePage="/admin/redacoes">
                <div style={{ textAlign: 'center', padding: '60px', color: '#94a3b8' }}>
                    Carregando redações...
                </div>
            </AdminLayout>
        );
    }

    return (
        <AdminLayout activePage="/admin/redacoes">
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Gestão de Redações
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Visualize e gerencie todas as redações da plataforma
                </p>
            </div>

            {error && (
                <div style={{
                    background: '#ef444420',
                    border: '1px solid #ef4444',
                    borderRadius: '12px',
                    padding: '16px',
                    marginBottom: '24px',
                    color: '#ef4444'
                }}>
                    {error}
                </div>
            )}

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
                        Total
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#10b981' }}>
                        {stats.total}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Concluídas
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#3b82f6' }}>
                        {stats.corrected}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Processando
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#f59e0b' }}>
                        {stats.processing}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Nota Média
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#a855f7' }}>
                        {stats.avgScore}
                    </div>
                </div>
            </div>

            {/* Ações em massa */}
            {selectedIds.size > 0 && (
                <div style={{
                    background: '#ef444420',
                    border: '1px solid #ef4444',
                    borderRadius: '12px',
                    padding: '16px 20px',
                    marginBottom: '24px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'space-between'
                }}>
                    <span style={{ color: '#ef4444', fontWeight: '600' }}>
                        {selectedIds.size} redação(ões) selecionada(s)
                    </span>
                    <button
                        onClick={handleDeleteSelected}
                        disabled={deleting}
                        style={{
                            padding: '8px 16px',
                            background: '#ef4444',
                            border: 'none',
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '14px',
                            fontWeight: '600',
                            cursor: deleting ? 'not-allowed' : 'pointer',
                            opacity: deleting ? 0.5 : 1
                        }}
                    >
                        {deleting ? 'Excluindo...' : '🗑️ Excluir Selecionados'}
                    </button>
                </div>
            )}

            {/* Search */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '20px',
                marginBottom: '24px'
            }}>
                <input
                    type="text"
                    placeholder="Buscar por título, tema, nome ou email do aluno..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    style={{
                        width: '100%',
                        padding: '12px 16px',
                        background: '#0f1419',
                        border: '1px solid #334155',
                        borderRadius: '8px',
                        color: '#fff',
                        fontSize: '14px'
                    }}
                />
            </div>

            {/* Submissions Table */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                overflow: 'hidden'
            }}>
                <div style={{ overflowX: 'auto' }}>
                    <table style={{
                        width: '100%',
                        borderCollapse: 'collapse'
                    }}>
                        <thead>
                            <tr style={{ background: '#0f1419' }}>
                                <th style={{ padding: '16px', textAlign: 'center', width: '50px' }}>
                                    <input
                                        type="checkbox"
                                        checked={selectedIds.size === filteredSubmissions.length && filteredSubmissions.length > 0}
                                        onChange={toggleSelectAll}
                                        style={{ cursor: 'pointer', width: '18px', height: '18px' }}
                                    />
                                </th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>ID</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Aluno</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Título</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Tema</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Data</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Nota</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Tipo</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Status</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredSubmissions.map((submission) => (
                                <tr key={submission.id} style={{ borderTop: '1px solid #334155' }}>
                                    <td style={{ padding: '16px', textAlign: 'center' }}>
                                        <input
                                            type="checkbox"
                                            checked={selectedIds.has(submission.id)}
                                            onChange={() => toggleSelection(submission.id)}
                                            style={{ cursor: 'pointer', width: '18px', height: '18px' }}
                                        />
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                        #{submission.id}
                                    </td>
                                    <td style={{ padding: '16px', color: '#fff', fontSize: '14px' }}>
                                        <div>{submission.owner.full_name}</div>
                                        <div style={{ fontSize: '12px', color: '#64748b' }}>{submission.owner.email}</div>
                                    </td>
                                    <td style={{ padding: '16px', color: '#fff', fontSize: '14px', maxWidth: '250px' }}>
                                        {submission.title.length > 40 ? `${submission.title.substring(0, 40)}...` : submission.title}
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px', maxWidth: '200px' }}>
                                        {submission.theme && submission.theme.length > 30
                                            ? `${submission.theme.substring(0, 30)}...`
                                            : (submission.theme || '-')}
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                        {new Date(submission.created_at).toLocaleString('pt-BR', {
                                            day: '2-digit',
                                            month: '2-digit',
                                            year: 'numeric',
                                            hour: '2-digit',
                                            minute: '2-digit'
                                        })}
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        {submission.correction?.total_score ? (
                                            <span style={{
                                                fontSize: '16px',
                                                fontWeight: '700',
                                                color: submission.correction.total_score >= 800
                                                    ? '#10b981'
                                                    : submission.correction.total_score >= 600
                                                        ? '#f59e0b'
                                                        : '#ef4444'
                                            }}>
                                                {submission.correction.total_score}
                                            </span>
                                        ) : (
                                            <span style={{ color: '#64748b' }}>-</span>
                                        )}
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <span style={{
                                            padding: '4px 8px',
                                            borderRadius: '6px',
                                            fontSize: '11px',
                                            fontWeight: '600',
                                            background: submission.correction_type === 'premium' ? '#a855f720' : '#3b82f620',
                                            color: submission.correction_type === 'premium' ? '#a855f7' : '#3b82f6'
                                        }}>
                                            {submission.correction_type === 'premium' ? '💎 Premium' : '⚡ Advanced'}
                                        </span>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <span style={{
                                            padding: '4px 12px',
                                            borderRadius: '12px',
                                            fontSize: '12px',
                                            fontWeight: '600',
                                            background: getStatusColor(submission.status).bg,
                                            color: getStatusColor(submission.status).text
                                        }}>
                                            {getStatusLabel(submission.status)}
                                        </span>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ display: 'flex', gap: '8px' }}>
                                            <button
                                                onClick={() => handleView(submission.id)}
                                                style={{
                                                    padding: '6px 12px',
                                                    background: '#3b82f6',
                                                    border: 'none',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '12px',
                                                    cursor: 'pointer',
                                                    fontWeight: '600'
                                                }}
                                            >
                                                👁️ Ver
                                            </button>
                                            <button
                                                onClick={() => handleDelete(submission.id)}
                                                disabled={deleting}
                                                style={{
                                                    padding: '6px 12px',
                                                    background: '#ef4444',
                                                    border: 'none',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '12px',
                                                    cursor: deleting ? 'not-allowed' : 'pointer',
                                                    fontWeight: '600',
                                                    opacity: deleting ? 0.5 : 1
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
                </div>

                {filteredSubmissions.length === 0 && !loading && (
                    <div style={{
                        padding: '60px',
                        textAlign: 'center',
                        color: '#64748b'
                    }}>
                        {searchTerm ? 'Nenhuma redação encontrada com esse filtro' : 'Nenhuma redação cadastrada ainda'}
                    </div>
                )}

                {/* Loading indicator */}
                {loading && filteredSubmissions.length > 0 && (
                    <div style={{
                        padding: '20px',
                        textAlign: 'center',
                        color: '#94a3b8'
                    }}>
                        Carregando mais redações...
                    </div>
                )}

                {/* Intersection Observer target */}
                {hasMore && !searchTerm && (
                    <div ref={observerTarget} style={{ height: '20px' }} />
                )}
            </div>
        </AdminLayout>
    );
};

export default RedacoesAdmin;
