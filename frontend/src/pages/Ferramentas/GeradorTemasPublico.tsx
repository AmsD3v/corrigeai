import { useState } from 'react';
import { Link } from 'react-router-dom';
import Header from '../../components/Header';
import SEOHead from '../../components/SEOHead';

// Temas pré-definidos para exibição pública (sem API)
const TEMAS_EXEMPLO = [
    // ENEM
    {
        id: 1,
        titulo: 'Perspectivas acerca do envelhecimento na sociedade brasileira',
        ano: '2025',
        vestibular: 'ENEM',
        destaque: true,
    },
    {
        id: 2,
        titulo: 'Desafios para o enfrentamento da invisibilidade do trabalho de cuidado no Brasil',
        ano: '2023',
        vestibular: 'ENEM',
    },
    {
        id: 3,
        titulo: 'Desafios para a valorização de comunidades e povos tradicionais no Brasil',
        ano: '2022',
        vestibular: 'ENEM',
    },
    // FUVEST
    {
        id: 4,
        titulo: 'O papel da ciência no mundo contemporâneo',
        ano: '2024',
        vestibular: 'FUVEST',
    },
    {
        id: 5,
        titulo: 'A importância do acesso à cultura para a formação cidadã',
        ano: '2023',
        vestibular: 'FUVEST',
    },
    // UNICAMP
    {
        id: 6,
        titulo: 'Inteligência artificial: avanços e riscos para a sociedade',
        ano: '2024',
        vestibular: 'UNICAMP',
    },
    {
        id: 7,
        titulo: 'O papel das redes sociais na formação de opinião pública',
        ano: '2023',
        vestibular: 'UNICAMP',
    },
    // UFRGS
    {
        id: 8,
        titulo: 'Desafios da mobilidade urbana nas grandes cidades brasileiras',
        ano: '2024',
        vestibular: 'UFRGS',
    },
    // UERJ
    {
        id: 9,
        titulo: 'A preservação do patrimônio histórico e cultural brasileiro',
        ano: '2024',
        vestibular: 'UERJ',
    },
    // UNB
    {
        id: 10,
        titulo: 'Fake news e seus impactos na democracia',
        ano: '2024',
        vestibular: 'UNB',
    },
    // PUC
    {
        id: 11,
        titulo: 'Saúde mental dos jovens na era digital',
        ano: '2024',
        vestibular: 'PUC-SP',
    },
    // UFMG
    {
        id: 12,
        titulo: 'O combate às desigualdades sociais no Brasil pós-pandemia',
        ano: '2023',
        vestibular: 'UFMG',
    },
];

