import { useState } from 'react';
import { Link } from 'react-router-dom';
import Header from '../../components/Header';
import SEOHead from '../../components/SEOHead';

// Temas pré-definidos para exibição pública (sem API)
const TEMAS_EXEMPLO = [
    {
        id: 1,
        titulo: 'Desafios para o enfrentamento da invisibilidade do trabalho de cuidado no Brasil',
        ano: '2023',
        vestibular: 'ENEM',
    },
    {
        id: 2,
        titulo: 'Desafios para a valorização de comunidades e povos tradicionais no Brasil',
        ano: '2022',
        vestibular: 'ENEM',
    },
    {
        id: 3,
        titulo: 'Invisibilidade e registro civil: garantia de acesso à cidadania no Brasil',
        ano: '2021',
        vestibular: 'ENEM',
    },
    {
        id: 4,
        titulo: 'O estigma associado às doenças mentais na sociedade brasileira',
        ano: '2020',
        vestibular: 'ENEM',
    },
    {
        id: 5,
        titulo: 'Democratização do acesso ao cinema no Brasil',
        ano: '2019',
        vestibular: 'ENEM',
    },
    {
        id: 6,
        titulo: 'Perspectivas acerca do envelhecimento na sociedade brasileira',
        ano: '2025',
        vestibular: 'ENEM',
        destaque: true,
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
                title="Temas de Redação ENEM 2025: Lista Completa | CorrigeAI"
                description="Veja os temas de redação do ENEM dos últimos anos e pratique com correção por IA. Prepare-se para o ENEM 2025 com temas anteriores."
                canonical="https://corrigeai.online/ferramentas/gerador-temas"
                keywords="temas redação enem 2025, temas enem anteriores, temas de redação, praticar redação enem"
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
                        📚 Temas de Redação ENEM
                    </h1>
                    <p style={{ fontSize: '18px', color: '#94a3b8', maxWidth: '600px', margin: '0 auto' }}>
                        Pratique com temas reais do ENEM e receba correção instantânea com IA
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
