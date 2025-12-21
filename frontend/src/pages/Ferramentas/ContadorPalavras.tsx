import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import Header from '../../components/Header';
import SEOHead from '../../components/SEOHead';

const ContadorPalavras = () => {
    const [texto, setTexto] = useState('');
    const [stats, setStats] = useState({
        palavras: 0,
        caracteres: 0,
        caracteresSemEspaco: 0,
        linhas: 0,
        paragrafos: 0,
    });

    useEffect(() => {
        const text = texto.trim();

        const palavras = text ? text.split(/\s+/).filter(word => word.length > 0).length : 0;
        const caracteres = texto.length;
        const caracteresSemEspaco = texto.replace(/\s/g, '').length;
        const linhas = texto ? texto.split('\n').length : 0;
        const paragrafos = text ? text.split(/\n\s*\n/).filter(p => p.trim().length > 0).length : 0;

        setStats({ palavras, caracteres, caracteresSemEspaco, linhas, paragrafos });
    }, [texto]);

    const getLinhasIdeal = (): { status: 'neutral' | 'success' | 'warning' | 'error'; message: string } => {
        if (stats.linhas === 0) return { status: 'neutral', message: 'Cole sua redação' };
        if (stats.linhas < 7) return { status: 'error', message: 'Mínimo 7 linhas para ENEM' };
        if (stats.linhas < 20) return { status: 'warning', message: 'Ideal: 25-30 linhas' };
        if (stats.linhas <= 30) return { status: 'success', message: 'Quantidade ideal!' };
        return { status: 'warning', message: 'Máximo 30 linhas no ENEM' };
    };

    const linhasStatus = getLinhasIdeal();

    return (
        <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
            <SEOHead
                title="Contador de Palavras para Redação ENEM | CorrigeAI"
                description="Conte palavras, caracteres e linhas da sua redação gratuitamente. Verifique se sua redação está no tamanho ideal para o ENEM (25-30 linhas)."
                canonical="https://corrigeai.online/ferramentas/contador-palavras"
                keywords="contador de palavras, contador de caracteres, quantas linhas redação enem, tamanho redação enem"
            />
            <Header />

            <main style={{ maxWidth: '900px', margin: '0 auto', padding: '100px 20px 40px' }}>
                {/* Breadcrumb */}
                <nav style={{ marginBottom: '24px' }}>
                    <Link to="/ferramentas" style={{ color: '#818cf8', textDecoration: 'none' }}>
                        Ferramentas
                    </Link>
                    <span style={{ color: '#64748b', margin: '0 8px' }}>/</span>
                    <span style={{ color: '#94a3b8' }}>Contador de Palavras</span>
                </nav>

                {/* Header */}
                <div style={{ textAlign: 'center', marginBottom: '40px' }}>
                    <h1 style={{ fontSize: '36px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>
                        📝 Contador de Palavras para Redação
                    </h1>
                    <p style={{ fontSize: '18px', color: '#94a3b8', maxWidth: '600px', margin: '0 auto' }}>
                        Verifique se sua redação está no tamanho ideal para o ENEM.
                        <strong style={{ color: '#818cf8' }}> Ideal: 25-30 linhas</strong>
                    </p>
                </div>

                {/* Área de texto */}
                <div style={{ marginBottom: '24px' }}>
                    <textarea
                        value={texto}
                        onChange={(e) => setTexto(e.target.value)}
                        placeholder="Cole sua redação aqui..."
                        style={{
                            width: '100%',
                            minHeight: '300px',
                            padding: '20px',
                            fontSize: '16px',
                            lineHeight: '1.8',
                            background: '#1a1f2e',
                            border: '2px solid #2c3344',
                            borderRadius: '12px',
                            color: '#fff',
                            resize: 'vertical',
                            fontFamily: 'Inter, sans-serif',
                        }}
                    />
                </div>

                {/* Estatísticas */}
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))',
                    gap: '16px',
                    marginBottom: '32px'
                }}>
                    <StatCard label="Palavras" value={stats.palavras} />
                    <StatCard label="Caracteres" value={stats.caracteres} />
                    <StatCard label="Sem espaços" value={stats.caracteresSemEspaco} />
                    <StatCard
                        label="Linhas"
                        value={stats.linhas}
                        status={linhasStatus.status}
                        hint={linhasStatus.message}
                    />
                    <StatCard label="Parágrafos" value={stats.paragrafos} />
                </div>

                {/* Dicas */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #2c3344',
                    borderRadius: '12px',
                    padding: '24px',
                    marginBottom: '32px'
                }}>
                    <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#fff', marginBottom: '16px' }}>
                        📌 Dicas para o ENEM
                    </h2>
                    <ul style={{ color: '#94a3b8', lineHeight: '2', margin: 0, paddingLeft: '20px' }}>
                        <li><strong>Mínimo:</strong> 7 linhas (menos que isso zera a redação)</li>
                        <li><strong>Ideal:</strong> 25-30 linhas para desenvolver bem os argumentos</li>
                        <li><strong>Estrutura:</strong> 4 parágrafos (intro + 2 desenvolvimento + conclusão)</li>
                        <li><strong>Proposta:</strong> A conclusão deve ter os 5 elementos obrigatórios</li>
                    </ul>
                </div>

                {/* CTA */}
                <div style={{
                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                    borderRadius: '16px',
                    padding: '32px',
                    textAlign: 'center'
                }}>
                    <h3 style={{ fontSize: '24px', fontWeight: '700', color: '#fff', marginBottom: '12px' }}>
                        Quer saber sua nota?
                    </h3>
                    <p style={{ fontSize: '16px', color: 'rgba(255,255,255,0.9)', marginBottom: '20px' }}>
                        O CorrigeAI corrige sua redação com IA e dá feedback detalhado em segundos!
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
                        Corrigir Minha Redação Grátis →
                    </Link>
                </div>
            </main>

            {/* Footer simples */}
            <footer style={{ textAlign: 'center', padding: '40px 20px', color: '#64748b' }}>
                © 2025 CorrigeAI. Todos os direitos reservados.
            </footer>
        </div>
    );
};

interface StatCardProps {
    label: string;
    value: number;
    status?: 'neutral' | 'success' | 'warning' | 'error';
    hint?: string;
}

const StatCard = ({ label, value, status = 'neutral', hint }: StatCardProps) => {
    const statusColors = {
        neutral: '#818cf8',
        success: '#22c55e',
        warning: '#f59e0b',
        error: '#ef4444',
    };

    return (
        <div style={{
            background: '#1a1f2e',
            border: '1px solid #2c3344',
            borderRadius: '12px',
            padding: '20px',
            textAlign: 'center'
        }}>
            <div style={{ fontSize: '32px', fontWeight: '800', color: statusColors[status] }}>
                {value.toLocaleString()}
            </div>
            <div style={{ fontSize: '14px', color: '#94a3b8', marginTop: '4px' }}>{label}</div>
            {hint && (
                <div style={{ fontSize: '11px', color: statusColors[status], marginTop: '8px' }}>
                    {hint}
                </div>
            )}
        </div>
    );
};

export default ContadorPalavras;
