import { useNavigate, useSearchParams } from 'react-router-dom';
import { useEffect, useState } from 'react';
import PanelLayout from '../../components/PanelLayout';
import apiClient from '../../services/api';

const PagamentoPendente = () => {
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const [checkingStatus, setCheckingStatus] = useState(true);

    const paymentId = searchParams.get('payment_id');
    const status = searchParams.get('status');

    // Poll payment status every 3 seconds
    useEffect(() => {
        if (!paymentId) {
            setCheckingStatus(false);
            return;
        }

        let intervalId: NodeJS.Timeout;
        let attempts = 0;
        const MAX_ATTEMPTS = 40; // 2 minutes maximum

        const checkPaymentStatus = async () => {
            try {
                const response = await apiClient.get('/api/payment/transactions');
                const transactions = response.data;

                // Find transaction by payment_id
                const transaction = transactions.find((t: any) =>
                    t.payment_id === paymentId
                );

                if (transaction) {
                    if (transaction.status === 'approved') {
                        // Redirect to success page
                        clearInterval(intervalId);
                        navigate('/painel/pagamento/sucesso?payment_id=' + paymentId);
                    } else if (transaction.status === 'rejected' || transaction.status === 'cancelled') {
                        // Redirect to failure page
                        clearInterval(intervalId);
                        navigate('/painel/pagamento/falha?payment_id=' + paymentId);
                    }
                }

                attempts++;
                if (attempts >= MAX_ATTEMPTS) {
                    clearInterval(intervalId);
                    setCheckingStatus(false);
                }
            } catch (error) {
                console.error('Error checking payment status:', error);
            }
        };

        // Check immediately
        checkPaymentStatus();

        // Then check every 3 seconds
        intervalId = setInterval(checkPaymentStatus, 3000);

        return () => {
            if (intervalId) clearInterval(intervalId);
        };
    }, [paymentId, navigate]);

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
                {/* Pending Icon */}
                <div style={{
                    width: '120px',
                    height: '120px',
                    borderRadius: '50%',
                    background: 'linear-gradient(135deg, #f59e0b 0%, #d97706 100%)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '60px',
                    marginBottom: '32px',
                    boxShadow: '0 12px 32px rgba(245, 158, 11, 0.3)',
                    animation: 'pulse 2s ease-in-out infinite'
                }}>
                    ⏳
                </div>

                {/* Pending Message */}
                <h1 style={{
                    fontSize: '36px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    Pagamento Pendente
                </h1>

                <p style={{
                    fontSize: '18px',
                    color: '#94a3b8',
                    marginBottom: '32px',
                    maxWidth: '600px'
                }}>
                    Seu pagamento está sendo processado. Você receberá uma notificação assim que for confirmado.
                </p>

                {/* Info Box */}
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
                        alignItems: 'start',
                        gap: '12px',
                        marginBottom: '16px'
                    }}>
                        <span style={{ fontSize: '24px' }}>💡</span>
                        <div style={{ textAlign: 'left' }}>
                            <h3 style={{
                                fontSize: '16px',
                                fontWeight: '600',
                                color: '#fff',
                                marginBottom: '8px'
                            }}>
                                O que acontece agora?
                            </h3>
                            <ul style={{
                                listStyle: 'none',
                                padding: 0,
                                margin: 0
                            }}>
                                {[
                                    'PIX: Aguardando confirmação do pagamento',
                                    'Boleto: Pode levar até 2 dias úteis',
                                    'Cartão: Processamento em andamento'
                                ].map((item, index) => (
                                    <li key={index} style={{
                                        display: 'flex',
                                        alignItems: 'center',
                                        gap: '8px',
                                        marginBottom: '8px',
                                        fontSize: '14px',
                                        color: '#94a3b8'
                                    }}>
                                        <span style={{ color: '#f59e0b' }}>•</span>
                                        <span>{item}</span>
                                    </li>
                                ))}
                            </ul>
                        </div>
                    </div>

                    {paymentId && (
                        <>
                            <div style={{
                                height: '1px',
                                background: '#334155',
                                margin: '16px 0'
                            }} />
                            <div style={{
                                display: 'flex',
                                justifyContent: 'space-between',
                                fontSize: '14px'
                            }}>
                                <span style={{ color: '#64748b' }}>ID do Pagamento:</span>
                                <span style={{
                                    color: '#fff',
                                    fontWeight: '600',
                                    fontFamily: 'monospace'
                                }}>
                                    {paymentId}
                                </span>
                            </div>
                        </>
                    )}
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
                        onClick={() => navigate('/painel/transacoes')}
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
                        Ver Minhas Compras
                    </button>
                </div>

                {/* Help Text */}
                <p style={{
                    fontSize: '14px',
                    color: '#64748b',
                    marginTop: '32px'
                }}>
                    Os créditos serão adicionados automaticamente após a confirmação do pagamento.
                </p>
            </div>

            <style>{`
                @keyframes pulse {
                    0%, 100% {
                        transform: scale(1);
                        opacity: 1;
                    }
                    50% {
                        transform: scale(1.05);
                        opacity: 0.8;
                    }
                }
            `}</style>
        </PanelLayout>
    );
};

export default PagamentoPendente;
