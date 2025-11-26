import { useState, useEffect } from 'react';
import AdminLayout from '../../components/AdminLayout';
import apiClient from '../../services/api';

interface Transaction {
    id: number;
    user_id: number;
    user_name: string;
    user_email: string;
    created_at: string;
    price: number;
    package_name: string;
    coins_amount: number;
    bonus_coins: number;
    payment_method: string | null;
    payment_id: string | null;
    status: string;
    approved_at: string | null;
}

const Transacoes = () => {
    const [transactions, setTransactions] = useState<Transaction[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [filterStatus, setFilterStatus] = useState<'all' | 'approved' | 'pending' | 'rejected' | 'cancelled'>('all');

    // Modal states
    const [showApproveModal, setShowApproveModal] = useState(false);
    const [showRejectModal, setShowRejectModal] = useState(false);
    const [showSuccessModal, setShowSuccessModal] = useState(false);
    const [selectedTransaction, setSelectedTransaction] = useState<Transaction | null>(null);
    const [rejectReason, setRejectReason] = useState('');
    const [modalMessage, setModalMessage] = useState('');
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        loadTransactions();
    }, [filterStatus]);

    const loadTransactions = async () => {
        try {
            const params = filterStatus !== 'all' ? `?status_filter=${filterStatus}` : '';
            const response = await apiClient.get(`/admin/transactions${params}`);
            console.log('Admin transactions loaded:', response.data);
            setTransactions(response.data);
        } catch (error) {
            console.error('Error loading transactions:', error);
            setTransactions([]);
        }
    };

    const handleApprove = (transactionId: number) => {
        const txn = transactions.find(t => t.id === transactionId);
        if (!txn) return;

        setSelectedTransaction(txn);
        setShowApproveModal(true);
    };

    const confirmApprove = async () => {
        if (!selectedTransaction) return;

        setLoading(true);
        setShowApproveModal(false);

        try {
            const response = await apiClient.patch(`/admin/transactions/${selectedTransaction.id}/approve`);
            setModalMessage(response.data.message || 'Transação aprovada com sucesso!');
            setShowSuccessModal(true);
            loadTransactions();
        } catch (error: any) {
            console.error('Approve error:', error);
            setModalMessage(`Erro: ${error.response?.data?.detail || error.message}`);
            setShowSuccessModal(true);
        } finally {
            setLoading(false);
            setSelectedTransaction(null);
        }
    };

    const handleReject = (transactionId: number) => {
        const txn = transactions.find(t => t.id === transactionId);
        if (!txn) return;

        setSelectedTransaction(txn);
        setRejectReason('');
        setShowRejectModal(true);
    };

    const confirmReject = async () => {
        if (!selectedTransaction) return;

        setLoading(true);
        setShowRejectModal(false);

        try {
            await apiClient.patch(`/admin/transactions/${selectedTransaction.id}/reject`,
                rejectReason ? { reason: rejectReason } : {}
            );
            setModalMessage('Transação rejeitada.');
            setShowSuccessModal(true);
            loadTransactions();
        } catch (error: any) {
            console.error('Reject error:', error);
            setModalMessage(`Erro: ${error.response?.data?.detail || error.message}`);
            setShowSuccessModal(true);
        } finally {
            setLoading(false);
            setSelectedTransaction(null);
            setRejectReason('');
        }
    };

    const filteredTransactions = transactions.filter(txn => {
        const matchesSearch = txn.user_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            txn.user_email.toLowerCase().includes(searchTerm.toLowerCase()) ||
            txn.id.toString().includes(searchTerm);
        return matchesSearch;
    });

    const totalRevenue = transactions.reduce((sum, txn) => sum + (txn.status === 'approved' ? txn.price / 100 : 0), 0);
    const completedCount = transactions.filter(t => t.status === 'approved').length;
    const pendingCount = transactions.filter(t => t.status === 'pending').length;
    const failedCount = transactions.filter(t => t.status === 'rejected').length;

    const handleExportCSV = () => {
        const csv = [
            ['ID', 'Usuário', 'Email', 'Data', 'Valor', 'Pacote', 'Método', 'Status'].join(','),
            ...filteredTransactions.map(txn => [
                txn.id,
                txn.user_name,
                txn.user_email,
                new Date(txn.created_at + 'Z').toLocaleString('pt-BR', { timeZone: 'America/Sao_Paulo' }),
                `R$ ${(txn.price / 100).toFixed(2)}`,
                txn.package_name,
                txn.payment_method || 'N/A',
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
            case 'approved': return '#10b981';
            case 'pending': return '#f59e0b';
            case 'rejected': return '#ef4444';
            case 'cancelled': return '#64748b';
            default: return '#64748b';
        }
    };

    const getStatusLabel = (status: string) => {
        switch (status) {
            case 'approved': return 'Aprovado';
            case 'pending': return 'Pendente';
            case 'rejected': return 'Rejeitado';
            case 'cancelled': return 'Cancelado';
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
                    <option value="approved">Aprovados</option>
                    <option value="pending">Pendentes</option>
                    <option value="rejected">Rejeitados</option>
                    <option value="cancelled">Cancelados</option>
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
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredTransactions.map((txn) => (
                                <tr key={txn.id} style={{ borderTop: '1px solid #334155' }}>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '13px', fontFamily: 'monospace' }}>
                                        #{txn.id}
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ color: '#fff', fontSize: '14px', fontWeight: '600', marginBottom: '2px' }}>
                                            {txn.user_name}
                                        </div>
                                        <div style={{ color: '#94a3b8', fontSize: '12px' }}>
                                            {txn.user_email}
                                        </div>
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                        {new Date(txn.created_at + 'Z').toLocaleString('pt-BR', {
                                            day: '2-digit',
                                            month: '2-digit',
                                            year: 'numeric',
                                            hour: '2-digit',
                                            minute: '2-digit',
                                            timeZone: 'America/Sao_Paulo'
                                        })}
                                    </td>
                                    <td style={{ padding: '16px', color: '#10b981', fontSize: '14px', fontWeight: '600' }}>
                                        R$ {(txn.price / 100).toFixed(2)}
                                    </td>
                                    <td style={{ padding: '16px', color: '#fff', fontSize: '14px' }}>
                                        <div>{txn.package_name}</div>
                                        <div style={{ fontSize: '12px', color: '#94a3b8' }}>
                                            {txn.coins_amount + txn.bonus_coins} créditos
                                        </div>
                                    </td>
                                    <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                        {txn.payment_method || 'N/A'}
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
                                    <td style={{ padding: '16px' }}>
                                        {txn.status === 'pending' && (
                                            <div style={{ display: 'flex', gap: '8px' }}>
                                                <button
                                                    onClick={() => handleApprove(txn.id)}
                                                    style={{
                                                        padding: '6px 12px',
                                                        background: '#10b981',
                                                        border: 'none',
                                                        borderRadius: '6px',
                                                        color: '#fff',
                                                        fontSize: '12px',
                                                        fontWeight: '600',
                                                        cursor: 'pointer',
                                                        transition: 'all 0.2s'
                                                    }}
                                                    onMouseEnter={(e) => e.currentTarget.style.background = '#059669'}
                                                    onMouseLeave={(e) => e.currentTarget.style.background = '#10b981'}
                                                    title="Aprovar transação"
                                                >
                                                    ✅ Aprovar
                                                </button>
                                                <button
                                                    onClick={() => handleReject(txn.id)}
                                                    style={{
                                                        padding: '6px 12px',
                                                        background: '#ef4444',
                                                        border: 'none',
                                                        borderRadius: '6px',
                                                        color: '#fff',
                                                        fontSize: '12px',
                                                        fontWeight: '600',
                                                        cursor: 'pointer',
                                                        transition: 'all 0.2s'
                                                    }}
                                                    onMouseEnter={(e) => e.currentTarget.style.background = '#dc2626'}
                                                    onMouseLeave={(e) => e.currentTarget.style.background = '#ef4444'}
                                                    title="Rejeitar transação"
                                                >
                                                    ❌ Rejeitar
                                                </button>
                                            </div>
                                        )}
                                        {txn.status !== 'pending' && (
                                            <span style={{ color: '#64748b', fontSize: '13px' }}>-</span>
                                        )}
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

            {/* Approve Modal */}
            {showApproveModal && selectedTransaction && (
                <div style={{
                    position: 'fixed',
                    top: 0,
                    left: 0,
                    width: '100%',
                    height: '100%',
                    background: 'rgba(0, 0, 0, 0.7)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    zIndex: 1000
                }}>
                    <div style={{
                        background: '#1a1f2e',
                        border: '1px solid #334155',
                        borderRadius: '16px',
                        padding: '32px',
                        maxWidth: '500px',
                        width: '90%'
                    }}>
                        <h2 style={{ color: '#fff', marginBottom: '16px', fontSize: '24px' }}>
                            ✅ Aprovar Transação
                        </h2>
                        <p style={{ color: '#94a3b8', marginBottom: '24px' }}>
                            Você está prestes a aprovar a transação:
                        </p>
                        <div style={{
                            background: '#0f1419',
                            padding: '16px',
                            borderRadius: '8px',
                            marginBottom: '24px'
                        }}>
                            <div style={{ color: '#94a3b8', fontSize: '13px', marginBottom: '8px' }}>
                                <strong style={{ color: '#fff' }}>Usuário:</strong> {selectedTransaction.user_name}
                            </div>
                            <div style={{ color: '#94a3b8', fontSize: '13px', marginBottom: '8px' }}>
                                <strong style={{ color: '#fff' }}>Pacote:</strong> {selectedTransaction.package_name}
                            </div>
                            <div style={{ color: '#94a3b8', fontSize: '13px' }}>
                                <strong style={{ color: '#fff' }}>Créditos:</strong> {selectedTransaction.coins_amount + selectedTransaction.bonus_coins}
                            </div>
                        </div>
                        <div style={{ display: 'flex', gap: '12px' }}>
                            <button
                                onClick={confirmApprove}
                                disabled={loading}
                                style={{
                                    flex: 1,
                                    padding: '12px 24px',
                                    background: loading ? '#64748b' : '#10b981',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: loading ? 'not-allowed' : 'pointer'
                                }}
                            >
                                {loading ? 'Aprovando...' : 'Confirmar Aprovação'}
                            </button>
                            <button
                                onClick={() => {
                                    setShowApproveModal(false);
                                    setSelectedTransaction(null);
                                }}
                                disabled={loading}
                                style={{
                                    flex: 1,
                                    padding: '12px 24px',
                                    background: '#334155',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#94a3b8',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: loading ? 'not-allowed' : 'pointer'
                                }}
                            >
                                Cancelar
                            </button>
                        </div>
                    </div>
                </div>
            )}

            {/* Reject Modal */}
            {showRejectModal && selectedTransaction && (
                <div style={{
                    position: 'fixed',
                    top: 0,
                    left: 0,
                    width: '100%',
                    height: '100%',
                    background: 'rgba(0, 0, 0, 0.7)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    zIndex: 1000
                }}>
                    <div style={{
                        background: '#1a1f2e',
                        border: '1px solid #334155',
                        borderRadius: '16px',
                        padding: '32px',
                        maxWidth: '500px',
                        width: '90%'
                    }}>
                        <h2 style={{ color: '#fff', marginBottom: '16px', fontSize: '24px' }}>
                            ❌ Rejeitar Transação
                        </h2>
                        <p style={{ color: '#94a3b8', marginBottom: '24px' }}>
                            Você está prestes a rejeitar a transação de <strong style={{ color: '#fff' }}>{selectedTransaction.user_name}</strong>.
                        </p>
                        <textarea
                            placeholder="Motivo da rejeição (opcional)"
                            value={rejectReason}
                            onChange={(e) => setRejectReason(e.target.value)}
                            style={{
                                width: '100%',
                                padding: '12px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px',
                                marginBottom: '24px',
                                minHeight: '100px',
                                resize: 'vertical',
                                fontFamily: 'inherit'
                            }}
                        />
                        <div style={{ display: 'flex', gap: '12px' }}>
                            <button
                                onClick={confirmReject}
                                disabled={loading}
                                style={{
                                    flex: 1,
                                    padding: '12px 24px',
                                    background: loading ? '#64748b' : '#ef4444',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: loading ? 'not-allowed' : 'pointer'
                                }}
                            >
                                {loading ? 'Rejeitando...' : 'Confirmar Rejeição'}
                            </button>
                            <button
                                onClick={() => {
                                    setShowRejectModal(false);
                                    setSelectedTransaction(null);
                                    setRejectReason('');
                                }}
                                disabled={loading}
                                style={{
                                    flex: 1,
                                    padding: '12px 24px',
                                    background: '#334155',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#94a3b8',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: loading ? 'not-allowed' : 'pointer'
                                }}
                            >
                                Cancelar
                            </button>
                        </div>
                    </div>
                </div>
            )}

            {/* Success/Error Modal */}
            {showSuccessModal && (
                <div style={{
                    position: 'fixed',
                    top: 0,
                    left: 0,
                    width: '100%',
                    height: '100%',
                    background: 'rgba(0, 0, 0, 0.7)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    zIndex: 1000
                }}>
                    <div style={{
                        background: '#1a1f2e',
                        border: '1px solid #334155',
                        borderRadius: '16px',
                        padding: '32px',
                        maxWidth: '400px',
                        width: '90%',
                        textAlign: 'center'
                    }}>
                        <div style={{ fontSize: '48px', marginBottom: '16px' }}>
                            {modalMessage.includes('Erro') ? '⚠️' : '✅'}
                        </div>
                        <p style={{
                            color: '#fff',
                            fontSize: '16px',
                            marginBottom: '24px',
                            lineHeight: '1.5'
                        }}>
                            {modalMessage}
                        </p>
                        <button
                            onClick={() => {
                                setShowSuccessModal(false);
                                setModalMessage('');
                            }}
                            style={{
                                padding: '12px 32px',
                                background: '#10b981',
                                border: 'none',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px',
                                fontWeight: '600',
                                cursor: 'pointer'
                            }}
                        >
                            OK
                        </button>
                    </div>
                </div>
            )}
        </AdminLayout>
    );
};

export default Transacoes;
