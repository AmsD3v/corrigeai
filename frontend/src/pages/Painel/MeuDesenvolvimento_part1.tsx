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
            const essayStr = localStorage.getItem(ssay_f:/corrigeai/frontend/src/pages/Painel/MeuDesenvolvimento.tsx.backup{essayId});

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
