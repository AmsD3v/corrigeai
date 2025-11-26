import React from 'react';
import { Link } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import './LandingPage.css';

const LandingPage: React.FC = () => {
  const { token } = useAuth();

  return (
    <div className="landing-page">
      {/* Cabeçalho */}
      <header className="header">
        <div className="container-wide">
          <div className="logo">
            <h2>CorrigeAI</h2>
          </div>
        </div>
      </header>

      {/* Seção Hero */}
      <section className="hero">
        <div className="container-wide">
          <div className="hero-content">
            <h1 className="hero-title">A inteligência artificial a seu favor na redação</h1>
            <p className="hero-subtitle">
              Corrija suas redações com precisão e obtenha feedback personalizado para melhorar seu desempenho nos vestibulares e concursos.
            </p>
            <div className="hero-buttons">
              {token ? (
                <>
                  <Link to="/dashboard" className="btn-primary">Acessar Dashboard</Link>
                  <Link to="/home" className="btn-secondary">Continuar navegando</Link>
                </>
              ) : (
                <>
                  <Link to="/register" className="btn-primary">Começar agora</Link>
                  <Link to="/login" className="btn-secondary">Acessar conta</Link>
                </>
              )}
            </div>
          </div>
        </div>
      </section>

      {/* Seção de Funcionalidades */}
      <section className="features">
        <div className="container-wide">
          <h2 className="section-title">Por que escolher o CorrigeAI?</h2>
          <div className="features-grid">
            <div className="feature-card">
              <div className="feature-icon">🤖</div>
              <h3>Correção por IA</h3>
              <p>Análise detalhada e precisa de sua redação com feedback personalizado usando inteligência artificial avançada.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">🎯</div>
              <h3>Foco em vestibulares</h3>
              <p>Baseado nos critérios oficiais de correção dos principais vestibulares e concursos do país.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">📝</div>
              <h3>Modelos de redação</h3>
              <p>Acesse diversos modelos de redação dissertativa para se inspirar e aprender diferentes estilos de escrita.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon">📈</div>
              <h3>Relatórios personalizados</h3>
              <p>Acompanhe seu progresso com relatórios detalhados e estatísticas de desempenho ao longo do tempo.</p>
            </div>
          </div>
        </div>
      </section>

      {/* Seção de Como Funciona */}
      <section className="how-it-works">
        <div className="container-wide">
          <h2 className="section-title">Como funciona</h2>
          <div className="steps">
            <div className="step">
              <div className="step-number">1</div>
              <h3>Escreva sua redação</h3>
              <p>Utilize nosso editor intuitivo para escrever sua redação no tema proposto.</p>
            </div>
            <div className="step">
              <div className="step-number">2</div>
              <h3>Correção automática</h3>
              <p>Nossa IA especializada analisa sua redação levando em consideração todos os critérios oficiais.</p>
            </div>
            <div className="step">
              <div className="step-number">3</div>
              <h3>Receba feedback personalizado</h3>
              <p>Obtenha um relatório detalhado com sugestões de melhoria e pontuação.</p>
            </div>
          </div>
        </div>
      </section>

      {/* Seção de Benefícios */}
      <section className="benefits">
        <div className="container-wide">
          <div className="benefits-content">
            <div className="benefits-text">
              <h2 className="section-title">Eleve sua escrita ao próximo nível</h2>
              <p>Nossa plataforma combina inteligência artificial avançada com critérios oficiais de correção para oferecer a você o melhor feedback possível. Aprenda com cada redação e acompanhe seu progresso.</p>
              <ul className="benefits-list">
                <li>✓ Análise detalhada por inteligência artificial</li>
                <li>✓ Feedback personalizado para cada critério</li>
                <li>✓ Acompanhamento de progresso</li>
                <li>✓ Modelos de redação para inspiração</li>
              </ul>
            </div>
          </div>
        </div>
      </section>

      {/* Seção de CTA */}
      <section className="cta">
        <div className="container-wide">
          <h2 className="cta-title">{token ? "Continue sua jornada de aprendizado!" : "Pronto para melhorar sua escrita?"}</h2>
          <p className="cta-subtitle">{token ? "Acesse seu dashboard para continuar sua jornada de aprendizado." : "Comece a corrigir suas redações com inteligência artificial hoje mesmo."}</p>
          {token ? (
            <Link to="/dashboard" className="btn-primary">Acessar Dashboard</Link>
          ) : (
            <Link to="/register" className="btn-primary">Começar agora</Link>
          )}
        </div>
      </section>

      {/* Rodapé */}
      <footer className="footer">
        <div className="container-wide">
          <div className="footer-content">
            <p className="footer-text">&copy; 2025 CorrigeAI. Todos os direitos reservados.</p>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default LandingPage;