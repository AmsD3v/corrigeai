import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import Header from '../../components/Header';
import SEOHead from '../../components/SEOHead';
import api from '../../services/api';

interface CompetenciaStats {
    competencia: number;
    media: number;
    nome: string;
}

interface ErroComum {
    tipo: string;
    percentual: number;
}

interface StatsData {
    total_correcoes: number;
    usuarios_ativos: number;
    media_nota_geral: number;
    media_por_competencia: CompetenciaStats[];
    erros_comuns: ErroComum[];
    taxa_melhoria: number;
    atualizado_em: string;
}

const Estatisticas = () => {
    const [stats, setStats] = useState<StatsData | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const response = await api.get('/api/public/stats');
                setStats(response.data);
            } catch {
                setError('Erro ao carregar estatísticas');
            } finally {
                setLoading(false);
            }
        };
        fetchStats();
    }, []);

    const formatNumber = (num: number) => {
        return num.toLocaleString('pt-BR');
    };

    return (
        <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
            <SEOHead
                title="Estatísticas de Correção de Redações | CorrigeAI"
                description="Veja estatísticas reais de correções de redação: média de notas por competência, erros mais comuns e taxa de melhoria dos estudantes."
                canonical="https://corrigeai.online/estatisticas"
                keywords="estatísticas redação enem, média notas enem, erros comuns redação, competências enem"
            />
            <Header />

            <main style={{ maxWidth: '1100px', margin: '0 auto', padding: '100px 20px 40px' }}>
                {/* Header */}
                <div style={{ textAlign: 'center', marginBottom: '48px' }}>
                    <h1 style={{ fontSize: '42px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>
                        📊 Estatísticas em Tempo Real
                    </h1>
                    <p style={{ fontSize: '18px', color: '#94a3b8', maxWidth: '600px', margin: '0 auto' }}>
                        Dados reais das correções realizadas pelo CorrigeAI com inteligência artificial
                    </p>
                    {stats?.atualizado_em && (
                        <p style={{ fontSize: '14px', color: '#64748b', marginTop: '12px' }}>
                            Última atualização: {stats.atualizado_em}
                        </p>
                    )}
                </div>

                {loading && (
                    <div style={{ textAlign: 'center', padding: '60px' }}>
                        <div style={{
                            width: '50px',
                            height: '50px',
                            border: '4px solid #334155',
                            borderTopColor: '#4F46E5',
                            borderRadius: '50%',
                            animation: 'spin 1s linear infinite',
                            margin: '0 auto'
                        }} />
                        <style>{`@keyframes spin { to { transform: rotate(360deg); } }`}</style>
                    </div>
                )}

                {error && (
                    <div style={{ textAlign: 'center', padding: '60px', color: '#ef4444' }}>
                        {error}
                    </div>
                )}

                {stats && (
                    <>
                        {/* Cards principais */}
                        <div style={{
                            display: 'grid',
                            gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))',
                            gap: '24px',
                            marginBottom: '48px'
                        }}>
                            <StatCard
                                icon="📝"
                                value={formatNumber(stats.total_correcoes)}
                                label="Redações Corrigidas"
                                color="#4F46E5"
                            />
                            <StatCard
                                icon="👥"
                                value={formatNumber(stats.usuarios_ativos)}
                                label="Estudantes Ativos"
                                color="#22c55e"
                            />
                            <StatCard
                                icon="⭐"
                                value={Math.round(stats.media_nota_geral).toString()}
                                label="Média de Nota Geral"
                                sublabel="de 1000 pontos"
                                color="#f59e0b"
                            />
                            <StatCard
                                icon="📈"
                                value={`+${stats.taxa_melhoria}%`}
                                label="Taxa de Melhoria"
                                sublabel="entre 1ª e 2ª redação"
                                color="#06b6d4"
                            />
                        </div>

                        {/* Média por Competência */}
                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #2c3344',
                            borderRadius: '16px',
                            padding: '32px',
                            marginBottom: '32px'
                        }}>
                            <h2 style={{ fontSize: '24px', fontWeight: '700', color: '#fff', marginBottom: '24px' }}>
                                📋 Média por Competência
                            </h2>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                                {stats.media_por_competencia.map((comp) => (
                                    <CompetenciaBar key={comp.competencia} {...comp} />
                                ))}
                            </div>
                        </div>

                        {/* Erros mais comuns */}
                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #2c3344',
                            borderRadius: '16px',
                            padding: '32px',
                            marginBottom: '32px'
                        }}>
                            <h2 style={{ fontSize: '24px', fontWeight: '700', color: '#fff', marginBottom: '24px' }}>
                                ⚠️ Erros Mais Comuns
                            </h2>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                                {stats.erros_comuns.map((erro, idx) => (
                                    <div key={idx} style={{
                                        display: 'flex',
                                        justifyContent: 'space-between',
                                        alignItems: 'center',
                                        padding: '16px',
                                        background: 'rgba(239, 68, 68, 0.1)',
                                        borderRadius: '8px',
                                        border: '1px solid rgba(239, 68, 68, 0.2)'
                                    }}>
                                        <span style={{ color: '#fff', fontWeight: '500' }}>
                                            {idx + 1}. {erro.tipo}
                                        </span>
                                        <span style={{
                                            color: '#ef4444',
                                            fontWeight: '700',
                                            fontSize: '18px'
                                        }}>
                                            {erro.percentual}% das redações
                                        </span>
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* CTA */}
                        <div style={{
                            background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                            borderRadius: '16px',
                            padding: '40px',
                            textAlign: 'center'
                        }}>
                            <h3 style={{ fontSize: '28px', fontWeight: '700', color: '#fff', marginBottom: '12px' }}>
                                Melhore suas notas com IA
                            </h3>
                            <p style={{ fontSize: '18px', color: 'rgba(255,255,255,0.9)', marginBottom: '24px', maxWidth: '600px', margin: '0 auto 24px' }}>
                                Receba feedback detalhado em cada competência e evolua sua escrita com inteligência artificial
                            </p>
                            <Link
                                to="/cadastro"
                                style={{
                                    display: 'inline-block',
                                    background: '#fff',
                                    color: '#4F46E5',
                                    padding: '16px 40px',
                                    borderRadius: '8px',
                                    fontWeight: '700',
                                    textDecoration: 'none',
                                    fontSize: '18px'
                                }}
                            >
                                Começar Agora - É Grátis →
                            </Link>
                        </div>
                    </>
                )}
            </main>

            {/* Footer */}
            <footer style={{ textAlign: 'center', padding: '40px 20px', color: '#64748b' }}>
                © 2025 CorrigeAI. Todos os direitos reservados.
            </footer>
        </div>
    );
};

