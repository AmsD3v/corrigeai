import { useNavigate } from 'react-router-dom';
import { useState } from 'react';

const Header = () => {
    const navigate = useNavigate();
    const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

    return (
        <>
            <style>{`
        .mobile-menu-btn {
          display: none;
          background: transparent;
          border: none;
          color: white;
          font-size: 24px;
          cursor: pointer;
        }

        .nav-links {
          display: flex;
          gap: 20px;
          align-items: center;
          flex-wrap: nowrap;
        }

        .nav-links a {
          white-space: nowrap;
          font-size: 14px;
          color: #94a3b8;
          text-decoration: none;
          font-weight: 500;
        }

        .desktop-only-btn {
          display: flex;
        }

        .mobile-only {
          display: none;
        }

        @media (max-width: 768px) {
          .desktop-only-btn {
            display: none !important;
          }

          .mobile-only {
            display: flex !important;
          }

          .mobile-menu-btn {
            display: block !important;
          }

          .nav-links {
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 100vh;
            background: rgba(10, 15, 30, 0.98);
            backdrop-filter: blur(12px);
            display: flex !important;
            flex-direction: column;
            padding: 100px 32px 32px;
            gap: 28px;
            z-index: 1000;
            transform: translateX(100%);
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow-y: auto;
          }

          .nav-links a {
            font-size: 18px !important;
            color: #fff !important;
            padding: 16px 20px;
            background: rgba(79, 70, 229, 0.1);
            border-radius: 12px;
            border: 1px solid rgba(79, 70, 229, 0.2);
            transition: all 0.2s ease;
          }

          .nav-links a:hover {
            background: rgba(79, 70, 229, 0.2);
            transform: translateX(4px);
          }

          .nav-links.open {
            transform: translateX(0);
          }
        }
      `}</style>

            {/* Mobile Menu Backdrop */}
            <div
                style={{
                    position: 'fixed',
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    zIndex: 999,
                    background: 'rgba(0, 0, 0, 0.6)',
                    backdropFilter: 'blur(6px)',
                    opacity: mobileMenuOpen ? 1 : 0,
                    pointerEvents: mobileMenuOpen ? 'auto' : 'none',
                    transition: 'opacity 0.3s ease',
                    display: mobileMenuOpen ? 'block' : 'none'
                }}
                onClick={() => setMobileMenuOpen(false)}
            />

            {/* HEADER */}
            <header style={{
                position: 'fixed',
                top: 0,
                left: 0,
                right: 0,
                width: '100%',
                backdropFilter: 'blur(10px)',
                backgroundColor: 'rgba(26, 31, 46, 0.8)',
                zIndex: 1000,
                borderBottom: '1px solid rgba(255,255,255,0.1)'
            }}>
                <div style={{
                    maxWidth: '100%',
                    margin: '0 auto',
                    padding: '0 24px',
                    height: '70px',
                    display: 'grid',
                    gridTemplateColumns: '1fr auto 1fr',
                    alignItems: 'center',
                    gap: '20px'
                }}>
                    {/* Logo - Left */}
                    <div
                        onClick={() => navigate('/')}
                        className="flex items-center gap-3 cursor-pointer group"
                    >
                        <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-brand-primary to-brand-secondary flex items-center justify-center shadow-lg group-hover:shadow-brand-primary/50 transition-all duration-300">
                            <span className="text-2xl">🦉</span>
                        </div>
                        <span className="text-xl md:text-2xl font-bold text-white tracking-tight">
                            Corrige<span className="text-brand-accent">AI</span>
                        </span>
                    </div>

                    {/* Mobile Menu Button */}
                    <button
                        className="mobile-menu-btn"
                        onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
                        style={{ zIndex: 1001, position: 'relative', paddingRight: '27px', gridColumn: '3', justifySelf: 'end' }}
                    >
                        {mobileMenuOpen ? '✕' : '☰'}
                    </button>

                    {/* Nav Links - Centered */}
                    <nav className={`nav-links ${mobileMenuOpen ? 'open' : ''}`} style={{
                        gridColumn: '2',
                        justifySelf: 'center'
                    }}>
                        <div style={{
                            display: 'flex',
                            flexDirection: 'row',
                            alignItems: 'center',
                            gap: '12px',
                            marginBottom: '32px',
                            paddingBottom: '24px',
                            borderBottom: '1px solid rgba(255,255,255,0.1)',
                            justifyContent: 'center',
                            width: '100%'
                        }} className="mobile-only">
                        </div>

                        <a href="/#como-funciona" style={{ color: '#94a3b8', textDecoration: 'none', fontSize: '14px', fontWeight: '500' }} onClick={() => setMobileMenuOpen(false)}>Como funciona</a>
                        <a href="/#correcao" style={{ color: '#94a3b8', textDecoration: 'none', fontSize: '14px', fontWeight: '500' }} onClick={() => setMobileMenuOpen(false)}>Correção</a>
                        <a href="/#objetivos" style={{ color: '#94a3b8', textDecoration: 'none', fontSize: '14px', fontWeight: '500' }} onClick={() => setMobileMenuOpen(false)}>Objetivos</a>
                        <a href="/#relatos" style={{ color: '#94a3b8', textDecoration: 'none', fontSize: '14px', fontWeight: '500' }} onClick={() => setMobileMenuOpen(false)}>Relatos</a>
                        <a href="/#precos" style={{ color: '#94a3b8', textDecoration: 'none', fontSize: '14px', fontWeight: '500' }} onClick={() => setMobileMenuOpen(false)}>Preços</a>
                    </nav>

                    {/* Right Buttons - Desktop */}
                    <div style={{
                        gridColumn: '3',
                        justifySelf: 'end',
                        display: 'flex',
                        gap: '12px',
                        alignItems: 'center'
                    }} className="desktop-only-btn">
                        <button
                            onClick={() => navigate('/login')}
                            style={{
                                background: 'transparent',
                                border: '1px solid rgba(255,255,255,0.2)',
                                color: '#fff',
                                fontSize: '14px',
                                fontWeight: '600',
                                padding: '10px 24px',
                                borderRadius: '8px',
                                cursor: 'pointer',
                                whiteSpace: 'nowrap',
                                transition: 'all 0.2s ease'
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.background = 'rgba(255,255,255,0.1)';
                                e.currentTarget.style.borderColor = 'rgba(255,255,255,0.3)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.background = 'transparent';
                                e.currentTarget.style.borderColor = 'rgba(255,255,255,0.2)';
                            }}
                        >
                            Entrar
                        </button>
                        <button
                            onClick={() => navigate('/register')}
                            style={{
                                background: '#4F46E5',
                                border: 'none',
                                color: '#fff',
                                fontSize: '14px',
                                fontWeight: '600',
                                padding: '10px 30px',
                                borderRadius: '8px',
                                cursor: 'pointer',
                                whiteSpace: 'nowrap'
                            }}
                        >
                            Começar correção grátis
                        </button>
                    </div>
                </div>
            </header>
        </>
    );
};

export default Header;
