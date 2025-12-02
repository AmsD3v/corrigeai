import React from 'react';

interface KPICardProps {
    title: string;
    value: string | number;
    icon: string;
    subtitle?: string;
}

const KPICard: React.FC<KPICardProps> = ({ title, value, icon, subtitle }) => {
    return (
        <div style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '12px',
            padding: '24px',
            display: 'flex',
            flexDirection: 'column',
            gap: '8px'
        }}>
            <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '12px'
            }}>
                <span style={{ fontSize: '32px' }}>{icon}</span>
                <div style={{ flex: 1 }}>
                    <div style={{
                        fontSize: '14px',
                        color: '#94a3b8',
                        fontWeight: '500'
                    }}>
                        {title}
                    </div>
                    <div style={{
                        fontSize: '32px',
                        fontWeight: '700',
                        color: '#fff',
                        marginTop: '4px'
                    }}>
                        {value}
                    </div>
                    {subtitle && (
                        <div style={{
                            fontSize: '12px',
                            color: '#64748b',
                            marginTop: '4px'
                        }}>
                            {subtitle}
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default KPICard;
