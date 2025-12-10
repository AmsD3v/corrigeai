import { useState } from 'react';
import PanelLayout from '../../components/PanelLayout';
import api from '../../services/api';

const Feedback = () => {
    const [feedbackType, setFeedbackType] = useState('');
    const [message, setMessage] = useState('');
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [successMessage, setSuccessMessage] = useState('');
    const [errorMessage, setErrorMessage] = useState('');
    const maxChars = 1000;

    const feedbackTypes = [
        { value: 'sugestao', label: 'Sugestão' },
        { value: 'bug', label: 'Reportar Bug' },
        { value: 'reclamacao', label: 'Reclamação' },
        { value: 'elogio', label: 'Elogio' },
        { value: 'outro', label: 'Outro' }
    ];

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();

        if (!feedbackType || !message.trim()) {
            setErrorMessage('Por favor, preencha todos os campos.');
            return;
        }

        setIsSubmitting(true);
        setSuccessMessage('');
        setErrorMessage('');

        try {
            await api.post('/feedback/', {
                type: feedbackType,
                message: message.trim()
            });

            setSuccessMessage('Feedback enviado com sucesso! Obrigado pela sua contribuição.');
            setFeedbackType('');
            setMessage('');
        } catch (error: any) {
            console.error('Erro ao enviar feedback:', error);
            // FastAPI validation errors come as array in detail
            let errorMsg = 'Erro ao enviar feedback. Tente novamente mais tarde.';

            if (error.response?.data?.detail) {
                const detail = error.response.data.detail;
                if (Array.isArray(detail)) {
                    // Pydantic validation errors
                    errorMsg = detail.map((e: any) => {
                        const msg = e.msg || e.message || String(e);
                        // Remove 'Value error, ' prefix from Pydantic messages
                        return msg.replace(/^Value error,\s*/i, '');
                    }).join('. ');
                } else if (typeof detail === 'string') {
                    errorMsg = detail;
                } else if (detail.msg) {
                    errorMsg = detail.msg;
                }
            }

            setErrorMessage(errorMsg);
        } finally {
            setIsSubmitting(false);
        }
    };

    return (
        <PanelLayout activePage="/painel/feedback">
            {/* Header */}
            <div style={{
                marginBottom: '32px'
            }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '12px'
                }}>
                    Envie seu Feedback
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8',
                    lineHeight: '1.6'
                }}>
                    Sua opinião é muito importante para nós! Use este formulário para enviar feedback, reclamações ou solicitar reembolso.
                </p>
            </div>

            {/* Feedback Form */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px'
            }}>
                <form onSubmit={handleSubmit}>
                    {/* Feedback Type */}
                    <div style={{ marginBottom: '24px' }}>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '12px'
                        }}>
                            Tipo de Feedback:
                        </label>
                        <select
                            value={feedbackType}
                            onChange={(e) => setFeedbackType(e.target.value)}
                            style={{
                                width: '100%',
                                padding: '14px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: feedbackType ? '#fff' : '#64748b',
                                fontSize: '14px',
                                cursor: 'pointer',
                                outline: 'none'
                            }}
                        >
                            <option value="" disabled>Selecione o tipo</option>
                            {feedbackTypes.map((type) => (
                                <option key={type.value} value={type.value}>
                                    {type.label}
                                </option>
                            ))}
                        </select>
                    </div>

                    {/* Message */}
                    <div style={{ marginBottom: '24px' }}>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '12px'
                        }}>
                            Sua Mensagem:
                        </label>
                        <textarea
                            value={message}
                            onChange={(e) => {
                                if (e.target.value.length <= maxChars) {
                                    setMessage(e.target.value);
                                }
                            }}
                            placeholder="Descreva sua sugestão, reclamação ou solicitação aqui..."
                            style={{
                                width: '100%',
                                minHeight: '180px',
                                padding: '14px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px',
                                resize: 'vertical',
                                outline: 'none',
                                fontFamily: 'inherit',
                                lineHeight: '1.6'
                            }}
                        />
                        <div style={{
                            textAlign: 'right',
                            fontSize: '12px',
                            color: message.length >= maxChars ? '#ef4444' : '#64748b',
                            marginTop: '8px'
                        }}>
                            {message.length}/{maxChars} caracteres
                        </div>
                    </div>

                    {/* Success Message */}
                    {successMessage && (
                        <div style={{
                            padding: '14px 16px',
                            background: '#10b98120',
                            border: '1px solid #10b981',
                            borderRadius: '8px',
                            color: '#10b981',
                            fontSize: '14px',
                            marginBottom: '20px'
                        }}>
                            ✓ {successMessage}
                        </div>
                    )}

                    {/* Error Message */}
                    {errorMessage && (
                        <div style={{
                            padding: '14px 16px',
                            background: '#ef444420',
                            border: '1px solid #ef4444',
                            borderRadius: '8px',
                            color: '#ef4444',
                            fontSize: '14px',
                            marginBottom: '20px'
                        }}>
                            ✗ {errorMessage}
                        </div>
                    )}

                    {/* Submit Button */}
                    <button
                        type="submit"
                        disabled={isSubmitting || !feedbackType || !message.trim()}
                        style={{
                            width: '100%',
                            padding: '14px',
                            background: isSubmitting || !feedbackType || !message.trim() ? '#334155' : '#4F46E5',
                            color: isSubmitting || !feedbackType || !message.trim() ? '#64748b' : '#fff',
                            border: 'none',
                            borderRadius: '8px',
                            fontSize: '15px',
                            fontWeight: '600',
                            cursor: isSubmitting || !feedbackType || !message.trim() ? 'not-allowed' : 'pointer',
                            transition: 'all 0.2s'
                        }}
                        onMouseEnter={(e) => {
                            if (!isSubmitting && feedbackType && message.trim()) {
                                e.currentTarget.style.background = '#4338ca';
                            }
                        }}
                        onMouseLeave={(e) => {
                            if (!isSubmitting && feedbackType && message.trim()) {
                                e.currentTarget.style.background = '#4F46E5';
                            }
                        }}
                    >
                        {isSubmitting ? 'Enviando...' : 'Enviar Feedback'}
                    </button>
                </form>
            </div>

            {/* Info Card */}
            <div style={{
                marginTop: '24px',
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '20px'
            }}>
                <div style={{
                    display: 'flex',
                    alignItems: 'flex-start',
                    gap: '12px'
                }}>
                    <span style={{ fontSize: '20px' }}>💡</span>
                    <div>
                        <h3 style={{
                            fontSize: '14px',
                            fontWeight: '600',
                            color: '#fff',
                            marginBottom: '8px'
                        }}>
                            Dicas para um bom feedback
                        </h3>
                        <ul style={{
                            fontSize: '13px',
                            color: '#94a3b8',
                            lineHeight: '1.8',
                            margin: 0,
                            paddingLeft: '20px'
                        }}>
                            <li>Seja específico e detalhado sobre o problema ou sugestão</li>
                            <li>Inclua exemplos quando possível</li>
                            <li>Se for um bug, descreva os passos para reproduzi-lo</li>
                            <li>Mantenha um tom respeitoso e construtivo</li>
                        </ul>
                    </div>
                </div>
            </div>
        </PanelLayout>
    );
};

export default Feedback;
