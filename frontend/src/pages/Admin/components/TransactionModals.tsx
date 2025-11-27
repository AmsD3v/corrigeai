import React from 'react';
import '../Transacoes.css';

interface Transaction {
    id: number;
    user_name: string;
    package_name: string;
    coins_amount: number;
    bonus_coins: number;
}

interface ApproveModalProps {
    transaction: Transaction;
    loading: boolean;
    onConfirm: () => void;
    onCancel: () => void;
}

export const ApproveModal: React.FC<ApproveModalProps> = ({ transaction, loading, onConfirm, onCancel }) => (
    <div className="modal-overlay">
        <div className="modal-content">
            <h2 className="modal-title">✅ Aprovar Transação</h2>
            <p className="modal-text">Você está prestes a aprovar a transação:</p>
            <div className="transaction-details">
                <div className="detail-row">
                    <span className="detail-label">Usuário:</span> {transaction.user_name}
                </div>
                <div className="detail-row">
                    <span className="detail-label">Pacote:</span> {transaction.package_name}
                </div>
                <div className="detail-row">
                    <span className="detail-label">Créditos:</span> {transaction.coins_amount + transaction.bonus_coins}
                </div>
            </div>
            <div className="modal-actions">
                <button
                    onClick={onConfirm}
                    disabled={loading}
                    className="btn-confirm approve"
                >
                    {loading ? 'Aprovando...' : 'Confirmar Aprovação'}
                </button>
                <button
                    onClick={onCancel}
                    disabled={loading}
                    className="btn-cancel"
                >
                    Cancelar
                </button>
            </div>
        </div>
    </div>
);

interface RejectModalProps {
    transaction: Transaction;
    loading: boolean;
    reason: string;
    setReason: (reason: string) => void;
    onConfirm: () => void;
    onCancel: () => void;
}

export const RejectModal: React.FC<RejectModalProps> = ({ transaction, loading, reason, setReason, onConfirm, onCancel }) => (
    <div className="modal-overlay">
        <div className="modal-content">
            <h2 className="modal-title">❌ Rejeitar Transação</h2>
            <p className="modal-text">
                Você está prestes a rejeitar a transação de <strong style={{ color: '#fff' }}>{transaction.user_name}</strong>.
            </p>
            <textarea
                placeholder="Motivo da rejeição (opcional)"
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                className="reject-textarea"
            />
            <div className="modal-actions">
                <button
                    onClick={onConfirm}
                    disabled={loading}
                    className="btn-confirm reject"
                >
                    {loading ? 'Rejeitando...' : 'Confirmar Rejeição'}
                </button>
                <button
                    onClick={onCancel}
                    disabled={loading}
                    className="btn-cancel"
                >
                    Cancelar
                </button>
            </div>
        </div>
    </div>
);

interface SuccessModalProps {
    message: string;
    onClose: () => void;
}

export const SuccessModal: React.FC<SuccessModalProps> = ({ message, onClose }) => (
    <div className="modal-overlay">
        <div className={`modal-content success-modal-content`}>
            <div className="success-icon">
                {message.includes('Erro') ? '⚠️' : '✅'}
            </div>
            <p className="success-text">{message}</p>
            <button onClick={onClose} className="btn-ok">OK</button>
        </div>
    </div>
);
