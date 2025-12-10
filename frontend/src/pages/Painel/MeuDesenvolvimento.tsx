import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';
import api from '../../services/api';

interface CompetencyData {
    id: number;
    name: string;
    description: string;
    score: number;
    max_score: number;
    percentage: number;
}

interface ScoreHistoryItem {
    essay_id: number;
    title: string;
    score: number;
    date: string;
    exam_type: string;
}

interface DevelopmentStats {
    has_data: boolean;
    competencies: CompetencyData[];
    score_history: ScoreHistoryItem[];
    best_competencies: CompetencyData[];
    worst_competencies: CompetencyData[];
    available_exam_types: string[];
}

const EXAM_TYPE_LABELS: Record<string, string> = {
    'enem': 'ENEM',
    'fuvest': 'FUVEST',
    'unicamp': 'UNICAMP',
    'unesp': 'UNESP',
    'uerj': 'UERJ',
    'ufpr': 'UFPR',
    'ufrgs': 'UFRGS',
    'ufsc': 'UFSC',
    'ufmg': 'UFMG',
    'unb': 'UnB',
    'ufrn': 'UFRN',
    'ufba': 'UFBA',
    'ufpe': 'UFPE',
    'ufc': 'UFC',
    'uff': 'UFF'
};

const MeuDesenvolvimento = () => {
    const navigate = useNavigate();
    const [loading, setLoading] = useState(true);
    const [stats, setStats] = useState<DevelopmentStats | null>(null);
    const [selectedExamType, setSelectedExamType] = useState<string>('all');

    useEffect(() => {
        loadDevelopmentData();
    }, [selectedExamType]);

    const loadDevelopmentData = async () => {
        try {
            setLoading(true);
            const params = selectedExamType !== 'all' ? `?exam_type=${selectedExamType}` : '';
            const response = await api.get(`/my-submissions/development-stats${params}`);
            setStats(response.data);
        } catch (error) {
            console.error('Error loading development data:', error);
            setStats({ has_data: false, competencies: [], score_history: [], best_competencies: [], worst_competencies: [], available_exam_types: [] });
        } finally {
            setLoading(false);
        }
    };

    const getExamTypeLabel = (examType: string) => {
        return EXAM_TYPE_LABELS[examType] || examType.toUpperCase();
    };

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

    if (loading) {
        return (
            <PanelLayout activePage="/painel/desenvolvimento">
                <div style={{
                    display: 'flex',
                    justifyContent: 'center',
                    alignItems: 'center',
                    minHeight: '400px',
                    color: '#94a3b8'
                }}>
                    Carregando dados de desenvolvimento...
                </div>
            </PanelLayout>
        );
    }

    const availableExamTypes = stats?.available_exam_types || [];

    if (!stats || !stats.has_data) {
        return (
            <PanelLayout activePage="/painel/desenvolvimento">
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '16px',
                    padding: '32px',
                    marginBottom: '32px',
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'flex-start'
                }}>
                    <div>
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
                    {availableExamTypes.length > 0 && (
                        <select
                            value={selectedExamType}
                            onChange={(e) => setSelectedExamType(e.target.value)}
                            style={{
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                padding: '10px 16px',
                                color: '#fff',
                                fontSize: '14px',
                                cursor: 'pointer',
                                minWidth: '180px'
                            }}
                        >
                            <option value="all">Todos os Vestibulares</option>
                            {availableExamTypes.map((type) => (
                                <option key={type} value={type}>{getExamTypeLabel(type)}</option>
                            ))}
                        </select>
                    )}
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
                        {selectedExamType !== 'all'
                            ? `Sem dados para ${getExamTypeLabel(selectedExamType)}`
                            : 'Ainda sem dados de desenvolvimento? 🤔'}
                    </h2>
                    <p style={{
                        fontSize: '14px',
                        color: '#94a3b8',
                        marginBottom: '32px',
                        maxWidth: '600px',
                        margin: '0 auto 32px'
                    }}>
                        {selectedExamType !== 'all'
                            ? 'Selecione outro vestibular ou escreva uma redação para este vestibular.'
                            : 'Escreva sua primeira redação e comece a acompanhar sua evolução por competência e pontuação ao longo do tempo!'}
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

    // Calculate chart dimensions with proper padding
    const chartPadding = { left: 60, right: 60, top: 40, bottom: 60 };
    const chartWidth = 100; // percentage
    const dataPoints = stats.score_history.length;

    // Calculate X position for each point, ensuring points don't touch edges
    const getXPosition = (index: number) => {
        if (dataPoints === 1) return 50;
        const usableWidth = 100 - 10; // 5% padding on each side
        return 5 + (index / (dataPoints - 1)) * usableWidth;
    };

    return (
        <PanelLayout activePage="/painel/desenvolvimento">
            <div style={{
                marginBottom: '32px',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'flex-start'
            }}>
                <div>
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
                {availableExamTypes.length > 0 && (
                    <select
                        value={selectedExamType}
                        onChange={(e) => setSelectedExamType(e.target.value)}
                        style={{
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            padding: '10px 16px',
                            color: '#fff',
                            fontSize: '14px',
                            cursor: 'pointer',
                            minWidth: '180px'
                        }}
                    >
                        <option value="all">Todos os Vestibulares</option>
                        {availableExamTypes.map((type) => (
                            <option key={type} value={type}>{getExamTypeLabel(type)}</option>
                        ))}
                    </select>
                )}
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
                            {stats.best_competencies.length > 1 ? 'Melhores Competências:' : 'Melhor Competência:'}
                        </div>
                        {stats.best_competencies.map((comp, index) => (
                            <div key={comp.id} style={{ marginBottom: index < stats.best_competencies.length - 1 ? '8px' : '0' }}>
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
                            {stats.worst_competencies.length > 1 ? 'Competências para Melhorar:' : 'Competência para Melhorar:'}
                        </div>
                        {stats.worst_competencies.map((comp, index) => (
                            <div key={comp.id} style={{ marginBottom: index < stats.worst_competencies.length - 1 ? '8px' : '0' }}>
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

                    {stats.competencies.map((comp) => (
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

                {stats.score_history.length > 0 ? (
                    <div style={{
                        position: 'relative',
                        height: '380px',
                        padding: '40px 80px 80px 80px'
                    }}>
                        {/* Y-axis labels */}
                        <div style={{
                            position: 'absolute',
                            left: '80px',
                            right: '80px',
                            top: '40px',
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
                                        left: '-50px',
                                        top: '-8px',
                                        fontSize: '11px',
                                        color: '#64748b',
                                        width: '40px',
                                        textAlign: 'right'
                                    }}>
                                        {value}
                                    </span>
                                </div>
                            ))}
                        </div>

                        {/* SVG Chart */}
                        <svg
                            style={{
                                position: 'absolute',
                                left: '80px',
                                right: '80px',
                                top: '40px',
                                bottom: '80px',
                                width: 'calc(100% - 160px)',
                                height: '260px',
                                overflow: 'visible'
                            }}
                            preserveAspectRatio="none"
                        >
                            <defs>
                                <linearGradient id="scoreGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                                    <stop offset="0%" stopColor="#10b981" />
                                    <stop offset="50%" stopColor="#f59e0b" />
                                    <stop offset="100%" stopColor="#ef4444" />
                                </linearGradient>
                            </defs>

                            {/* Lines - always draw, even when y1 === y2 */}
                            {stats.score_history.map((item, index) => {
                                if (index === stats.score_history.length - 1) return null;

                                const x1 = getXPosition(index);
                                const y1 = 100 - (item.score / 1000) * 100;
                                const x2 = getXPosition(index + 1);
                                const y2 = 100 - (stats.score_history[index + 1].score / 1000) * 100;

                                // Use average score to determine line color
                                const avgScore = (item.score + stats.score_history[index + 1].score) / 2;
                                const lineColor = getScoreColor(avgScore);

                                return (
                                    <line
                                        key={`line-${index}`}
                                        x1={`${x1}%`}
                                        y1={`${y1}%`}
                                        x2={`${x2}%`}
                                        y2={`${y2}%`}
                                        stroke={lineColor}
                                        strokeWidth="3"
                                        strokeLinecap="round"
                                    />
                                );
                            })}

                            {/* Points and labels */}
                            {stats.score_history.map((item, index) => {
                                const x = getXPosition(index);
                                const y = 100 - (item.score / 1000) * 100;

                                return (
                                    <g key={`point-${index}`}>
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

                        {/* X-axis labels */}
                        <div style={{
                            position: 'absolute',
                            left: '80px',
                            right: '80px',
                            bottom: '40px',
                            display: 'flex',
                            justifyContent: 'space-between',
                            paddingLeft: '5%',
                            paddingRight: '5%'
                        }}>
                            {stats.score_history.map((item, index) => (
                                <div
                                    key={`label-${index}`}
                                    style={{
                                        fontSize: '10px',
                                        color: '#64748b',
                                        textAlign: 'center',
                                        flex: dataPoints === 1 ? 'none' : 1,
                                        maxWidth: dataPoints === 1 ? 'none' : `${90 / dataPoints}%`
                                    }}
                                    title={item.title}
                                >
                                    <div style={{
                                        overflow: 'hidden',
                                        textOverflow: 'ellipsis',
                                        whiteSpace: 'nowrap'
                                    }}>
                                        Redação {index + 1}
                                    </div>
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
