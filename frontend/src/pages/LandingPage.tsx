import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/api';
import Header from '../components/Header';

interface Package {
  id: string;
  name: string;
  credits: number;
  price: number;
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
            entry.target.classList.remove('revealed');
          }
        });
      },
      { threshold: 0.1, rootMargin: '0px 0px -100px 0px' }
    );

    const elements = document.querySelectorAll('.reveal-on-scroll, .slide-left, .slide-right, .scale-in');
    elements.forEach((el) => observer.observe(el));
    return () => observer.disconnect();
  }, []);

  useEffect(() => {
    const fetchPackages = async () => {
      try {
        const response = await api.get('/api/packages');
        const activePackages = response.data
          .filter((pkg: any) => pkg.is_active)
          .sort((a: any, b: any) => a.credits - b.credits);
        setPackages(activePackages);
      } catch (error) {
        console.error('[LandingPage] Error fetching packages:', error);
      } finally {
        setLoading(false);
      }
    };
    fetchPackages();
  }, []);

  return (
    <>
      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        * {
          box-sizing: border-box;
        }

        body {
          margin: 0;
          padding: 0;
          font-family: 'Inter', sans-serif;
          background: #1a1f2e;
          color: #fff;
          overflow-x: hidden;
        }

        /* ========================================
           CONTAINER & GRIDS - DESKTOP (padrão)
        ======================================== */
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

        /* ========================================
           NAV DESKTOP
        ======================================== */
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
          transition: color 0.2s;
        }

        .nav-links a:hover {
          color: #fff;
        }

        /* ========================================
           HERO
        ======================================== */
        .hero-section {
          padding-top: 140px;
          padding-bottom: 80px;
          position: relative;
          overflow: hidden;
        }

        .hero-title {
          font-size: 56px;
          font-weight: 800;
          line-height: 1.1;
          margin-bottom: 24px;
          background: linear-gradient(to right, #fff, #94a3b8);
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
        }

        .hero-buttons {
          display: flex;
          gap: 16px;
          margin-bottom: 24px;
          flex-wrap: wrap;
        }

        .hero-image {
          width: 400px;
          max-width: 100%;
          height: auto;
          animation: breathe 8s ease-in-out infinite;
          filter: drop-shadow(0 20px 40px rgba(0,0,0,0.3));
        }

        /* ========================================
           BUTTONS
        ======================================== */
        .btn-primary {
          background: #4F46E5;
          border: none;
          color: #fff;
          font-size: 16px;
          font-weight: 600;
          padding: 16px 32px;
          border-radius: 12px;
          cursor: pointer;
          display: flex;
          align-items: center;
          gap: 8px;
          transition: all 0.3s ease;
          white-space: nowrap;
        }

        .btn-primary:hover {
          transform: translateY(-2px);
          box-shadow: 0 10px 30px rgba(79, 70, 229, 0.4);
        }

        .btn-outline {
          background: transparent;
          border: 2px solid #334155;
          color: #fff;
          font-size: 16px;
          font-weight: 600;
          padding: 16px 32px;
          border-radius: 12px;
          cursor: pointer;
          transition: all 0.3s ease;
        }

        .btn-outline:hover {
          border-color: #4F46E5;
        }

        /* ========================================
           MOBILE MENU BUTTON
        ======================================== */
        .mobile-menu-btn {
          display: none;
          background: transparent;
          border: none;
          color: white;
          font-size: 28px;
          cursor: pointer;
          padding: 8px;
          z-index: 1001;
        }

        /* ========================================
           STEP CARDS - SEMPRE EM LINHA
        ======================================== */
        .step-card {
          display: flex !important;
          flex-direction: row !important;
          align-items: flex-start !important;
          gap: 16px !important;
        }

        .step-card-badge {
          flex-shrink: 0 !important;
        }

        .step-card-content {
          flex: 1 !important;
          min-width: 0 !important;
        }

        /* ========================================
           ANIMATIONS
        ======================================== */
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

        .delay-1 { transition-delay: 0.1s; }
        .delay-2 { transition-delay: 0.2s; }
        .delay-3 { transition-delay: 0.3s; }
        .delay-4 { transition-delay: 0.4s; }

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

        /* ========================================
           HOVER EFFECTS
        ======================================== */
        .hover-lift {
          transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1),
                      box-shadow 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .hover-lift:hover {
          transform: translateY(-8px);
          box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
        }

        /* ========================================
           CTA BOX & FOOTER
        ======================================== */
        .cta-box {
          background: linear-gradient(135deg, rgba(79, 70, 229, 0.1) 0%, rgba(124, 58, 237, 0.1) 100%);
          border: 1px solid rgba(79, 70, 229, 0.3);
          border-radius: 20px;
          padding: 48px;
          display: flex;
          justify-content: space-between;
          align-items: center;
          gap: 24px;
        }

        .footer-content {
          display: flex;
          justify-content: space-between;
          align-items: center;
          flex-wrap: wrap;
          gap: 24px;
        }

        /* ========================================
           VISIBILITY CLASSES
        ======================================== */
        .desktop-only {
          display: block;
        }

        .mobile-only {
          display: none !important;
        }

        /* ========================================
           TIMELINE STEPS
        ======================================== */
        .timeline-steps {
          display: flex;
          flex-direction: row;
          justify-content: space-around;
          align-items: center;
          gap: 20px;
          flex-wrap: nowrap;
          position: relative;
          z-index: 1;
        }

        /* ========================================
           STATS GRID
        ======================================== */
        .stats-grid {
          display: grid;
          grid-template-columns: repeat(4, 1fr);
          gap: 40px;
        }

        /* ========================================
           LOGO CONTAINER
        ======================================== */
        .logo-container {
          display: flex;
          align-items: center;
          gap: 12px;
          cursor: pointer;
          flex-direction: row;
          flex-wrap: nowrap;
        }

        /* ========================================
           COMO FUNCIONA SECTION
        ======================================== */
        .como-funciona-section {
          padding: 80px 0;
          background: #1a1f2e;
        }

        /* ========================================
           TABLET (max-width: 1024px)
        ======================================== */
        @media (max-width: 1024px) {
          .grid-2 {
            grid-template-columns: 1fr;
            gap: 40px;
          }

          .grid-3 {
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
          }

          .grid-4 {
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
          }

          .stats-grid {
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
          }

          .hero-title {
            font-size: 42px;
          }

          .hero-section {
            padding-top: 100px;
            padding-bottom: 60px;
          }

          .cta-box {
            flex-direction: column;
            text-align: center;
            padding: 40px 32px;
          }
        }

        /* ========================================
           MOBILE (max-width: 768px)
        ======================================== */
        @media (max-width: 768px) {
          .desktop-only {
            display: none !important;
          }

          .mobile-only {
            display: flex !important;
          }

          .container {
            padding: 0 16px !important;
          }

          /* Grids viram coluna única */
          .grid-2,
          .grid-3,
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

          /* Hero - REDUZIDO padding inferior */
          .hero-section {
            padding-top: 100px !important;
            padding-bottom: 20px !important;
          }

          /* Como Funciona - REDUZIDO padding superior */
          .como-funciona-section {
            padding-top: 32px !important;
            padding-bottom: 60px !important;
          }

          .hero-title {
            font-size: 32px !important;
            text-align: center;
          }

          .hero-buttons {
            flex-direction: column !important;
            width: 100% !important;
          }

          .hero-buttons button,
          .btn-primary,
          .btn-outline {
            width: 100% !important;
            justify-content: center !important;
          }

          .hero-image {
            width: 100% !important;
            max-width: 280px !important;
            margin: 0 auto;
          }

          /* Nav Mobile */
          .nav-links {
            display: flex !important;
            position: fixed;
            top: 0;
            right: 0;
            left: auto;
            bottom: 0;
            width: 100%;
            max-width: 320px;
            background: rgba(15, 20, 25, 0.98);
            backdrop-filter: blur(16px);
            flex-direction: column;
            padding: 100px 24px 40px;
            gap: 20px;
            z-index: 999;
            transform: translateX(100%);
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border-left: 1px solid #334155;
          }

          .nav-links.open {
            transform: translateX(0);
          }

          .nav-links a {
            font-size: 18px;
            padding: 12px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
          }

          .mobile-menu-btn {
            display: block !important;
          }

          /* STEP CARDS - Badge à esquerda, texto à direita */
          .step-card {
            display: flex !important;
            flex-direction: row !important;
            align-items: flex-start !important;
            gap: 16px !important;
          }

          .step-card-badge {
            flex-shrink: 0 !important;
            width: 40px !important;
            height: 40px !important;
          }

          .step-card-content {
            flex: 1 !important;
            min-width: 0 !important;
          }

          .step-card-content h3 {
            font-size: 16px !important;
            margin-bottom: 8px !important;
          }

          .step-card-content p {
            font-size: 13px !important;
          }

          /* CTA Box */
          .cta-box {
            flex-direction: column !important;
            text-align: center !important;
            gap: 24px !important;
            padding: 32px 20px !important;
          }

          .cta-box h2 {
            font-size: 24px !important;
          }

          /* Footer */
          .footer-content {
            flex-direction: column !important;
            gap: 24px !important;
            text-align: center !important;
          }

          /* Sections */
          section {
            padding-left: 16px !important;
            padding-right: 16px !important;
          }

          /* Timeline horizontal em mobile */
          .timeline-steps {
            display: flex !important;
            flex-direction: row !important;
            justify-content: space-around !important;
            flex-wrap: nowrap !important;
            gap: 12px !important;
          }

          .timeline-steps > div {
            flex: 1;
            min-width: 0;
          }

          /* Logo sempre horizontal */
          .logo-container {
            flex-direction: row !important;
            flex-wrap: nowrap !important;
          }

          .logo-container div {
            width: 36px !important;
            height: 36px !important;
            font-size: 20px !important;
            flex-shrink: 0 !important;
          }

          .logo-container span {
            font-size: 18px !important;
            white-space: nowrap !important;
          }

          /* Títulos menores */
          h2 {
            font-size: 28px !important;
          }

          /* Texto gratuito - sem margem extra */
          .hero-note {
            margin-bottom: 0 !important;
          }
        }

        /* ========================================
           MOBILE PEQUENO (max-width: 480px)
        ======================================== */
        @media (max-width: 480px) {
          .hero-title {
            font-size: 28px !important;
          }

          .hero-section {
            padding-bottom: 50px !important;
          }

          .como-funciona-section {
            padding-top: 24px !important;
          }

          .stats-grid {
            grid-template-columns: 1fr !important;
            gap: 16px !important;
          }

          .stats-grid > div {
            padding: 20px !important;
          }

          .cta-box {
            padding: 24px 16px !important;
          }

          h2 {
            font-size: 24px !important;
          }

          .container {
            padding: 0 12px !important;
          }

          /* Step cards ainda menores */
          .step-card {
            padding: 16px !important;
            gap: 12px !important;
          }

          .step-card-badge {
            width: 36px !important;
            height: 36px !important;
          }

          .step-card-content h3 {
            font-size: 15px !important;
          }

          .step-card-content p {
            font-size: 12px !important;
          }
        }

        /* ========================================
           TELAS GRANDES (min-width: 1440px)
        ======================================== */
        @media (min-width: 1440px) {
          .container {
            max-width: 1320px;
          }

          .hero-title {
            font-size: 64px;
          }

          .hero-section {
            padding-top: 160px;
            padding-bottom: 100px;
          }
        }
        /* Força layout horizontal nos cards */
          .grid-3 > div > div:first-child {
            display: flex !important;
            flex-direction: row !important;
        }
      `}</style>

      <div style={{ minHeight: '100vh', background: 'linear-gradient(180deg, #1a1f2e 0%, #0f1419 100%)' }}>

        <Header />

        {/* HERO SECTION */}
        <section className="hero-section">
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
            <div className="slide-left" style={{ textAlign: isMobile ? 'center' : 'left' }}>
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

              <h1 className="hero-title">
                Nota 1000<br />
                começa com feedback<br />
                inteligente
              </h1>

              <p style={{
                fontSize: '18px',
                color: '#94a3b8',
                lineHeight: '1.6',
                marginBottom: '32px',
                maxWidth: isMobile ? '100%' : '500px'
              }}>
                Receba nota e feedback detalhado da sua redação do Enem em segundos. Correção com IA alinhada aos critérios oficiais do Enem.
              </p>

              <div className="hero-buttons">
                <button
                  className="btn-primary"
                  onClick={() => navigate('/cadastro')}
                >
                  Começar de graça →
                </button>
                <button
                  className="btn-outline"
                  onClick={() => navigate('/login')}
                >
                  Já tenho conta
                </button>
              </div>

              <p className="hero-note" style={{ fontSize: '14px', color: '#9ca3af', marginBottom: isMobile ? '0' : '24px' }}>
                Gratuito • Sem cartão de crédito • Feedback imediato
              </p>
            </div>

            {/* Right side - Character (Desktop Only) */}
            <div className="slide-right desktop-only" style={{ position: 'relative', display: 'flex', justifyContent: 'center' }}>
              <img
                src="/owl-thumbs-up-plate.webp"
                alt="Character"
                className="hero-image"
                fetchPriority="high"
                loading="eager"
                decoding="sync"
                width={400}
                height={400}
              />
            </div>
          </div>
        </section>

        {/* COMO FUNCIONA */}
        <section id="como-funciona" className="como-funciona-section">
          <div className="container">
            {/* Timeline Header */}
            <div style={{ textAlign: 'center', marginBottom: '80px' }} className="reveal-on-scroll">
              <p style={{ color: '#9ca3af', fontSize: '13px', fontWeight: '600', marginBottom: '16px', textTransform: 'uppercase', letterSpacing: '1px' }}>
                Transparente e didático
              </p>
              <h2 style={{ fontSize: '42px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>Como funciona</h2>
              <p style={{ fontSize: '16px', color: '#94a3b8', marginBottom: '8px' }}>
                Da entrega ao feedback: Tudo pensado para você evoluir com clareza.
              </p>
              <p style={{ fontSize: '14px', color: '#9ca3af' }}>
                Nossa simulação reproduz o processo oficial de correção do Enem.{' '}
                <a href="#" style={{ color: '#4F46E5', textDecoration: 'underline' }}>Veja como é a correção →</a>
              </p>
            </div>

            {/* Timeline Steps */}
            <div className="desktop-only" style={{ position: 'relative', marginBottom: '60px' }}>
              {/* Connecting Line */}
              <div className="reveal-on-scroll" style={{
                position: 'absolute',
                top: '32px',
                left: '20%',
                right: '20%',
                height: '2px',
                background: 'linear-gradient(90deg, transparent 0%, #334155 10%, #334155 90%, transparent 100%)',
                zIndex: 0
              }} />

              {/* Steps Container */}
              <div className="timeline-steps">
                {[
                  { icon: '📤', label: 'Envio' },
                  { icon: '🔍', label: 'Análise' },
                  { icon: '📊', label: 'Resultado' }
                ].map((step, i) => (
                  <div key={i} className={`scale-in delay-${i + 1}`} style={{ textAlign: 'center' }}>
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
                      <span style={{ fontSize: '28px' }}>{step.icon}</span>
                    </div>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#94a3b8' }}>{step.label}</div>
                  </div>
                ))}
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
                {/* Linha do título com badge */}
                <div style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', gap: '16px', marginBottom: '16px' }}>
                  <div style={{
                    width: '40px',
                    minWidth: '40px',
                    height: '40px',
                    background: 'rgba(79, 70, 229, 0.1)',
                    borderRadius: '10px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                  }}>
                    <span style={{ fontSize: '20px' }}>1️⃣</span>
                  </div>
                  <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', margin: 0 }}>
                    Envie sua redação
                  </h3>
                </div>
                {/* Conteúdo abaixo */}
                <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', margin: 0 }}>
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
                {/* Linha do título com badge */}
                <div style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', gap: '16px', marginBottom: '16px' }}>
                  <div style={{
                    width: '40px',
                    minWidth: '40px',
                    height: '40px',
                    background: 'rgba(79, 70, 229, 0.1)',
                    borderRadius: '10px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                  }}>
                    <span style={{ fontSize: '20px' }}>2️⃣</span>
                  </div>
                  <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', margin: 0 }}>
                    Correção por 3 avaliadores
                  </h3>
                </div>
                {/* Conteúdo abaixo */}
                <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', marginBottom: '12px' }}>
                  Três avaliadores digitais analisam sua redação de forma independente, como no processo do Enem.
                </p>
                <p style={{ fontSize: '13px', color: '#9ca3af', fontStyle: 'italic', margin: 0 }}>
                  Padrão Enem (3 corretores) • +200 pts
                </p>
                <div style={{ display: 'inline-flex', flexDirection: 'row', gap: '8px', marginTop: '12px' }}>
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
                <p style={{ fontSize: '12px', color: '#9ca3af', marginTop: '8px', marginBottom: 0 }}>
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
                {/* Linha do título com badge */}
                <div style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', gap: '16px', marginBottom: '16px' }}>
                  <div style={{
                    width: '40px',
                    minWidth: '40px',
                    height: '40px',
                    background: 'rgba(79, 70, 229, 0.1)',
                    borderRadius: '10px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                  }}>
                    <span style={{ fontSize: '20px' }}>3️⃣</span>
                  </div>
                  <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', margin: 0 }}>
                    Feedback claro + nota final
                  </h3>
                </div>
                {/* Conteúdo abaixo */}
                <p style={{ fontSize: '14px', color: '#94a3b8', lineHeight: '1.6', marginBottom: '12px' }}>
                  Receba o resumo em pontos fortes, o que melhorar e sua nota por competência (I, II, III, IV, V), cada uma valendo até 200 pontos.
                </p>
                <div style={{ display: 'flex', flexDirection: 'row', gap: '6px', flexWrap: 'wrap' }}>
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
        {/* RELATOS / TESTIMONIALS */}
        <section id="relatos" style={{ padding: '80px 0', background: '#1a1f2e' }}>
          <div className="container">
            <div style={{ textAlign: 'center', marginBottom: '60px' }} className="reveal-on-scroll">
              <p style={{ color: '#818cf8', fontSize: '14px', fontWeight: '600', marginBottom: '12px' }}>DEPOIMENTOS</p>
              <h2 style={{ fontSize: '42px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>O que nossos usuários dizem</h2>
              <p style={{ fontSize: '18px', color: '#94a3b8' }}>Resultados reais de quem usa o CorrigeAI</p>
            </div>

            {/* Stats Cards */}
            <div className="reveal-on-scroll grid-3" style={{ marginBottom: '48px', maxWidth: '900px', margin: '0 auto 48px' }}>
              {[
                { value: '+300', label: 'redações corrigidas' },
                { value: '+25 pts', label: 'média de melhoria por redação' },
                { value: '2 minutos', label: 'feedback imediato' }
              ].map((stat, i) => (
                <div key={i} style={{
                  background: '#0f1419',
                  border: '1px solid #334155',
                  borderRadius: '16px',
                  padding: '32px 24px',
                  textAlign: 'center'
                }}>
                  <div style={{ fontSize: '48px', fontWeight: '800', color: '#4F46E5', marginBottom: '8px' }}>{stat.value}</div>
                  <p style={{ fontSize: '14px', color: '#94a3b8', margin: 0 }}>{stat.label}</p>
                </div>
              ))}
            </div>

            {/* Testimonial Card */}
            <div className="reveal-on-scroll" style={{
              background: '#0f1419',
              border: '1px solid #334155',
              borderRadius: '16px',
              padding: isMobile ? '24px' : '40px',
              maxWidth: '900px',
              margin: '0 auto'
            }}>
              <div style={{ display: 'flex', gap: '20px', alignItems: 'flex-start', flexDirection: isMobile ? 'column' : 'row' }}>
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
                <div style={{ flex: 1 }}>
                  <p style={{
                    fontSize: '16px',
                    color: '#e6edf3',
                    lineHeight: '1.7',
                    marginBottom: '16px',
                    fontStyle: 'italic'
                  }}>
                    "Usei o CorrigeAI por 3 semanas. O feedback por competência ajudou muito. Passei de 840 pontos para 920 na última redação. Recomendo!"
                  </p>
                  <div>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#fff' }}>Marina, estudante</div>
                    <div style={{ fontSize: '13px', color: '#9ca3af' }}>São Paulo, Brasil</div>
                  </div>
                </div>
              </div>
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
              {/* Competências */}
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
                      fontSize: '18px',
                      flexShrink: 0
                    }}>
                      {['I', 'II', 'III', 'IV', 'V'][i]}
                    </div>
                    <div style={{ flex: 1, color: '#fff', fontWeight: '600', fontSize: '16px' }}>{comp}</div>
                    <div style={{
                      color: '#4F46E5',
                      fontWeight: '700',
                      fontSize: '14px',
                      background: 'rgba(79, 70, 229, 0.1)',
                      padding: '6px 12px',
                      borderRadius: '6px',
                      whiteSpace: 'nowrap'
                    }}>200 pts</div>
                  </div>
                ))}
              </div>

              {/* Processo (Desktop Only) */}
              <div /*className="slide-right desktop-only"*/ style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '16px',
                padding: '32px',
                position: 'relative'
              }}>
                <h3 style={{ fontSize: '22px', fontWeight: '700', color: '#fff', marginBottom: '24px' }}>Como corrigimos</h3>

                <div style={{ position: 'relative' }}>
                  <div style={{
                    position: 'absolute',
                    left: '15px',
                    top: '16px',
                    bottom: '35px',
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
                      <div key={i} style={{ display: 'inline-flex', gap: '16px', alignItems: 'flex-start', position: 'relative' }}>
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
                          zIndex: 1
                        }}>
                          {i + 1}
                        </div>
                        <div style={{ flex: 1 }}>
                          <div style={{ color: '#fff', fontSize: '15px', fontWeight: '600', marginBottom: '4px' }}>{step.title}</div>
                          <p style={{ color: '#94a3b8', fontSize: '14px', lineHeight: '1.5', margin: 0 }}>{step.desc}</p>
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
                  <div key={i} style={{ display: 'inline-flex', gap: '16px', alignItems: 'flex-start' }}>
                    {/* Badge à esquerda */}
                    <div style={{
                      width: '48px',
                      minWidth: '48px',
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
                    {/* Título + texto à direita */}
                    <div style={{ flex: 1 }}>
                      <h4 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', margin: 0, marginBottom: '6px' }}>
                        {obj.title}
                      </h4>
                      <p style={{ fontSize: '15px', color: '#94a3b8', lineHeight: '1.6', margin: 0 }}>
                        {obj.desc}
                      </p>
                    </div>
                  </div>
                ))}
              </div>

              {/* Imagem do mascote logo ao lado / abaixo em mobile */}
              <div className="reveal-on-scroll" style={{
                display: 'flex',
                justifyContent: 'center',
                alignItems: 'center',
                marginTop: '24px'
              }}>
                <img
                  src="/owl-desk.webp"  // coloque aqui o path estático do mascote (por ex: /mascote-corrigeai.png)
                  alt="Mascote CorrigeAI"
                  style={{
                    width: '100%',
                    maxWidth: '420px',
                    height: 'auto',
                    borderRadius: '18px',
                    boxShadow: '0 18px 40px rgba(15,23,42,0.7)',
                    objectFit: 'cover'
                  }}
                />
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
                <div style={{ gridColumn: '1 / -1', textAlign: 'center', padding: '40px', color: '#94a3b8' }}>
                  Carregando pacotes...
                </div>
              ) : packages.length === 0 ? (
                <div style={{ gridColumn: '1 / -1', textAlign: 'center', padding: '40px', color: '#94a3b8' }}>
                  Nenhum pacote disponível no momento.
                </div>
              ) : (
                packages.map((pkg, index) => {
                  const isPopular = pkg.is_popular || index === 1;
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
                          fontWeight: '700',
                          whiteSpace: 'nowrap'
                        }}>
                          {pkg.discount_text}
                        </div>
                      )}

                      <img
                        src="/corricoin.webp"
                        alt="Coin"
                        style={{
                          width: '48px',
                          height: '48px',
                          margin: '0 auto 16px',
                          animation: 'spin-slow 20s linear infinite'
                        }}
                      />

                      <h3 style={{ fontSize: '16px', fontWeight: '600', color: '#fff', marginBottom: '8px' }}>
                        Pacote de {pkg.credits} Créditos
                      </h3>

                      {pkg.discount_percentage > 0 && (
                        <div style={{
                          fontSize: '18px',
                          fontWeight: '600',
                          color: '#9ca3af',
                          textDecoration: 'line-through',
                          marginBottom: '4px'
                        }}>
                          R$ {((pkg.price / 100) / (1 - pkg.discount_percentage / 100)).toFixed(2).replace('.', ',')}
                        </div>
                      )}

                      <div style={{ fontSize: '32px', fontWeight: '800', color: '#4F46E5', marginBottom: '2px' }}>
                        R$ {priceInReais}
                      </div>

                      <p style={{ fontSize: '13px', color: '#9ca3af', marginBottom: '16px' }}>
                        {pkg.credits} créditos para correção de redações
                      </p>

                      <p style={{ fontSize: '12px', color: '#9ca3af', marginBottom: '16px' }}>
                        ({pkg.credits} Redações = R$ {pricePerCredit}/crédito)
                      </p>

                      <button
                        onClick={() => navigate('/cadastro')}
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

            <div className="reveal-on-scroll" style={{
              textAlign: 'center',
              marginTop: '32px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              gap: '16px',
              flexWrap: 'wrap'
            }}>
              <p style={{ fontSize: '13px', color: '#9ca3af', maxWidth: '600px', margin: 0 }}>
                Valores e formas ilustrativas para didática. Você pode ajustar quantidades, formas e regras a qualquer momento.
              </p>
              <img src="/corricoin.webp" alt="Coin" style={{ width: '64px', height: '64px', opacity: 0.6 }} />
            </div>
          </div>
        </section>

        {/* CTA SECTION */}
        <section style={{ padding: '60px 0', background: '#1a1f2e' }}>
          <div className="container">
            <div className="cta-box">
              <div style={{ textAlign: isMobile ? 'center' : 'left' }}>
                <h2 style={{ fontSize: '32px', fontWeight: '800', color: '#fff', marginBottom: '12px' }}>
                  Pronto para corrigir sua redação?
                </h2>
                <p style={{ fontSize: '16px', color: '#94a3b8', margin: 0 }}>
                  Crie sua conta gratuita e comece a corrigir agora.
                </p>
              </div>
              <button
                onClick={() => navigate('/cadastro')}
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
            <div className="logo-container">
              <div style={{
                width: '40px',
                height: '40px',
                background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                borderRadius: '10px',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                overflow: 'hidden'
              }}>
                <img src="/owl_custom.webp" alt="Logo" style={{ width: '85%', height: '85%', objectFit: 'contain' }} />
              </div>
              <span style={{ fontSize: '18px', fontWeight: '700', color: '#fff' }}>CorrigeAI</span>
            </div>

            <div style={{ display: 'inline-flex', gap: '32px', fontSize: '14px', color: '#94a3b8' }}>
              <a href="#" style={{ color: '#94a3b8', textDecoration: 'none' }}>Privacidade</a>
              <a href="#" style={{ color: '#94a3b8', textDecoration: 'none' }}>Termos</a>
            </div>

            <p style={{ fontSize: '14px', color: '#9ca3af', margin: 0 }}>© 2025 CorrigeAI. Todos os direitos reservados.</p>
          </div>
        </footer>

      </div>
    </>
  );
};

export default LandingPage;
