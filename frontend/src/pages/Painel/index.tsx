import PanelLayout from '../../components/PanelLayout';
import { useAuth } from '../../contexts/AuthContext';

const Painel = () => {
  const { user } = useAuth();

  return (
    <PanelLayout activePage="/painel">
      {/* Welcome Card */}
      <div className="bg-[#1a1f2e] border border-[#334155] rounded-2xl p-6 md:p-8 lg:p-10 mb-8 relative overflow-hidden">
        <div className="absolute -top-12 -right-12 w-48 h-48 pointer-events-none" style={{
          background: 'radial-gradient(circle, rgba(79, 70, 229, 0.1) 0%, transparent 70%)'
        }} />

        <span className="inline-block bg-[#334155] text-[#94a3b8] text-[10px] md:text-xs font-bold px-3 py-1.5 rounded-full mb-4 uppercase tracking-wide">
          Bem-vindo
        </span>

        <h1 className="text-2xl md:text-3xl lg:text-4xl font-extrabold text-white mb-3 tracking-tight">
          Olá, {user?.full_name || 'Estudante'}! 👋
        </h1>

        <p className="text-sm md:text-base text-[#94a3b8] mb-6 md:mb-8 max-w-2xl leading-relaxed">
          Que tal continuar sua jornada rumo à redação nota 1000? Escolha uma das opções abaixo para começar.
        </p>

        <div className="flex flex-col sm:flex-row gap-3">
          <a
            href="/painel/redigir-redacao"
            className="inline-flex items-center justify-center gap-2 px-6 py-3.5 bg-[#4F46E5] hover:bg-[#4338ca] text-white rounded-xl text-sm md:text-base font-semibold transition-all shadow-lg shadow-[rgba(79,70,229,0.3)] hover:shadow-[rgba(79,70,229,0.5)] hover:-translate-y-0.5 no-underline"
          >
            <span>✍️</span>
            Escrever Redação
          </a>

          <a
            href="/painel/minhas-redacoes"
            className="inline-flex items-center justify-center gap-2 px-6 py-3.5 bg-transparent hover:bg-[#334155] text-[#94a3b8] hover:text-white border border-[#334155] rounded-xl text-sm md:text-base font-semibold transition-all no-underline"
          >
            <span>📄</span>
            Ver Minhas Redações
          </a>
        </div>
      </div>

      {/* Quick Actions Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {/* Card 1 */}
        <a
          href="/painel/desenvolvimento"
          className="block bg-[#1a1f2e] border border-[#334155] rounded-2xl p-6 md:p-8 no-underline transition-all hover:-translate-y-1 hover:shadow-xl hover:shadow-black/30 hover:border-[#4F46E5]"
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