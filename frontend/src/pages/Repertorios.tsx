import { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import Header from '../components/Header';

// Repertórios organizados por vestibular
const REPERTORIOS_POR_VESTIBULAR = {
    enem: {
        nome: "ENEM",
        temas: [
            {
                titulo: "Envelhecimento Populacional",
                descricao: "Tema oficial ENEM 2024: Perspectivas acerca do envelhecimento na sociedade brasileira",
                citacoes: [
                    "Simone de Beauvoir - 'A Velhice': análise da marginalização dos idosos",
                    "IBGE 2023: Brasil terá mais idosos que jovens até 2040",
                    "Estatuto do Idoso (Lei 10.741/2003)"
                ],
                filmes: ["Amor (2012)", "A Baleia (2022)", "Amour (Michael Haneke)"],
                argumentos: ["Políticas de saúde pública", "Previdência social", "Inclusão digital de idosos"]
            },
            {
                titulo: "Saúde Mental",
                descricao: "Ansiedade, depressão e bem-estar psicológico na sociedade contemporânea",
                citacoes: [
                    "OMS: Depressão é a principal causa de incapacidade no mundo",
                    "Byung-Chul Han - 'Sociedade do Cansaço'",
                    "Lei 10.216/2001 - Reforma Psiquiátrica"
                ],
                filmes: ["O Lado Bom da Vida", "Uma Mente Brilhante", "Precisamos Falar Sobre o Kevin"],
                argumentos: ["Acesso a tratamento no SUS", "Estigma social", "Prevenção ao suicídio"]
            },
            {
                titulo: "Desinformação Digital",
                descricao: "Fake news, manipulação de informação e democracia",
                citacoes: [
                    "Hannah Arendt - 'Verdade e Política'",
                    "Marco Civil da Internet (Lei 12.965/2014)",
                    "Umberto Eco: 'Redes sociais deram voz a legião de imbecis'"
                ],
                filmes: ["O Dilema das Redes", "Privacidade Hackeada", "O Círculo"],
                argumentos: ["Alfabetização midiática", "Regulamentação de plataformas", "Verificação de fatos"]
            },
            {
                titulo: "Mudanças Climáticas",
                descricao: "Aquecimento global, sustentabilidade e responsabilidade ambiental",
                citacoes: [
                    "IPCC 2023: Última década foi a mais quente registrada",
                    "Acordo de Paris (2015)",
                    "Greta Thunberg: 'Nossa casa está em chamas'"
                ],
                filmes: ["Uma Verdade Inconveniente", "Don't Look Up", "Antes do Dilúvio"],
                argumentos: ["Transição energética", "Desmatamento zero", "Economia circular"]
            }
        ]
    },
    fuvest: {
        nome: "FUVEST",
        temas: [
            {
                titulo: "Cultura e Identidade Nacional",
                descricao: "Formação cultural brasileira e diversidade",
                citacoes: [
                    "Gilberto Freyre - 'Casa-Grande & Senzala'",
                    "Sérgio Buarque de Holanda - 'Raízes do Brasil'",
                    "Darcy Ribeiro - 'O Povo Brasileiro'"
                ],
                filmes: ["Bacurau", "Central do Brasil", "Cidade de Deus"],
                argumentos: ["Miscigenação cultural", "Patrimônio imaterial", "Resistência cultural"]
            }
        ]
    },
    unicamp: {
        nome: "UNICAMP",
        temas: [
            {
                titulo: "Ciência e Sociedade",
                descricao: "Papel da ciência no desenvolvimento social",
                citacoes: [
                    "Carl Sagan - 'O Mundo Assombrado pelos Demônios'",
                    "Thomas Kuhn - 'A Estrutura das Revoluções Científicas'",
                    "Paulo Freire - 'Pedagogia do Oprimido'"
                ],
                filmes: ["Interestelar", "Gattaca", "Ex Machina"],
                argumentos: ["Financiamento da pesquisa", "Divulgação científica", "Ética na ciência"]
            }
        ]
    }
};

// Repertórios genéricos para vestibulares que usam ENEM
const VESTIBULARES_SISU = [
    "SISU", "UFAC", "UNIFAP", "UFAM", "UFPA", "UNIR", "UFRR", "UFT",
    "UFAL", "UFBA", "UFC", "UFMA", "UFPB", "UFPE", "UFPI", "UFRN", "UFS",
    "UDF", "UFG", "UFMT", "UFMS", "UFES", "UERR"
];

const Repertorios = () => {
    const [vestibularSelecionado, setVestibularSelecionado] = useState<string>('enem');

    useEffect(() => {
        document.title = 'Repertórios para Redação ENEM e Vestibulares 2025 | CorrigeAI';
        const metaDesc = document.querySelector('meta[name="description"]');
        if (metaDesc) {
            metaDesc.setAttribute('content', 'Repertórios socioculturais atualizados para redação ENEM e 43 vestibulares. Citações, filmes, argumentos prontos para envelhecimento, saúde mental, clima.');
        }
    }, []);

    const repertoriosAtuais = REPERTORIOS_POR_VESTIBULAR[vestibularSelecionado as keyof typeof REPERTORIOS_POR_VESTIBULAR]
        || REPERTORIOS_POR_VESTIBULAR.enem;

    return (
        <div style={{ minHeight: '100vh', background: 'linear-gradient(180deg, #0f1419 0%, #1a1f2e 100%)' }}>
            <Header />

            <main style={{ maxWidth: '1200px', margin: '0 auto', padding: '40px 20px' }}>
                {/* Hero */}
                <div style={{ textAlign: 'center', marginBottom: '48px' }}>
                    <h1 style={{
                        fontSize: '42px',
                        fontWeight: '800',
                        background: 'linear-gradient(135deg, #4F46E5, #10b981)',
                        WebkitBackgroundClip: 'text',
                        WebkitTextFillColor: 'transparent',
                        marginBottom: '16px'
                    }}>
                        📚 Repertórios para Redação 2025
                    </h1>
                    <p style={{ fontSize: '18px', color: '#94a3b8', maxWidth: '700px', margin: '0 auto' }}>
                        Citações, filmes e argumentos prontos para usar na sua redação do ENEM e vestibulares
                    </p>
                </div>

                {/* Seletor de Vestibular */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '24px',
                    marginBottom: '32px'
                }}>
                    <h2 style={{ color: '#fff', fontSize: '16px', fontWeight: '600', marginBottom: '16px' }}>
                        🎯 Selecione seu Vestibular
                    </h2>
                    <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px' }}>
                        {['enem', 'fuvest', 'unicamp'].map(vest => (
                            <button
                                key={vest}
                                onClick={() => setVestibularSelecionado(vest)}
                                style={{
                                    padding: '8px 16px',
                                    background: vestibularSelecionado === vest ? '#4F46E5' : '#334155',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: 'pointer',
                                    textTransform: 'uppercase'
                                }}
                            >
                                {vest}
                            </button>
                        ))}
                        {/* Mostrar que outros vestibulares usam ENEM */}
                        <div style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: '8px',
                            marginLeft: '16px',
                            color: '#64748b',
                            fontSize: '12px'
                        }}>
                            <span>+ 40 vestibulares via SISU usam os mesmos repertórios do ENEM</span>
                        </div>
                    </div>
                </div>

                {/* Lista de Repertórios */}
                <div style={{ display: 'grid', gap: '24px' }}>
                    {repertoriosAtuais.temas.map((tema, idx) => (
                        <div key={idx} style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '16px',
                            padding: '32px',
                            overflow: 'hidden'
                        }}>
                            <div style={{ marginBottom: '24px' }}>
                                <span style={{
                                    background: '#4F46E5',
                                    color: '#fff',
                                    padding: '4px 12px',
                                    borderRadius: '20px',
                                    fontSize: '12px',
                                    fontWeight: '600',
                                    marginBottom: '12px',
                                    display: 'inline-block'
                                }}>
                                    {repertoriosAtuais.nome}
                                </span>
                                <h2 style={{ color: '#fff', fontSize: '24px', fontWeight: '700', marginTop: '12px' }}>
                                    {tema.titulo}
                                </h2>
                                <p style={{ color: '#94a3b8', fontSize: '14px', marginTop: '8px' }}>
                                    {tema.descricao}
                                </p>
                            </div>

                            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '20px' }}>
                                {/* Citações */}
                                <div style={{
                                    background: '#0f1419',
                                    borderRadius: '12px',
                                    padding: '20px'
                                }}>
                                    <h3 style={{ color: '#10b981', fontSize: '14px', fontWeight: '600', marginBottom: '16px' }}>
                                        💬 Citações
                                    </h3>
                                    <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
                                        {tema.citacoes.map((citacao, i) => (
                                            <li key={i} style={{
                                                color: '#e2e8f0',
                                                fontSize: '13px',
                                                lineHeight: '1.6',
                                                padding: '8px 0',
                                                borderBottom: i < tema.citacoes.length - 1 ? '1px solid #334155' : 'none'
                                            }}>
                                                {citacao}
                                            </li>
                                        ))}
                                    </ul>
                                </div>

                                {/* Filmes */}
                                <div style={{
                                    background: '#0f1419',
                                    borderRadius: '12px',
                                    padding: '20px'
                                }}>
                                    <h3 style={{ color: '#f59e0b', fontSize: '14px', fontWeight: '600', marginBottom: '16px' }}>
                                        🎬 Filmes e Documentários
                                    </h3>
                                    <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
                                        {tema.filmes.map((filme, i) => (
                                            <li key={i} style={{
                                                color: '#e2e8f0',
                                                fontSize: '13px',
                                                lineHeight: '1.6',
                                                padding: '8px 0',
                                                borderBottom: i < tema.filmes.length - 1 ? '1px solid #334155' : 'none'
                                            }}>
                                                {filme}
                                            </li>
                                        ))}
                                    </ul>
                                </div>

                                {/* Argumentos */}
                                <div style={{
                                    background: '#0f1419',
                                    borderRadius: '12px',
                                    padding: '20px'
                                }}>
                                    <h3 style={{ color: '#3b82f6', fontSize: '14px', fontWeight: '600', marginBottom: '16px' }}>
                                        📝 Linhas de Argumentação
                                    </h3>
                                    <ul style={{ listStyle: 'none', padding: 0, margin: 0 }}>
                                        {tema.argumentos.map((arg, i) => (
                                            <li key={i} style={{
                                                color: '#e2e8f0',
                                                fontSize: '13px',
                                                lineHeight: '1.6',
                                                padding: '8px 0',
                                                borderBottom: i < tema.argumentos.length - 1 ? '1px solid #334155' : 'none'
                                            }}>
                                                {arg}
                                            </li>
                                        ))}
                                    </ul>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>

                {/* Info sobre SISU */}
                <div style={{
                    marginTop: '48px',
                    padding: '24px',
                    background: 'rgba(79,70,229,0.1)',
                    borderRadius: '12px',
                    border: '1px solid rgba(79,70,229,0.3)'
                }}>
                    <h3 style={{ color: '#fff', fontSize: '16px', fontWeight: '600', marginBottom: '12px' }}>
                        🎓 Vestibulares que usam a nota do ENEM (SISU)
                    </h3>
                    <p style={{ color: '#94a3b8', fontSize: '14px', lineHeight: '1.6' }}>
                        {VESTIBULARES_SISU.join(', ')} e mais de 100 outras instituições aceitam a nota do ENEM.
                        Os repertórios acima são válidos para todos esses vestibulares!
                    </p>
                </div>

                {/* CTA */}
                <div style={{
                    textAlign: 'center',
                    marginTop: '64px',
                    padding: '48px',
                    background: 'linear-gradient(135deg, rgba(79,70,229,0.1), rgba(16,185,129,0.1))',
                    borderRadius: '24px',
                    border: '1px solid rgba(79,70,229,0.3)'
                }}>
                    <h2 style={{ color: '#fff', fontSize: '28px', fontWeight: '700', marginBottom: '16px' }}>
                        Quer treinar sua redação com esses repertórios?
                    </h2>
                    <p style={{ color: '#94a3b8', fontSize: '16px', marginBottom: '24px' }}>
                        Use o CorrigeAI para escrever uma redação e receba feedback instantâneo da IA!
                    </p>
                    <Link
                        to="/cadastro"
                        style={{
                            display: 'inline-block',
                            padding: '16px 48px',
                            background: 'linear-gradient(135deg, #4F46E5, #7c3aed)',
                            color: '#fff',
                            borderRadius: '12px',
                            fontSize: '18px',
                            fontWeight: '700',
                            textDecoration: 'none'
                        }}
                    >
                        Começar Agora - É Grátis! 🚀
                    </Link>
                </div>
            </main>
        </div>
    );
};

export default Repertorios;
