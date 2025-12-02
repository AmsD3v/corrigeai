import React from 'react';

interface ToggleSwitchProps {
    enabled: boolean;
    onChange: (enabled: boolean) => void;
    label?: string;
}

/**
 * Toggle Switch Component
 * Modern on/off switch with smooth animation
 */
const ToggleSwitch: React.FC<ToggleSwitchProps> = ({ enabled, onChange, label }) => {
    return (
        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
            {label && (
                <span style={{
                    fontSize: '14px',
                    color: enabled ? '#4ade80' : '#64748b',
                    fontWeight: '600'
                }}>
                    {label}
                </span>
            )}
            <button
                onClick={() => onChange(!enabled)}
                style={{
                    position: 'relative',
                    width: '48px',
                    height: '24px',
                    background: enabled ? '#4ade80' : '#334155',
                    border: 'none',
                    borderRadius: '12px',
                    cursor: 'pointer',
                    transition: 'background 0.3s',
                    padding: 0
                }}
            >
                <div style={{
                    position: 'absolute',
                    top: '2px',
                    left: enabled ? '26px' : '2px',
                    width: '20px',
                    height: '20px',
                    background: '#fff',
                    borderRadius: '50%',
                    transition: 'left 0.3s',
                    boxShadow: '0 2px 4px rgba(0,0,0,0.2)'
                }} />
            </button>
        </div>
    );
};

export default ToggleSwitch;