const GeradorTemasPublico = () => {
    const [temasVisiveis, setTemasVisiveis] = useState(3);

    const mostrarMais = () => {
        setTemasVisiveis(prev => Math.min(prev + 3, TEMAS_EXEMPLO.length));
    };

    return (
        <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
            <SEOHead
                title="Temas de Redação: ENEM, FUVEST, UNICAMP e Vestibulares 2025 | CorrigeAI"
                description="Veja temas de redação do ENEM, FUVEST, UNICAMP, UFRGS e outros vestibulares. Pratique com temas reais e receba correção por IA."
                canonical="https://corrigeai.online/ferramentas/gerador-temas"
                keywords="temas redação enem 2025, temas fuvest, temas unicamp, vestibulares, praticar redação"
            />
            <Header />

            <main style={{ maxWidth: '900px', margin: '0 auto', padding: '100px 20px 40px' }}>
                {/* Breadcrumb */}
                <nav style={{ marginBottom: '24px' }}>
                    <Link to="/ferramentas" style={{ color: '#818cf8', textDecoration: 'none' }}>
                        Ferramentas
                    </Link>
                    <span style={{ color: '#64748b', margin: '0 8px' }}>/</span>
                    <span style={{ color: '#94a3b8' }}>Temas de Redação</span>
                </nav>

                {/* Header */}
                <div style={{ textAlign: 'center', marginBottom: '40px' }}>
                    <h1 style={{ fontSize: '36px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>
                        📚 Temas de Redação - Vestibulares
                    </h1>
                    <p style={{ fontSize: '18px', color: '#94a3b8', maxWidth: '600px', margin: '0 auto' }}>
                        Pratique com temas reais do ENEM, FUVEST, UNICAMP e outros vestibulares
                    </p>
                </div>

                {/* Lista de Temas */}
                <div style={{ marginBottom: '32px' }}>
                    {TEMAS_EXEMPLO.slice(0, temasVisiveis).map((tema) => (
                        <div
                            key={tema.id}
                            style={{
                                background: tema.destaque
                                    ? 'linear-gradient(135deg, #1e1b4b 0%, #312e81 100%)'
                                    : '#1a1f2e',
                                border: tema.destaque ? '2px solid #818cf8' : '1px solid #2c3344',
                                borderRadius: '12px',
                                padding: '24px',
                                marginBottom: '16px',
                            }}
                        >
                            {tema.destaque && (
                                <span style={{
                                    background: '#818cf8',
                                    color: '#fff',
                                    padding: '4px 12px',
                                    borderRadius: '20px',
                                    fontSize: '12px',
                                    fontWeight: '600',
                                    marginBottom: '12px',
                                    display: 'inline-block'
                                }}>
                                    🔥 TEMA 2025
                                </span>
                            )}
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', gap: '16px' }}>
                                <div style={{ flex: 1 }}>
                                    <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', margin: '0 0 8px 0' }}>
                                        {tema.titulo}
                                    </h3>
                                    <div style={{ display: 'flex', gap: '12px' }}>
                                        <span style={{ fontSize: '14px', color: '#818cf8' }}>{tema.vestibular}</span>
                                        <span style={{ fontSize: '14px', color: '#64748b' }}>{tema.ano}</span>
                                    </div>
                                </div>
                                <Link
                                    to="/cadastro"
                                    style={{
                                        background: '#4F46E5',
                                        color: '#fff',
                                        padding: '10px 20px',
                                        borderRadius: '8px',
                                        fontWeight: '600',
                                        textDecoration: 'none',
                                        fontSize: '14px',
                                        whiteSpace: 'nowrap'
                                    }}
                                >
                                    Praticar →
                                </Link>
                            </div>
                        </div>
                    ))}
                </div>

                {/* Mostrar Mais */}
                {temasVisiveis < TEMAS_EXEMPLO.length && (
                    <div style={{ textAlign: 'center', marginBottom: '32px' }}>
                        <button
                            onClick={mostrarMais}
                            style={{
                                background: 'transparent',
                                border: '2px solid #4F46E5',
                                color: '#818cf8',
                                padding: '12px 32px',
                                borderRadius: '8px',
                                fontWeight: '600',
                                cursor: 'pointer',
                                fontSize: '16px'
                            }}
                        >
                            Ver Mais Temas
                        </button>
                    </div>
                )}

                {/* Info Box */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #2c3344',
                    borderRadius: '12px',
                    padding: '24px',
                    marginBottom: '32px'
                }}>
                    <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#fff', marginBottom: '16px' }}>
                        💡 Como Usar Esta Ferramenta
                    </h2>
                    <ol style={{ color: '#94a3b8', lineHeight: '2', margin: 0, paddingLeft: '20px' }}>
                        <li>Escolha um tema para praticar</li>
                        <li>Escreva sua redação (25-30 linhas)</li>
                        <li>Envie para correção no CorrigeAI</li>
                        <li>Receba feedback detalhado em segundos</li>
                        <li>Melhore com base nas sugestões da IA</li>
                    </ol>
                </div>

                {/* CTA */}
                <div style={{
                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                    borderRadius: '16px',
                    padding: '32px',
                    textAlign: 'center'
                }}>
                    <h3 style={{ fontSize: '24px', fontWeight: '700', color: '#fff', marginBottom: '12px' }}>
                        Acesse todos os temas e funcionalidades
                    </h3>
                    <p style={{ fontSize: '16px', color: 'rgba(255,255,255,0.9)', marginBottom: '20px' }}>
                        No painel do CorrigeAI você tem acesso a gerador de temas com textos motivadores, correção ilimitada e muito mais!
                    </p>
                    <Link
                        to="/cadastro"
                        style={{
                            display: 'inline-block',
                            background: '#fff',
                            color: '#4F46E5',
                            padding: '14px 32px',
                            borderRadius: '8px',
                            fontWeight: '700',
                            textDecoration: 'none',
                            fontSize: '16px'
                        }}
                    >
                        Criar Conta Grátis →
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

export default GeradorTemasPublico;
