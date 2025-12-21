import { useNavigate } from 'react-router-dom';
import { useState } from 'react';
import { useAuth } from '../contexts/AuthContext';

const Header = () => {
    const navigate = useNavigate();
    const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
    const { user, logout, isLoading } = useAuth();

    const scrollToSection = (id: string) => {
        const el = document.getElementById(id);
        if (el) {
            const y = el.getBoundingClientRect().top + window.scrollY - 80;
            window.scrollTo({ top: y, behavior: 'smooth' });
        }
        setMobileMenuOpen(false);
    };

    return (
        <>
            {/* Backdrop com fade in/out */}
            {mobileMenuOpen && (
                <div
                    onClick={() => setMobileMenuOpen(false)}
                    style={{
                        position: 'fixed',
                        inset: 0,
                        background: 'rgba(15, 23, 42, 0.7)',
                        backdropFilter: 'blur(8px)',
                        zIndex: 999,
                        animation: 'fadeIn 0.3s ease-out',
                    }}
                />
            )}

            {/* Header */}
            <header
                style={{
                    position: 'fixed',
                    top: 0,
                    left: 0,
                    right: 0,
                    zIndex: mobileMenuOpen ? 1002 : 1000,
                    borderBottom: '1px solid rgba(148, 163, 184, 0.12)',
                    background: 'rgba(15, 23, 42, 0.9)',
                    backdropFilter: 'blur(18px)',
                }}
            >
                <div
                    style={{
                        maxWidth: 1200,
                        margin: '0 auto',
                        padding: '14px 20px',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'space-between',
                    }}
                >
                    {/* ESQUERDA: Logo */}
                    <button
                        onClick={() => {
                            navigate('/');
                            setMobileMenuOpen(false);
                            window.scrollTo({ top: 0, behavior: 'smooth' });
                        }}
                        style={{
                            display: 'inline-flex',
                            flexDirection: 'row',
                            alignItems: 'center',
                            gap: 12,
                            cursor: 'pointer',
                            background: 'transparent',
                            border: 'none',
                            padding: 0,
                        }}
                    >
                        {/* Ícone */}
                        <div
                            style={{
                                width: 36,
                                height: 36,
                                minWidth: 36,
                                flexShrink: 0,
                                borderRadius: 10,
                                background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                overflow: 'hidden',
                            }}
                        >
                            <img src="/owl_custom.webp" alt="Logo" width={24} height={24} style={{ objectFit: 'contain' }} />
                        </div>
                        {/* Texto */}
                        <span
                            style={{
                                color: '#ffffff',
                                fontWeight: 700,
                                fontSize: 19,
                                whiteSpace: 'nowrap',
                                display: 'inline-block',
                            }}
                        >
                            CorrigeAI
                        </span>
                    </button>

                    {/* CENTRO: Nav Desktop (apenas links) */}
                    <nav
                        className="nav-links-desktop"
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: 28,
                            position: 'absolute',
                            left: '45%',
                            transform: 'translateX(-50%)',
                        }}
                    >
                        <button onClick={() => scrollToSection('como-funciona')} style={navItemStyle}>
                            Como funciona
                        </button>
                        <button onClick={() => scrollToSection('correcao')} style={navItemStyle}>
                            Correção Enem
                        </button>
                        <button onClick={() => scrollToSection('objetivos')} style={navItemStyle}>
                            Objetivos
                        </button>
                        <button onClick={() => scrollToSection('relatos')} style={navItemStyle}>
                            Relatos
                        </button>
                        <button onClick={() => scrollToSection('precos')} style={navItemStyle}>
                            Preços
                        </button>
                    </nav>

                    {/* DIREITA: Botões Desktop */}
                    <div
                        className="desktop-buttons"
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: 12,
                        }}
                    >
                        {!isLoading && user ? (
                            <>
                                <span style={{ color: '#94a3b8', fontSize: 14 }}>
                                    Olá, {user.full_name?.split(' ')[0] || 'Usuário'}
                                </span>
                                <button
                                    onClick={() => navigate('/painel')}
                                    style={{
                                        background: '#4F46E5',
                                        border: 'none',
                                        borderRadius: 999,
                                        padding: '8px 20px',
                                        color: '#fff',
                                        fontSize: 14,
                                        fontWeight: 600,
                                        cursor: 'pointer',
                                        transition: 'all 0.2s ease',
                                    }}
                                >
                                    Meu Painel
                                </button>
                            </>
                        ) : (
                            <>
                                <button
                                    onClick={() => navigate('/login')}
                                    style={{
                                        background: 'transparent',
                                        border: '1px solid #4b5563',
                                        borderRadius: 999,
                                        padding: '8px 16px',
                                        color: '#e5e7eb',
                                        fontSize: 14,
                                        cursor: 'pointer',
                                        transition: 'all 0.2s ease',
                                    }}
                                >
                                    Entrar
                                </button>
                                <button
                                    onClick={() => navigate('/cadastro')}
                                    style={{
                                        background: '#4F46E5',
                                        border: 'none',
                                        borderRadius: 999,
                                        padding: '8px 20px',
                                        color: '#fff',
                                        fontSize: 14,
                                        fontWeight: 600,
                                        cursor: 'pointer',
                                        transition: 'all 0.2s ease',
                                    }}
                                >
                                    Começar correção grátis
                                </button>
                            </>
                        )}
                    </div>

                    {/* DIREITA: Hambúrguer com rotação */}
                    <button
                        className="mobile-menu-btn"
                        onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
                        style={{
                            background: 'transparent',
                            border: 'none',
                            color: '#ffffff',
                            fontSize: 28,
                            cursor: 'pointer',
                            padding: '8px 30px',
                            marginRight: 0,
                            display: 'none',
                            transition: 'transform 0.3s ease',
                            transform: mobileMenuOpen ? 'rotate(90deg)' : 'rotate(0deg)',
                        }}
                    >
                        {mobileMenuOpen ? '✕' : '☰'}
                    </button>
                </div>

                {/* Menu Mobile com slide in/out */}
                {mobileMenuOpen && (
                    <div
                        style={{
                            position: 'fixed',
                            top: 0,
                            left: 0,
                            width: '100%',
                            height: '100vh',
                            background: 'rgba(15, 23, 42, 0.98)',
                            backdropFilter: 'blur(18px)',
                            zIndex: 1001,
                            display: 'flex',
                            flexDirection: 'column',
                            padding: '24px 32px 32px',
                            gap: 20,
                            overflowY: 'auto',
                            animation: 'slideInFromRight 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                        }}
                    >
                        {/* Topo: Logo à esquerda e X à direita */}
                        <div
                            style={{
                                display: 'flex',
                                justifyContent: 'space-between',
                                alignItems: 'center',
                                marginBottom: 16,
                                animation: 'fadeIn 0.3s ease-out',
                            }}
                        >
                            {/* Logo clicável */}
                            <button
                                onClick={() => {
                                    navigate('/');
                                    setMobileMenuOpen(false);
                                    window.scrollTo({ top: 0, behavior: 'smooth' });
                                }}
                                style={{
                                    display: 'inline-flex',
                                    flexDirection: 'row',
                                    alignItems: 'center',
                                    gap: 12,
                                    cursor: 'pointer',
                                    background: 'transparent',
                                    border: 'none',
                                    padding: 0,
                                }}
                            >
                                {/* Ícone */}
                                <div
                                    style={{
                                        width: 36,
                                        height: 36,
                                        minWidth: 36,
                                        flexShrink: 0,
                                        borderRadius: 10,
                                        background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        overflow: 'hidden',
                                    }}
                                >
                                    <img src="/owl_custom.webp" alt="Logo" width={30} height={30} style={{ objectFit: 'contain' }} />
                                </div>
                                {/* Texto */}
                                <span
                                    style={{
                                        color: '#ffffff',
                                        fontWeight: 700,
                                        fontSize: 19,
                                        whiteSpace: 'nowrap',
                                        display: 'inline-block',
                                    }}
                                >
                                    CorrigeAI
                                </span>
                            </button>

                            {/* Botão X para fechar */}
                            <button
                                onClick={() => setMobileMenuOpen(false)}
                                style={{
                                    background: 'transparent',
                                    border: 'none',
                                    color: '#ffffff',
                                    fontSize: 32,
                                    cursor: 'pointer',
                                    padding: 8,
                                }}
                            >
                                ✕
                            </button>
                        </div>

                        {/* Links de navegação */}
                        <button
                            onClick={() => scrollToSection('como-funciona')}
                            style={{
                                ...mobileItemStyle,
                                animation: 'fadeInUp 0.4s ease-out 0.1s both',
                            }}
                        >
                            Como funciona
                        </button>
                        <button
                            onClick={() => scrollToSection('correcao')}
                            style={{
                                ...mobileItemStyle,
                                animation: 'fadeInUp 0.4s ease-out 0.15s both',
                            }}
                        >
                            Correção Enem
                        </button>
                        <button
                            onClick={() => scrollToSection('objetivos')}
                            style={{
                                ...mobileItemStyle,
                                animation: 'fadeInUp 0.4s ease-out 0.2s both',
                            }}
                        >
                            Objetivos
                        </button>
                        <button
                            onClick={() => scrollToSection('relatos')}
                            style={{
                                ...mobileItemStyle,
                                animation: 'fadeInUp 0.4s ease-out 0.25s both',
                            }}
                        >
                            Relatos
                        </button>
                        <button
                            onClick={() => scrollToSection('precos')}
                            style={{
                                ...mobileItemStyle,
                                animation: 'fadeInUp 0.4s ease-out 0.3s both',
                            }}
                        >
                            Preços
                        </button>

                        {/* Botões - FORÇAR CENTRALIZAÇÃO */}
                        <div
                            style={{
                                width: '100%',
                                display: 'flex',
                                flexDirection: 'column',
                                alignItems: 'center',
                                justifyContent: 'center',
                                gap: 10,
                                marginTop: 24,
                                animation: 'fadeInUp 0.4s ease-out 0.35s both',
                            }}
                        >
                            {!isLoading && user ? (
                                <>
                                    <span style={{ color: '#94a3b8', fontSize: 14, marginBottom: 8 }}>
                                        Olá, {user.full_name?.split(' ')[0] || 'Usuário'}
                                    </span>
                                    <button
                                        onClick={() => {
                                            navigate('/painel');
                                            setMobileMenuOpen(false);
                                        }}
                                        style={{
                                            width: '85%',
                                            maxWidth: '260px',
                                            background: '#4F46E5',
                                            border: 'none',
                                            borderRadius: 999,
                                            padding: '11px',
                                            color: '#fff',
                                            fontSize: 14,
                                            fontWeight: 600,
                                            cursor: 'pointer',
                                            transition: 'all 0.2s ease',
                                            margin: '0 auto',
                                        }}
                                    >
                                        Meu Painel
                                    </button>
                                </>
                            ) : (
                                <>
                                    <button
                                        onClick={() => {
                                            navigate('/login');
                                            setMobileMenuOpen(false);
                                        }}
                                        style={{
                                            width: '85%',
                                            maxWidth: '260px',
                                            background: 'transparent',
                                            border: '2px solid #4b5563',
                                            borderRadius: 999,
                                            padding: '10px',
                                            color: '#ffffff',
                                            fontSize: 14,
                                            fontWeight: 600,
                                            cursor: 'pointer',
                                            transition: 'all 0.2s ease',
                                            margin: '0 auto',
                                        }}
                                    >
                                        Entrar
                                    </button>
                                    <button
                                        onClick={() => {
                                            navigate('/cadastro');
                                            setMobileMenuOpen(false);
                                        }}
                                        style={{
                                            width: '85%',
                                            maxWidth: '260px',
                                            background: '#4F46E5',
                                            border: 'none',
                                            borderRadius: 999,
                                            padding: '11px',
                                            color: '#fff',
                                            fontSize: 14,
                                            fontWeight: 600,
                                            cursor: 'pointer',
                                            transition: 'all 0.2s ease',
                                            margin: '0 auto',
                                        }}
                                    >
                                        Criar conta
                                    </button>
                                </>
                            )}
                        </div>
                    </div>
                )}
            </header>

            <style>{`
        /* Forçar logo horizontal */
        button[style*="inline-flex"] {
          display: inline-flex !important;
          flex-direction: row !important;
        }

        /* Animações */
        @keyframes fadeIn {
          from {
            opacity: 0;
          }
          to {
            opacity: 1;
          }
        }

        @keyframes slideInFromRight {
          from {
            transform: translateX(100%);
            opacity: 0;
          }
          to {
            transform: translateX(0);
            opacity: 1;
          }
        }

        @keyframes fadeInUp {
          from {
            opacity: 0;
            transform: translateY(20px);
          }
          to {
            opacity: 1;
            transform: translateY(0);
          }
        }

        @media (max-width: 768px) {
          .nav-links-desktop,
          .desktop-buttons {
            display: none !important;
          }
          .mobile-menu-btn {
            display: block !important;
          }
        }
        @media (min-width: 769px) {
          .mobile-menu-btn {
            display: none !important;
          }
        }
      `}</style>
        </>
    );
};

const navItemStyle: React.CSSProperties = {
    background: 'none',
    border: 'none',
    color: '#e5e7eb',
    fontSize: 14,
    cursor: 'pointer',
    transition: 'all 0.2s ease',
};

const mobileItemStyle: React.CSSProperties = {
    textAlign: 'left',
    background: 'none',
    border: 'none',
    borderBottom: '1px solid rgba(255,255,255,0.08)',
    paddingBottom: 16,
    color: '#e5e7eb',
    fontSize: 16,
    cursor: 'pointer',
    transition: 'all 0.2s ease',
};

export default Header;
