import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';
import FeedbackPopup from '../../components/FeedbackPopup';
import AIProfessorChat from '../../components/AIProfessorChat';
import api from '../../services/api';

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
    exam_type?: string;
    user_has_feedback?: boolean;
}

const EXAM_CRITERIA: Record<string, { name: string; max_score: number; competencies: string[]; weights: number[] }> = {
    enem: {
        name: 'ENEM',
        max_score: 1000,
        competencies: [
            'Domínio da Norma Culta',
            'Compreensão do Tema',
            'Argumentação',
            'Coesão e Coerência',
            'Proposta de Intervenção'
        ],
        weights: [200, 200, 200, 200, 200]
    },
    fuvest: {
        name: 'FUVEST',
        max_score: 50,
        competencies: [
            'Desenvolvimento do Tema',
            'Estrutura e Organização',
            'Expressão e Gramática',
            'Coesão e Coerência'
        ],
        weights: [12.5, 12.5, 12.5, 12.5]
    },
    unicamp: {
        name: 'UNICAMP',
        max_score: 48,
        competencies: [
            'Adequação ao Gênero',
            'Compreensão da Proposta',
            'Propósito Comunicativo',
            'Articulação de Ideias',
            'Adequação Linguística'
        ],
        weights: [9.6, 9.6, 9.6, 9.6, 9.6]
    },
    ita: {
        name: 'ITA',
        max_score: 100,
        competencies: [
            'Argumentação Técnica',
            'Rigor Lógico',
            'Conhecimento Técnico',
            'Organização Textual',
            'Domínio da Norma Culta'
        ],
        weights: [20, 20, 20, 20, 20]
    },
    unesp: {
        name: 'UNESP',
        max_score: 100,
        competencies: [
            'Tema',
            'Estrutura e Coesão',
            'Expressão',
            'Autoria e Originalidade',
            'Conhecimento de Mundo'
        ],
        weights: [20, 20, 20, 20, 20]
    },
    uerj: {
        name: 'UERJ',
        max_score: 100,
        competencies: [
            'Adequação ao Tema/Gênero',
            'Articulação Textual',
            'Domínio da Língua'
        ],
        weights: [33.3, 33.3, 33.4]
    },
    ufmg: {
        name: 'UFMG',
        max_score: 100,
        competencies: [
            'Abordagem do Tema',
            'Articulação Argumentativa',
            'Uso de Informações',
            'Domínio da Norma Culta'
        ],
        weights: [25, 25, 25, 25]
    },
    afa: {
        name: 'AFA',
        max_score: 100,
        competencies: [
            'Adequação ao Tema',
            'Clareza e Objetividade',
            'Coerência e Coesão',
            'Argumentação Lógica',
            'Domínio da Norma Culta'
        ],
        weights: [20, 20, 20, 20, 20]
    },
    cacd: {
        name: 'CACD',
        max_score: 100,
        competencies: [
            'Aprofundamento Temático',
            'Argumentação Sofisticada',
            'Domínio da Norma Culta',
            'Articulação de Ideias',
            'Perspectiva Geopolítica'
        ],
        weights: [20, 20, 20, 20, 20]
    },
    sisu: {
        name: 'SISU',
        max_score: 1000,
        competencies: [
            'Domínio da Norma Culta',
            'Compreensão do Tema',
            'Argumentação',
            'Coesão e Coerência',
            'Proposta de Intervenção'
        ],
        weights: [200, 200, 200, 200, 200]
    }
};

