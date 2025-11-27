import AdminLayout from '../../components/AdminLayout';
import { useTransactions } from './hooks/useTransactions';
import { ApproveModal, RejectModal, SuccessModal } from './components/TransactionModals';
import './Transacoes.css';

const Transacoes = () => {
    const {
        transactions,
        searchTerm,
        setSearchTerm,
        filterStatus,
        setFilterStatus,
        loading,
        showApproveModal,
        setShowApproveModal,
        showRejectModal,
        setShowRejectModal,
        showSuccessModal,
        setShowSuccessModal,
        selectedTransaction,
        setSelectedTransaction,
        rejectReason,
        setRejectReason,
        modalMessage,
        setModalMessage,
        handleApprove,
        confirmApprove,
        handleReject,
        confirmReject,
        handleExportCSV
    } = useTransactions();

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
            <div className="transactions-container">
                <h1 className="page-title">Gestão de Transações</h1>
                <p className="page-subtitle">Visualize e gerencie todas as transações financeiras</p>
            </div>

            {/* Financial Stats */}
            <div className="stats-grid">
                <div className="stat-card">
                    <div className="stat-label">Receita Total</div>
                    <div className="stat-value revenue">
                        R$ {totalRevenue.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}
                    </div>
                </div>
                <div className="stat-card">
                    <div className="stat-label">Concluídas</div>
                    <div className="stat-value completed">{completedCount}</div>
                </div>
                <div className="stat-card">
                    <div className="stat-label">Pendentes</div>
                    <div className="stat-value pending">{pendingCount}</div>
                </div>
                <div className="stat-card">
                    <div className="stat-label">Falhadas</div>
                    <div className="stat-value failed">{failedCount}</div>
                </div>
            </div>

            {/* Filters and Export */}
            <div className="filters-container">
                <input
                    type="text"
                    placeholder="Buscar por usuário ou ID..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="search-input"
                />
                <select
                    value={filterStatus}
                    onChange={(e) => setFilterStatus(e.target.value as any)}
                    className="status-select"
                >
                    <option value="all">Todos os status</option>
                    <option value="approved">Aprovados</option>
                    <option value="pending">Pendentes</option>
                    <option value="rejected">Rejeitados</option>
                    <option value="cancelled">Cancelados</option>
                </select>
                <button onClick={handleExportCSV} className="export-btn">
                    📥 Exportar CSV
                </button>
            </div>

            {/* Transactions Table */}
            <div className="table-container">
                <div style={{ overflowX: 'auto' }}>
                    <table className="transactions-table">
                        <thead className="table-header">
                            <tr>
                                <th className="table-th">ID</th>
                                <th className="table-th">Usuário</th>
                                <th className="table-th">Data</th>
                                <th className="table-th">Valor</th>
                                <th className="table-th">Pacote</th>
                                <th className="table-th">Método</th>
                                <th className="table-th">Status</th>
                                <th className="table-th">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            {filteredTransactions.map((txn) => (
                                <tr key={txn.id} className="table-row">
                                    <td className="table-td td-id">#{txn.id}</td>
                                    <td className="table-td">
                                        <div className="user-name">{txn.user_name}</div>
                                        <div className="user-email">{txn.user_email}</div>
                                    </td>
                                    <td className="table-td td-date">
                                        {new Date(txn.created_at + 'Z').toLocaleString('pt-BR', {
                                            day: '2-digit',
                                            month: '2-digit',
                                            year: 'numeric',
                                            hour: '2-digit',
                                            minute: '2-digit',
                                            timeZone: 'America/Sao_Paulo'
                                        })}
                                    </td>
                                    <td className="table-td td-price">
                                        R$ {(txn.price / 100).toFixed(2)}
                                    </td>
                                    <td className="table-td">
                                        <div className="package-name">{txn.package_name}</div>
                                        <div className="package-credits">
                                            {txn.coins_amount + txn.bonus_coins} créditos
                                        </div>
                                    </td>
                                    <td className="table-td td-method">
                                        {txn.payment_method || 'N/A'}
                                    </td>
                                    <td className="table-td">
                                        <span className="status-badge" style={{
                                            background: `${getStatusColor(txn.status)}20`,
                                            color: getStatusColor(txn.status)
                                        }}>
                                            {getStatusLabel(txn.status)}
                                        </span>
                                    </td>
                                    <td className="table-td">
                                        {txn.status === 'pending' && (
                                            <div className="action-buttons">
                                                <button
                                                    onClick={() => handleApprove(txn.id)}
                                                    className="btn-approve"
                                                    title="Aprovar transação"
                                                >
                                                    ✅ Aprovar
                                                </button>
                                                <button
                                                    onClick={() => handleReject(txn.id)}
                                                    className="btn-reject"
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
                    <div className="empty-state">
                        Nenhuma transação encontrada
                    </div>
                )}
            </div>

            {/* Modals */}
            {showApproveModal && selectedTransaction && (
                <ApproveModal
                    transaction={selectedTransaction}
                    loading={loading}
                    onConfirm={confirmApprove}
                    onCancel={() => {
                        setShowApproveModal(false);
                        setSelectedTransaction(null);
                    }}
                />
            )}

            {showRejectModal && selectedTransaction && (
                <RejectModal
                    transaction={selectedTransaction}
                    loading={loading}
                    reason={rejectReason}
                    setReason={setRejectReason}
                    onConfirm={confirmReject}
                    onCancel={() => {
                        setShowRejectModal(false);
                        setSelectedTransaction(null);
                        setRejectReason('');
                    }}
                />
            )}

            {showSuccessModal && (
                <SuccessModal
                    message={modalMessage}
                    onClose={() => {
                        setShowSuccessModal(false);
                        setModalMessage('');
                    }}
                />
            )}
        </AdminLayout>
    );
};

export default Transacoes;
