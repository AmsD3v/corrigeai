import { useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';

interface HeaderProps {
    variant?: 'landing' | 'auth'; // landing = menu completo, auth = apenas logo + botão
}

const Header = ({ variant = 'landing' }: HeaderProps) => {
    const navigate = useNavigate();
    const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
    const [isMobile, setIsMobile] = useState(window.innerWidth <= 768);

    useEffect(() => {
        const handleResize = () => {
            setIsMobile(window.innerWidth <= 768);
        };

        window.addEventListener('resize', handleResize);
        return () => window.removeEventListener('resize', handleResize);
    }, []);

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
          display: block;
        }

        @media (max-width: 768px) {
          .desktop-only-btn {
            display: none !important;
          }

          .mobile-menu-btn {
            display: block !important;
          }

          .nav-links {
            display: flex !important;
            position: fixed;
            top: 0;
            right: 0;
            bottom: 0;
            width: 100%;
            background: rgba(0, 0, 0, 0.9);
            backdrop-filter: blur(10px);
            flex-direction: column;
            padding: 80px 24px 24px;
            gap: 20px;
            z-index: 999;
            transform: translateX(100%);
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
          }

          .nav-links.open {
            transform: translateX(0);
          }
        }
      `}</style>

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
                    gridTemplateColumns: variant === 'auth' ? '1fr auto' : '1fr auto 1fr',
                    alignItems: 'center',
                    gap: '20px'
                }}>
                    {/* Logo */}
                    <div
                        onClick={() => navigate('/')}
                        className="flex items-center gap-3 cursor-pointer group"
                        style={{ display: 'flex', alignItems: 'center', gap: '12px', cursor: 'pointer' }}
                    >
                        <div style={{
                            width: '40px',
                            height: '40px',
                            background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                            borderRadius: '12px',
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'center',
                            fontSize: '24px',
                            flexShrink: 0
                        }}>
                            🦉
                        </div>
                        <span style={{
                            fontSize: '24px',
                            fontWeight: '800',
                            color: '#fff',
                            letterSpacing: '-0.5px',
                            whiteSpace: 'nowrap'
                        }}>
                            Corrige<span style={{ color: '#818cf8' }}>AI</span>
                        </span>
                    </div>

                    {variant === 'landing' && (
                        <>
                            {/* Mobile Menu Button */}
                            <button
                                className="mobile-menu-btn"
                                onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
                                style={{ zIndex: 1002, position: 'relative', paddingRight: '27px', gridColumn: '3', justifySelf: 'end' }}
                            >
                                {mobileMenuOpen ? '✕' : '☰'}
                            </button>

                            {/* Nav Links - Centered */}
                            <nav className={`nav-links ${mobileMenuOpen ? 'open' : ''}`} style={{
                                gridColumn: '2',
                                justifySelf: 'center'
                            }}>
                                <a href="#como-funciona" onClick={() => setMobileMenuOpen(false)}>Como funciona</a>
                                <a href="#correcao" onClick={() => setMobileMenuOpen(false)}>Correção</a>
                                <a href="#objetivos" onClick={() => setMobileMenuOpen(false)}>Objetivos</a>
                                <a href="#relatos" onClick={() => setMobileMenuOpen(false)}>Relatos</a>
                                <a href="#precos" onClick={() => setMobileMenuOpen(false)}>Preços</a>
                                <button
                                    onClick={() => navigate('/login')}
                                    style={{
                                        background: 'transparent',
                                        border: 'none',
                                        color: '#fff',
                                        fontSize: '14px',
                                        fontWeight: '600',
                                        cursor: 'pointer',
                                        padding: '8px 16px'
                                    }}
                                >
                                    Entrar
                                </button>
                            </nav>

                            {/* CTA Button - Right (Desktop only) */}
                            <button
                                className="desktop-only-btn"
                                onClick={() => navigate('/register')}
                                style={{
                                    gridColumn: '3',
                                    justifySelf: 'end',
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
                        </>
                    )}

                    {variant === 'auth' && (
                        <button
                            onClick={() => navigate('/')}
                            style={{
                                background: 'transparent',
                                border: '1px solid #4F46E5',
                                color: '#fff',
                                fontSize: '14px',
                                fontWeight: '600',
                                padding: '8px 20px',
                                borderRadius: '8px',
                                cursor: 'pointer',
                                whiteSpace: 'nowrap'
                            }}
                        >
                            Voltar ao início
                        </button>
                    )}
                </div>
            </header>
        </>
    );
};

export default Header;
