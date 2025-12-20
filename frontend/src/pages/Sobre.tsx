import { Link } from 'react-router-dom';
import SEOHead from '../components/SEOHead';

const Sobre = () => {
    return (
        <>
            <SEOHead
                title="Sobre o CorrigeAI - Correção de Redação com Inteligência Artificial"
                description="Conheça o CorrigeAI, a plataforma de correção de redação ENEM com Inteligência Artificial. Saiba como funciona, nossa missão e como podemos ajudar você a melhorar sua nota."
                canonical="https://corrigeai.online/sobre"
                keywords="sobre corrigeai, correção redação ia, como funciona corrigeai, plataforma redação enem, inteligência artificial educação"
            />

            {/* Schema.org BreadcrumbList */}
            <script type="application/ld+json" dangerouslySetInnerHTML={{
                __html: JSON.stringify({
                    "@context": "https://schema.org",
                    "@type": "BreadcrumbList",
                    "itemListElement": [
                        {
                            "@type": "ListItem",
                            "position": 1,
                            "name": "Início",
                            "item": "https://corrigeai.online/"
                        },
                        {
                            "@type": "ListItem",
                            "position": 2,
                            "name": "Sobre",
                            "item": "https://corrigeai.online/sobre"
                        }
                    ]
                })
            }} />

            <div style={{
                minHeight: '100vh',
                background: 'linear-gradient(180deg, #0f1419 0%, #1a1f2e 100%)',
                color: '#fff',
                fontFamily: "'Inter', sans-serif"
            }}>
                {/* Header */}
                <header style={{
                    padding: '20px 40px',
                    display: 'flex',
                    justifyContent: 'space-between',
                    alignItems: 'center',
                    borderBottom: '1px solid #334155'
                }}>
                    <Link to="/" style={{ textDecoration: 'none' }}>
                        <h1 style={{
                            fontSize: '24px',
                            fontWeight: '800',
                            background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                            WebkitBackgroundClip: 'text',
                            WebkitTextFillColor: 'transparent'
                        }}>
                            CorrigeAI
                        </h1>
                    </Link>
                    <nav style={{ display: 'flex', gap: '24px' }}>
                        <Link to="/" style={{ color: '#94a3b8', textDecoration: 'none' }}>Início</Link>
                        <Link to="/blog" style={{ color: '#94a3b8', textDecoration: 'none' }}>Blog</Link>
                        <Link to="/login" style={{ color: '#94a3b8', textDecoration: 'none' }}>Entrar</Link>
                    </nav>
                </header>

                {/* Main Content */}
                <main style={{ maxWidth: '800px', margin: '0 auto', padding: '60px 20px' }}>
                    {/* Breadcrumb */}
                    <nav style={{ marginBottom: '32px' }}>
                        <ol style={{
                            display: 'flex',
                            gap: '8px',
                            listStyle: 'none',
                            padding: 0,
                            margin: 0,
                            fontSize: '14px',
                            color: '#94a3b8'
                        }}>
                            <li><Link to="/" style={{ color: '#4F46E5' }}>Início</Link></li>
                            <li>/</li>
                            <li>Sobre</li>
                        </ol>
                    </nav>

                    <h1 style={{
                        fontSize: '42px',
                        fontWeight: '800',
                        marginBottom: '24px',
                        lineHeight: '1.2'
                    }}>
                        Sobre o CorrigeAI
                    </h1>

                    <p style={{
                        fontSize: '18px',
                        color: '#94a3b8',
                        lineHeight: '1.8',
                        marginBottom: '40px'
                    }}>
                        O CorrigeAI é uma plataforma inovadora que utiliza <strong style={{ color: '#fff' }}>Inteligência Artificial</strong> para
                        corrigir redações do ENEM e outros vestibulares, oferecendo feedback detalhado e instantâneo.
                    </p>

                    {/* Como Funciona */}
                    <section style={{ marginBottom: '48px' }}>
                        <h2 style={{
                            fontSize: '28px',
                            fontWeight: '700',
                            marginBottom: '20px',
                            color: '#4F46E5'
                        }}>
                            🤖 Como Funciona?
                        </h2>
                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '12px',
                            padding: '24px'
                        }}>
                            <ol style={{
                                color: '#d1d5db',
                                lineHeight: '2',
                                paddingLeft: '20px',
                                margin: 0
                            }}>
                                <li><strong>Envie sua redação</strong> - Cole ou digite seu texto na plataforma</li>
                                <li><strong>IA analisa</strong> - Nossa IA avalia seguindo os critérios oficiais do ENEM</li>
                                <li><strong>Receba feedback</strong> - Nota por competência e sugestões de melhoria em segundos</li>
                                <li><strong>Evolua</strong> - Use o feedback para aprimorar suas redações</li>
                            </ol>
                        </div>
                    </section>

                    {/* Por que CorrigeAI */}
                    <section style={{ marginBottom: '48px' }}>
                        <h2 style={{
                            fontSize: '28px',
                            fontWeight: '700',
                            marginBottom: '20px',
                            color: '#10b981'
                        }}>
                            ✨ Por que escolher o CorrigeAI?
                        </h2>
                        <div style={{
                            display: 'grid',
                            gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                            gap: '16px'
                        }}>
                            {[
                                { icon: '⚡', title: 'Instantâneo', desc: 'Feedback em segundos, não dias' },
                                { icon: '🎯', title: 'Preciso', desc: 'Segue os critérios oficiais do ENEM' },
                                { icon: '💰', title: 'Gratuito', desc: 'Correções grátis todos os dias' },
                                { icon: '🎮', title: 'Gamificação', desc: 'Aprenda jogando e ganhe recompensas' },
                                { icon: '📊', title: 'Detalhado', desc: 'Nota por competência e sugestões' },
                                { icon: '🏆', title: '40+ Vestibulares', desc: 'ENEM, FUVEST, UNICAMP e mais' }
                            ].map((item, i) => (
                                <div key={i} style={{
                                    background: '#1a1f2e',
                                    border: '1px solid #334155',
                                    borderRadius: '12px',
                                    padding: '20px'
                                }}>
                                    <div style={{ fontSize: '32px', marginBottom: '12px' }}>{item.icon}</div>
                                    <h3 style={{ fontSize: '18px', fontWeight: '600', marginBottom: '8px' }}>{item.title}</h3>
                                    <p style={{ fontSize: '14px', color: '#94a3b8', margin: 0 }}>{item.desc}</p>
                                </div>
                            ))}
                        </div>
                    </section>

                    {/* Nossa Missão */}
                    <section style={{ marginBottom: '48px' }}>
                        <h2 style={{
                            fontSize: '28px',
                            fontWeight: '700',
                            marginBottom: '20px',
                            color: '#f59e0b'
                        }}>
                            🎯 Nossa Missão
                        </h2>
                        <p style={{
                            fontSize: '16px',
                            color: '#d1d5db',
                            lineHeight: '1.8'
                        }}>
                            Democratizar o acesso à educação de qualidade, permitindo que qualquer estudante brasileiro
                            tenha acesso a correções de redação profissionais, instantâneas e acessíveis. Acreditamos que
                            a tecnologia pode transformar a educação e ajudar milhares de estudantes a alcançarem seus sonhos.
                        </p>
                    </section>

                    {/* CTA */}
                    <section style={{
                        background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                        borderRadius: '16px',
                        padding: '40px',
                        textAlign: 'center'
                    }}>
                        <h2 style={{
                            fontSize: '28px',
                            fontWeight: '700',
                            marginBottom: '16px'
                        }}>
                            Pronto para melhorar sua redação?
                        </h2>
                        <p style={{
                            fontSize: '16px',
                            opacity: 0.9,
                            marginBottom: '24px'
                        }}>
                            Comece agora mesmo, é grátis!
                        </p>
                        <Link to="/cadastro" style={{
                            display: 'inline-block',
                            background: '#fff',
                            color: '#4F46E5',
                            padding: '14px 32px',
                            borderRadius: '8px',
                            fontWeight: '600',
                            textDecoration: 'none',
                            fontSize: '16px'
                        }}>
                            Criar Conta Grátis →
                        </Link>
                    </section>
                </main>

                {/* Footer */}
                <footer style={{
                    borderTop: '1px solid #334155',
                    padding: '40px 20px',
                    textAlign: 'center',
                    color: '#64748b',
                    fontSize: '14px'
                }}>
                    <p>© 2025 CorrigeAI. Todos os direitos reservados.</p>
                    <div style={{ marginTop: '16px', display: 'flex', justifyContent: 'center', gap: '24px' }}>
                        <Link to="/" style={{ color: '#94a3b8' }}>Início</Link>
                        <Link to="/blog" style={{ color: '#94a3b8' }}>Blog</Link>
                        <Link to="/login" style={{ color: '#94a3b8' }}>Entrar</Link>
                    </div>
                </footer>
            </div>
        </>
    );
};

export default Sobre;
