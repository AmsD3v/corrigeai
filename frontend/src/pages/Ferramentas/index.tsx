import { Link } from 'react-router-dom';
import Header from '../../components/Header';
import SEOHead from '../../components/SEOHead';

const ferramentas = [
    {
        id: 'contador',
        titulo: 'Contador de Palavras',
        descricao: 'Conte palavras, caracteres e linhas da sua redação. Verifique se está no tamanho ideal para o ENEM.',
        icone: '📝',
        link: '/ferramentas/contador-palavras',
        tags: ['Grátis', 'Sem cadastro'],
    },
    {
        id: 'temas',
        titulo: 'Temas de Redação ENEM',
        descricao: 'Veja temas anteriores do ENEM e pratique sua redação com correção por IA.',
        icone: '📚',
        link: '/ferramentas/gerador-temas',
        tags: ['Temas reais', 'ENEM 2025'],
    },
    {
        id: 'estatisticas',
        titulo: 'Estatísticas de Correções',
        descricao: 'Dados reais: média de notas, erros comuns e taxa de melhoria dos estudantes.',
        icone: '📊',
        link: '/estatisticas',
        tags: ['Dados reais', 'Atualizado'],
    },
    {
        id: 'verificador',
        titulo: 'Verificador de Repertórios',
        descricao: 'Identifique os repertórios socioculturais mencionados na sua redação.',
        icone: '🔍',
        link: '/ferramentas/verificar-repertorio',
        tags: ['Grátis', 'Novo'],
    },
    {
        id: 'repertorios',
        titulo: 'Repertórios Socioculturais',
        descricao: 'Explore nossa biblioteca de repertórios para usar na sua redação.',
        icone: '📖',
        link: '/repertorios',
        tags: ['Filósofos', 'Citações'],
    },
    {
        id: 'correcao',
        titulo: 'Correção com IA',
        descricao: 'Envie sua redação e receba feedback detalhado em segundos usando inteligência artificial.',
        icone: '🤖',
        link: '/cadastro',
        tags: ['Instantâneo', 'Detalhado'],
        destaque: true,
    },
];

const Ferramentas = () => {
    return (
        <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
            <SEOHead
                title="Ferramentas Grátis para Redação ENEM | CorrigeAI"
                description="Ferramentas gratuitas para melhorar sua redação: contador de palavras, temas do ENEM, repertórios socioculturais e correção com IA."
                canonical="https://corrigeai.online/ferramentas"
                keywords="ferramentas redação enem, contador palavras, temas redação, repertórios enem, correção redação"
            />
            <Header />

            <main style={{ maxWidth: '1000px', margin: '0 auto', padding: '100px 20px 40px' }}>
                {/* Header */}
                <div style={{ textAlign: 'center', marginBottom: '48px' }}>
                    <h1 style={{ fontSize: '42px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>
                        🛠️ Ferramentas Grátis
                    </h1>
                    <p style={{ fontSize: '18px', color: '#94a3b8', maxWidth: '600px', margin: '0 auto' }}>
                        Recursos gratuitos para você se preparar melhor para a redação do ENEM e outros vestibulares
                    </p>
                </div>

                {/* Grid de Ferramentas */}
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
                    gap: '24px',
                    marginBottom: '48px'
                }}>
                    {ferramentas.map((ferramenta) => (
                        <Link
                            key={ferramenta.id}
                            to={ferramenta.link}
                            style={{
                                textDecoration: 'none',
                                background: ferramenta.destaque
                                    ? 'linear-gradient(135deg, #1e1b4b 0%, #312e81 100%)'
                                    : '#1a1f2e',
                                border: ferramenta.destaque ? '2px solid #818cf8' : '1px solid #2c3344',
                                borderRadius: '16px',
                                padding: '28px',
                                transition: 'all 0.2s ease',
                                display: 'block',
                            }}
                            onMouseEnter={(e) => {
                                e.currentTarget.style.transform = 'translateY(-4px)';
                                e.currentTarget.style.boxShadow = '0 12px 40px rgba(79, 70, 229, 0.15)';
                            }}
                            onMouseLeave={(e) => {
                                e.currentTarget.style.transform = 'translateY(0)';
                                e.currentTarget.style.boxShadow = 'none';
                            }}
                        >
                            <div style={{ fontSize: '40px', marginBottom: '16px' }}>
                                {ferramenta.icone}
                            </div>
                            <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#fff', marginBottom: '8px' }}>
                                {ferramenta.titulo}
                            </h2>
                            <p style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '16px', lineHeight: '1.6' }}>
                                {ferramenta.descricao}
                            </p>
                            <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap' }}>
                                {ferramenta.tags.map((tag) => (
                                    <span
                                        key={tag}
                                        style={{
                                            background: 'rgba(129, 140, 248, 0.1)',
                                            color: '#818cf8',
                                            padding: '4px 10px',
                                            borderRadius: '20px',
                                            fontSize: '12px',
                                            fontWeight: '500',
                                        }}
                                    >
                                        {tag}
                                    </span>
                                ))}
                            </div>
                        </Link>
                    ))}
                </div>

                {/* CTA Blog */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #2c3344',
                    borderRadius: '16px',
                    padding: '32px',
                    textAlign: 'center'
                }}>
                    <h3 style={{ fontSize: '24px', fontWeight: '700', color: '#fff', marginBottom: '12px' }}>
                        📝 Aprenda mais no Blog
                    </h3>
                    <p style={{ fontSize: '16px', color: '#94a3b8', marginBottom: '20px' }}>
                        Artigos completos sobre as 5 competências do ENEM, dicas de escrita e muito mais
                    </p>
                    <Link
                        to="/blog"
                        style={{
                            display: 'inline-block',
                            background: '#4F46E5',
                            color: '#fff',
                            padding: '14px 32px',
                            borderRadius: '8px',
                            fontWeight: '700',
                            textDecoration: 'none',
                            fontSize: '16px'
                        }}
                    >
                        Acessar Blog →
                    </Link>
                </div>
            </main>

            {/* Footer */}
            <footer style={{ textAlign: 'center', padding: '40px 20px', color: '#64748b' }}>
                © 2025 CorrigeAI. Todos os direitos reservados.
            </footer>
        </div>
    );
};

export default Ferramentas;
