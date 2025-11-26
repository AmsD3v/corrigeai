import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';

interface Correction {
    competence_1_score: number;
    competence_2_score: number;
    competence_3_score: number;
    competence_4_score: number;
    competence_5_score: number;
    total_score: number;
}

interface CompetencyData {
    id: number;
    name: string;
    description: string;
    score: number;
    maxScore: number;
    percentage: number;
}

interface ScoreHistoryItem {
    essayId: string;
    title: string;
    score: number;
    date: string;
}

const MeuDesenvolvimento = () => {
    const navigate = useNavigate();
    const [hasEssays, setHasEssays] = useState(false);
    const [competencies, setCompetencies] = useState<CompetencyData[]>([]);
    const [bestCompetencies, setBestCompetencies] = useState<CompetencyData[]>([]);
    const [worstCompetencies, setWorstCompetencies] = useState<CompetencyData[]>([]);
    const [scoreHistory, setScoreHistory] = useState<ScoreHistoryItem[]>([]);

    useEffect(() => {
        const allKeys = Object.keys(localStorage);
        const correctionKeys = allKeys.filter(key => key.startsWith('correction_'));

        if (correctionKeys.length === 0) {
            setHasEssays(false);
            return;
        }

        setHasEssays(true);

        const competencyTotals = [0, 0, 0, 0, 0];
        const competencyCounts = [0, 0, 0, 0, 0];
        const scores: ScoreHistoryItem[] = [];

        correctionKeys.forEach(key => {
            const essayId = key.replace('correction_', '');
            const correctionStr = localStorage.getItem(key);
            const essayStr = localStorage.getItem(`essay_${essayId}`);

            if (correctionStr && essayStr) {
                try {
                    const correction: Correction = JSON.parse(correctionStr);
                    const essay = JSON.parse(essayStr);

                    competencyTotals[0] += correction.competence_1_score;
                    competencyTotals[1] += correction.competence_2_score;
                    competencyTotals[2] += correction.competence_3_score;
                    competencyTotals[3] += correction.competence_4_score;
                    competencyTotals[4] += correction.competence_5_score;

                    competencyCounts[0]++;
                    competencyCounts[1]++;
                    competencyCounts[2]++;
                    competencyCounts[3]++;
                    competencyCounts[4]++;

                    scores.push({
                        essayId,
                        title: essay.title || 'Redação sem título',
                        score: correction.total_score,
                        date: essay.submitted_at || new Date().toISOString()
                    });
                } catch (error) {
                    console.error('Error parsing correction:', error);
                }
            }
        });

        const competencyData: CompetencyData[] = [
            {
                id: 1,
                name: 'Competência I',
                description: 'Domínio da escrita formal',
                score: Math.round(competencyTotals[0] / competencyCounts[0]),
                maxScore: 200,
                percentage: Math.round((competencyTotals[0] / competencyCounts[0] / 200) * 100)
            },
            {
                id: 2,
                name: 'Competência II',
                description: 'Compreensão do tema e repertório',
                score: Math.round(competencyTotals[1] / competencyCounts[1]),
                maxScore: 200,
                percentage: Math.round((competencyTotals[1] / competencyCounts[1] / 200) * 100)
            },
            {
                id: 3,
                name: 'Competência III',
                description: 'Seleção e organização de ideias',
                score: Math.round(competencyTotals[2] / competencyCounts[2]),
                maxScore: 200,
                percentage: Math.round((competencyTotals[2] / competencyCounts[2] / 200) * 100)
            },
            {
                id: 4,
                name: 'Competência IV',
                description: 'Coesão e coerência',
                score: Math.round(competencyTotals[3] / competencyCounts[3]),
                maxScore: 200,
                percentage: Math.round((competencyTotals[3] / competencyCounts[3] / 200) * 100)
            },
            {
                id: 5,
                name: 'Competência V',
                description: 'Proposta de intervenção',
                score: Math.round(competencyTotals[4] / competencyCounts[4]),
                maxScore: 200,
                percentage: Math.round((competencyTotals[4] / competencyCounts[4] / 200) * 100)
            }
        ];

        setCompetencies(competencyData);

        const maxScore = Math.max(...competencyData.map(c => c.score));
        const best = competencyData.filter(c => c.score === maxScore);
        setBestCompetencies(best);

        const minScore = Math.min(...competencyData.map(c => c.score));
        const worst = competencyData.filter(c => c.score === minScore);
        setWorstCompetencies(worst);

        scores.sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());
        setScoreHistory(scores);
    }, []);

    const getColorByPercentage = (percentage: number) => {
        if (percentage >= 80) return '#10b981';
        if (percentage >= 60) return '#f59e0b';
        return '#ef4444';
    };

    const getScoreColor = (score: number) => {
        if (score >= 800) return '#10b981';
        if (score >= 600) return '#f59e0b';
        return '#ef4444';
    };

    if (!hasEssays) {
        return (
            <PanelLayout activePage="/painel/desenvolvimento">
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
                        Meu Desenvolvimento
                    </h1>
                    <p style={{
                        fontSize: '14px',
                        color: '#94a3b8'
                    }}>
                        Acompanhe sua evolução por competência e ao longo do tempo.
                    </p>
                </div>

                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '16px',
                    padding: '80px 40px',
                    textAlign: 'center'
                }}>
                    <div style={{
                        fontSize: '48px',
                        marginBottom: '16px'
                    }}>
                        😊
                    </div>
                    <h2 style={{
                        fontSize: '20px',
                        fontWeight: '700',
                        color: '#fff',
                        marginBottom: '12px'
                    }}>
                        Ainda sem dados de desenvolvimento? 🤔
                    </h2>
                    <p style={{
                        fontSize: '14px',
                        color: '#94a3b8',
                        marginBottom: '32px',
                        maxWidth: '600px',
                        margin: '0 auto 32px'
                    }}>
                        Escreva sua primeira redação e comece a acompanhar sua evolução por competência e pontuação ao longo do tempo!
                    </p>
                    <button
                        onClick={() => navigate('/painel/redigir-redacao')}
                        style={{
                            padding: '14px 32px',
                            background: '#4F46E5',
                            color: '#fff',
                            border: 'none',
                            borderRadius: '12px',
                            fontSize: '15px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s',
                            boxShadow: '0 4px 12px rgba(79, 70, 229, 0.3)'
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.background = '#4338ca';
                            e.currentTarget.style.transform = 'translateY(-2px)';
                            e.currentTarget.style.boxShadow = '0 6px 16px rgba(79, 70, 229, 0.4)';
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.background = '#4F46E5';
                            e.currentTarget.style.transform = 'translateY(0)';
                            e.currentTarget.style.boxShadow = '0 4px 12px rgba(79, 70, 229, 0.3)';
                        }}
                    >
                        Escrever Minha Primeira Redação
                    </button>
                </div>
            </PanelLayout>
        );
    }

    return (
        <PanelLayout activePage="/painel/desenvolvimento">
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Meu Desenvolvimento
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Acompanhe sua evolução por competência e ao longo do tempo.
                </p>
            </div>

            <div style={{
                display: 'grid',
                gridTemplateColumns: '1fr 1fr',
                gap: '24px',
                marginBottom: '32px'
            }}>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '16px',
                    padding: '24px'
                }}>
                    <h2 style={{
                        fontSize: '18px',
                        fontWeight: '700',
                        color: '#fff',
                        marginBottom: '20px'
                    }}>
                        Insights de Desempenho
                    </h2>

                    <div style={{ marginBottom: '16px' }}>
                        <div style={{
                            fontSize: '13px',
                            color: '#64748b',
                            marginBottom: '8px'
                        }}>
                            {bestCompetencies.length > 1 ? 'Melhores Competências:' : 'Melhor Competência:'}
                        </div>
                        {bestCompetencies.map((comp, index) => (
                            <div key={comp.id} style={{ marginBottom: index < bestCompetencies.length - 1 ? '8px' : '0' }}>
                                <div style={{
                                    fontSize: '13px',
                                    color: '#64748b'
                                }}>
                                    <span style={{ color: '#10b981', fontWeight: '600' }}>{comp.name}</span> ({comp.description})
                                </div>
                                <div style={{
                                    fontSize: '13px',
                                    color: '#64748b'
                                }}>
                                    Pontuação Média: <span style={{ color: '#10b981', fontWeight: '600' }}>{comp.score}</span>
                                </div>
                            </div>
                        ))}
                    </div>

                    <div style={{
                        height: '1px',
                        background: '#334155',
                        margin: '16px 0'
                    }} />

                    <div>
                        <div style={{
                            fontSize: '13px',
                            color: '#64748b',
                            marginBottom: '8px'
                        }}>
                            {worstCompetencies.length > 1 ? 'Competências para Melhorar:' : 'Competência para Melhorar:'}
                        </div>
                        {worstCompetencies.map((comp, index) => (
                            <div key={comp.id} style={{ marginBottom: index < worstCompetencies.length - 1 ? '8px' : '0' }}>
                                <div style={{
                                    fontSize: '13px',
                                    color: '#64748b'
                                }}>
                                    <span style={{ color: '#ef4444', fontWeight: '600' }}>{comp.name}</span> ({comp.description})
                                </div>
                                <div style={{
                                    fontSize: '13px',
                                    color: '#64748b'
                                }}>
                                    Pontuação Média: <span style={{ color: '#ef4444', fontWeight: '600' }}>{comp.score}</span>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '16px',
                    padding: '24px'
                }}>
                    <h2 style={{
                        fontSize: '18px',
                        fontWeight: '700',
                        color: '#fff',
                        marginBottom: '20px'
                    }}>
                        Média por Competência
                    </h2>

                    {competencies.map((comp) => (
                        <div key={comp.id} style={{ marginBottom: '16px' }}>
                            <div style={{
                                display: 'flex',
                                justifyContent: 'space-between',
                                alignItems: 'center',
                                marginBottom: '6px'
                            }}>
                                <div style={{
                                    fontSize: '13px',
                                    fontWeight: '600',
                                    color: '#fff'
                                }}>
                                    {comp.name} ({comp.description})
                                </div>
                                <div style={{
                                    fontSize: '13px',
                                    fontWeight: '700',
                                    color: getColorByPercentage(comp.percentage),
                                    minWidth: '60px',
                                    textAlign: 'right'
                                }}>
                                    {comp.score} ({comp.percentage}%)
                                </div>
                            </div>

                            <div style={{
                                width: '100%',
                                height: '6px',
                                background: '#0f1419',
                                borderRadius: '3px',
                                overflow: 'hidden'
                            }}>
                                <div style={{
                                    width: `${comp.percentage}%`,
                                    height: '100%',
                                    background: getColorByPercentage(comp.percentage),
                                    borderRadius: '3px',
                                    transition: 'width 0.3s ease'
                                }} />
                            </div>
                        </div>
                    ))}
                </div>
            </div>

            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '24px'
                }}>
                    Pontuação ao longo do tempo
                </h2>

                {scoreHistory.length > 0 ? (
                    <div style={{
                        position: 'relative',
                        height: '420px',
                        padding: '80px 100px 80px 100px'
                    }}>
                        <div style={{
                            position: 'absolute',
                            left: '100px',
                            right: '100px',
                            top: '80px',
                            bottom: '80px',
                            display: 'flex',
                            flexDirection: 'column',
                            justifyContent: 'space-between'
                        }}>
                            {[1000, 800, 600, 400, 200, 0].map((value) => (
                                <div key={value} style={{
                                    borderTop: '1px dashed #334155',
                                    position: 'relative'
                                }}>
                                    <span style={{
                                        position: 'absolute',
                                        left: '-75px',
                                        top: '-8px',
                                        fontSize: '11px',
                                        color: '#64748b'
                                    }}>
                                        {value}
                                    </span>
                                </div>
                            ))}
                        </div>

                        <svg
                            style={{
                                position: 'absolute',
                                left: '100px',
                                right: '100px',
                                top: '80px',
                                bottom: '80px',
                                width: 'calc(100% - 200px)',
                                height: '260px'
                            }}
                        >
                            <defs>
                                <linearGradient id="scoreGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                                    <stop offset="0%" stopColor="#10b981" />
                                    <stop offset="50%" stopColor="#f59e0b" />
                                    <stop offset="100%" stopColor="#ef4444" />
                                </linearGradient>
                            </defs>

                            {scoreHistory.map((item, index) => {
                                if (index === scoreHistory.length - 1) return null;

                                const x1 = (index / (scoreHistory.length - 1)) * 100;
                                const y1 = 100 - (item.score / 1000) * 100;
                                const x2 = ((index + 1) / (scoreHistory.length - 1)) * 100;
                                const y2 = 100 - (scoreHistory[index + 1].score / 1000) * 100;

                                return (
                                    <line
                                        key={index}
                                        x1={`${x1}%`}
                                        y1={`${y1}%`}
                                        x2={`${x2}%`}
                                        y2={`${y2}%`}
                                        stroke="url(#scoreGradient)"
                                        strokeWidth="3"
                                    />
                                );
                            })}

                            {scoreHistory.map((item, index) => {
                                const x = (index / (scoreHistory.length - 1)) * 100;
                                const y = 100 - (item.score / 1000) * 100;

                                return (
                                    <g key={index}>
                                        <circle
                                            cx={`${x}%`}
                                            cy={`${y}%`}
                                            r="6"
                                            fill={getScoreColor(item.score)}
                                            stroke="#0f1419"
                                            strokeWidth="2"
                                        />
                                        <text
                                            x={`${x}%`}
                                            y={`${y}%`}
                                            dy="-15"
                                            textAnchor="middle"
                                            fill={getScoreColor(item.score)}
                                            fontSize="12"
                                            fontWeight="600"
                                        >
                                            {item.score}
                                        </text>
                                    </g>
                                );
                            })}
                        </svg>

                        <div style={{
                            position: 'absolute',
                            left: '100px',
                            right: '100px',
                            bottom: '45px',
                            display: 'flex',
                            justifyContent: 'space-between'
                        }}>
                            {scoreHistory.map((item, index) => (
                                <div
                                    key={index}
                                    style={{
                                        fontSize: '10px',
                                        color: '#64748b',
                                        textAlign: 'center',
                                        maxWidth: '80px',
                                        overflow: 'hidden',
                                        textOverflow: 'ellipsis',
                                        whiteSpace: 'nowrap'
                                    }}
                                    title={item.title}
                                >
                                    Redação {index + 1}
                                </div>
                            ))}
                        </div>
                    </div>
                ) : (
                    <div style={{
                        textAlign: 'center',
                        padding: '60px',
                        color: '#64748b'
                    }}>
                        Nenhuma redação corrigida ainda
                    </div>
                )}
            </div>
        </PanelLayout>
    );
};

export default MeuDesenvolvimento;
