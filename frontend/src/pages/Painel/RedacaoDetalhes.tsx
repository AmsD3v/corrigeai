import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';

interface Correction {
    competence_1_score: number;
    competence_2_score: number;
    competence_3_score: number;
    competence_4_score: number;
    competence_5_score: number;
    total_score: number;
    competence_1_feedback: string;
    competence_2_feedback: string;
    competence_3_feedback: string;
    competence_4_feedback: string;
    competence_5_feedback: string;
    strengths: string[] | string;
    improvements: string[] | string;
    general_comments: string;
}

interface Essay {
    id: string;
    title: string;
    theme: string;
    content: string;
    submitted_at: string;
    status: string;
    correction?: Correction;
}

const RedacaoDetalhes = () => {
    const { id } = useParams<{ id: string }>();
    const navigate = useNavigate();
    const [essay, setEssay] = useState<Essay | null>(null);
    const [loading, setLoading] = useState(true);

    // Safe parse helper: handles both string (JSON) and array formats
    const parseArrayField = (field: any): string[] => {
        if (!field) return [];
        if (Array.isArray(field)) return field;
        if (typeof field === 'string') {
            try {
                const parsed = JSON.parse(field);
                return Array.isArray(parsed) ? parsed : [field];
            } catch {
                return [field]; // If not valid JSON, treat as single string
            }
        }
        return [];
    };

    useEffect(() => {
        // Get essay and correction data from localStorage
        const essayDataStr = localStorage.getItem(`essay_${id}`);
        const correctionDataStr = localStorage.getItem(`correction_${id}`);

        if (!essayDataStr || !correctionDataStr) {
            console.warn('⚠️ Dados não encontrados no localStorage');
            setLoading(false);
            return;
        }

        try {
            const essayData = JSON.parse(essayDataStr);
            const correctionData = JSON.parse(correctionDataStr);

            setEssay({
                ...essayData,
                correction: correctionData
            });
        } catch (error) {
            console.error('❌ Erro ao parsear dados:', error);
        } finally {
            setLoading(false);
        }
    }, [id]);

    if (loading) {
        return (
            <PanelLayout activePage="/painel/minhas-redacoes">
                <div style={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    minHeight: '400px',
                    color: '#94a3b8'
                }}>
                    Carregando...
                </div>
            </PanelLayout>
        );
    }

    if (!essay) {
        return (
            <PanelLayout activePage="/painel/minhas-redacoes">
                <div style={{
                    textAlign: 'center',
                    padding: '60px 20px',
                    color: '#64748b'
                }}>
                    <h2 style={{ fontSize: '24px', marginBottom: '16px' }}>Redação não encontrada</h2>
                    <button
                        onClick={() => navigate('/painel/minhas-redacoes')}
                        style={{
                            padding: '12px 24px',
                            background: '#4F46E5',
                            border: 'none',
                            borderRadius: '8px',
                            color: '#fff',
                            cursor: 'pointer',
                            fontSize: '14px',
                            fontWeight: '600'
                        }}
                    >
                        Voltar para Minhas Redações
                    </button>
                </div>
            </PanelLayout>
        );
    }

    const getScoreColor = (score: number) => {
        if (score >= 160) return '#10b981';
        if (score >= 120) return '#f59e0b';
        return '#ef4444';
    };

    const strengths = parseArrayField(essay.correction?.strengths);
    const improvements = parseArrayField(essay.correction?.improvements);

    return (
        <PanelLayout activePage="/painel/minhas-redacoes">
            {/* Header with Score */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px',
                marginBottom: '32px',
                position: 'relative',
                overflow: 'hidden'
            }}>
                <div style={{
                    position: 'absolute',
                    top: '-50px',
                    right: '-50px',
                    width: '200px',
                    height: '200px',
                    background: 'radial-gradient(circle, rgba(79, 70, 229, 0.1) 0%, transparent 70%)'
                }} />

                <button
                    onClick={() => navigate('/painel/minhas-redacoes')}
                    style={{
                        marginBottom: '16px',
                        padding: '8px 16px',
                        background: 'transparent',
                        border: '1px solid #334155',
                        borderRadius: '8px',
                        color: '#94a3b8',
                        cursor: 'pointer',
                        fontSize: '14px',
                        display: 'flex',
                        alignItems: 'center',
                        gap: '8px'
                    }}
                >
                    ← Voltar
                </button>

                <h1 style={{
                    fontSize: '28px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '16px',
                    lineHeight: '1.3'
                }}>
                    {essay.title}
                </h1>

                <div style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '32px',
                    flexWrap: 'wrap'
                }}>
                    <div>
                        <div style={{ fontSize: '12px', color: '#64748b', marginBottom: '4px' }}>Nota Total</div>
                        <div style={{
                            fontSize: '48px',
                            fontWeight: '800',
                            color: getScoreColor(essay.correction?.total_score || 0)
                        }}>
                            {essay.correction?.total_score || 0}
                            <span style={{ fontSize: '24px', color: '#64748b' }}>/1000</span>
                        </div>
                    </div>

                    <div style={{ flex: 1, display: 'grid', gridTemplateColumns: 'repeat(5, 1fr)', gap: '12px' }}>
                        {[1, 2, 3, 4, 5].map((comp) => {
                            const score = essay.correction?.[`competence_${comp}_score` as keyof Correction] as number || 0;
                            return (
                                <div key={comp} style={{
                                    background: '#0f1419',
                                    padding: '12px',
                                    borderRadius: '8px',
                                    textAlign: 'center'
                                }}>
                                    <div style={{ fontSize: '11px', color: '#64748b', marginBottom: '4px' }}>C{comp}</div>
                                    <div style={{
                                        fontSize: '20px',
                                        fontWeight: '700',
                                        color: getScoreColor(score)
                                    }}>
                                        {score}
                                    </div>
                                </div>
                            );
                        })}
                    </div>
                </div>
            </div>

            {/* Essay Content */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px',
                marginBottom: '32px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    Sua Redação
                </h2>
                <div style={{
                    fontSize: '14px',
                    color: '#cbd5e1',
                    lineHeight: '1.8',
                    whiteSpace: 'pre-wrap'
                }}>
                    {essay.content}
                </div>
            </div>

            {/* Feedback by Competence */}
            <div style={{ marginBottom: '32px' }}>
                <h2 style={{
                    fontSize: '20px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    Correção por Competência
                </h2>

                {[1, 2, 3, 4, 5].map((comp) => {
                    const competenceNames = [
                        'Domínio da Norma Culta',
                        'Compreensão do Tema',
                        'Argumentação',
                        'Coesão e Coerência',
                        'Proposta de Intervenção'
                    ];
                    const score = essay.correction?.[`competence_${comp}_score` as keyof Correction] as number || 0;
                    const feedback = essay.correction?.[`competence_${comp}_feedback` as keyof Correction] as string || '';

                    return (
                        <div key={comp} style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '16px',
                            padding: '24px',
                            marginBottom: '16px'
                        }}>
                            <div style={{
                                display: 'flex',
                                justifyContent: 'space-between',
                                alignItems: 'center',
                                marginBottom: '16px',
                                flexWrap: 'wrap',
                                gap: '12px'
                            }}>
                                <h3 style={{
                                    fontSize: '16px',
                                    fontWeight: '700',
                                    color: '#fff'
                                }}>
                                    Competência {comp}: {competenceNames[comp - 1]}
                                </h3>
                                <div style={{
                                    padding: '6px 16px',
                                    background: `${getScoreColor(score)}20`,
                                    color: getScoreColor(score),
                                    borderRadius: '8px',
                                    fontSize: '14px',
                                    fontWeight: '700'
                                }}>
                                    {score}/200
                                </div>
                            </div>

                            {(() => {
                                // Parse feedback sections
                                const parts = feedback ? feedback.split(/✅ Pontos Fortes:|⚠️ O que melhorar:/) : [];
                                const analise = parts[0]?.replace('Análise:', '').trim();
                                const pontosFortes = parts[1]?.trim();
                                const melhorias = parts[2]?.trim();

                                return (
                                    <div style={{
                                        display: 'grid',
                                        gridTemplateColumns: 'minmax(0, 1.5fr) minmax(0, 1fr)',
                                        gap: '24px',
                                        alignItems: 'start'
                                    }}>
                                        {/* Left Column: Análise */}
                                        <div>
                                            {analise && (
                                                <div style={{
                                                    background: 'rgba(51, 65, 85, 0.3)', // Slate-700 with opacity
                                                    border: '1px solid rgba(51, 65, 85, 0.5)',
                                                    borderRadius: '12px',
                                                    padding: '20px'
                                                }}>
                                                    <h4 style={{
                                                        fontSize: '14px',
                                                        fontWeight: '700',
                                                        color: '#e2e8f0', // Slate-200
                                                        marginBottom: '12px',
                                                        display: 'flex',
                                                        alignItems: 'center',
                                                        gap: '6px'
                                                    }}>
                                                        📝 Análise Detalhada
                                                    </h4>
                                                    <p style={{
                                                        fontSize: '14px',
                                                        color: '#cbd5e1', // Slate-300
                                                        lineHeight: '1.8',
                                                        margin: 0,
                                                        whiteSpace: 'pre-line'
                                                    }}>
                                                        {analise}
                                                    </p>
                                                </div>
                                            )}
                                        </div>

                                        {/* Right Column: Cards */}
                                        <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                                            {/* Pontos Fortes Card */}
                                            {pontosFortes && (
                                                <div style={{
                                                    background: 'rgba(16, 185, 129, 0.1)',
                                                    border: '1px solid rgba(16, 185, 129, 0.2)',
                                                    borderRadius: '12px',
                                                    padding: '16px'
                                                }}>
                                                    <h4 style={{
                                                        fontSize: '14px',
                                                        fontWeight: '700',
                                                        color: '#10b981',
                                                        marginBottom: '8px',
                                                        display: 'flex',
                                                        alignItems: 'center',
                                                        gap: '6px'
                                                    }}>
                                                        ✅ Pontos Fortes
                                                    </h4>
                                                    <p style={{
                                                        fontSize: '13px',
                                                        color: '#cbd5e1',
                                                        lineHeight: '1.5',
                                                        margin: 0,
                                                        whiteSpace: 'pre-line'
                                                    }}>
                                                        {pontosFortes}
                                                    </p>
                                                </div>
                                            )}

                                            {/* Melhorias Card */}
                                            {melhorias && (
                                                <div style={{
                                                    background: 'rgba(245, 158, 11, 0.1)',
                                                    border: '1px solid rgba(245, 158, 11, 0.2)',
                                                    borderRadius: '12px',
                                                    padding: '16px'
                                                }}>
                                                    <h4 style={{
                                                        fontSize: '14px',
                                                        fontWeight: '700',
                                                        color: '#f59e0b',
                                                        marginBottom: '8px',
                                                        display: 'flex',
                                                        alignItems: 'center',
                                                        gap: '6px'
                                                    }}>
                                                        ⚠️ O que melhorar
                                                    </h4>
                                                    <p style={{
                                                        fontSize: '13px',
                                                        color: '#cbd5e1',
                                                        lineHeight: '1.5',
                                                        margin: 0,
                                                        whiteSpace: 'pre-line'
                                                    }}>
                                                        {melhorias}
                                                    </p>
                                                </div>
                                            )}
                                        </div>
                                    </div>
                                );
                            })()}
                        </div>
                    );
                })}
            </div>

            {/* Strengths and Improvements */}
            {(strengths.length > 0 || improvements.length > 0) && (
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(2, 1fr)',
                    gap: '16px',
                    marginBottom: '32px'
                }}>
                    {/* Pontos Fortes */}
                    {strengths.length > 0 && (
                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '16px',
                            padding: '24px'
                        }}>
                            <h3 style={{
                                fontSize: '16px',
                                fontWeight: '700',
                                color: '#10b981',
                                marginBottom: '16px',
                                display: 'flex',
                                alignItems: 'center',
                                gap: '8px'
                            }}>
                                ✓ Pontos Fortes
                            </h3>
                            <ul style={{
                                listStyle: 'none',
                                padding: 0,
                                margin: 0
                            }}>
                                {strengths.map((strength, idx) => (
                                    <li key={idx} style={{
                                        fontSize: '14px',
                                        color: '#94a3b8',
                                        marginBottom: '12px',
                                        paddingLeft: '20px',
                                        position: 'relative',
                                        lineHeight: '1.6'
                                    }}>
                                        <span style={{
                                            position: 'absolute',
                                            left: 0,
                                            color: '#10b981',
                                            fontWeight: '700'
                                        }}>•</span>
                                        {strength}
                                    </li>
                                ))}
                            </ul>
                        </div>
                    )}

                    {/* Pontos a Melhorar */}
                    {improvements.length > 0 && (
                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '16px',
                            padding: '24px'
                        }}>
                            <h3 style={{
                                fontSize: '16px',
                                fontWeight: '700',
                                color: '#f59e0b',
                                marginBottom: '16px',
                                display: 'flex',
                                alignItems: 'center',
                                gap: '8px'
                            }}>
                                ⚠ Pontos a Melhorar
                            </h3>
                            <ul style={{
                                listStyle: 'none',
                                padding: 0,
                                margin: 0
                            }}>
                                {improvements.map((improvement, idx) => (
                                    <li key={idx} style={{
                                        fontSize: '14px',
                                        color: '#94a3b8',
                                        marginBottom: '12px',
                                        paddingLeft: '20px',
                                        position: 'relative',
                                        lineHeight: '1.6'
                                    }}>
                                        <span style={{
                                            position: 'absolute',
                                            left: 0,
                                            color: '#f59e0b',
                                            fontWeight: '700'
                                        }}>•</span>
                                        {improvement}
                                    </li>
                                ))}
                            </ul>
                        </div>
                    )}
                </div>
            )}

            {/* General Comments */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '24px'
            }}>
                <h3 style={{
                    fontSize: '16px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '12px'
                }}>
                    Comentário Geral
                </h3>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8',
                    lineHeight: '1.6'
                }}>
                    {essay.correction?.general_comments}
                </p>
            </div>
        </PanelLayout>
    );
};

export default RedacaoDetalhes;
