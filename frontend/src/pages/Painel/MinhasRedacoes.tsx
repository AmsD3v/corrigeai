import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';

interface Essay {
    id: string; // UUID
    title: string;
    submitted_at: string;
    status: string;
    theme?: string;
    score?: number;
}
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
            {loading ? (
                <div style={{
                    padding: '60px',
                    textAlign: 'center',
                    color: '#64748b'
                }}>
                    Carregando...
                </div>
            ) : essays.length === 0 ? (
                <div style={{
                    padding: '60px',
                    textAlign: 'center',
                    color: '#64748b'
                }}>
                    Nenhuma redação encontrada.
                </div>
            ) : (
                essays.map((essay) => (
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
                ))
            )}
        </div>
    </PanelLayout>
);
};

export default MinhasRedacoes;
