import { useState } from 'react';

interface FeedbackPopupProps {
    onFeedback?: (isPositive: boolean) => void;
    onClose?: () => void;
}

const FeedbackPopup = ({ onFeedback, onClose }: FeedbackPopupProps) => {
    const [feedback, setFeedback] = useState<boolean | null>(null);
    const [showThanks, setShowThanks] = useState(false);

    const handleFeedback = (isPositive: boolean) => {
        setFeedback(isPositive);
        setShowThanks(true);

        // Chama o callback se fornecido
        onFeedback?.(isPositive);

        // Fecha o popup após 2 segundos
        setTimeout(() => {
            onClose?.();
        }, 2000);
    };

    return (
        <div style={{
            position: 'fixed',
            bottom: '90px',
            right: '24px',
            background: '#1a1f2e',
            border: '2px solid #4F46E5',
            borderRadius: '16px',
            padding: '24px',
            boxShadow: '0 20px 60px rgba(79, 70, 229, 0.4)',
            zIndex: 1001,  // Above AI Professor button (1000)
            minWidth: '320px',
            maxWidth: '400px'
        }}>
            {/* Close Button */}
            <button
                onClick={() => onClose?.()}
                style={{
                    position: 'absolute',
                    top: '12px',
                    right: '12px',
                    width: '24px',
                    height: '24px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    borderRadius: '50%',
                    background: 'transparent',
                    border: 'none',
                    color: '#64748b',
                    cursor: 'pointer',
                    fontSize: '18px',
                    transition: 'all 0.2s'
                }}
                onMouseOver={(e) => {
                    e.currentTarget.style.background = '#334155';
                    e.currentTarget.style.color = 'white';
                }}
                onMouseOut={(e) => {
                    e.currentTarget.style.background = 'transparent';
                    e.currentTarget.style.color = '#64748b';
                }}
            >
                ✕
            </button>

            {!showThanks ? (
                <>
                    {/* Header with Avatar */}
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '16px' }}>
                        <div style={{ position: 'relative' }}>
                            <div style={{
                                width: '48px',
                                height: '48px',
                                background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                                borderRadius: '50%',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                fontSize: '24px'
                            }}>
                                🤖
                            </div>
                            <div style={{
                                position: 'absolute',
                                bottom: '-4px',
                                right: '-4px',
                                width: '16px',
                                height: '16px',
                                background: '#10b981',
                                border: '2px solid #1a1f2e',
                                borderRadius: '50%'
                            }}></div>
                        </div>
                        <div>
                            <div style={{ fontSize: '14px', fontWeight: '600', color: 'white' }}>Professor IA</div>
                            <div style={{ fontSize: '12px', color: '#64748b' }}>pronto pra ajudar</div>
                        </div>
                    </div>

                    {/* Question */}
                    <div style={{ marginBottom: '16px' }}>
                        <h3 style={{ fontSize: '16px', fontWeight: '700', color: 'white', marginBottom: '4px' }}>
                            Achou a correção da redação útil?
                        </h3>
                        <p style={{ fontSize: '12px', color: '#94a3b8' }}>
                            Sua resposta nos ajuda a melhorar!
                        </p>
                    </div>

                    {/* Feedback Buttons */}
                    <div style={{ display: 'flex', gap: '12px' }}>
                        <button
                            onClick={() => handleFeedback(true)}
                            style={{
                                flex: 1,
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '12px',
                                padding: '12px 16px',
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                            onMouseOver={(e) => {
                                e.currentTarget.style.background = '#10b981';
                                e.currentTarget.style.borderColor = '#10b981';
                            }}
                            onMouseOut={(e) => {
                                e.currentTarget.style.background = '#0f1419';
                                e.currentTarget.style.borderColor = '#334155';
                            }}
                        >
                            <span style={{ fontSize: '24px' }}>👍</span>
                        </button>
                        <button
                            onClick={() => handleFeedback(false)}
                            style={{
                                flex: 1,
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '12px',
                                padding: '12px 16px',
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                            onMouseOver={(e) => {
                                e.currentTarget.style.background = '#ef4444';
                                e.currentTarget.style.borderColor = '#ef4444';
                            }}
                            onMouseOut={(e) => {
                                e.currentTarget.style.background = '#0f1419';
                                e.currentTarget.style.borderColor = '#334155';
                            }}
                        >
                            <span style={{ fontSize: '24px' }}>👎</span>
                        </button>
                    </div>
                </>
            ) : (
                /* Thank You Message */
                <div style={{ textAlign: 'center', padding: '24px 0' }}>
                    <div style={{ fontSize: '48px', marginBottom: '12px' }}>
                        {feedback ? '🎉' : '📝'}
                    </div>
                    <h3 style={{ fontSize: '16px', fontWeight: '700', color: 'white', marginBottom: '4px' }}>
                        {feedback ? 'Obrigado!' : 'Obrigado pelo feedback!'}
                    </h3>
                    <p style={{ fontSize: '12px', color: '#94a3b8' }}>
                        {feedback
                            ? 'Ficamos felizes em ajudar!'
                            : 'Vamos trabalhar para melhorar!'}
                    </p>
                </div>
            )}
        </div>
    );
};

export default FeedbackPopup;
