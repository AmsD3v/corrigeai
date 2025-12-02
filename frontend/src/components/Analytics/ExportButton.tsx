import React from 'react';
import api from '../../services/api';

interface ExportButtonProps {
    onExportStart?: () => void;
    onExportComplete?: () => void;
    onExportError?: (error: any) => void;
}

const ExportButton: React.FC<ExportButtonProps> = ({
    onExportStart,
    onExportComplete,
    onExportError
}) => {
    const [loading, setLoading] = React.useState(false);

    const handleExport = async () => {
        try {
            setLoading(true);
            if (onExportStart) onExportStart();

            const response = await api.get('/admin/export-user-data', {
                responseType: 'blob'
            });

            // Criar URL do blob e fazer download
            const blob = new Blob([response.data], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = url;

            // Nome do arquivo com timestamp
            const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
            link.download = `user_data_${timestamp}.csv`;

            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            window.URL.revokeObjectURL(url);

            if (onExportComplete) onExportComplete();
        } catch (error) {
            console.error('Error exporting data:', error);
            if (onExportError) onExportError(error);
            alert('Erro ao exportar dados. Tente novamente.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <button
            onClick={handleExport}
            disabled={loading}
            style={{
                padding: '12px 24px',
                background: loading ? '#64748b' : '#10b981',
                border: 'none',
                borderRadius: '8px',
                color: '#fff',
                fontSize: '14px',
                fontWeight: '600',
                cursor: loading ? 'not-allowed' : 'pointer',
                display: 'flex',
                alignItems: 'center',
                gap: '8px',
                transition: 'all 0.3s'
            }}
        >
            <span>{loading ? '📥' : '📊'}</span>
            {loading ? 'Exportando...' : 'Exportar CSV'}
        </button>
    );
};

export default ExportButton;