interface StatCardProps {
    icon: string;
    value: string;
    label: string;
    sublabel?: string;
    color: string;
}

const StatCard = ({ icon, value, label, sublabel, color }: StatCardProps) => (
    <div style={{
        background: '#1a1f2e',
        border: '1px solid #2c3344',
        borderRadius: '16px',
        padding: '28px',
        textAlign: 'center',
        borderTop: `4px solid ${color}`
    }}>
        <div style={{ fontSize: '40px', marginBottom: '12px' }}>{icon}</div>
        <div style={{ fontSize: '36px', fontWeight: '800', color, marginBottom: '4px' }}>
            {value}
        </div>
        <div style={{ fontSize: '14px', color: '#fff', fontWeight: '600' }}>{label}</div>
        {sublabel && (
            <div style={{ fontSize: '12px', color: '#64748b', marginTop: '4px' }}>{sublabel}</div>
        )}
    </div>
);

const CompetenciaBar = ({ competencia, media, nome }: CompetenciaStats) => {
    const percentage = (media / 200) * 100;
    const color = percentage >= 70 ? '#22c55e' : percentage >= 50 ? '#f59e0b' : '#ef4444';

    return (
        <div>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px' }}>
                <span style={{ color: '#fff', fontWeight: '500' }}>
                    C{competencia}: {nome}
                </span>
                <span style={{ color, fontWeight: '700' }}>
                    {Math.round(media)}/200
                </span>
            </div>
            <div style={{
                height: '12px',
                background: '#2c3344',
                borderRadius: '6px',
                overflow: 'hidden'
            }}>
                <div style={{
                    width: `${percentage}%`,
                    height: '100%',
                    background: color,
                    borderRadius: '6px',
                    transition: 'width 0.5s ease'
                }} />
            </div>
        </div>
    );
};

export default Estatisticas;
