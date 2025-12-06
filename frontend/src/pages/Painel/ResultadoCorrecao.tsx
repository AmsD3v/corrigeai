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
        // Principais (critérios próprios)
        enem: { name: 'ENEM', max: 1000 },
        fuvest: { name: 'FUVEST', max: 50 },
        unicamp: { name: 'UNICAMP', max: 48 },
        ita: { name: 'ITA', max: 100 },
        unesp: { name: 'UNESP', max: 100 },
        uerj: { name: 'UERJ', max: 100 },
        ufmg: { name: 'UFMG', max: 100 },
        afa: { name: 'AFA', max: 100 },
        cacd: { name: 'CACD', max: 100 },
        sisu: { name: 'SISU', max: 1000 },
        // Vestibulares próprios (notas especiais)
        unb: { name: 'UnB', max: 10 },
        ufpr: { name: 'UFPR', max: 60 },
        ufrgs: { name: 'UFRGS', max: 30 },
        ufsc: { name: 'UFSC', max: 10 },
        // Federais via SISU (usam nota ENEM = 1000)
        ufac: { name: 'UFAC', max: 1000 },
        unifap: { name: 'UNIFAP', max: 1000 },
        ufam: { name: 'UFAM', max: 1000 },
        ufpa: { name: 'UFPA', max: 1000 },
        unir: { name: 'UNIR', max: 1000 },
        ufrr: { name: 'UFRR', max: 1000 },
        uft: { name: 'UFT', max: 1000 },
        uerr: { name: 'UERR', max: 1000 },
        ufal: { name: 'UFAL', max: 1000 },
        ufba: { name: 'UFBA', max: 1000 },
        ufc: { name: 'UFC', max: 1000 },
        ufma: { name: 'UFMA', max: 1000 },
        ufpb: { name: 'UFPB', max: 1000 },
        ufpe: { name: 'UFPE', max: 1000 },
        ufpi: { name: 'UFPI', max: 1000 },
        ufrn: { name: 'UFRN', max: 1000 },
        ufs: { name: 'UFS', max: 1000 },
        udf: { name: 'UDF', max: 1000 },
        ufg: { name: 'UFG', max: 1000 },
        ufmt: { name: 'UFMT', max: 1000 },
        ufms: { name: 'UFMS', max: 1000 },
        ufes: { name: 'UFES', max: 1000 },
        // PUCs (critérios próprios)
        pucsp: { name: 'PUC-SP', max: 100 },
        puccampinas: { name: 'PUC-Campinas', max: 100 },
        pucminas: { name: 'PUC-Minas', max: 10 },
        pucpr: { name: 'PUCPR', max: 10 },
        pucrio: { name: 'PUC-Rio', max: 100 },
        pucgoias: { name: 'PUC-Goiás', max: 100 },
        pucrs: { name: 'PUCRS', max: 100 }
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
