import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import AdminLayout from '../../components/AdminLayout';

interface Essay {
    id: string;
    userId: string;
    title: string;
    theme: string;
    submittedAt: string;
    score: number;
    status: 'corrected' | 'pending';
}

const RedacoesAdmin = () => {
    const navigate = useNavigate();
    const [essays, setEssays] = useState<Essay[]>([]);
    const [searchTerm, setSearchTerm] = useState('');

    useEffect(() => {
        loadEssays();
    }, []);

    const loadEssays = () => {
        const allKeys = Object.keys(localStorage);
        const essayKeys = allKeys.filter(key => key.startsWith('essay_'));

        const loadedEssays: Essay[] = essayKeys.map(key => {
            try {
                const essayData = JSON.parse(localStorage.getItem(key) || '{}');
                const essayId = key.replace('essay_', '');
                const correctionKey = `correction_${essayId}`;
                const correction = localStorage.getItem(correctionKey);

                let score = 0;
                if (correction) {
                    try {
                        const correctionData = JSON.parse(correction);
                        score = correctionData.total_score || 0;
                    } catch (e) {
                        // ignore
                    }
                }

                return {
                    id: essayId,
                    userId: essayData.userId || 'unknown',
                    title: essayData.title || 'Sem título',
                    theme: essayData.theme || 'Tema não especificado',
                    submittedAt: essayData.submitted_at || new Date().toISOString(),
                    score,
                    status: correction ? 'corrected' : 'pending'
                };
            } catch (e) {
                return null;
            }
        }).filter(Boolean) as Essay[];

        // Sort by date (newest first)
        loadedEssays.sort((a, b) => new Date(b.submittedAt).getTime() - new Date(a.submittedAt).getTime());
        setEssays(loadedEssays);
    };

    const filteredEssays = essays.filter(essay =>
        essay.title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        essay.theme.toLowerCase().includes(searchTerm.toLowerCase())
    );

    const handleDelete = (essayId: string) => {
        if (confirm('Tem certeza que deseja deletar esta redação?')) {
            localStorage.removeItem(`essay_${essayId}`);
            localStorage.removeItem(`correction_${essayId}`);
            loadEssays();
        }
    };

    const handleView = (essayId: string) => {
        navigate(`/painel/redacao/${essayId}`);
    };

    const avgScore = essays.length > 0
        ? Math.round(essays.reduce((sum, e) => sum + e.score, 0) / essays.filter(e => e.score > 0).length)
        : 0;

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

            {/* Stats */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
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
                        Total de Redações
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#10b981' }}>
                        {essays.length}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Corrigidas
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#3b82f6' }}>
                        {essays.filter(e => e.status === 'corrected').length}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Pontuação Média
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#f59e0b' }}>
                        {avgScore}
                    </div>
                </div>
            </div>

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
                    placeholder="Buscar por título ou tema..."
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

            {/* Essays Table */}
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
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Título</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Tema</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Data</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Pontuação</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Status</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredEssays.map((essay) => (
                                <tr key={essay.id} style={{ borderTop: '1px solid #334155' }}>
                                    <td style={{ padding: '16px', color: '#fff', fontSize: '14px', maxWidth: '300px' }}>
                                        {essay.title.length > 50 ? `${essay.title.substring(0, 50)}...` : essay.title}
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px', maxWidth: '250px' }}>
                                        {essay.theme.length > 40 ? `${essay.theme.substring(0, 40)}...` : essay.theme}
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                        {new Date(essay.submittedAt).toLocaleDateString('pt-BR')}
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <span style={{
                                            fontSize: '16px',
                                            fontWeight: '700',
                                            color: essay.score >= 800 ? '#10b981' : essay.score >= 600 ? '#f59e0b' : '#ef4444'
                                        }}>
                                            {essay.score > 0 ? essay.score : '-'}
                                        </span>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <span style={{
                                            padding: '4px 12px',
                                            borderRadius: '12px',
                                            fontSize: '12px',
                                            fontWeight: '600',
                                            background: essay.status === 'corrected' ? '#10b98120' : '#f59e0b20',
                                            color: essay.status === 'corrected' ? '#10b981' : '#f59e0b'
                                        }}>
                                            {essay.status === 'corrected' ? 'Corrigida' : 'Pendente'}
                                        </span>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ display: 'flex', gap: '8px' }}>
                                            <button
                                                onClick={() => handleView(essay.id)}
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
                                                Visualizar
                                            </button>
                                            <button
                                                onClick={() => handleDelete(essay.id)}
                                                style={{
                                                    padding: '6px 12px',
                                                    background: '#ef4444',
                                                    border: 'none',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '12px',
                                                    cursor: 'pointer'
                                                }}
                                            >
                                                Deletar
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>

                {filteredEssays.length === 0 && (
                    <div style={{
                        padding: '60px',
                        textAlign: 'center',
                        color: '#64748b'
                    }}>
                        Nenhuma redação encontrada
                    </div>
                )}
            </div>
        </AdminLayout>
    );
};

export default RedacoesAdmin;
