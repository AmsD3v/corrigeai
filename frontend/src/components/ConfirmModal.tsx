interface ConfirmModalProps {
    isOpen: boolean;
    title: string;
    message: string;
    confirmText?: string;
    cancelText?: string;
    onConfirm: () => void;
    onCancel: () => void;
    variant?: 'danger' | 'warning' | 'info';
}

const ConfirmModal = ({
    isOpen,
    title,
    message,
    confirmText = 'Confirmar',
    cancelText = 'Cancelar',
    onConfirm,
    onCancel,
    variant = 'warning'
}: ConfirmModalProps) => {
    if (!isOpen) return null;

    const variants = {
        danger: {
            icon: '🗑️',
            color: '#ef4444',
            bgColor: '#ef444420'
        },
        warning: {
            icon: '⚠️',
            color: '#f59e0b',
            bgColor: '#f59e0b20'
        },
        info: {
            icon: 'ℹ️',
            color: '#3b82f6',
            bgColor: '#3b82f620'
        }
    };

    const currentVariant = variants[variant];

    return (
        <div
            style={{
                position: 'fixed',
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                background: 'rgba(0, 0, 0, 0.75)',
                backdropFilter: 'blur(4px)',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                zIndex: 9999,
                animation: 'fadeIn 0.2s ease-out'
            }}
            onClick={onCancel}
        >
            <div
                style={{
                    background: 'linear-gradient(135deg, #1a1f2e 0%, #0f1419 100%)',
                    border: `1px solid ${currentVariant.color}`,
                    borderRadius: '16px',
                    padding: '32px',
                    maxWidth: '480px',
                    width: '90%',
                    boxShadow: `0 20px 60px rgba(0, 0, 0, 0.5), 0 0 0 1px ${currentVariant.color}30`,
                    animation: 'slideUp 0.3s ease-out'
                }}
                onClick={(e) => e.stopPropagation()}
            >
                {/* Icon */}
                <div
                    style={{
                        width: '64px',
                        height: '64px',
                        background: currentVariant.bgColor,
                        border: `2px solid ${currentVariant.color}`,
                        borderRadius: '50%',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        fontSize: '32px',
                        margin: '0 auto 24px'
                    }}
                >
                    {currentVariant.icon}
                </div>

                {/* Title */}
                <h2
                    style={{
                        fontSize: '24px',
                        fontWeight: '700',
                        color: '#fff',
                        marginBottom: '12px',
                        textAlign: 'center'
                    }}
                >
                    {title}
                </h2>

                {/* Message */}
                <p
                    style={{
                        fontSize: '15px',
                        color: '#94a3b8',
                        marginBottom: '32px',
                        textAlign: 'center',
                        lineHeight: '1.6'
                    }}
                >
                    {message}
                </p>

                {/* Buttons */}
                <div
                    style={{
                        display: 'flex',
                        gap: '12px',
                        justifyContent: 'center'
                    }}
                >
                    <button
                        onClick={onCancel}
                        style={{
                            flex: 1,
                            padding: '14px 24px',
                            background: '#334155',
                            border: '1px solid #475569',
                            borderRadius: '10px',
                            color: '#fff',
                            fontSize: '15px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.background = '#475569';
                            e.currentTarget.style.transform = 'translateY(-2px)';
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.background = '#334155';
                            e.currentTarget.style.transform = 'translateY(0)';
                        }}
                    >
                        {cancelText}
                    </button>

                    <button
                        onClick={onConfirm}
                        style={{
                            flex: 1,
                            padding: '14px 24px',
                            background: currentVariant.color,
                            border: 'none',
                            borderRadius: '10px',
                            color: '#fff',
                            fontSize: '15px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s',
                            boxShadow: `0 4px 12px ${currentVariant.color}40`
                        }}
                        onMouseEnter={(e) => {
                            e.currentTarget.style.transform = 'translateY(-2px)';
                            e.currentTarget.style.boxShadow = `0 6px 20px ${currentVariant.color}60`;
                        }}
                        onMouseLeave={(e) => {
                            e.currentTarget.style.transform = 'translateY(0)';
                            e.currentTarget.style.boxShadow = `0 4px 12px ${currentVariant.color}40`;
                        }}
                    >
                        {confirmText}
                    </button>
                </div>
            </div>

            <style>{`
                @keyframes fadeIn {
                    from { opacity: 0; }
                    to { opacity: 1; }
                }
                
                @keyframes slideUp {
                    from {
                        opacity: 0;
                        transform: translateY(20px) scale(0.95);
                    }
                    to {
                        opacity: 1;
                        transform: translateY(0) scale(1);
                    }
                }
            `}</style>
        </div>
    );
};

export default ConfirmModal;
