import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';

const ResultadoCorrecao = () => {
    const { id: rawId } = useParams<{ id: string }>();
    // Remove "M" prefix if it exists (from old localStorage data)
    const id = rawId?.startsWith('M') ? rawId.substring(1) : rawId;
    const navigate = useNavigate();
    const [score, setScore] = useState(0);
    const [examType, setExamType] = useState('enem');
    const [correction, setCorrection] = useState<any>(null); // Store full correction data
    const [showConfetti, setShowConfetti] = useState(false);

    const EXAM_DETAILS: Record<string, { name: string; max: number }> = {
        enem: { name: 'ENEM', max: 1000 },
        fuvest: { name: 'FUVEST', max: 50 },
        unicamp: { name: 'UNICAMP', max: 48 },
        ita: { name: 'ITA', max: 100 },
        unesp: { name: 'UNESP', max: 100 },
        uerj: { name: 'UERJ', max: 100 },
        ufmg: { name: 'UFMG', max: 100 },
        afa: { name: 'AFA', max: 100 },
        cacd: { name: 'CACD', max: 100 },
        sisu: { name: 'SISU', max: 1000 }
    };

    const COMPETENCIES: Record<string, string[]> = {
        enem: [
            "Domínio da escrita formal",
            "Compreensão do tema e estrutura",
            "Organização e interpretação de dados",
            "Mecanismos linguísticos",
            "Proposta de intervenção"
        ],
        fuvest: [
            "Desenvolvimento do tema",
            "Estrutura e organização",
            "Expressão e gramática",
            "Coesão e coerência"
        ],
        unicamp: [
            "Adequação ao gênero",
            "Compreensão da proposta",
            "Propósito comunicativo",
            "Articulação de ideias",
            "Adequação linguística"
        ],
        ita: [
            "Argumentação técnica",
            "Rigor lógico",
            "Conhecimento técnico",
            "Organização textual",
            "Norma culta"
        ],
        unesp: [
            "Tema e desenvolvimento",
            "Estrutura e coesão",
            "Expressão e gramática",
            "Autoria e originalidade",
            "Conhecimento de mundo"
        ],
        uerj: [
            "Adequação ao tema/gênero",
            "Articulação textual",
            "Domínio da língua padrão"
        ],
        ufmg: [
            "Abordagem do tema",
            "Articulação argumentativa",
            "Uso de informações",
            "Domínio da norma culta"
        ],
        afa: [
            "Adequação ao tema",
            "Clareza e objetividade",
            "Coerência e coesão",
            "Argumentação lógica",
            "Domínio da norma culta"
        ],
        cacd: [
            "Aprofundamento temático",
            "Argumentação sofisticada",
            "Domínio excepcional da língua",
            "Articulação de ideias",
            "Perspectiva geopolítica"
        ],
        sisu: [
            "Domínio da escrita formal",
            "Compreensão do tema e estrutura",
            "Organização e interpretação de dados",
            "Mecanismos linguísticos",
            "Proposta de intervenção"
        ]
    };

    const currentExam = EXAM_DETAILS[examType] || EXAM_DETAILS['enem'];

    // Redirect if URL has "M" prefix (clean URL)
    useEffect(() => {
        if (rawId?.startsWith('M')) {
            navigate(`/painel/redacao/${id}/resultado`, { replace: true });
        }
    }, [rawId, id, navigate]);

    useEffect(() => {
        const loadCorrection = async () => {
            // 1. Tenta pegar do localStorage
            const correctionDataStr = localStorage.getItem(`correction_${id}`);

            if (correctionDataStr) {
                try {
                    const correctionData = JSON.parse(correctionDataStr);
                    processCorrectionData(correctionData);
                    return;
                } catch (error) {
                    console.error('Erro ao ler localStorage:', error);
                }
            }

            // 2. Se falhar, tenta buscar da API
            console.log('⚠️ Correção não encontrada no localStorage, buscando da API...');
            try {
                const { essayService } = await import('../../services/essayService');
                const correction = await essayService.correctEssay(id!); // Reusa endpoint de get correction
                console.log('✅ Correção recuperada da API:', correction);

                // Salva no localStorage para próximas vezes
                localStorage.setItem(`correction_${id}`, JSON.stringify(correction));

                processCorrectionData(correction);
            } catch (error) {
                console.error('❌ Erro ao buscar correção da API:', error);
                // Fallback apenas se tudo falhar
                setScore(0); // Mostra 0 ou erro em vez de mock
                // Opcional: setar estado de erro para mostrar na UI
            }
        };

        const processCorrectionData = (data: any) => {
            if (!data) {
                console.error('❌ Dados de correção inválidos ou nulos');
                return;
            }

            try {
                console.log('🔄 Processando dados da correção:', data);
                setCorrection(data); // Save full data
                const finalScore = typeof data.total_score === 'number' ? data.total_score : 0;

                if (data.exam_type && EXAM_DETAILS[data.exam_type]) {
                    setExamType(data.exam_type);
                } else {
                    console.warn('⚠️ Tipo de exame desconhecido ou não fornecido, usando padrão ENEM');
                }

                // Animate score
                let current = 0;
                const increment = finalScore / 50;
                const timer = setInterval(() => {
                    current += increment;
                    if (current >= finalScore) {
                        setScore(finalScore);
                        setShowConfetti(true);
                        clearInterval(timer);
                    } else {
                        setScore(Math.floor(current));
                    }
                }, 20);
            } catch (error) {
                console.error('❌ Erro ao processar dados da correção:', error);
            }
        };

        loadCorrection();
    }, [id]);

    const getScoreColor = (score: number) => {
        const percentage = score / currentExam.max;
        if (percentage >= 0.8) return '#10b981';
        if (percentage >= 0.6) return '#f59e0b';
        return '#ef4444';
    };

    const getScoreMessage = (score: number) => {
        const percentage = score / currentExam.max;
        if (percentage >= 0.9) return 'Excelente! 🎉';
        if (percentage >= 0.8) return 'Muito bom! 👏';
        if (percentage >= 0.7) return 'Bom trabalho! 👍';
        if (percentage >= 0.6) return 'Continue melhorando! 💪';
        return 'Não desista! 📚';
    };

    return (
        <PanelLayout activePage="/painel/minhas-redacoes">
            <div style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                minHeight: 'calc(100vh - 164px)'
            }}>
                <div style={{
                    maxWidth: '800px',
                    width: '100%',
                    textAlign: 'center'
                }}>
                    {/* Result Card */}
                    <div style={{
                        background: '#1a1f2e',
                        border: '1px solid #334155',
                        borderRadius: '16px',
                        padding: '64px 48px',
                        position: 'relative',
                        overflow: 'hidden'
                    }}>
                        {/* Exam Badge */}
                        <div style={{
                            position: 'absolute',
                            top: '24px',
                            right: '24px',
                            background: '#3B82F6',
                            color: 'white',
                            padding: '6px 12px',
                            borderRadius: '20px',
                            fontSize: '12px',
                            fontWeight: 'bold',
                            textTransform: 'uppercase',
                            boxShadow: '0 4px 6px -1px rgba(59, 130, 246, 0.5)'
                        }}>
                            {currentExam.name}
                        </div>

                        {/* Confetti effect */}
                        {showConfetti && (
                            <div style={{
                                position: 'absolute',
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                pointerEvents: 'none',
                                background: 'radial-gradient(circle, rgba(79, 70, 229, 0.1) 0%, transparent 70%)',
                                animation: 'fadeIn 0.5s ease-in'
                            }} />
                        )}

                        {/* Success Icon */}
                        <div style={{
                            width: '100px',
                            height: '100px',
                            margin: '0 auto 32px',
                            background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                            borderRadius: '50%',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            fontSize: '48px',
                            animation: 'scaleIn 0.5s ease-out',
                            position: 'relative',
                            zIndex: 1
                        }}>
                            🎉
                        </div>

                        {/* Score */}
                        <div style={{
                            marginBottom: '24px',
                            position: 'relative',
                            zIndex: 1
                        }}>
                            <div style={{
                                fontSize: '72px',
                                fontWeight: '900',
                                color: getScoreColor(score),
                                lineHeight: '1',
                                marginBottom: '8px',
                                textShadow: `0 0 30px ${getScoreColor(score)}40`
                            }}>
                                {score}
                            </div>
                            <div style={{
                                fontSize: '24px',
                                color: '#64748b',
                                fontWeight: '600'
                            }}>
                                / {currentExam.max}
                            </div>
                        </div>

                        <h1 style={{
                            fontSize: '28px',
                            fontWeight: '800',
                            color: '#fff',
                            marginBottom: '12px',
                            position: 'relative',
                            zIndex: 1
                        }}>
                            Correção concluída! {getScoreMessage(score)}
                        </h1>

                        <p style={{
                            fontSize: '16px',
                            color: '#94a3b8',
                            marginBottom: '40px',
                            position: 'relative',
                            zIndex: 1
                        }}>
                            Sua nota final está pronta.
                            <br />
                            Você será redirecionado automaticamente em 5 segundos...
                        </p>

                        {/* Button */}
                        <button
                            onClick={() => navigate(`/painel/redacao/${id}`)}
                            style={{
                                padding: '16px 48px',
                                background: '#4F46E5',
                                color: '#fff',
                                border: 'none',
                                borderRadius: '12px',
                                fontSize: '16px',
                                fontWeight: '700',
                                cursor: 'pointer',
                                transition: 'all 0.3s',
                                boxShadow: '0 4px 20px rgba(79, 70, 229, 0.3)',
                                position: 'relative',
                                zIndex: 1
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.background = '#4338ca';
                                e.currentTarget.style.transform = 'translateY(-2px)';
                                e.currentTarget.style.boxShadow = '0 6px 24px rgba(79, 70, 229, 0.4)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.background = '#4F46E5';
                                e.currentTarget.style.transform = 'translateY(0)';
                                e.currentTarget.style.boxShadow = '0 4px 20px rgba(79, 70, 229, 0.3)';
                            }}
                        >
                            Ver redação corrigida
                        </button>
                    </div>

                    {/* Quick Stats */}
                    <div style={{
                        marginTop: '32px',
                        display: 'grid',
                        gridTemplateColumns: 'repeat(3, 1fr)',
                        gap: '16px'
                    }}>
                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '12px',
                            padding: '20px',
                            textAlign: 'center'
                        }}>
                            <div style={{
                                fontSize: '28px',
                                fontWeight: '800',
                                color: '#4F46E5',
                                marginBottom: '4px'
                            }}>
                                5
                            </div>
                            <div style={{
                                fontSize: '12px',
                                color: '#64748b',
                                textTransform: 'uppercase',
                                fontWeight: '600'
                            }}>
                                Competências
                            </div>
                        </div>

                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '12px',
                            padding: '20px',
                            textAlign: 'center'
                        }}>
                            <div style={{
                                fontSize: '28px',
                                fontWeight: '800',
                                color: '#10b981',
                                marginBottom: '4px'
                            }}>
                                ✓
                            </div>
                            <div style={{
                                fontSize: '12px',
                                color: '#64748b',
                                textTransform: 'uppercase',
                                fontWeight: '600'
                            }}>
                                Analisada
                            </div>
                        </div>

                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '12px',
                            padding: '20px',
                            textAlign: 'center'
                        }}>
                            <div style={{
                                fontSize: '28px',
                                fontWeight: '800',
                                color: '#f59e0b',
                                marginBottom: '4px'
                            }}>
                                AI
                            </div>
                            <div style={{
                                fontSize: '12px',
                                color: '#64748b',
                                textTransform: 'uppercase',
                                fontWeight: '600'
                            }}>
                                Powered
                            </div>
                        </div>
                    </div>

                    {/* Competencies Breakdown */}
                    <div style={{ marginTop: '48px', textAlign: 'left' }}>
                        <h2 style={{
                            color: '#fff',
                            fontSize: '24px',
                            fontWeight: '700',
                            marginBottom: '24px',
                            borderBottom: '1px solid #334155',
                            paddingBottom: '16px'
                        }}>
                            Detalhamento por Competência
                        </h2>

                        <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                            {(COMPETENCIES[examType] || COMPETENCIES['enem']).map((compName, index) => {
                                const compIndex = index + 1;
                                const scoreKey = `competence_${compIndex}_score`;
                                const feedbackKey = `competence_${compIndex}_feedback`;
                                const compScore = correction ? correction[scoreKey] : 0;
                                const rawFeedback = correction ? correction[feedbackKey] : 'Feedback não disponível';
                                const compFeedback = typeof rawFeedback === 'string' ? rawFeedback : JSON.stringify(rawFeedback);

                                // Calculate max score per competency based on exam type
                                let maxCompScore = 200; // Default ENEM
                                if (examType === 'fuvest') maxCompScore = 12.5;
                                if (examType === 'unicamp') maxCompScore = 9.6;
                                if (['ita', 'unesp', 'afa', 'cacd'].includes(examType)) maxCompScore = 20;
                                if (examType === 'uerj') maxCompScore = index === 2 ? 33.4 : 33.3;
                                if (examType === 'ufmg') maxCompScore = 25;

                                return (
                                    <div key={index} style={{
                                        background: '#1a1f2e',
                                        border: '1px solid #334155',
                                        borderRadius: '12px',
                                        padding: '20px',
                                        transition: 'all 0.2s',
                                    }}>
                                        <div style={{
                                            display: 'flex',
                                            justifyContent: 'space-between',
                                            alignItems: 'center',
                                            marginBottom: '12px'
                                        }}>
                                            <h3 style={{
                                                color: '#fff',
                                                fontSize: '16px',
                                                fontWeight: '600',
                                                margin: 0
                                            }}>
                                                <span style={{ color: '#64748b', marginRight: '8px' }}>#{compIndex}</span>
                                                {compName}
                                            </h3>
                                            <div style={{
                                                background: '#0f1419',
                                                padding: '6px 12px',
                                                borderRadius: '8px',
                                                border: '1px solid #334155',
                                                color: getScoreColor(compScore * (1000 / currentExam.max)), // Normalize color
                                                fontWeight: '700',
                                                fontSize: '14px'
                                            }}>
                                                {compScore} <span style={{ color: '#64748b', fontSize: '12px' }}>/ {maxCompScore}</span>
                                            </div>
                                        </div>

                                        {(() => {
                                            // Parse feedback sections safely
                                            const parts = typeof compFeedback === 'string' ? compFeedback.split(/✅ Pontos Fortes:|⚠️ O que melhorar:/) : [];
                                            const analise = parts[0]?.replace('Análise:', '').trim() || (typeof compFeedback === 'string' ? compFeedback : '');
                                            const pontosFortes = parts[1]?.trim();
                                            const melhorias = parts[2]?.trim();

                                            return (
                                                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                                                    {/* Análise */}
                                                    {analise && (
                                                        <p style={{
                                                            color: '#94a3b8',
                                                            fontSize: '14px',
                                                            lineHeight: '1.6',
                                                            margin: 0,
                                                            whiteSpace: 'pre-line'
                                                        }}>
                                                            {analise}
                                                        </p>
                                                    )}

                                                    {/* Cards Container */}
                                                    {(pontosFortes || melhorias) && (
                                                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px', marginTop: '8px' }}>
                                                            {/* Pontos Fortes Card */}
                                                            {pontosFortes && (
                                                                <div style={{
                                                                    background: 'rgba(16, 185, 129, 0.1)',
                                                                    border: '1px solid rgba(16, 185, 129, 0.2)',
                                                                    borderRadius: '8px',
                                                                    padding: '12px'
                                                                }}>
                                                                    <h4 style={{
                                                                        fontSize: '12px',
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
                                                                        fontSize: '12px',
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
                                                                    borderRadius: '8px',
                                                                    padding: '12px'
                                                                }}>
                                                                    <h4 style={{
                                                                        fontSize: '12px',
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
                                                                        fontSize: '12px',
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
                                                    )}
                                                </div>
                                            );
                                        })()}
                                    </div>
                                );
                            })}
                        </div>
                    </div>

                    {/* Strengths & Improvements */}
                    <div style={{ marginTop: '48px', textAlign: 'left' }}>
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                            {/* Strengths */}
                            <div style={{
                                background: '#1a1f2e',
                                border: '1px solid #10b98140',
                                borderRadius: '16px',
                                padding: '24px'
                            }}>
                                <h3 style={{
                                    color: '#10b981',
                                    fontSize: '18px',
                                    fontWeight: '700',
                                    marginBottom: '16px',
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '8px'
                                }}>
                                    <span>✓</span> Pontos Fortes
                                </h3>
                                <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
                                    {Array.isArray(correction?.strengths) && correction.strengths.length > 0 ? (
                                        correction.strengths.map((point: string, index: number) => (
                                            <li key={index} style={{
                                                color: '#cbd5e1',
                                                fontSize: '14px',
                                                marginBottom: '12px',
                                                lineHeight: '1.5',
                                                display: 'flex',
                                                gap: '8px'
                                            }}>
                                                <span style={{ color: '#10b981', fontWeight: 'bold' }}>•</span>
                                                {point}
                                            </li>
                                        ))
                                    ) : (
                                        <li style={{ color: '#64748b', fontSize: '14px', fontStyle: 'italic' }}>
                                            Nenhum ponto forte destacado.
                                        </li>
                                    )}
                                </ul>
                            </div>

                            {/* Improvements */}
                            <div style={{
                                background: '#1a1f2e',
                                border: '1px solid #f59e0b40',
                                borderRadius: '16px',
                                padding: '24px'
                            }}>
                                <h3 style={{
                                    color: '#f59e0b',
                                    fontSize: '18px',
                                    fontWeight: '700',
                                    marginBottom: '16px',
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '8px'
                                }}>
                                    <span>⚠</span> Pontos a Melhorar
                                </h3>
                                <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
                                    {Array.isArray(correction?.improvements) && correction.improvements.length > 0 ? (
                                        correction.improvements.map((point: string, index: number) => (
                                            <li key={index} style={{
                                                color: '#cbd5e1',
                                                fontSize: '14px',
                                                marginBottom: '12px',
                                                lineHeight: '1.5',
                                                display: 'flex',
                                                gap: '8px'
                                            }}>
                                                <span style={{ color: '#f59e0b', fontWeight: 'bold' }}>•</span>
                                                {point}
                                            </li>
                                        ))
                                    ) : (
                                        <li style={{ color: '#64748b', fontSize: '14px', fontStyle: 'italic' }}>
                                            Nenhum ponto de melhoria destacado.
                                        </li>
                                    )}
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Animations */}
            <style>{`
        @keyframes scaleIn {
          0% { transform: scale(0); opacity: 0; }
          50% { transform: scale(1.1); }
          100% { transform: scale(1); opacity: 1; }
        }
        
        @keyframes fadeIn {
          0% { opacity: 0; }
          100% { opacity: 1; }
        }
      `}</style>
        </PanelLayout >
    );
};

export default ResultadoCorrecao;
