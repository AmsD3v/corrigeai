import { useState, useEffect } from 'react';
import AdminLayout from '../../components/AdminLayout';

interface Transaction {
    id: string;
    userId: string;
    userName: string;
    date: string;
    amount: number;
    package: string;
    credits: number;
    paymentMethod: string;
    status: 'completed' | 'pending' | 'failed';
}

const Transacoes = () => {
    const [transactions, setTransactions] = useState<Transaction[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [filterStatus, setFilterStatus] = useState<'all' | 'completed' | 'pending' | 'failed'>('all');

    useEffect(() => {
        loadTransactions();
    }, []);

    const loadTransactions = () => {
        // Generate mock transactions from localStorage data
        const allKeys = Object.keys(localStorage);
        const essayKeys = allKeys.filter(key => key.startsWith('essay_'));

        const mockTransactions: Transaction[] = essayKeys.map((key, index) => {
            const essayId = key.replace('essay_', '');
            const essayData = JSON.parse(localStorage.getItem(key) || '{}');

            return {
                id: `txn_${essayId}`,
                userId: essayData.userId || 'unknown',
                userName: `Usuário ${index + 1}`,
                date: essayData.submitted_at || new Date().toISOString(),
                amount: 15.00,
                package: 'Correção Individual',
                credits: 1,
                paymentMethod: ['Cartão de Crédito', 'PIX', 'Boleto'][Math.floor(Math.random() * 3)],
                status: 'completed'
            };
        });

        mockTransactions.sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());
        setTransactions(mockTransactions);
    };

    const filteredTransactions = transactions.filter(txn => {
        const matchesSearch = txn.userName.toLowerCase().includes(searchTerm.toLowerCase()) ||
            txn.id.toLowerCase().includes(searchTerm.toLowerCase());
        const matchesStatus = filterStatus === 'all' || txn.status === filterStatus;
        return matchesSearch && matchesStatus;
    });

    const totalRevenue = transactions.reduce((sum, txn) => sum + (txn.status === 'completed' ? txn.amount : 0), 0);
    const completedCount = transactions.filter(t => t.status === 'completed').length;
    const pendingCount = transactions.filter(t => t.status === 'pending').length;
    const failedCount = transactions.filter(t => t.status === 'failed').length;

    const handleExportCSV = () => {
        const csv = [
            ['ID', 'Usuário', 'Data', 'Valor', 'Pacote', 'Método', 'Status'].join(','),
            ...filteredTransactions.map(txn => [
                txn.id,
                txn.userName,
                new Date(txn.date).toLocaleDateString('pt-BR'),
                `R$ ${txn.amount.toFixed(2)}`,
                txn.package,
                txn.paymentMethod,
                txn.status
            ].join(','))
        ].join('\n');

        const blob = new Blob([csv], { type: 'text/csv' });
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `transacoes_${new Date().toISOString().split('T')[0]}.csv`;
        a.click();
    };

    const getStatusColor = (status: string) => {
        switch (status) {
            case 'completed': return '#10b981';
            case 'pending': return '#f59e0b';
            case 'failed': return '#ef4444';
            default: return '#64748b';
        }
    };

    const getStatusLabel = (status: string) => {
        switch (status) {
            case 'completed': return 'Concluída';
            case 'pending': return 'Pendente';
            case 'failed': return 'Falhou';
            default: return status;
        }
    };

    return (
        <AdminLayout activePage="/admin/transacoes">
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Gestão de Transações
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Visualize e gerencie todas as transações financeiras
                </p>
            </div>

            {/* Financial Stats */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
                gap: '16px',
                marginBottom: '24px'
            }}>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Receita Total
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#10b981' }}>
                        R$ {totalRevenue.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Concluídas
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#3b82f6' }}>
                        {completedCount}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Pendentes
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#f59e0b' }}>
                        {pendingCount}
                    </div>
                </div>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Falhadas
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#ef4444' }}>
                        {failedCount}
                    </div>
                </div>
            </div>

            {/* Filters and Export */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '20px',
                marginBottom: '24px',
                display: 'flex',
                gap: '16px',
                flexWrap: 'wrap',
                alignItems: 'center'
            }}>
                <input
                    type="text"
                    placeholder="Buscar por usuário ou ID..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    style={{
                        flex: 1,
                        minWidth: '250px',
                        padding: '12px 16px',
                        background: '#0f1419',
                        border: '1px solid #334155',
                        borderRadius: '8px',
                        color: '#fff',
                        fontSize: '14px'
                    }}
                />
                <select
                    value={filterStatus}
                    onChange={(e) => setFilterStatus(e.target.value as any)}
                    style={{
                        padding: '12px 16px',
                        background: '#0f1419',
                        border: '1px solid #334155',
                        borderRadius: '8px',
                        color: '#fff',
                        fontSize: '14px',
                        cursor: 'pointer'
                    }}
                >
                    <option value="all">Todos os status</option>
                    <option value="completed">Concluídas</option>
                    <option value="pending">Pendentes</option>
                    <option value="failed">Falhadas</option>
                </select>
                <button
                    onClick={handleExportCSV}
                    style={{
                        padding: '12px 24px',
                        background: '#10b981',
                        border: 'none',
                        borderRadius: '8px',
                        color: '#fff',
                        fontSize: '14px',
                        fontWeight: '600',
                        cursor: 'pointer',
                        transition: 'all 0.2s'
                    }}
                    onMouseEnter={(e) => {
                        e.currentTarget.style.background = '#059669';
                    }}
                    onMouseLeave={(e) => {
                        e.currentTarget.style.background = '#10b981';
                    }}
                >
                    📥 Exportar CSV
                </button>
            </div>

            {/* Transactions Table */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                overflow: 'hidden'
            }}>
                <div style={{ overflowX: 'auto' }}>
                    <table style={{
                        width: '100%',
                        borderCollapse: 'collapse'
                    }}>
                        <thead>
                            <tr style={{ background: '#0f1419' }}>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>ID</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Usuário</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Data</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Valor</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Pacote</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Método</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredTransactions.map((txn) => (
                                <tr key={txn.id} style={{ borderTop: '1px solid #334155' }}>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '13px', fontFamily: 'monospace' }}>
                                        {txn.id}
                                    </td>
                                    <td style={{ padding: '16px', color: '#fff', fontSize: '14px' }}>
                                        {txn.userName}
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                        {new Date(txn.date).toLocaleDateString('pt-BR')}
                                    </td>
                                    <td style={{ padding: '16px', color: '#10b981', fontSize: '14px', fontWeight: '600' }}>
                                        R$ {txn.amount.toFixed(2)}
                                    </td>
                                    <td style={{ padding: '16px', color: '#fff', fontSize: '14px' }}>
                                        {txn.package}
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                        {txn.paymentMethod}
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <span style={{
                                            padding: '4px 12px',
                                            borderRadius: '12px',
                                            fontSize: '12px',
                                            fontWeight: '600',
                                            background: `${getStatusColor(txn.status)}20`,
                                            color: getStatusColor(txn.status)
                                        }}>
                                            {getStatusLabel(txn.status)}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>

                {filteredTransactions.length === 0 && (
                    <div style={{
                        padding: '60px',
                        textAlign: 'center',
                        color: '#64748b'
                    }}>
                        Nenhuma transação encontrada
                    </div>
                )}
            </div>
        </AdminLayout>
    );
};

export default Transacoes;
