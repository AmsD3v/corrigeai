import { useState, useEffect } from 'react';
import apiClient from '../../../services/api';

export interface Transaction {
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

export const useTransactions = () => {
    const [transactions, setTransactions] = useState<Transaction[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [filterStatus, setFilterStatus] = useState<'all' | 'approved' | 'pending' | 'rejected' | 'cancelled'>('all');
    const [loading, setLoading] = useState(false);

    // Modal states
    const [showApproveModal, setShowApproveModal] = useState(false);
    const [showRejectModal, setShowRejectModal] = useState(false);
    const [showSuccessModal, setShowSuccessModal] = useState(false);
    const [selectedTransaction, setSelectedTransaction] = useState<Transaction | null>(null);
    const [rejectReason, setRejectReason] = useState('');
    const [modalMessage, setModalMessage] = useState('');

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
        try {
            const response = await apiClient.patch(`/admin/transactions/${selectedTransaction.id}/approve`);
            setModalMessage(response.data.message || 'Transação aprovada com sucesso!');
            setShowApproveModal(false);
            setShowSuccessModal(true);
            loadTransactions();
        } catch (error: any) {
            console.error('Approve error:', error);
            setModalMessage(`Erro: ${error.response?.data?.detail || error.message}`);
            setShowApproveModal(false);
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
        try {
            await apiClient.patch(`/admin/transactions/${selectedTransaction.id}/reject`,
                rejectReason ? { reason: rejectReason } : {}
            );
            setModalMessage('Transação rejeitada.');
            setShowRejectModal(false);
            setShowSuccessModal(true);
            loadTransactions();
        } catch (error: any) {
            console.error('Reject error:', error);
            setModalMessage(`Erro: ${error.response?.data?.detail || error.message}`);
            setShowRejectModal(false);
            setShowSuccessModal(true);
        } finally {
            setLoading(false);
            setSelectedTransaction(null);
            setRejectReason('');
        }
    };

    const handleExportCSV = () => {
        const filteredTransactions = transactions.filter(txn => {
            const matchesSearch = txn.user_name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                txn.user_email.toLowerCase().includes(searchTerm.toLowerCase()) ||
                txn.id.toString().includes(searchTerm);
            return matchesSearch;
        });

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

    return {
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
    };
};
