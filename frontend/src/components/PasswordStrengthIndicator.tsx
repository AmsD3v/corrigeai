import React from 'react';

interface PasswordStrengthIndicatorProps {
    password: string;
}

const PasswordStrengthIndicator: React.FC<PasswordStrengthIndicatorProps> = ({ password }) => {
    // Check individual requirements
    const hasMinLength = password.length >= 8;
    const hasUpperCase = /[A-Z]/.test(password);
    const hasLowerCase = /[a-z]/.test(password);
    const hasNumber = /\d/.test(password);
    const hasSpecialChar = /[!@#$%^&*(),.?":{}|<>]/.test(password);

    // Calculate strength
    const requirementsMet = [
        hasMinLength,
        hasUpperCase,
        hasLowerCase,
        hasNumber,
        hasSpecialChar
    ].filter(Boolean).length;

    const getStrength = () => {
        if (requirementsMet === 0) return { label: '', color: '', width: '0%' };
        if (requirementsMet <= 2) return { label: 'Muito fraca', color: '#ef4444', width: '25%' };
        if (requirementsMet === 3) return { label: 'Fraca', color: '#f59e0b', width: '50%' };
        if (requirementsMet === 4) return { label: 'Média', color: '#eab308', width: '75%' };
        return { label: 'Forte', color: '#10b981', width: '100%' };
    };

    const strength = getStrength();

    const Indicator = ({ met, label }: { met: boolean; label: string }) => (
        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: '13px' }}>
            <div style={{
                width: '6px',
                height: '6px',
                borderRadius: '50%',
                background: met ? '#10b981' : '#64748b'
            }} />
            <span style={{ color: met ? '#10b981' : '#64748b' }}>{label}</span>
        </div>
    );

    if (!password) return null;

    return (
        <div style={{ marginTop: '12px' }}>
            {/* Strength Bar */}
            <div style={{ marginBottom: '12px' }}>
                <div style={{
                    width: '100%',
                    height: '4px',
                    background: '#334155',
                    borderRadius: '2px',
                    overflow: 'hidden'
                }}>
                    <div style={{
                        width: strength.width,
                        height: '100%',
                        background: strength.color,
                        transition: 'all 0.3s ease'
                    }} />
                </div>
                {strength.label && (
                    <div style={{
                        display: 'flex',
                        justifyContent: 'space-between',
                        alignItems: 'center',
                        marginTop: '8px'
                    }}>
                        <span style={{ fontSize: '12px', fontWeight: '600', color: strength.color }}>
                            Força: {strength.label}
                        </span>
                    </div>
                )}
            </div>

            {/* Requirements List */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: '1fr 1fr',
                gap: '8px',
                marginTop: '12px'
            }}>
                <Indicator met={hasMinLength} label="Mín. 8 caracteres" />
                <Indicator met={hasUpperCase} label="1 letra maiúscula" />
                <Indicator met={hasNumber} label="1 número" />
                <Indicator met={hasSpecialChar} label="1 caractere especial" />
            </div>
        </div>
    );
};

export default PasswordStrengthIndicator;
