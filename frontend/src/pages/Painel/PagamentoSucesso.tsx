import { useEffect, useState } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';

const PagamentoSucesso = () => {
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const [countdown, setCountdown] = useState(5);

    const paymentId = searchParams.get('payment_id');
    const status = searchParams.get('status');
    const externalReference = searchParams.get('external_reference');

    useEffect(() => {
        // Countdown to redirect
        const timer = setInterval(() => {
            setCountdown((prev) => {
                if (prev <= 1) {
                    clearInterval(timer);
                    navigate('/painel');
                    return 0;
                }
                return prev - 1;
            });
        }, 1000);

        return () => clearInterval(timer);
    }, [navigate]);

    return (
        <PanelLayout activePage="/painel/comprar-creditos">
            <div style={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                minHeight: '60vh',
                textAlign: 'center'
            }}>
                {/* Success Icon */}
                <div style={{
                    width: '120px',
                    height: '120px',
                    borderRadius: '50%',
                    background: 'linear-gradient(135deg, #10b981 0%, #059669 100%)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '60px',
                    marginBottom: '32px',
                    boxShadow: '0 12px 32px rgba(16, 185, 129, 0.3)',
                    animation: 'scaleIn 0.5s ease-out'
                }}>
                    ✓
                </div>

                {/* Success Message */}
                <h1 style={{
                    fontSize: '36px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    Pagamento Aprovado! 🎉
                </h1>

                <p style={{
                    fontSize: '18px',
                    color: '#94a3b8',
                    marginBottom: '32px',
                    maxWidth: '600px'
                }}>
                    Seus CorriCoins foram adicionados à sua conta com sucesso! Agora você pode continuar corrigindo suas redações.
                </p>

                {/* Payment Details */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '24px',
                    marginBottom: '32px',
                    maxWidth: '500px',
                    width: '100%'
                }}>
                    <div style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        marginBottom: '12px'
                    }}>
                        <span style={{ color: '#64748b', fontSize: '14px' }}>ID do Pagamento:</span>
                        <span style={{ color: '#fff', fontSize: '14px', fontWeight: '600', fontFamily: 'monospace' }}>
                            {paymentId || 'N/A'}
                        </span>
                    </div>
                    <div style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        marginBottom: '12px'
                    }}>
                        <span style={{ color: '#64748b', fontSize: '14px' }}>Status:</span>
                        <span style={{
                            color: '#10b981',
                            fontSize: '14px',
                            fontWeight: '600',
                            padding: '4px 12px',
                            background: '#10b98120',
                            borderRadius: '12px'
                        }}>
                            {status === 'approved' ? 'Aprovado' : status}
                        </span>
                    </div>
                </div>

                {/* Action Buttons */}
                <div style={{
                    display: 'flex',
                    gap: '16px',
                    flexWrap: 'wrap',
                    justifyContent: 'center'
                }}>
                    <button
                        onClick={() => navigate('/painel')}
                        style={{
                            padding: '14px 32px',
                            background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                            border: 'none',
                            borderRadius: '12px',
                            color: '#fff',
                            fontSize: '16px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.transform = 'translateY(-2px)';
                            e.currentTarget.style.boxShadow = '0 8px 20px rgba(79, 70, 229, 0.4)';
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.transform = 'translateY(0)';
                            e.currentTarget.style.boxShadow = 'none';
                        }}
                    >
                        Ir para Dashboard
                    </button>

                    <button
                        onClick={() => navigate('/painel/redigir-redacao')}
                        style={{
                            padding: '14px 32px',
                            background: '#334155',
                            border: 'none',
                            borderRadius: '12px',
                            color: '#fff',
                            fontSize: '16px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.background = '#475569';
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.background = '#334155';
                        }}
                    >
                        Escrever Redação
                    </button>
                </div>

                {/* Auto Redirect Message */}
                <p style={{
                    fontSize: '14px',
                    color: '#64748b',
                    marginTop: '32px'
                }}>
                    Redirecionando para o dashboard em {countdown} segundos...
                </p>
            </div>

            <style>{`
                @keyframes scaleIn {
                    from {
                        transform: scale(0);
                        opacity: 0;
                    }
                    to {
                        transform: scale(1);
                        opacity: 1;
                    }
                }
            `}</style>
        </PanelLayout>
    );
};

export default PagamentoSucesso;
