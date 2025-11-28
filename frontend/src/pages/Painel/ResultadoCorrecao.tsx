import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';

const ResultadoCorrecao = () => {
    const { id: rawId } = useParams<{ id: string }>();
    // Remove "M" prefix if it exists (from old localStorage data)
    const id = rawId?.startsWith('M') ? rawId.substring(1) : rawId;
    const navigate = useNavigate();
    const [score, setScore] = useState(0);
    const [showConfetti, setShowConfetti] = useState(false);

    // Redirect if URL has "M" prefix (clean URL)
    useEffect(() => {
        if (rawId?.startsWith('M')) {
            navigate(`/painel/redacao/${id}/resultado`, { replace: true });
        }
    }, [rawId, id, navigate]);

    useEffect(() => {
        // Get correction data from localStorage
        const correctionDataStr = localStorage.getItem(`correction_${id}`);

        let finalScore = 880; // Default fallback

        if (correctionDataStr) {
            try {
                const correctionData = JSON.parse(correctionDataStr);
                finalScore = correctionData.total_score;
                console.log('📊 Exibindo correção real:', correctionData);
            } catch (error) {
                console.error('Erro ao ler correção do localStorage:', error);
            }
        } else {
            console.warn('⚠️ Correção não encontrada no localStorage, usando dados mock');
        }

        // Animate score counting
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

        return () => clearInterval(timer);
    }, [id]);

    const getScoreColor = (score: number) => {
        if (score >= 800) return '#10b981';
        if (score >= 600) return '#f59e0b';
        return '#ef4444';
    };

    const getScoreMessage = (score: number) => {
        if (score >= 900) return 'Excelente! 🎉';
        if (score >= 800) return 'Muito bom! 👏';
        if (score >= 700) return 'Bom trabalho! 👍';
        if (score >= 600) return 'Continue melhorando! 💪';
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
                    maxWidth: '600px',
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
                                / 1000
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
        </PanelLayout>
    );
};

export default ResultadoCorrecao;
