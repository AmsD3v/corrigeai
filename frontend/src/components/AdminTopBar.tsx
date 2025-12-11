import { useNavigate } from 'react-router-dom';

const AdminTopBar = () => {
    const navigate = useNavigate();

    return (
        <div style={{
            position: 'fixed',
            top: 0,
            left: 0,
            right: 0,
            height: '64px',
            background: '#1a1f2e',
            borderBottom: '1px solid #334155',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            padding: '0 32px',
            zIndex: 50
        }}>
            {/* Logo */}
            <div
                onClick={() => navigate('/admin')}
                style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '12px',
                    cursor: 'pointer'
                }}
            >
                <div style={{
                    width: '36px',
                    height: '36px',
                    borderRadius: '8px',
                    overflow: 'hidden'
                }}>
                    <img src="/owl_custom.png" alt="Logo" style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                </div>
                <div>
                    <div style={{
                        fontSize: '20px',
                        fontWeight: '800',
                        color: '#fff'
                    }}>
                        CorrigeAI
                    </div>
                    <div style={{
                        fontSize: '11px',
                        fontWeight: '600',
                        color: '#ef4444',
                        letterSpacing: '1px'
                    }}>
                        ADMIN PANEL
                    </div>
                </div>
            </div>

            {/* Admin Info */}
            <div style={{
                display: 'flex',
                alignItems: 'center',
                gap: '16px'
            }}>
                <div style={{
                    padding: '8px 16px',
                    background: 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)',
                    borderRadius: '20px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '8px'
                }}>
                    <span style={{ fontSize: '16px' }}>👑</span>
                    <span style={{
                        fontSize: '13px',
                        fontWeight: '600',
                        color: '#fff'
                    }}>
                        Administrador
                    </span>
                </div>
            </div>
        </div>
    );
};

export default AdminTopBar;
