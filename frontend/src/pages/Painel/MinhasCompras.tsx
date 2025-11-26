import { useEffect, useState } from 'react';
import PanelLayout from '../../components/PanelLayout';
import apiClient from '../../services/api';

interface Transaction {
    id: number;
    created_at: string;
    package_name: string;
    coins_amount: number;
    bonus_coins: number;
    price: number;
    status: string;
    payment_method?: string;
}

const MinhasCompras = () => {
    const [transactions, setTransactions] = useState<Transaction[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchTransactions = async () => {
            try {
                const response = await apiClient.get('/api/payment/transactions');
                console.log('Transactions loaded:', response.data);
                setTransactions(response.data);
            } catch (error) {
                console.error('Error loading transactions:', error);
                setTransactions([]);
            } finally {
                setLoading(false);
            }
        };

        fetchTransactions();
    }, []);

    const getStatusBadge = (status: string) => {
        const statusConfig: Record<string, { label: string; color: string }> = {
            approved: { label: 'Aprovado', color: '#10b981' },
            pending: { label: 'Pendente', color: '#f59e0b' },
            rejected: { label: 'Rejeitado', color: '#ef4444' },
            cancelled: { label: 'Cancelado', color: '#64748b' }
        };

        const config = statusConfig[status as keyof typeof statusConfig] || statusConfig.pending;

        return (
            <span style={{
                padding: '4px 12px',
                borderRadius: '12px',
                fontSize: '12px',
                fontWeight: '600',
                background: `${config.color}20`,
                color: config.color
            }}>
                {config.label}
            </span>
        );
    };

    const formatDate = (dateString: string) => {
        const date = new Date(dateString);
        return date.toLocaleDateString('pt-BR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    };

    const formatCurrency = (value: number) => {
        return value.toLocaleString('pt-BR', {
            style: 'currency',
            currency: 'BRL'
        });
    };

    return (
        <PanelLayout activePage="/painel/transacoes">
            {/* Header */}
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
                    Minhas Compras
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Aqui você pode ver o histórico de suas compras e pagamentos.
                </p>
            </div>

            {/* Content */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                overflow: 'hidden'
            }}>
                {loading ? (
                    <div style={{
                        padding: '60px',
                        textAlign: 'center',
                        color: '#64748b'
                    }}>
                        Carregando...
                    </div>
                ) : transactions.length === 0 ? (
                    /* Empty State */
                    <div style={{
                        padding: '80px 40px',
                        textAlign: 'center'
                    }}>
                        <div style={{
                            fontSize: '48px',
                            marginBottom: '16px'
                        }}>
                            🛒
                        </div>
                        <h2 style={{
                            fontSize: '18px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '8px'
                        }}>
                            Nenhuma transação encontrada.
                        </h2>
                        <p style={{
                            fontSize: '14px',
                            color: '#64748b'
                        }}>
                            Suas compras de CorriCoins aparecerão aqui.
                        </p>
                    </div>
                ) : (
                    /* Transactions Table */
                    <>
                        {/* Table Header */}
                        <div style={{
                            display: 'grid',
                            gridTemplateColumns: '2fr 1.5fr 1fr 1fr 1fr 1fr',
                            padding: '16px 24px',
                            borderBottom: '1px solid #334155',
                            background: '#0f1419'
                        }}>
                            <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                Pacote
                            </div>
                            <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                Data
                            </div>
                            <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                Créditos
                            </div>
                            <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                Valor
                            </div>
                            <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                Pagamento
                            </div>
                            <div style={{ fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                Status
                            </div>
                        </div>

                        {/* Table Body */}
                        {transactions.map((transaction) => (
                            <div
                                key={transaction.id}
                                style={{
                                    display: 'grid',
                                    gridTemplateColumns: '2fr 1.5fr 1fr 1fr 1fr 1fr',
                                    padding: '20px 24px',
                                    borderBottom: '1px solid #334155',
                                    alignItems: 'center',
                                    transition: 'background 0.2s'
                                }}
                                onMouseEnter={(e) => e.currentTarget.style.background = '#0f1419'}
                                onMouseLeave={(e) => e.currentTarget.style.background = 'transparent'}
                            >
                                <div>
                                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#fff' }}>
                                        {transaction.package_name}
                                    </div>
                                </div>
                                <div style={{ fontSize: '14px', color: '#94a3b8' }}>
                                    {formatDate(transaction.created_at)}
                                </div>
                                <div>
                                    <span style={{
                                        padding: '4px 12px',
                                        borderRadius: '12px',
                                        fontSize: '12px',
                                        fontWeight: '700',
                                        background: '#4F46E520',
                                        color: '#4F46E5'
                                    }}>
                                        +{transaction.coins_amount + transaction.bonus_coins}
                                    </span>
                                </div>
                                <div style={{ fontSize: '14px', fontWeight: '600', color: '#10b981' }}>
                                    {formatCurrency(transaction.price / 100)}
                                </div>
                                <div style={{ fontSize: '13px', color: '#94a3b8' }}>
                                    {transaction.payment_method || 'N/A'}
                                </div>
                                <div>
                                    {getStatusBadge(transaction.status)}
                                </div>
                            </div>
                        ))}
                    </>
                )}
            </div>

            {/* Info Card */}
            {transactions.length > 0 && (
                <div style={{
                    marginTop: '24px',
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '16px',
                    padding: '24px'
                }}>
                    <div style={{
                        display: 'flex',
                        alignItems: 'center',
                        gap: '12px',
                        marginBottom: '12px'
                    }}>
                        <span style={{ fontSize: '24px' }}>💡</span>
                        <h3 style={{
                            fontSize: '16px',
                            fontWeight: '700',
                            color: '#fff'
                        }}>
                            Resumo de Compras
                        </h3>
                    </div>
                    <div style={{
                        display: 'grid',
                        gridTemplateColumns: 'repeat(3, 1fr)',
                        gap: '16px'
                    }}>
                        <div>
                            <div style={{ fontSize: '12px', color: '#64748b', marginBottom: '4px' }}>
                                Total de Transações
                            </div>
                            <div style={{ fontSize: '24px', fontWeight: '700', color: '#fff' }}>
                                {transactions.length}
                            </div>
                        </div>
                        <div>
                            <div style={{ fontSize: '12px', color: '#64748b', marginBottom: '4px' }}>
                                Créditos Adquiridos
                            </div>
                            <div style={{ fontSize: '24px', fontWeight: '700', color: '#4F46E5' }}>
                                {transactions.reduce((sum, t) => sum + t.coins_amount + t.bonus_coins, 0)}
                            </div>
                        </div>
                        <div>
                            <div style={{ fontSize: '12px', color: '#64748b', marginBottom: '4px' }}>
                                Total Investido
                            </div>
                            <div style={{ fontSize: '24px', fontWeight: '700', color: '#10b981' }}>
                                {formatCurrency(transactions.reduce((sum, t) => sum + (t.price / 100), 0))}
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </PanelLayout>
    );
};

export default MinhasCompras;
