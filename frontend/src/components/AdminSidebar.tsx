import { ReactNode } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

interface AdminSidebarProps {
    activePage: string;
}

const AdminSidebar = ({ activePage }: AdminSidebarProps) => {
    const navigate = useNavigate();
    const { logout } = useAuth();

    const menuItems = [
        { path: '/admin', label: 'Dashboard', icon: '📊' },
        { path: '/admin/usuarios', label: 'Usuários', icon: '👥' },
        { path: '/admin/redacoes', label: 'Redações', icon: '📝' },
        { path: '/admin/transacoes', label: 'Transações', icon: '💰' },
        { path: '/admin/dropdown-options', label: 'Opções Dropdown', icon: '📋' },
        { path: '/admin/configuracoes', label: 'Configurações', icon: '⚙️' },
        { path: '/admin/analytics', label: 'Analytics', icon: '📈' },
        { path: '/admin/feedback-stats', label: 'Feedback Stats', icon: '💬' },
    ];

    const handleLogout = () => {
        logout();
        localStorage.removeItem('isAdmin');
        navigate('/login');
    };

    return (
        <div style={{
            position: 'fixed',
            top: '64px',
            left: 0,
            bottom: 0,
            width: '280px',
            background: '#1a1f2e',
            borderRight: '1px solid #334155',
            display: 'flex',
            flexDirection: 'column',
            zIndex: 40
        }}>
            {/* Admin Badge */}
            <div style={{
                padding: '20px',
                borderBottom: '1px solid #334155'
            }}>
                <div style={{
                    background: 'linear-gradient(135deg, #ef4444 0%, #dc2626 100%)',
                    padding: '12px 16px',
                    borderRadius: '8px',
                    textAlign: 'center'
                }}>
                    <div style={{
                        fontSize: '20px',
                        marginBottom: '4px'
                    }}>
                        👑
                    </div>
                    <div style={{
                        fontSize: '14px',
                        fontWeight: '700',
                        color: '#fff'
                    }}>
                        PAINEL ADMIN
                    </div>
                </div>
            </div>

            {/* Menu Items */}
            <nav style={{
                flex: 1,
                overflowY: 'auto',
                padding: '16px 0'
            }}>
                {menuItems.map((item) => (
                    <button
                        key={item.path}
                        onClick={() => navigate(item.path)}
                        style={{
                            width: '100%',
                            padding: '14px 20px',
                            background: activePage === item.path ? '#334155' : 'transparent',
                            border: 'none',
                            borderLeft: activePage === item.path ? '3px solid #ef4444' : '3px solid transparent',
                            color: activePage === item.path ? '#fff' : '#94a3b8',
                            fontSize: '15px',
                            fontWeight: activePage === item.path ? '600' : '500',
                            cursor: 'pointer',
                            transition: 'all 0.2s',
                            display: 'flex',
                            alignItems: 'center',
                            gap: '12px',
                            textAlign: 'left'
                        }}
                        onMouseEnter={(e) => {
                            if (activePage !== item.path) {
                                e.currentTarget.style.background = '#1e293b';
                                e.currentTarget.style.color = '#fff';
                            }
                        }}
                        onMouseLeave={(e) => {
                            if (activePage !== item.path) {
                                e.currentTarget.style.background = 'transparent';
                                e.currentTarget.style.color = '#94a3b8';
                            }
                        }}
                    >
                        <span style={{ fontSize: '20px' }}>{item.icon}</span>
                        <span>{item.label}</span>
                    </button>
                ))}
            </nav>

            {/* Back to User Panel */}
            <div style={{
                padding: '16px',
                borderTop: '1px solid #334155'
            }}>
                <button
                    onClick={() => navigate('/painel')}
                    style={{
                        width: '100%',
                        padding: '12px',
                        background: '#334155',
                        border: 'none',
                        borderRadius: '8px',
                        color: '#fff',
                        fontSize: '14px',
                        fontWeight: '600',
                        cursor: 'pointer',
                        marginBottom: '8px',
                        transition: 'all 0.2s'
                    }}
                    onMouseEnter={(e) => {
                        e.currentTarget.style.background = '#475569';
                    }}
                    onMouseLeave={(e) => {
                        e.currentTarget.style.background = '#334155';
                    }}
                >
                    ← Voltar ao Painel
                </button>
                <button
                    onClick={handleLogout}
                    style={{
                        width: '100%',
                        padding: '12px',
                        background: 'transparent',
                        border: '1px solid #ef4444',
                        borderRadius: '8px',
                        color: '#ef4444',
                        fontSize: '14px',
                        fontWeight: '600',
                        cursor: 'pointer',
                        transition: 'all 0.2s'
                    }}
                    onMouseEnter={(e) => {
                        e.currentTarget.style.background = '#ef4444';
                        e.currentTarget.style.color = '#fff';
                    }}
                    onMouseLeave={(e) => {
                        e.currentTarget.style.background = 'transparent';
                        e.currentTarget.style.color = '#ef4444';
                    }}
                >
                    Sair
                </button>
            </div>
        </div>
    );
};

export default AdminSidebar;
