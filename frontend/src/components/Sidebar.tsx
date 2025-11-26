import { Link } from 'react-router-dom';
import { useState } from 'react';

interface SidebarProps {
    activePage: string;
}

const Sidebar = ({ activePage }: SidebarProps) => {
    const [isOpen, setIsOpen] = useState(false);

    const menuItems = [
        { path: '/painel', icon: '🏠', label: 'Página Inicial' },
        { path: '/painel/minhas-redacoes', icon: '📄', label: 'Minhas Redações' },
        { path: '/painel/redigir-redacao', icon: '✍️', label: 'Redigir Redação' },
        { path: '/painel/desenvolvimento', icon: '📊', label: 'Meu Desenvolvimento' },
        { path: '/painel/comprar-creditos', icon: '💰', label: 'Comprar CorriCoins' },
        { path: '/painel/transacoes', icon: '🛒', label: 'Minhas Compras' },
        { path: '/painel/configuracoes', icon: '⚙️', label: 'Configurações' },
        { path: '/painel/feedback', icon: '💬', label: 'Feedback' }
    ];

    return (
        <>
            {/* Mobile Menu Button */}
            <button
                onClick={() => setIsOpen(!isOpen)}
                style={{
                    position: 'fixed',
                    top: '16px',
                    left: '16px',
                    zIndex: 1001,
                    display: 'none',
                    padding: '12px',
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '8px',
                    color: '#fff',
                    cursor: 'pointer',
                    fontSize: '20px'
                }}
                className="mobile-menu-btn"
            >
                {isOpen ? '✕' : '☰'}
            </button>

            {/* Overlay for mobile */}
            {isOpen && (
                <div
                    onClick={() => setIsOpen(false)}
                    style={{
                        position: 'fixed',
                        inset: 0,
                        background: 'rgba(0, 0, 0, 0.5)',
                        zIndex: 999,
                        display: 'none'
                    }}
                    className="mobile-overlay"
                />
            )}

            {/* Sidebar */}
            <div
                style={{
                    width: '280px',
                    background: '#1a1f2e',
                    borderRight: '1px solid #334155',
                    display: 'flex',
                    flexDirection: 'column',
                    position: 'fixed',
                    top: '64px',
                    left: 0,
                    bottom: 0,
                    zIndex: 999,
                    transition: 'transform 0.3s ease'
                }}
                className={`sidebar ${isOpen ? 'sidebar-open' : ''}`}
            >
                {/* Menu */}
                <nav style={{ marginTop: '24px', flex: 1, overflowY: 'auto', padding: '0 12px' }}>
                    {menuItems.map((item) => {
                        const isActive = activePage === item.path;
                        return (
                            <Link
                                key={item.path}
                                to={item.path}
                                onClick={() => setIsOpen(false)}
                                style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '12px',
                                    padding: '12px 24px',
                                    color: isActive ? '#fff' : '#94a3b8',
                                    textDecoration: 'none',
                                    fontSize: '14px',
                                    fontWeight: '500',
                                    background: isActive ? '#334155' : 'transparent',
                                    borderLeft: isActive ? '3px solid #4F46E5' : '3px solid transparent',
                                    transition: 'all 0.2s'
                                }}
                                onMouseEnter={(e) => {
                                    if (!isActive) {
                                        e.currentTarget.style.background = '#334155';
                                        e.currentTarget.style.color = '#fff';
                                    }
                                }}
                                onMouseLeave={(e) => {
                                    if (!isActive) {
                                        e.currentTarget.style.background = 'transparent';
                                        e.currentTarget.style.color = '#94a3b8';
                                    }
                                }}
                            >
                                <span>{item.icon}</span>
                                {item.label}
                            </Link>
                        );
                    })}
                </nav>

                {/* Footer */}
                <div style={{
                    padding: '24px',
                    borderTop: '1px solid #334155',
                    fontSize: '12px',
                    color: '#64748b',
                    textAlign: 'center'
                }}>
                    © 2025 RedaAI
                </div>
            </div>

            {/* Responsive Styles */}
            <style>{`
        @media (max-width: 768px) {
          .mobile-menu-btn {
            display: block !important;
          }
          
          .mobile-overlay {
            display: block !important;
          }
          
          .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            transform: translateX(-100%);
          }
          
          .sidebar-open {
            transform: translateX(0);
          }
        }
      `}</style>
        </>
    );
};

export default Sidebar;