const RedacaoDetalhes = () => {
    const { id: rawId } = useParams<{ id: string }>();
    // Remove "M" prefix if it exists (from old localStorage data)
    const id = rawId?.startsWith('M') ? rawId.substring(1) : rawId;
    const navigate = useNavigate();
    const [essay, setEssay] = useState<Essay | null>(null);
    const [loading, setLoading] = useState(true);
    const [showFeedbackPopup, setShowFeedbackPopup] = useState(false);

    // Redirect if URL has "M" prefix (clean URL)
    useEffect(() => {
        if (rawId?.startsWith('M')) {
            navigate(`/painel/redacao/${id}`, { replace: true });
        }
    }, [rawId, id, navigate]);

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
        const fetchEssay = async () => {
            try {
                setLoading(true);

                // Try API first (for new integer IDs)
                try {
                    const response = await api.get(`/my-submissions/${id}`);
                    setEssay(response.data);
                    return; // Success, exit early
                } catch (apiError: any) {
                    // If API fails (e.g., UUID not found), try localStorage
                    console.warn('⚠️ API failed, trying localStorage:', apiError.response?.data?.detail || apiError.message);
                }

                // Fallback to localStorage (for old UUID-based submissions)
                const essayDataStr = localStorage.getItem(`essay_${id}`);
                const correctionDataStr = localStorage.getItem(`correction_${id}`);

                if (!essayDataStr || !correctionDataStr) {
                    console.warn('⚠️ Dados não encontrados nem na API nem no localStorage');
                    setEssay(null);
                    return;
                }

                const essayData = JSON.parse(essayDataStr);
                const correctionData = JSON.parse(correctionDataStr);

                setEssay({
                    ...essayData,
                    correction: correctionData
                });
            } catch (error) {
                console.error('❌ Erro ao buscar redação:', error);
                setEssay(null);
            } finally {
                setLoading(false);
            }
        };

        fetchEssay();
    }, [id]);

    // Show popup only if user hasn't given feedback yet
    useEffect(() => {
        if (essay?.status === 'completed' && essay.correction && !essay.user_has_feedback) {
            const timer = setTimeout(() => {
                setShowFeedbackPopup(true);
            }, 3000);

            return () => clearTimeout(timer);
        }
    }, [essay]);

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

    // Determine current exam criteria
    const currentExamKey = essay.exam_type?.toLowerCase() || 'enem';
    const currentExam = EXAM_CRITERIA[currentExamKey] || EXAM_CRITERIA['enem'];

    const getScoreColor = (score: number, max: number = 200) => {
        const percentage = score / max;
        if (percentage >= 0.8) return '#10b981';
        if (percentage >= 0.6) return '#f59e0b';
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

                {/* Exam Badge */}
                <div style={{
                    position: 'absolute',
                    top: '24px',
                    right: '24px',
                    background: '#3B82F6',
                    color: 'white',
                    padding: '4px 12px',
                    borderRadius: '20px',
                    fontSize: '12px',
                    fontWeight: 'bold',
                    textTransform: 'uppercase',
                    boxShadow: '0 4px 6px -1px rgba(59, 130, 246, 0.5)'
                }}>
                    {currentExam.name}
                </div>

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
                            color: getScoreColor(essay.correction?.total_score || 0, currentExam.max_score)
                        }}>
                            {essay.correction?.total_score || 0}
                            <span style={{ fontSize: '24px', color: '#64748b' }}>/{currentExam.max_score}</span>
                        </div>
                    </div>

                    <div style={{ flex: 1, display: 'grid', gridTemplateColumns: `repeat(${currentExam.competencies.length}, 1fr)`, gap: '12px' }}>
                        {currentExam.competencies.map((_, idx) => {
                            const comp = idx + 1;
                            const score = essay.correction?.[`competence_${comp}_score` as keyof Correction] as number || 0;
                            const maxScore = currentExam.weights[idx];

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
                                        color: getScoreColor(score, maxScore)
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
            {essay.correction ? (
                <>
                    <div style={{ marginBottom: '32px' }}>
                        <h2 style={{
                            fontSize: '20px',
                            fontWeight: '700',
                            color: '#fff',
                            marginBottom: '16px'
                        }}>
                            Correção por Competência
                        </h2>

                        {currentExam.competencies.map((compName, idx) => {
                            const comp = idx + 1;
                            const score = essay.correction?.[`competence_${comp}_score` as keyof Correction] as number || 0;
                            const rawFeedback = essay.correction?.[`competence_${comp}_feedback` as keyof Correction];
                            const feedback = typeof rawFeedback === 'string' ? rawFeedback : (rawFeedback ? JSON.stringify(rawFeedback) : '');
                            const maxScore = currentExam.weights[idx];

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
                                            Competência {comp}: {compName}
                                        </h3>
                                        <div style={{
                                            padding: '6px 16px',
                                            background: `${getScoreColor(score, maxScore)}20`,
                                            color: getScoreColor(score, maxScore),
                                            borderRadius: '8px',
                                            fontSize: '14px',
                                            fontWeight: '700'
                                        }}>
                                            {score}/{maxScore}
                                        </div>
                                    </div>

                                    {(() => {
                                        // Parse feedback sections safely
                                        const parts = feedback ? feedback.split(/✅ Pontos Fortes:|⚠️ O que melhorar:/) : [];
                                        const analise = parts[0]?.replace('Análise:', '').trim();
                                        const pontosFortes = parts[1]?.trim();
                                        const melhorias = parts[2]?.trim();

                                        return (
                                            <div style={{
                                                display: 'grid',
                                                gridTemplateColumns: 'minmax(0, 1.5fr) minmax(0, 1fr)',
                                                gap: '24px',
                                                alignItems: 'stretch'
                                            }}>
                                                {/* Left Column: Análise */}
                                                <div>
                                                    {analise && (
                                                        <div style={{
                                                            background: 'rgba(51, 65, 85, 0.3)', // Slate-700 with opacity
                                                            border: '1px solid rgba(51, 65, 85, 0.5)',
                                                            borderRadius: '12px',
                                                            padding: '20px',
                                                            height: '100%'
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
                                        {strengths.map((strength: any, idx) => {
                                            // Handle case where strength is an object (e.g. {descricao: "..."})
                                            const text = typeof strength === 'object' && strength !== null
                                                ? (strength.descricao || JSON.stringify(strength))
                                                : String(strength);

                                            return (
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
                                                    {text}
                                                </li>
                                            );
                                        })}
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
                                        {improvements.map((improvement: any, idx) => {
                                            // Handle case where improvement is an object (e.g. {descricao: "..."})
                                            const text = typeof improvement === 'object' && improvement !== null
                                                ? (improvement.descricao || JSON.stringify(improvement))
                                                : String(improvement);

                                            return (
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
                                                    {text}
                                                </li>
                                            );
                                        })}
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
                </>
            ) : (
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '16px',
                    padding: '32px',
                    textAlign: 'center'
                }}>
                    <h3 style={{
                        fontSize: '18px',
                        fontWeight: '700',
                        color: '#fff',
                        marginBottom: '12px'
                    }}>
                        Correção em andamento ou indisponível
                    </h3>
                    <p style={{
                        fontSize: '14px',
                        color: '#94a3b8'
                    }}>
                        A correção para esta redação ainda não está disponível. Por favor, aguarde alguns instantes e recarregue a página.
                    </p>
                </div>
            )}

            {/* AI Professor Chat - Show only for completed essays */}
            {essay?.status === 'completed' && essay.correction && (
                <AIProfessorChat submissionId={id || ''} />
            )}

            {/* Feedback Popup */}
            {showFeedbackPopup && (
                <FeedbackPopup
                    onFeedback={async (isPositive) => {
                        try {
                            await api.post(`/submissions/${id}/feedback`, {
                                helpful: isPositive
                            });
                            // Atualiza o estado para evitar mostrar popup novamente
                            setEssay(prev => prev ? { ...prev, user_has_feedback: true } : null);
                        } catch (error) {
                            console.error('Erro ao enviar feedback:', error);
                        }
                    }}
                    onClose={() => setShowFeedbackPopup(false)}
                />
            )}
        </PanelLayout>
    );
};

export default RedacaoDetalhes;
