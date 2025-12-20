import { useEffect } from 'react';
import { Link } from 'react-router-dom';
import Header from '../components/Header';

const Demonstracao = () => {
    useEffect(() => {
        // SEO Meta tags
        document.title = 'Demonstração - Veja Como a IA Corrige Sua Redação | CorrigeAI';
        const metaDesc = document.querySelector('meta[name="description"]');
        if (metaDesc) {
            metaDesc.setAttribute('content', 'Veja um exemplo real de correção de redação ENEM feita pela Inteligência Artificial do CorrigeAI. Nota por competência e feedback detalhado em segundos.');
        }
    }, []);

    // Exemplo de correção
    const exemploCorrecao = {
        titulo: "O impacto das redes sociais na saúde mental dos jovens brasileiros",
        texto: `A crescente utilização das redes sociais, principalmente entre os jovens brasileiros, tem gerado debates acerca de seus impactos na saúde mental dessa parcela da população. Nesse contexto, deve-se analisar não apenas como o uso excessivo dessas plataformas pode ser prejudicial, mas também o papel do Estado e da sociedade na mitigação desses efeitos negativos.

Em primeiro lugar, é importante destacar que o uso desmedido das redes sociais está diretamente relacionado ao aumento de casos de ansiedade e depressão entre os jovens. Segundo pesquisa da Fiocruz, 47% dos brasileiros entre 18 e 24 anos relataram piora na saúde mental durante a pandemia, período em que o uso de plataformas digitais aumentou significativamente. Essa correlação evidencia como a exposição constante a padrões irreais de beleza e sucesso pode afetar negativamente a autoestima e o bem-estar psicológico.

Ademais, a falta de regulamentação adequada sobre o funcionamento das redes sociais agrava o problema. Os algoritmos dessas plataformas são projetados para maximizar o tempo de uso, criando dependência digital e, consequentemente, isolamento social. O documentário "O Dilema das Redes" expõe como empresas de tecnologia priorizam o engajamento em detrimento da saúde mental dos usuários, demonstrando a necessidade de intervenção governamental nesse setor.

Portanto, para enfrentar essa problemática, é essencial que o Ministério da Saúde, em parceria com o Ministério da Educação, promova campanhas de conscientização nas escolas sobre o uso saudável das redes sociais. Além disso, o Congresso Nacional deve aprovar legislação que obrigue as plataformas digitais a implementar alertas de tempo de uso e limitar o acesso de menores a conteúdos potencialmente prejudiciais. Somente com ações conjuntas entre Estado e sociedade será possível proteger a saúde mental dos jovens brasileiros.`,
        notas: {
            c1: 180, // Domínio da norma culta
            c2: 180, // Compreensão da proposta
            c3: 160, // Argumentação
            c4: 180, // Coesão
            c5: 200  // Proposta de intervenção
        },
        total: 900,
        feedbacks: [
            {
                competencia: "Competência 1 - Domínio da Norma Culta",
                nota: 180,
                comentario: "Excelente domínio da norma padrão da língua portuguesa. O texto apresenta estrutura sintática adequada, pontuação correta e vocabulário preciso. Pequenas inadequações pontuais não comprometem a qualidade.",
                pontos: ["Vocabulário diversificado e adequado", "Estrutura sintática bem elaborada", "Poucas inadequações pontuais"]
            },
            {
                competencia: "Competência 2 - Compreensão da Proposta",
                nota: 180,
                comentario: "O texto demonstra compreensão consistente do tema proposto, desenvolvendo-o de forma coerente com argumentos bem selecionados. A abordagem é adequada ao tipo dissertativo-argumentativo.",
                pontos: ["Tema desenvolvido de forma consistente", "Gênero textual adequado", "Repertório sociocultural produtivo"]
            },
            {
                competencia: "Competência 3 - Argumentação",
                nota: 160,
                comentario: "Boa seleção de argumentos e uso de dados estatísticos. A argumentação poderia ser aprofundada com mais exemplos concretos ou contrapontos.",
                pontos: ["Dados da Fiocruz bem utilizados", "Referência ao documentário pertinente", "Poderia aprofundar análise crítica"]
            },
            {
                competencia: "Competência 4 - Coesão",
                nota: 180,
                comentario: "Excelente articulação entre as partes do texto. Uso adequado de conectivos e progressão temática clara. Os parágrafos se conectam de forma lógica.",
                pontos: ["Conectivos bem empregados", "Progressão temática clara", "Boa articulação entre parágrafos"]
            },
            {
                competencia: "Competência 5 - Proposta de Intervenção",
                nota: 200,
                comentario: "Proposta de intervenção completa e detalhada. Apresenta agentes (Ministério da Saúde, Educação, Congresso), ações específicas (campanhas, legislação), meios (parcerias, alertas) e detalhamento adequado.",
                pontos: ["Agentes claramente identificados", "Ações específicas e viáveis", "Meio de execução detalhado", "Respeito aos direitos humanos"]
            }
        ]
    };

    const getNotaColor = (nota: number) => {
        if (nota >= 180) return '#10b981';
        if (nota >= 120) return '#f59e0b';
        return '#ef4444';
    };

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
                        Veja a IA em Ação
                    </h1>
                    <p style={{ fontSize: '18px', color: '#94a3b8', maxWidth: '600px', margin: '0 auto' }}>
                        Confira um exemplo real de como o CorrigeAI analisa e pontua sua redação em segundos
                    </p>
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 400px', gap: '32px' }}>
                    {/* Redação */}
                    <div style={{
                        background: '#1a1f2e',
                        border: '1px solid #334155',
                        borderRadius: '16px',
                        padding: '32px',
                        overflow: 'hidden'
                    }}>
                        <h2 style={{ color: '#fff', fontSize: '18px', fontWeight: '700', marginBottom: '8px' }}>
                            📝 Redação Exemplo
                        </h2>
                        <p style={{ color: '#64748b', fontSize: '14px', marginBottom: '24px' }}>
                            Tema: {exemploCorrecao.titulo}
                        </p>
                        <div style={{
                            background: '#0f1419',
                            borderRadius: '12px',
                            padding: '24px',
                            maxHeight: '500px',
                            overflowY: 'auto'
                        }}>
                            <p style={{
                                color: '#e2e8f0',
                                fontSize: '15px',
                                lineHeight: '1.8',
                                textAlign: 'justify',
                                whiteSpace: 'pre-wrap'
                            }}>
                                {exemploCorrecao.texto}
                            </p>
                        </div>
                    </div>

                    {/* Notas */}
                    <div>
                        {/* Nota Total */}
                        <div style={{
                            background: 'linear-gradient(135deg, #4F46E5, #7c3aed)',
                            borderRadius: '16px',
                            padding: '24px',
                            textAlign: 'center',
                            marginBottom: '24px'
                        }}>
                            <p style={{ color: 'rgba(255,255,255,0.8)', fontSize: '14px', marginBottom: '8px' }}>
                                NOTA TOTAL
                            </p>
                            <p style={{ color: '#fff', fontSize: '56px', fontWeight: '800' }}>
                                {exemploCorrecao.total}
                            </p>
                            <p style={{ color: 'rgba(255,255,255,0.6)', fontSize: '14px' }}>
                                de 1000 pontos
                            </p>
                        </div>

                        {/* Notas por competência */}
                        <div style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '16px',
                            padding: '24px'
                        }}>
                            <h3 style={{ color: '#fff', fontSize: '16px', fontWeight: '600', marginBottom: '20px' }}>
                                📊 Nota por Competência
                            </h3>
                            {[
                                { label: 'C1 - Norma Culta', nota: exemploCorrecao.notas.c1 },
                                { label: 'C2 - Compreensão', nota: exemploCorrecao.notas.c2 },
                                { label: 'C3 - Argumentação', nota: exemploCorrecao.notas.c3 },
                                { label: 'C4 - Coesão', nota: exemploCorrecao.notas.c4 },
                                { label: 'C5 - Intervenção', nota: exemploCorrecao.notas.c5 }
                            ].map((comp, idx) => (
                                <div key={idx} style={{
                                    display: 'flex',
                                    justifyContent: 'space-between',
                                    alignItems: 'center',
                                    padding: '12px 0',
                                    borderBottom: idx < 4 ? '1px solid #334155' : 'none'
                                }}>
                                    <span style={{ color: '#94a3b8', fontSize: '14px' }}>{comp.label}</span>
                                    <span style={{
                                        color: getNotaColor(comp.nota),
                                        fontSize: '20px',
                                        fontWeight: '700'
                                    }}>
                                        {comp.nota}
                                    </span>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>

                {/* Feedbacks detalhados */}
                <div style={{ marginTop: '48px' }}>
                    <h2 style={{
                        color: '#fff',
                        fontSize: '24px',
                        fontWeight: '700',
                        marginBottom: '24px',
                        textAlign: 'center'
                    }}>
                        💬 Feedback Detalhado da IA
                    </h2>
                    <div style={{ display: 'grid', gap: '16px' }}>
                        {exemploCorrecao.feedbacks.map((fb, idx) => (
                            <div key={idx} style={{
                                background: '#1a1f2e',
                                border: '1px solid #334155',
                                borderRadius: '12px',
                                padding: '24px'
                            }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                                    <h3 style={{ color: '#fff', fontSize: '16px', fontWeight: '600' }}>
                                        {fb.competencia}
                                    </h3>
                                    <span style={{
                                        background: getNotaColor(fb.nota),
                                        color: '#fff',
                                        padding: '4px 12px',
                                        borderRadius: '20px',
                                        fontSize: '14px',
                                        fontWeight: '700'
                                    }}>
                                        {fb.nota}/200
                                    </span>
                                </div>
                                <p style={{ color: '#94a3b8', fontSize: '14px', lineHeight: '1.6', marginBottom: '16px' }}>
                                    {fb.comentario}
                                </p>
                                <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px' }}>
                                    {fb.pontos.map((ponto, i) => (
                                        <span key={i} style={{
                                            background: '#0f1419',
                                            color: '#64748b',
                                            padding: '6px 12px',
                                            borderRadius: '6px',
                                            fontSize: '12px'
                                        }}>
                                            ✓ {ponto}
                                        </span>
                                    ))}
                                </div>
                            </div>
                        ))}
                    </div>
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
                        Pronto para corrigir sua redação?
                    </h2>
                    <p style={{ color: '#94a3b8', fontSize: '16px', marginBottom: '24px' }}>
                        Crie sua conta grátis e receba feedback instantâneo em segundos!
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
                            textDecoration: 'none',
                            transition: 'transform 0.2s'
                        }}
                    >
                        Começar Agora - É Grátis! 🚀
                    </Link>
                </div>
            </main>
        </div>
    );
};

export default Demonstracao;
