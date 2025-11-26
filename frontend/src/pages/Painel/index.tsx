import PanelLayout from '../../components/PanelLayout';
import { useAuth } from '../../contexts/AuthContext';

const Painel = () => {
  const { user } = useAuth();

  return (
    <PanelLayout activePage="/painel">
      {/* Welcome Card */}
      <div style={{
        background: '#1a1f2e',
        border: '1px solid #334155',
        borderRadius: '16px',
        padding: '40px',
        marginBottom: '32px',
        position: 'relative',
        overflow: 'hidden'
      }}>
        <div style={{
          position: 'absolute',
          top: '-50px',
          right: '-50px',
          width: '200px',
          height: '200px',
          background: 'radial-gradient(circle, rgba(79, 70, 229, 0.1) 0%, transparent 70%)',
          pointerEvents: 'none'
        }} />

        <span style={{
          display: 'inline-block',
          background: '#334155',
          color: '#94a3b8',
          fontSize: '11px',
          fontWeight: '700',
          padding: '6px 12px',
          borderRadius: '20px',
          marginBottom: '16px',
          textTransform: 'uppercase',
          letterSpacing: '0.5px'
        }}>
          Bem-vindo
        </span>

        <h1 style={{
          fontSize: '36px',
          fontWeight: '800',
          color: '#fff',
          marginBottom: '12px',
          letterSpacing: '-0.5px'
        }}>
          Olá, {user?.full_name || 'Estudante'}! 👋
        </h1>

        <p style={{
          fontSize: '16px',
          color: '#94a3b8',
          marginBottom: '32px',
          maxWidth: '600px',
          lineHeight: '1.6'
        }}>
          Que tal continuar sua jornada rumo à redação nota 1000? Escolha uma das opções abaixo para começar.
        </p>

        <div style={{
          display: 'flex',
          gap: '12px',
          flexWrap: 'wrap'
        }}>
          <a
            href="/painel/redigir-redacao"
            style={{
              padding: '14px 28px',
              background: '#4F46E5',
              color: '#fff',
              border: 'none',
              borderRadius: '12px',
              fontSize: '15px',
              fontWeight: '600',
              cursor: 'pointer',
              textDecoration: 'none',
              display: 'inline-flex',
              alignItems: 'center',
              gap: '8px',
              transition: 'all 0.2s',
              boxShadow: '0 4px 12px rgba(79, 70, 229, 0.3)'
            }}

            onMouseEnter={(e) => {
              e.currentTarget.style.background = '#4338ca';
              e.currentTarget.style.transform = 'translateY(-2px)';
              e.currentTarget.style.boxShadow = '0 6px 16px rgba(79, 70, 229, 0.4)';
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.background = '#4F46E5';
              e.currentTarget.style.transform = 'translateY(0)';
              e.currentTarget.style.boxShadow = '0 4px 12px rgba(79, 70, 229, 0.3)';
            }}
          >
            <span>✍️</span>
            Escrever Redação
          </a>

          <a
            href="/painel/minhas-redacoes"
            style={{
              padding: '14px 28px',
              background: 'transparent',
              color: '#94a3b8',
              border: '1px solid #334155',
              borderRadius: '12px',
              fontSize: '15px',
              fontWeight: '600',
              cursor: 'pointer',
              textDecoration: 'none',
              display: 'inline-flex',
              alignItems: 'center',
              gap: '8px',
              transition: 'all 0.2s'
            }}
            onMouseEnter={(e) => {
              e.currentTarget.style.background = '#334155';
              e.currentTarget.style.color = '#fff';
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.background = 'transparent';
              e.currentTarget.style.color = '#94a3b8';
            }}
          >
            <span>📄</span>
            Ver Minhas Redações
          </a>
        </div>
      </div>

      {/* Quick Actions Grid */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
        gap: '24px'
      }}>
        {/* Card 1 */}
        <a
          href="/painel/desenvolvimento"
          style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '16px',
            padding: '32px',
            textDecoration: 'none',
            transition: 'all 0.3s',
            display: 'block'
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.transform = 'translateY(-4px)';
            e.currentTarget.style.boxShadow = '0 12px 24px rgba(0, 0, 0, 0.3)';
            e.currentTarget.style.borderColor = '#4F46E5';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.transform = 'translateY(0)';
            e.currentTarget.style.boxShadow = 'none';
            e.currentTarget.style.borderColor = '#334155';
          }}
        >
          <div style={{
            width: '48px',
            height: '48px',
            background: '#4F46E520',
            borderRadius: '12px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontSize: '24px',
            marginBottom: '16px'
          }}>
            📊
          </div>
          <h3 style={{
            fontSize: '18px',
            fontWeight: '700',
            color: '#fff',
            marginBottom: '8px'
          }}>
            Meu Desenvolvimento
          </h3>
          <p style={{
            fontSize: '14px',
            color: '#64748b',
            lineHeight: '1.5'
          }}>
            Acompanhe sua evolução e veja seu progresso ao longo do tempo.
          </p>
        </a>

        {/* Card 2 */}
        <a
          href="/painel/comprar-creditos"
          style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '16px',
            padding: '32px',
            textDecoration: 'none',
            transition: 'all 0.3s',
            display: 'block'
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.transform = 'translateY(-4px)';
            e.currentTarget.style.boxShadow = '0 12px 24px rgba(0, 0, 0, 0.3)';
            e.currentTarget.style.borderColor = '#4F46E5';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.transform = 'translateY(0)';
            e.currentTarget.style.boxShadow = 'none';
            e.currentTarget.style.borderColor = '#334155';
          }}
        >
          <div style={{
            width: '48px',
            height: '48px',
            background: '#fbbf2420',
            borderRadius: '12px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontSize: '24px',
            marginBottom: '16px'
          }}>
            💰
          </div>
          <h3 style={{
            fontSize: '18px',
            fontWeight: '700',
            color: '#fff',
            marginBottom: '8px'
          }}>
            Comprar CorriCoins
          </h3>
          <p style={{
            fontSize: '14px',
            color: '#64748b',
            lineHeight: '1.5'
          }}>
            Adquira CorriCoins para corrigir mais redações e melhorar ainda mais.
          </p>
        </a>

        {/* Card 3 */}
        <a
          href="/painel/feedback"
          style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '16px',
            padding: '32px',
            textDecoration: 'none',
            transition: 'all 0.3s',
            display: 'block'
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.transform = 'translateY(-4px)';
            e.currentTarget.style.boxShadow = '0 12px 24px rgba(0, 0, 0, 0.3)';
            e.currentTarget.style.borderColor = '#4F46E5';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.transform = 'translateY(0)';
            e.currentTarget.style.boxShadow = 'none';
            e.currentTarget.style.borderColor = '#334155';
          }}
        >
          <div style={{
            width: '48px',
            height: '48px',
            background: '#10b98120',
            borderRadius: '12px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontSize: '24px',
            marginBottom: '16px'
          }}>
            💬
          </div>
          <h3 style={{
            fontSize: '18px',
            fontWeight: '700',
            color: '#fff',
            marginBottom: '8px'
          }}>
            Enviar Feedback
          </h3>
          <p style={{
            fontSize: '14px',
            color: '#64748b',
            lineHeight: '1.5'
          }}>
            Sua opinião é importante! Ajude-nos a melhorar a plataforma.
          </p>
        </a>
      </div>
    </PanelLayout>
  );
};

export default Painel;