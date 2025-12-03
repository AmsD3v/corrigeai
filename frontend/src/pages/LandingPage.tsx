import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/api';
import Header from '../components/Header';

interface Package {
  id: string;
  name: string;
  credits: number;
  price: number; // in cents
  discount_percentage: number;
  discount_text: string | null;
  bonus: number;
  is_popular: boolean;
}

const LandingPage = () => {
  const navigate = useNavigate();
  const [packages, setPackages] = useState<Package[]>([]);
  const [loading, setLoading] = useState(true);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [isMobile, setIsMobile] = useState(window.innerWidth <= 768);

  // Detect screen size changes
  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth <= 768);
    };

    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  useEffect(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('revealed');
          } else {
            // Remove revealed class when element exits viewport to allow re-animation
            entry.target.classList.remove('revealed');
          }
        });
      },
      {
        threshold: 0.1,
        rootMargin: '0px 0px -100px 0px' // Trigger when element is 100px into viewport
      }
    );

    const elements = document.querySelectorAll('.reveal-on-scroll, .slide-left, .slide-right, .scale-in');
    elements.forEach((el) => observer.observe(el));

    return () => observer.disconnect();
  }, []);

  // Fetch packages from API
  useEffect(() => {
    const fetchPackages = async () => {
      try {
        console.log('[LandingPage] Fetching packages from API...');
        const response = await api.get('/api/packages');
        console.log('[LandingPage] API Response:', response.data);
        // Filter only active packages and sort by credits
        const activePackages = response.data
          .filter((pkg: any) => pkg.is_active)
          .sort((a: any, b: any) => a.credits - b.credits);
        console.log('[LandingPage] Active packages:', activePackages);
        setPackages(activePackages);
      } catch (error) {
        console.error('[LandingPage] Error fetching packages:', error);
      } finally {
        setLoading(false);
        console.log('[LandingPage] Loading set to false');
      }
    };

    fetchPackages();
  }, []);

  return (
    <>
      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');
        
        body {
          margin: 0;
          padding: 0;
          font-family: 'Inter', sans-serif;
          background: #1a1f2e;
          color: #fff;
          overflow-x: hidden;
        }

        /* Responsive Utilities */
        .container {
          max-width: 1200px;
          margin: 0 auto;
          padding: 0 24px;
        }

        .grid-2 {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 60px;
          align-items: center;
        }

        .grid-3 {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          gap: 24px;
        }

        .grid-4 {
          display: grid;
          grid-template-columns: repeat(4, 1fr);
          gap: 40px;
        }

        .flex-between {
          display: flex;
          justify-content: space-between;
          align-items: center;
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
        }

        .hero-title {
          fontSize: 56px;
          fontWeight: 800;
          lineHeight: 1.1;
          marginBottom: 24px;
          background: linear-gradient(135deg, #fff 0%, #818cf8 100%);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
        }
        
        .hero-buttons {
          display: flex;
          gap: 16px;
          margin-bottom: 24px;
        }
        
        .mobile-menu-btn {
          display: none;
          background: transparent;
          border: none;
          color: white;
          font-size: 24px;
          cursor: pointer;
        }

        /* Scroll Reveal Animations */
        .reveal-on-scroll {
          opacity: 0;
          transform: translateY(40px);
          transition: opacity 0.8s cubic-bezier(0.16, 1, 0.3, 1),
                      transform 0.8s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .reveal-on-scroll.revealed {
          opacity: 1;
          transform: translateY(0);
        }

        /* Slide from left */
        .slide-left {
          opacity: 0;
          transform: translateX(-60px);
          transition: opacity 0.8s cubic-bezier(0.16, 1, 0.3, 1),
                      transform 0.8s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .slide-left.revealed {
          opacity: 1;
          transform: translateX(0);
        }

        /* Slide from right */
        .slide-right {
          opacity: 0;
          transform: translateX(60px);
          transition: opacity 0.8s cubic-bezier(0.16, 1, 0.3, 1),
                      transform 0.8s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .slide-right.revealed {
          opacity: 1;
          transform: translateX(0);
        }

        /* Stagger delays for multiple items */
        .delay-1 { transition-delay: 0.1s; }
        .delay-2 { transition-delay: 0.2s; }
        .delay-3 { transition-delay: 0.3s; }
        .delay-4 { transition-delay: 0.4s; }

        /* Scale animation */
        .scale-in {
          opacity: 0;
          transform: scale(0.9);
          transition: opacity 0.6s cubic-bezier(0.16, 1, 0.3, 1),
                      transform 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .scale-in.revealed {
          opacity: 1;
          transform: scale(1);
        }

        /* Continuous animations */
        @keyframes breathe {
          0%, 100% { transform: scale(1); }
          50% { transform: scale(1.03); }
        }

        @keyframes spin-slow {
          from { transform: rotate(0deg); }
          to { transform: rotate(360deg); }
        }

        @keyframes float {
          0%, 100% { transform: translateY(0px); }
          50% { transform: translateY(-10px); }
        }

        /* Hover effects */
        .hover-lift {
          transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1),
                      box-shadow 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .hover-lift:hover {
          transform: translateY(-8px);
          box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
        }

        .cta-box {
          background: linear-gradient(135deg, rgba(79, 70, 229, 0.1) 0%, rgba(124, 58, 237, 0.1) 100%);
          border: 1px solid rgba(79, 70, 229, 0.3);
          border-radius: 20px;
          padding: 48px;
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        .footer-content {
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        .desktop-only {
          display: block;
        }

        .mobile-only {
          display: none;
        }

        .desktop-only-btn {
          display: block;
        }

        /* Mobile Logo - Ensure horizontal layout */
        @media (max-width: 768px) {
          .desktop-only-btn {
            display: none !important;
          }
          
          .logo-container {
            flex-direction: row !important;
            gap: 12px !important;
          }
          
          .logo-container div {
            width: 36px !important;
            height: 36px !important;
            background: linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%) !important;
            borderRadius: 10px !important;
            fontSize: 20px !important;
            flexShrink: 0 !important;
          }
          
          .logo-container span {
            fontSize: 20px !important;
            whiteSpace: 'nowrap' !important;
          }
        }

        /* MEDIA QUERIES */
        @media (max-width: 768px) {
          .desktop-only {
            display: none !important;
          }

          .mobile-only {
            display: flex !important;
          }

          /* Force container padding */
          .container {
            padding: 0 16px !important;
          }

          /* Force all grids to single column */
          .grid-2 {
            display: flex !important;
            flex-direction: column !important;
            gap: 24px !important;
          }

          .grid-3 {
            display: flex !important;
            flex-direction: column !important;
            gap: 24px !important;
          }

          /* Keep timeline badges horizontal */
          .timeline-steps {
            display: flex !important;
            flex-direction: row !important;
            justify-content: space-around !important;
            flex-wrap: nowrap !important;
          }

          .grid-4 {
            display: flex !important;
            flex-direction: column !important;
            gap: 24px !important;
          }
          
          .stats-grid {
            display: grid !important;
            grid-template-columns: 1fr 1fr !important;
            gap: 20px !important;
          }

          .hero-title {
            font-size: 36px !important;
          }
          
          /* Hide desktop nav */
          .nav-links {
            display: flex !important;
            position: fixed;
            top: 0;
            right: 0; /* Position on right */
            left: auto; /* Reset left */
            bottom: 0;
            width: 100%;
            background: rgba(0, 0, 0, 0.9);
            backdrop-filter: blur(10px);
            flex-direction: column;
            padding: 80px 24px 24px;
            border-left: none; /* Was border-right */
            gap: 20px;
            z-index: 999;
            transform: translateX(100%); /* Start from right */
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
          }
          
          /* Show nav when open */
          .nav-links.open {
            transform: translateX(0);
          }
          
          /* Show hamburger menu */
          .mobile-menu-btn {
            display: block !important;
            background: transparent;
            border: none;
            color: white;
            font-size: 28px;
            cursor: pointer;
            padding: 8px;
          }
          
          .hero-buttons {
            flex-direction: column !important;
            width: 100% !important;
          }
          
          .hero-buttons button {
            width: 100% !important;
            justify-content: center !important;
          }
          
          .hero-image {
            width: 100% !important;
            max-width: 300px !important;
          }

          .cta-box {
            flex-direction: column !important;
            text-align: center !important;
            gap: 24px !important;
            padding: 32px 24px !important;
          }

          .footer-content {
            flex-direction: column !important;
            gap: 24px !important;
            text-align: center !important;
          }

          /* Force sections padding */
          section {
            padding-left: 16px !important;
            padding-right: 16px !important;
          }

          /* Force logo row layout */
          .logo-container {
            flex-direction: row !important;
            flex-wrap: nowrap !important;
          }
        }
      `}</style>

      <div style={{ minHeight: '100vh', background: 'linear-gradient(180deg, #1a1f2e 0%, #0f1419 100%)' }}>

        <Header />

        {/* HERO SECTION */}
        <section style={{
          paddingTop: '140px',
          paddingBottom: '80px',
          position: 'relative',
          overflow: 'hidden'
        }}>
          {/* Background glow */}
          <div style={{
            position: 'absolute',
            top: '0',
            left: '50%',
            transform: 'translateX(-50%)',
            width: '100%',
            height: '100%',
            background: 'radial-gradient(circle at 50% 0%, rgba(79, 70, 229, 0.15) 0%, transparent 50%)',
            pointerEvents: 'none'
          }} />

          <div className="container grid-2">
            {/* Left side - Text */}
            <div className="slide-left">
              <div style={{
                display: 'inline-flex',
                alignItems: 'center',
                gap: '8px',
                background: 'rgba(79, 70, 229, 0.1)',
                border: '1px solid rgba(79, 70, 229, 0.2)',
                padding: '8px 16px',
                borderRadius: '20px',
                marginBottom: '24px'
              }}>
                <span style={{ fontSize: '16px' }}>✨</span>
                <span style={{ color: '#818cf8', fontSize: '14px', fontWeight: '600' }}>CORREÇÃO COM INTELIGÊNCIA ARTIFICIAL</span>
              </div>

              <h1 className="hero-title" style={{
                fontSize: '64px',
                fontWeight: '800',
                lineHeight: '1.1',
                marginBottom: '24px',
                background: 'linear-gradient(to right, #fff, #94a3b8)',
                WebkitBackgroundClip: 'text',
                WebkitTextFillColor: 'transparent',
                backgroundClip: 'text'
              }}>
                Nota 1000<br />
                começa com feedback<br />
                inteligente
              </h1>

              <p style={{
                fontSize: '18px',
                color: '#94a3b8',
                lineHeight: '1.6',
                marginBottom: '32px',
                maxWidth: '500px'
              }}>
                Receba nota e feedback detalhado da sua redação do Enem em segundos. Correção com IA alinhada aos critérios oficiais do Enem.
              </p>

              <div className="hero-buttons">
                <button
                  onClick={() => navigate('/register')}
                  style={{
                    background: '#4F46E5',
                    border: 'none',
                    color: '#fff',
                    fontSize: '16px',
                    fontWeight: '600',
                    padding: '16px 32px',
                    borderRadius: '12px',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '8px',
                    transition: 'all 0.3s ease'
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.transform = 'translateY(-2px)';
                    e.currentTarget.style.boxShadow = '0 10px 30px rgba(79, 70, 229, 0.4)';
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.transform = 'translateY(0)';
                    e.currentTarget.style.boxShadow = 'none';
                  }}
                >
                  Começar de graça →
                </button>
                <button
                  onClick={() => navigate('/login')}
                  style={{
                    background: 'transparent',
                    border: '2px solid #334155',
                    color: '#fff',
                    fontSize: '16px',
                    fontWeight: '600',
                    padding: '16px 32px',
                    borderRadius: '12px',
                    cursor: 'pointer',
                    transition: 'all 0.3s ease'
                  }}
                  onMouseEnter={(e) => {
                    e.currentTarget.style.borderColor = '#4F46E5';
                  }}
                  onMouseLeave={(e) => {
                    e.currentTarget.style.borderColor = '#334155';
                  }}
                >
                  Já tenho conta
                </button>
              </div>

              <p style={{ fontSize: '14px', color: '#64748b' }}>
                Gratuito • Sem cartão de crédito • Feedback imediato
              </p>
            </div>

            {/* Right side - Character */}
            <div className="slide-right desktop-only" style={{ position: 'relative', display: 'flex', justifyContent: 'center' }}>
              <img
                src="/owl-thumbs-up-plate.png"
                alt="Character"
                className="hero-image"
                style={{
                  width: '400px',
                  height: 'auto',
                  animation: 'breathe 8s ease-in-out infinite',
                  filter: 'drop-shadow(0 20px 40px rgba(0,0,0,0.3))'
                }}
              />
              {/* Score badge */}
              <div className="scale-in delay-2" style={{
                position: 'absolute',
                top: '0px',
                right: '0px',
                background: '#ffffffff',
                borderRadius: '16px',
                padding: '0px 0px',
                boxShadow: '0 10px 30px rgba(0,0,0,0.2)',
                animation: 'float 3s ease-in-out infinite'
              }}>
              </div>
            </div>
          </div>
        </section>

        {/* COMO FUNCIONA */}
        <section id="como-funciona" style={{

        }}>
        </section>

        {/* TIMELINE */}
        <section style={{ padding: '80px 0', background: '#1a1f2e' }}>
          <div className="container">
            {/* Timeline Header */}
            <div style={{ textAlign: 'center', marginBottom: '60px' }} className="reveal-on-scroll">
              <p style={{ color: '#64748b', fontSize: '13px', fontWeight: '600', marginBottom: '16px', textTransform: 'uppercase', letterSpacing: '1px' }}>
                Transparente e didático
              </p>
              <h2 style={{ fontSize: '42px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>Como funciona</h2>
              <p style={{ fontSize: '16px', color: '#94a3b8', marginBottom: '8px' }}>
                Da entrega ao feedback: Tudo pensado para você evoluir com clareza.
              </p>
              <p style={{ fontSize: '14px', color: '#64748b' }}>
                Nossa simulação reproduz o processo oficial de correção do Enem.{' '}
                <a href="#" style={{ color: '#4F46E5', textDecoration: 'none' }}>Veja como é a correção →</a>
              </p>
            </div>

            {/* Timeline Steps - Desktop Only */}
            <div className="desktop-only" style={{ position: 'relative', marginBottom: '60px' }}>
              {/* Connecting Line */}
              <div className="desktop-only" style={{
                position: 'absolute',
                top: '32px',
                left: '20%',
                right: '20%',
                height: '2px',
                background: 'linear-gradient(90deg, transparent 0%, #334155 10%, #334155 90%, transparent 100%)',
                zIndex: 0
              }} className="reveal-on-scroll" />

              {/* Steps Container */}
              <div className="timeline-steps" style={{ display: 'flex', flexDirection: 'row', justifyContent: 'space-around', alignItems: 'center', gap: '20px', flexWrap: 'nowrap', position: 'relative', zIndex: 1 }}>
                {/* Step 1 - Envio */}
                <div className="scale-in delay-1" style={{ textAlign: 'center' }}>
                  <div style={{
                    width: '64px',
                    height: '64px',
                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                    borderRadius: '50%',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    margin: '0 auto 16px',
                    boxShadow: '0 8px 24px rgba(79, 70, 229, 0.3)',
                    border: '4px solid #1a1f2e'
                  }}>
                    <span style={{ fontSize: '28px' }}>📤</span>
                  </div>
                  <div style={{ fontSize: '14px', fontWeight: '600', color: '#94a3b8', marginBottom: '4px' }}>Envio</div>
                </div>

                {/* Step 2 - Análise */}
                <div className="scale-in delay-2" style={{ textAlign: 'center' }}>
                  <div style={{
                    width: '64px',
                    height: '64px',
                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                    borderRadius: '50%',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    margin: '0 auto 16px',
                    boxShadow: '0 8px 24px rgba(79, 70, 229, 0.3)',
                    border: '4px solid #1a1f2e'
                  }}>
                    <span style={{ fontSize: '28px' }}>🔍</span>
                  </div>
                  <div style={{ fontSize: '14px', fontWeight: '600', color: '#94a3b8', marginBottom: '4px' }}>Análise</div>
                </div>

                {/* Step 3 - Resultado */}
                <div className="scale-in delay-3" style={{ textAlign: 'center' }}>
                  <div style={{
                    width: '64px',
                    height: '64px',
                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                    borderRadius: '50%',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    margin: '0 auto 16px',
                    boxShadow: '0 8px 24px rgba(79, 70, 229, 0.3)',
                    border: '4px solid #1a1f2e'
                  }}>
                    <span style={{ fontSize: '28px' }}>📊</span>
                  </div>
                  <div style={{ fontSize: '14px', fontWeight: '600', color: '#94a3b8', marginBottom: '4px' }}>Resultado</div>
                </div>
              </div>
            </div>

            {/* Mobile-Only Vertical Cards */}
            <div className="mobile-only" style={{ display: 'none', flexDirection: 'column', gap: '20px', maxWidth: '600px', margin: '0 auto' }}>
              {/* Card 1 */}
              <div className="reveal-on-scroll delay-1" style={{
                background: 'rgba(15, 23, 42, 0.6)',
                border: '1px solid rgba(148, 163, 184, 0.1)',
                borderRadius: '20px',
                padding: '24px',
                display: 'flex',
                gap: '16px',
                alignItems: 'flex-start'
              }}>
                <div style={{
                  width: '48px',
                  height: '48px',
                  background: '#4F46E5',
                  borderRadius: '50%',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  flexShrink: 0,
                  fontSize: '20px',
                  fontWeight: '700',
                  color: '#fff'
                }}>
                  1
                </div>
                <div style={{ flex: 1 }}>
                  <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '8px' }}>
                    Envie sua redação
                  </h3>
                  <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', margin: 0 }}>
                    Use um tema sugerido ou escolha um tema livre. Envie colando o texto ou anexando um arquivo.
                  </p>
                </div>
              </div>

              {/* Card 2 */}
              <div className="reveal-on-scroll delay-2" style={{
                background: 'rgba(15, 23, 42, 0.6)',
                border: '1px solid rgba(148, 163, 184, 0.1)',
                borderRadius: '20px',
                padding: '24px',
                display: 'flex',
                gap: '16px',
                alignItems: 'flex-start'
              }}>
                <div style={{
                  width: '48px',
                  height: '48px',
                  background: '#4F46E5',
                  borderRadius: '50%',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  flexShrink: 0,
                  fontSize: '20px',
                  fontWeight: '700',
                  color: '#fff'
                }}>
                  2
                </div>
                <div style={{ flex: 1 }}>
                  <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '8px' }}>
                    Correção por 3 avaliadores
                  </h3>
                  <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', marginBottom: '12px' }}>
                    Três avaliadores digitais analisam sua redação de forma independente, como no processo do Enem.
                  </p>
                  <p style={{
                    fontSize: '12px',
                    color: '#64748b',
                    background: 'rgba(79, 70, 229, 0.1)',
                    padding: '6px 10px',
                    borderRadius: '6px',
                    display: 'inline-block',
                    marginBottom: '10px'
                  }}>
                    Padrão Enem (5 competências × 200 pts)
                  </p>
                  <div style={{ display: 'flex', gap: '6px', marginBottom: '8px' }}>
                    {['A', 'B', 'C'].map((letter) => (
                      <div key={letter} style={{
                        width: '36px',
                        height: '36px',
                        background: '#4F46E5',
                        borderRadius: '8px',
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        color: '#fff',
                        fontSize: '14px',
                        fontWeight: '700'
                      }}>
                        {letter}
                      </div>
                    ))}
                  </div>
                  <p style={{ fontSize: '12px', color: '#64748b', margin: 0 }}>
                    IA calibrada e validada para o formato do Enem.
                  </p>
                </div>
              </div>

              {/* Card 3 */}
              <div className="reveal-on-scroll delay-3" style={{
                background: 'rgba(15, 23, 42, 0.6)',
                border: '1px solid rgba(148, 163, 184, 0.1)',
                borderRadius: '20px',
                padding: '24px',
                display: 'flex',
                gap: '16px',
                alignItems: 'flex-start'
              }}>
                <div style={{
                  width: '48px',
                  height: '48px',
                  background: '#4F46E5',
                  borderRadius: '50%',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  flexShrink: 0,
                  fontSize: '20px',
                  fontWeight: '700',
                  color: '#fff'
                }}>
                  3
                </div>
                <div style={{ flex: 1 }}>
                  <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '8px' }}>
                    Feedback claro + nota final
                  </h3>
                  <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', margin: 0 }}>
                    Receba o resumo com pontos fortes, o que melhorar e suas notas por competência (I a V), cada uma valendo até <strong style={{ color: '#fff' }}>200 pontos</strong>.
                  </p>
                </div>
              </div>
            </div>

            {/* Detail Cards */}
            <div className="grid-3">
              {/* Card 1 */}
              <div className="slide-left delay-1 hover-lift" style={{
                background: 'linear-gradient(135deg, rgba(79, 70, 229, 0.05) 0%, rgba(30, 41, 59, 0.8) 100%)',
                border: '1px solid rgba(79, 70, 229, 0.2)',
                borderRadius: '16px',
                padding: '24px'
              }}>
                <div style={{
                  width: '40px',
                  height: '40px',
                  background: 'rgba(79, 70, 229, 0.1)',
                  borderRadius: '10px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: '16px'
                }}>
                  <span style={{ fontSize: '20px' }}>1️⃣</span>
                </div>
                <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '12px' }}>
                  Envie sua redação
                </h3>
                <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', marginBottom: '12px' }}>
                  Use um tema sugerido ou escolha o tema livre. Envie copiando o texto ou anexando um arquivo.
                </p>
              </div>

              {/* Card 2 */}
              <div className="reveal-on-scroll delay-2 hover-lift" style={{
                background: 'linear-gradient(135deg, rgba(79, 70, 229, 0.05) 0%, rgba(30, 41, 59, 0.8) 100%)',
                border: '1px solid rgba(79, 70, 229, 0.2)',
                borderRadius: '16px',
                padding: '24px'
              }}>
                <div style={{
                  width: '40px',
                  height: '40px',
                  background: 'rgba(79, 70, 229, 0.1)',
                  borderRadius: '10px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: '16px'
                }}>
                  <span style={{ fontSize: '20px' }}>2️⃣</span>
                </div>
                <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '12px' }}>
                  Correção por 3 avaliadores
                </h3>
                <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', marginBottom: '12px' }}>
                  Três avaliadores digitais analisam sua redação de forma independente, como no processo do Enem.
                </p>
                <p style={{ fontSize: '13px', color: '#64748b', fontStyle: 'italic' }}>
                  Padrão Enem (3 corretores) • +200 pts
                </p>
                <div style={{ display: 'flex', gap: '8px', marginTop: '12px' }}>
                  {['A', 'B', 'C'].map((letter, i) => (
                    <div key={i} style={{
                      width: '32px',
                      height: '32px',
                      background: '#4F46E5',
                      borderRadius: '8px',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      color: '#fff',
                      fontSize: '14px',
                      fontWeight: '700'
                    }}>
                      {letter}
                    </div>
                  ))}
                </div>
                <p style={{ fontSize: '12px', color: '#64748b', marginTop: '8px' }}>
                  Já calibrados e validados para o formato do Enem
                </p>
              </div>

              {/* Card 3 */}
              <div className="slide-right delay-3 hover-lift" style={{
                background: 'linear-gradient(135deg, rgba(79, 70, 229, 0.05) 0%, rgba(30, 41, 59, 0.8) 100%)',
                border: '1px solid rgba(79, 70, 229, 0.2)',
                borderRadius: '16px',
                padding: '24px'
              }}>
                <div style={{
                  width: '40px',
                  height: '40px',
                  background: 'rgba(79, 70, 229, 0.1)',
                  borderRadius: '10px',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  marginBottom: '16px'
                }}>
                  <span style={{ fontSize: '20px' }}>3️⃣</span>
                </div>
                <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '12px' }}>
                  Feedback claro + nota final
                </h3>
                <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', marginBottom: '12px' }}>
                  Receba o resumo em pontos fortes, o que melhorar e sua nota por competência (I, II, III, IV, V), cada uma valendo até 200 pontos.
                </p>
                <div style={{ display: 'flex', gap: '6px', marginTop: '12px', flexWrap: 'wrap' }}>
                  {['I', 'II', 'III', 'IV', 'V'].map((num, i) => (
                    <div key={i} style={{
                      padding: '6px 12px',
                      background: '#1a1f2e',
                      border: '1px solid #334155',
                      borderRadius: '6px',
                      color: '#94a3b8',
                      fontSize: '12px',
                      fontWeight: '600'
                    }}>
                      {num}
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* STATISTICS */}
        <section style={{ padding: '60px 0', background: '#1a1f2e' }}>
          <div className="container stats-grid grid-4">
            <div className="scale-in delay-1" style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '48px', fontWeight: '800', color: '#4F46E5', marginBottom: '8px' }}>+300</div>
              <div style={{ fontSize: '14px', color: '#94a3b8' }}>redações corrigidas</div>
            </div>
            <div className="scale-in delay-2" style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '48px', fontWeight: '800', color: '#4F46E5', marginBottom: '8px' }}>+25 pts</div>
              <div style={{ fontSize: '14px', color: '#94a3b8' }}>média de melhora</div>
            </div>
            <div className="scale-in delay-3" style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '48px', fontWeight: '800', color: '#4F46E5', marginBottom: '8px' }}>2 min</div>
              <div style={{ fontSize: '14px', color: '#94a3b8' }}>feedback imediato</div>
            </div>
            <div className="scale-in delay-4" style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '48px', fontWeight: '800', color: '#4F46E5', marginBottom: '8px' }}>5 comp.</div>
              <div style={{ fontSize: '14px', color: '#94a3b8' }}>critérios do Enem</div>
            </div>
          </div>
        </section>

        {/* CORREÇÃO ENEM */}
        <section id="correcao" style={{ padding: '80px 0', background: '#1a1f2e' }}>
          <div className="container">
            <div style={{ textAlign: 'center', marginBottom: '60px' }} className="reveal-on-scroll">
              <p style={{ color: '#818cf8', fontSize: '14px', fontWeight: '600', marginBottom: '12px' }}>CRITÉRIOS OFICIAIS</p>
              <h2 style={{ fontSize: '42px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>Entenda a correção do Enem</h2>
              <p style={{ fontSize: '18px', color: '#94a3b8' }}>Nossa IA avalia sua redação nas 5 competências do Enem</p>
            </div>

            <div className="grid-2">
              {/* Competências (sem timeline) */}
              <div className="slide-left" style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {[
                  'Domínio da norma culta',
                  'Compreensão do tema',
                  'Argumentação',
                  'Coesão',
                  'Proposta de intervenção'
                ].map((comp, i) => (
                  <div key={i} style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '16px'
                  }}>
                    <div style={{
                      width: '48px',
                      height: '48px',
                      background: '#4F46E5',
                      borderRadius: '50%',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      color: '#fff',
                      fontWeight: '700',
                      fontSize: '18px'
                    }}>
                      {['I', 'II', 'III', 'IV', 'V'][i]}
                    </div>
                    <div style={{ flex: 1 }}>
                      <div style={{ color: '#fff', fontWeight: '600', fontSize: '16px' }}>{comp}</div>
                    </div>
                    <div style={{
                      color: '#4F46E5',
                      fontWeight: '700',
                      fontSize: '14px',
                      background: 'rgba(79, 70, 229, 0.1)',
                      padding: '6px 12px',
                      borderRadius: '6px'
                    }}>200 pts</div>
                  </div>
                ))}
              </div>

              {/* Processo COM TIMELINE */}
              <div className="slide-right desktop-only" style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px',
                position: 'relative'
              }}>
                <h3 style={{ fontSize: '22px', fontWeight: '700', color: '#fff', marginBottom: '24px' }}>Como corrigimos</h3>

                {/* Container com timeline */}
                <div style={{ position: 'relative' }}>
                  {/* Linha vertical da timeline passando pelo centro das esferas */}
                  <div style={{
                    position: 'absolute',
                    left: '15px', // Centro da esfera (32px/2 = 16px)
                    top: '16px',
                    bottom: '16px',
                    width: '2px',
                    background: 'linear-gradient(180deg, #4F46E5 0%, rgba(79, 70, 229, 0.3) 100%)'
                  }}></div>

                  <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                    {[
                      { title: 'Análise automática do texto', desc: 'Nossa IA lê e compreende sua redação em segundos' },
                      { title: 'Avaliação por competência', desc: 'Cada uma das 5 competências do ENEM é avaliada individualmente' },
                      { title: 'Identificação de erros', desc: 'Detectamos problemas de gramática, coesão e argumentação' },
                      { title: 'Sugestões de melhoria', desc: 'Receba feedback detalhado com pontos fortes e áreas a melhorar' }
                    ].map((step, i) => (
                      <div key={i} style={{ display: 'flex', gap: '16px', alignItems: 'flex-start', position: 'relative' }}>
                        <div style={{
                          width: '32px',
                          height: '32px',
                          background: '#4F46E5',
                          borderRadius: '50%',
                          display: 'flex',
                          alignItems: 'center',
                          justifyContent: 'center',
                          color: '#fff',
                          fontWeight: '700',
                          fontSize: '14px',
                          flexShrink: 0,
                          border: '3px solid #1a1f2e',
                          zIndex: 1,
                          position: 'relative'
                        }}>
                          {i + 1}
                        </div>
                        <div style={{ flex: 1 }}>
                          <div style={{ color: '#fff', fontSize: '15px', fontWeight: '600', marginBottom: '4px' }}>{step.title}</div>
                          <p style={{ color: '#94a3b8', fontSize: '14px', lineHeight: '1.5' }}>{step.desc}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* OBJETIVOS */}
        <section id="objetivos" style={{ padding: '80px 0', background: '#1a1f2e' }}>
          <div className="container">
            <div style={{ textAlign: 'center', marginBottom: '60px' }} className="reveal-on-scroll">
              <p style={{ color: '#818cf8', fontSize: '14px', fontWeight: '600', marginBottom: '12px' }}>NOSSA MISSÃO</p>
              <h2 style={{ fontSize: '42px', fontWeight: '800', color: '#fff' }}>Objetivos do projeto</h2>
            </div>

            <div className="grid-2">
              {/* Objetivos */}
              <div className="reveal-on-scroll" style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                {[
                  { icon: '🎯', title: 'Democratizar o acesso', desc: 'Tornar a correção de redações acessível a todos os estudantes' },
                  { icon: '⚡', title: 'Feedback instantâneo', desc: 'Reduzir o tempo de espera para receber correções' },
                  { icon: '🛡️', title: 'Transparência', desc: 'Mostrar claramente os critérios de avaliação' },
                  { icon: '📚', title: 'Autonomia', desc: 'Permitir que estudantes pratiquem de forma independente' }
                ].map((obj, i) => (
                  <div key={i} style={{ display: 'flex', gap: '16px' }}>
                    <div style={{
                      width: '48px',
                      height: '48px',
                      background: 'rgba(79, 70, 229, 0.1)',
                      borderRadius: '12px',
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'center',
                      fontSize: '24px',
                      flexShrink: 0
                    }}>
                      {obj.icon}
                    </div>
                    <div>
                      <h4 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '6px' }}>{obj.title}</h4>
                      <p style={{ fontSize: '15px', color: '#94a3b8', lineHeight: '1.6' }}>{obj.desc}</p>
                    </div>
                  </div>
                ))}
              </div>

              {/* Image */}
              <div className="reveal-on-scroll" style={{ display: 'flex', justifyContent: 'center' }}>
                <img src="/owl-desk.png" alt="Owl at desk" style={{ width: '100%', maxWidth: '400px', height: 'auto' }} />
              </div>
            </div>
          </div>
        </section>

        {/* PREÇOS */}


        {/* RELATOS / TESTIMONIALS */}
        <section id="relatos" style={{ padding: '80px 0', background: '#1a1f2e' }}>
          <div className="container">
            <div style={{ textAlign: 'center', marginBottom: '60px' }} className="reveal-on-scroll">
              <p style={{ color: '#818cf8', fontSize: '14px', fontWeight: '600', marginBottom: '12px' }}>DEPOIMENTOS</p>
              <h2 style={{ fontSize: '42px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>O que nossos usuários dizem</h2>
              <p style={{ fontSize: '18px', color: '#94a3b8' }}>Resultados reais de quem usa o CorrigeAI</p>
            </div>

            {/* Stats Cards */}
            <div className="reveal-on-scroll grid-3" style={{
              marginBottom: '48px',
              maxWidth: '900px',
              margin: '0 auto 48px'
            }}>
              <div style={{
                background: '#0f1419',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px 24px',
                textAlign: 'center'
              }}>
                <div style={{ fontSize: '48px', fontWeight: '800', color: '#4F46E5', marginBottom: '8px' }}>+300</div>
                <p style={{ fontSize: '14px', color: '#94a3b8' }}>redações corrigidas</p>
              </div>
              <div style={{
                background: '#0f1419',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px 24px',
                textAlign: 'center'
              }}>
                <div style={{ fontSize: '48px', fontWeight: '800', color: '#4F46E5', marginBottom: '8px' }}>+25 pts</div>
                <p style={{ fontSize: '14px', color: '#94a3b8' }}>média de melhoria por redação</p>
              </div>
              <div style={{
                background: '#0f1419',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px 24px',
                textAlign: 'center'
              }}>
                <div style={{ fontSize: '48px', fontWeight: '800', color: '#4F46E5', marginBottom: '8px' }}>2 minutos</div>
                <p style={{ fontSize: '14px', color: '#94a3b8' }}>feedback imediato</p>
              </div>
            </div>

            {/* Testimonial Card */}
            <div className="reveal-on-scroll" style={{
              background: '#0f1419',
              border: '1px solid #334155',
              borderRadius: '16px',
              padding: '40px',
              maxWidth: '900px',
              margin: '0 auto'
            }}>
              <div style={{ display: 'flex', gap: '20px', alignItems: 'flex-start' }}>
                {/* Avatar */}
                <div style={{
                  width: '56px',
                  height: '56px',
                  background: 'linear-gradient(135deg, #4F46E5 0%, #818cf8 100%)',
                  borderRadius: '50%',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: '#fff',
                  fontSize: '24px',
                  fontWeight: '700',
                  flexShrink: 0
                }}>
                  M
                </div>
                {/* Content */}
                <div id="relatos" style={{ flex: 1 }}>
                  <p style={{
                    fontSize: '16px',
                    color: '#e6edf3',
                    lineHeight: '1.7',
                    marginBottom: '16px',
                    fontStyle: 'italic'
                  }}>
                    "Usei o CorrigeAI por 3 semanas. O feedback por competência ajudou muito. Passei de 840 pontos para 920 na última redação. Recomendo!"
                  </p>
                  <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div>
                      <div style={{ fontSize: '14px', fontWeight: '600', color: '#fff' }}>Marina, estudante</div>
                      <div style={{ fontSize: '13px', color: '#64748b' }}>São Paulo, Brasil</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* PREÇOS */}
        <section id="precos" style={{ padding: '80px 0', background: '#1a1f2e' }}>
          <div className="container">
            <div style={{ textAlign: 'center', marginBottom: '60px' }} className="reveal-on-scroll">
              <p style={{ color: '#818cf8', fontSize: '14px', fontWeight: '600', marginBottom: '12px' }}>PLANOS FLEXÍVEIS</p>
              <h2 style={{ fontSize: '42px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>Consulte os Preços dos CorriCoins</h2>
              <p style={{ fontSize: '18px', color: '#94a3b8' }}>Você define quanto quer investir • Sem mensalidade • Sem compromisso</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '24px', maxWidth: '1000px', margin: '0 auto', justifyItems: 'center' }}>
              {loading ? (
                // Loading state
                <div style={{ gridColumn: '1 / -1', textAlign: 'center', padding: '40px', color: '#94a3b8' }}>
                  Carregando pacotes...
                </div>
              ) : packages.length === 0 ? (
                // Empty state
                <div style={{ gridColumn: '1 / -1', textAlign: 'center', padding: '40px', color: '#94a3b8' }}>
                  Nenhum pacote disponível no momento.
                </div>
              ) : (
                // Dynamic package cards
                packages.map((pkg, index) => {
                  const isPopular = pkg.is_popular || index === 1; // Middle card or marked as popular
                  const priceInReais = (pkg.price / 100).toFixed(2).replace('.', ',');
                  const pricePerCredit = (pkg.price / 100 / pkg.credits).toFixed(2).replace('.', ',');

                  return (
                    <div
                      key={pkg.id}
                      style={{
                        width: '100%',
                        maxWidth: '320px',
                        background: isPopular
                          ? 'linear-gradient(180deg, rgba(79, 70, 229, 0.1) 0%, #1a1f2e 100%)'
                          : '#1a1f2e',
                        border: isPopular ? '2px solid #4F46E5' : '1px solid #334155',
                        borderRadius: '16px',
                        padding: '24px',
                        textAlign: 'center',
                        position: 'relative'
                      }}
                    >
                      {/* Discount badge */}
                      {pkg.discount_text && (
                        <div style={{
                          position: 'absolute',
                          top: '-12px',
                          left: '50%',
                          transform: 'translateX(-50%)',
                          background: '#4F46E5',
                          color: '#fff',
                          padding: '4px 16px',
                          borderRadius: '12px',
                          fontSize: '11px',
                          fontWeight: '700'
                        }}>
                          {pkg.discount_text}
                        </div>
                      )}

                      <img
                        src="/corricoin.png"
                        alt="Coin"
                        style={{
                          width: '48px',
                          height: '48px',
                          margin: '0 auto 16px',
                          animation: 'spin-slow 20s linear infinite'
                        }}
                      />

                      <h3 style={{
                        fontSize: '16px',
                        fontWeight: '600',
                        color: '#fff',
                        marginBottom: '8px'
                      }}>
                        Pacote de {pkg.credits} Créditos
                      </h3>

                      {/* Show original price if there's a discount */}
                      {pkg.discount_percentage > 0 && (
                        <div style={{
                          fontSize: '18px',
                          fontWeight: '600',
                          color: '#64748b',
                          textDecoration: 'line-through',
                          marginBottom: '4px'
                        }}>
                          R$ {((pkg.price / 100) / (1 - pkg.discount_percentage / 100)).toFixed(2).replace('.', ',')}
                        </div>
                      )}

                      <div style={{
                        fontSize: '32px',
                        fontWeight: '800',
                        color: '#4F46E5',
                        marginBottom: '2px'
                      }}>
                        R$ {priceInReais}
                      </div>

                      <p style={{
                        fontSize: '13px',
                        color: '#64748b',
                        marginBottom: '16px'
                      }}>
                        {pkg.credits} créditos para correção de redações
                      </p>

                      <p style={{
                        fontSize: '12px',
                        color: '#64748b',
                        marginBottom: '16px'
                      }}>
                        ({pkg.credits} Redações = R$ {pricePerCredit}/crédito)
                      </p>

                      <button
                        onClick={() => navigate('/register')}
                        style={{
                          width: '100%',
                          background: '#4F46E5',
                          border: 'none',
                          color: '#fff',
                          padding: '10px',
                          borderRadius: '8px',
                          fontSize: '14px',
                          fontWeight: '600',
                          cursor: 'pointer'
                        }}
                      >
                        Comprar Agora
                      </button>
                    </div>
                  );
                })
              )}
            </div>

            {/* Disclaimer */}
            <div className="reveal-on-scroll" style={{
              textAlign: 'center',
              marginTop: '32px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              gap: '16px'
            }}>
              <p style={{ fontSize: '13px', color: '#64748b', maxWidth: '600px' }}>
                Valores e formas ilustrativas para didática. Você pode ajustar quantidades, formas e regras a qualquer momento.
              </p>
              <img src="/corricoin.png" alt="Coin" style={{ width: '64px', height: '64px', opacity: 0.6 }} />
            </div>
          </div>
        </section>

        {/* CTA SECTION */}
        <section style={{
          padding: '60px 0',
          background: '#1a1f2e'
        }}>
          <div className="container">
            <div className="cta-box">
              <div>
                <h2 style={{ fontSize: '32px', fontWeight: '800', color: '#fff', marginBottom: '12px' }}>
                  Pronto para corrigir sua redação?
                </h2>
                <p style={{ fontSize: '16px', color: '#94a3b8' }}>
                  Crie sua conta gratuita e comece a corrigir agora.
                </p>
              </div>
              <button
                onClick={() => navigate('/register')}
                style={{
                  background: '#4F46E5',
                  border: 'none',
                  color: '#fff',
                  fontSize: '16px',
                  fontWeight: '600',
                  padding: '16px 32px',
                  borderRadius: '12px',
                  cursor: 'pointer',
                  whiteSpace: 'nowrap'
                }}
              >
                Começar correção grátis
              </button>
            </div>
          </div>
        </section>

        {/* FOOTER */}
        <footer style={{ padding: '40px 0', background: '#1a1f2e', borderTop: '1px solid #334155' }}>
          <div className="container footer-content">
            <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
              <div style={{
                width: '40px',
                height: '40px',
                background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                borderRadius: '10px',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                fontSize: '24px'
              }}>
                🦉
              </div>
              <span style={{ fontSize: '18px', fontWeight: '700', color: '#fff' }}>CorrigeAI</span>
            </div>

            <div style={{ display: 'flex', gap: '32px', fontSize: '14px', color: '#94a3b8' }}>
              <a href="#" style={{ color: '#94a3b8', textDecoration: 'none' }}>Privacidade</a>
              <a href="#" style={{ color: '#94a3b8', textDecoration: 'none' }}>Termos</a>
            </div>

            <p style={{ fontSize: '14px', color: '#64748b' }}>© 2025 CorrigeAI. Todos os direitos reservados.</p>
          </div>
        </footer>

      </div>
    </>
  );
};

export default LandingPage;