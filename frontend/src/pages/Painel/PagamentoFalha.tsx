import { useNavigate, useSearchParams } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';

const PagamentoFalha = () => {
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();

    const paymentId = searchParams.get('payment_id');
    const status = searchParams.get('status');

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
                {/* Error Icon */}
                <div style={{
                    width: '120px',
                    height: '120px',
                    borderRadius: '50%',
                    background: 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    fontSize: '60px',
                    marginBottom: '32px',
                    boxShadow: '0 12px 32px rgba(239, 68, 68, 0.3)',
                    animation: 'shake 0.5s ease-out'
                }}>
                    ✕
                </div>

                {/* Error Message */}
                <h1 style={{
                    fontSize: '36px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    Pagamento Não Aprovado
                </h1>

                <p style={{
                    fontSize: '18px',
                    color: '#94a3b8',
                    marginBottom: '32px',
                    maxWidth: '600px'
                }}>
                    Infelizmente, não foi possível processar seu pagamento. Não se preocupe, nenhum valor foi cobrado.
                </p>

                {/* Common Reasons */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '24px',
                    marginBottom: '32px',
                    maxWidth: '500px',
                    width: '100%',
                    textAlign: 'left'
                }}>
                    <h3 style={{
                        fontSize: '16px',
                        fontWeight: '600',
                        color: '#fff',
                        marginBottom: '16px'
                    }}>
                        Possíveis motivos:
                    </h3>
                    <ul style={{
                        listStyle: 'none',
                        padding: 0,
                        margin: 0
                    }}>
                        {[
                            'Saldo insuficiente',
                            'Dados do cartão incorretos',
                            'Cartão bloqueado ou vencido',
                            'Limite de crédito excedido',
                            'Pagamento cancelado pelo usuário'
                        ].map((reason, index) => (
                            <li key={index} style={{
                                display: 'flex',
                                alignItems: 'center',
                                gap: '12px',
                                marginBottom: '12px',
                                fontSize: '14px',
                                color: '#94a3b8'
                            }}>
                                <span style={{ color: '#ef4444' }}>•</span>
                                <span>{reason}</span>
                            </li>
                        ))}
                    </ul>
                </div>

                {/* Action Buttons */}
                <div style={{
                    display: 'flex',
                    gap: '16px',
                    flexWrap: 'wrap',
                    justifyContent: 'center'
                }}>
                    <button
                        onClick={() => navigate('/painel/comprar-creditos')}
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
                        Tentar Novamente
                    </button>

                    <button
                        onClick={() => navigate('/painel')}
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
                        Voltar ao Dashboard
                    </button>
                </div>

                {/* Help Text */}
                <p style={{
                    fontSize: '14px',
                    color: '#64748b',
                    marginTop: '32px'
                }}>
                    Precisa de ajuda? Entre em contato com nosso suporte.
                </p>
            </div>

            <style>{`
                @keyframes shake {
                    0%, 100% { transform: translateX(0); }
                    10%, 30%, 50%, 70%, 90% { transform: translateX(-10px); }
                    20%, 40%, 60%, 80% { transform: translateX(10px); }
                }
            `}</style>
        </PanelLayout>
    );
};

export default PagamentoFalha;
