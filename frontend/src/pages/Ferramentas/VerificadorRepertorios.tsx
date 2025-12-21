import { useState } from 'react';
import { Link } from 'react-router-dom';
import Header from '../../components/Header';
import SEOHead from '../../components/SEOHead';

// Base de repertórios conhecidos para identificação
const REPERTORIOS_CONHECIDOS = [
    // Filósofos e Pensadores
    { nome: 'Zygmunt Bauman', tipo: 'Filósofo', palavras: ['bauman', 'modernidade líquida', 'amor líquido'], contexto: 'Modernidade líquida, relações superficiais, consumismo' },
    { nome: 'Hannah Arendt', tipo: 'Filósofa', palavras: ['arendt', 'banalidade do mal', 'condição humana'], contexto: 'Banalidade do mal, totalitarismo, violência' },
    { nome: 'Michel Foucault', tipo: 'Filósofo', palavras: ['foucault', 'vigiar e punir', 'biopoder', 'sociedade disciplinar'], contexto: 'Poder, controle social, vigilância' },
    { nome: 'Immanuel Kant', tipo: 'Filósofo', palavras: ['kant', 'imperativo categórico', 'esclarecimento'], contexto: 'Ética, razão, iluminismo' },
    { nome: 'Jean-Paul Sartre', tipo: 'Filósofo', palavras: ['sartre', 'existencialismo', 'condenado a ser livre'], contexto: 'Liberdade, existência, responsabilidade' },
    { nome: 'Paulo Freire', tipo: 'Educador', palavras: ['freire', 'pedagogia do oprimido', 'educação libertadora'], contexto: 'Educação crítica, conscientização' },
    { nome: 'Byung-Chul Han', tipo: 'Filósofo', palavras: ['byung-chul', 'sociedade do cansaço', 'burnout'], contexto: 'Esgotamento, autoexploração, saúde mental' },
    { nome: 'Pierre Bourdieu', tipo: 'Sociólogo', palavras: ['bourdieu', 'capital cultural', 'violência simbólica'], contexto: 'Desigualdade, educação, reprodução social' },
    { nome: 'John Locke', tipo: 'Filósofo', palavras: ['locke', 'tábula rasa', 'contrato social'], contexto: 'Formação do indivíduo, direitos naturais' },

    // Obras Literárias
    { nome: 'Vidas Secas (Graciliano Ramos)', tipo: 'Literatura', palavras: ['vidas secas', 'graciliano', 'fabiano'], contexto: 'Seca, miséria, nordeste brasileiro' },
    { nome: '1984 (George Orwell)', tipo: 'Literatura', palavras: ['1984', 'orwell', 'big brother', 'grande irmão'], contexto: 'Vigilância, totalitarismo, controle' },
    { nome: 'O Cortiço (Aluísio Azevedo)', tipo: 'Literatura', palavras: ['cortiço', 'aluísio azevedo'], contexto: 'Desigualdade social, moradia, urbanização' },
    { nome: 'Dom Casmurro (Machado de Assis)', tipo: 'Literatura', palavras: ['dom casmurro', 'capitu', 'machado de assis'], contexto: 'Ciúme, sociedade patriarcal' },

    // Documentos e Leis
    { nome: 'Constituição Federal de 1988', tipo: 'Documento', palavras: ['constituição', 'carta magna', 'artigo 5', 'art. 5'], contexto: 'Direitos fundamentais, cidadania' },
    { nome: 'Declaração Universal dos Direitos Humanos', tipo: 'Documento', palavras: ['direitos humanos', 'declaração universal', 'onu'], contexto: 'Direitos humanos, igualdade, dignidade' },
    { nome: 'Estatuto da Criança e do Adolescente (ECA)', tipo: 'Lei', palavras: ['eca', 'estatuto da criança'], contexto: 'Proteção infantil, direitos da criança' },

    // Dados e Instituições
    { nome: 'IBGE', tipo: 'Instituição', palavras: ['ibge', 'instituto brasileiro de geografia'], contexto: 'Dados demográficos, estatísticas nacionais' },
    { nome: 'OMS', tipo: 'Instituição', palavras: ['oms', 'organização mundial da saúde'], contexto: 'Saúde pública, epidemias, saúde mental' },
    { nome: 'UNESCO', tipo: 'Instituição', palavras: ['unesco'], contexto: 'Educação, cultura, patrimônio' },
    { nome: 'IPEA', tipo: 'Instituição', palavras: ['ipea'], contexto: 'Pesquisa econômica, desigualdade' },
];

interface RepertorioEncontrado {
    nome: string;
    tipo: string;
    contexto: string;
    trecho: string;
}

const VerificadorRepertorios = () => {
    const [texto, setTexto] = useState('');
    const [repertoriosEncontrados, setRepertoriosEncontrados] = useState<RepertorioEncontrado[]>([]);
    const [verificado, setVerificado] = useState(false);

    const verificarRepertorios = () => {
        const textoLower = texto.toLowerCase();
        const encontrados: RepertorioEncontrado[] = [];

        REPERTORIOS_CONHECIDOS.forEach(rep => {
            for (const palavra of rep.palavras) {
                const index = textoLower.indexOf(palavra.toLowerCase());
                if (index !== -1) {
                    // Extrai um trecho ao redor da palavra encontrada
                    const inicio = Math.max(0, index - 30);
                    const fim = Math.min(texto.length, index + palavra.length + 30);
                    const trecho = '...' + texto.substring(inicio, fim) + '...';

                    encontrados.push({
                        nome: rep.nome,
                        tipo: rep.tipo,
                        contexto: rep.contexto,
                        trecho: trecho
                    });
                    break; // Evita duplicatas do mesmo repertório
                }
            }
        });

        setRepertoriosEncontrados(encontrados);
        setVerificado(true);
    };

    const limpar = () => {
        setTexto('');
        setRepertoriosEncontrados([]);
        setVerificado(false);
    };

    return (
        <div style={{ minHeight: '100vh', background: 'linear-gradient(135deg, #0f1419 0%, #1a1f2e 100%)' }}>
            <SEOHead
                title="Verificador de Repertórios para Redação ENEM | CorrigeAI"
                description="Verifique se os repertórios da sua redação são válidos e conhecidos. Identifique filósofos, obras e dados mencionados no seu texto."
                canonical="https://corrigeai.online/ferramentas/verificar-repertorio"
                keywords="verificar repertório redação, repertório sociocultural enem, citações redação, filósofos enem"
            />
            <Header />

            <main style={{ maxWidth: '900px', margin: '0 auto', padding: '100px 20px 40px' }}>
                {/* Breadcrumb */}
                <nav style={{ marginBottom: '24px' }}>
                    <Link to="/ferramentas" style={{ color: '#818cf8', textDecoration: 'none' }}>
                        Ferramentas
                    </Link>
                    <span style={{ color: '#64748b', margin: '0 8px' }}>/</span>
                    <span style={{ color: '#94a3b8' }}>Verificar Repertórios</span>
                </nav>

                {/* Header */}
                <div style={{ textAlign: 'center', marginBottom: '40px' }}>
                    <h1 style={{ fontSize: '36px', fontWeight: '800', color: '#fff', marginBottom: '16px' }}>
                        📖 Verificador de Repertórios
                    </h1>
                    <p style={{ fontSize: '18px', color: '#94a3b8', maxWidth: '600px', margin: '0 auto' }}>
                        Cole sua redação e identifique os repertórios socioculturais mencionados
                    </p>
                </div>

                {/* Área de texto */}
                <div style={{ marginBottom: '24px' }}>
                    <textarea
                        value={texto}
                        onChange={(e) => setTexto(e.target.value)}
                        placeholder="Cole sua redação aqui para verificar os repertórios mencionados..."
                        style={{
                            width: '100%',
                            minHeight: '250px',
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

                {/* Botões */}
                <div style={{ display: 'flex', gap: '16px', marginBottom: '32px' }}>
                    <button
                        onClick={verificarRepertorios}
                        disabled={texto.trim().length < 50}
                        style={{
                            flex: 1,
                            padding: '16px 32px',
                            fontSize: '16px',
                            fontWeight: '700',
                            background: texto.trim().length >= 50 ? '#4F46E5' : '#2c3344',
                            color: '#fff',
                            border: 'none',
                            borderRadius: '8px',
                            cursor: texto.trim().length >= 50 ? 'pointer' : 'not-allowed',
                        }}
                    >
                        🔍 Verificar Repertórios
                    </button>
                    {verificado && (
                        <button
                            onClick={limpar}
                            style={{
                                padding: '16px 24px',
                                fontSize: '16px',
                                fontWeight: '600',
                                background: 'transparent',
                                color: '#94a3b8',
                                border: '2px solid #2c3344',
                                borderRadius: '8px',
                                cursor: 'pointer',
                            }}
                        >
                            Limpar
                        </button>
                    )}
                </div>

                {/* Resultados */}
                {verificado && (
                    <div style={{
                        background: '#1a1f2e',
                        border: '1px solid #2c3344',
                        borderRadius: '16px',
                        padding: '24px',
                        marginBottom: '32px'
                    }}>
                        <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#fff', marginBottom: '20px' }}>
                            {repertoriosEncontrados.length > 0
                                ? `✅ ${repertoriosEncontrados.length} repertório(s) identificado(s)`
                                : '⚠️ Nenhum repertório identificado'
                            }
                        </h2>

                        {repertoriosEncontrados.length > 0 ? (
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                                {repertoriosEncontrados.map((rep, idx) => (
                                    <div key={idx} style={{
                                        background: 'rgba(34, 197, 94, 0.1)',
                                        border: '1px solid rgba(34, 197, 94, 0.3)',
                                        borderRadius: '12px',
                                        padding: '16px'
                                    }}>
                                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '8px' }}>
                                            <span style={{ fontSize: '18px', fontWeight: '700', color: '#22c55e' }}>
                                                {rep.nome}
                                            </span>
                                            <span style={{
                                                background: '#22c55e',
                                                color: '#fff',
                                                padding: '4px 10px',
                                                borderRadius: '20px',
                                                fontSize: '12px',
                                                fontWeight: '600'
                                            }}>
                                                {rep.tipo}
                                            </span>
                                        </div>
                                        <p style={{ color: '#94a3b8', fontSize: '14px', marginBottom: '8px' }}>
                                            <strong>Contexto ideal:</strong> {rep.contexto}
                                        </p>
                                        <p style={{ color: '#64748b', fontSize: '13px', fontStyle: 'italic' }}>
                                            Encontrado em: "{rep.trecho}"
                                        </p>
                                    </div>
                                ))}
                            </div>
                        ) : (
                            <p style={{ color: '#94a3b8' }}>
                                Não identificamos repertórios conhecidos em seu texto. Considere adicionar referências a filósofos,
                                obras literárias, dados estatísticos ou documentos legais para enriquecer sua argumentação.
                            </p>
                        )}
                    </div>
                )}

                {/* Sugestões */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #2c3344',
                    borderRadius: '16px',
                    padding: '24px',
                    marginBottom: '32px'
                }}>
                    <h2 style={{ fontSize: '20px', fontWeight: '700', color: '#fff', marginBottom: '16px' }}>
                        💡 Repertórios mais usados no ENEM
                    </h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '12px' }}>
                        {REPERTORIOS_CONHECIDOS.slice(0, 8).map((rep, idx) => (
                            <div key={idx} style={{
                                background: 'rgba(129, 140, 248, 0.1)',
                                padding: '12px',
                                borderRadius: '8px',
                                borderLeft: '3px solid #818cf8'
                            }}>
                                <div style={{ fontWeight: '600', color: '#fff', fontSize: '14px' }}>{rep.nome}</div>
                                <div style={{ color: '#64748b', fontSize: '12px' }}>{rep.tipo}</div>
                            </div>
                        ))}
                    </div>
                    <Link to="/repertorios" style={{
                        display: 'inline-block',
                        marginTop: '16px',
                        color: '#818cf8',
                        textDecoration: 'none',
                        fontWeight: '600'
                    }}>
                        Ver todos os repertórios →
                    </Link>
                </div>

                {/* CTA */}
                <div style={{
                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                    borderRadius: '16px',
                    padding: '32px',
                    textAlign: 'center'
                }}>
                    <h3 style={{ fontSize: '24px', fontWeight: '700', color: '#fff', marginBottom: '12px' }}>
                        Quer análise completa da sua redação?
                    </h3>
                    <p style={{ fontSize: '16px', color: 'rgba(255,255,255,0.9)', marginBottom: '20px' }}>
                        O CorrigeAI analisa seus repertórios, argumentação, coesão e proposta de intervenção!
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

            {/* Footer */}
            <footer style={{ textAlign: 'center', padding: '40px 20px', color: '#64748b' }}>
                © 2025 CorrigeAI. Todos os direitos reservados.
            </footer>
        </div>
    );
};

export default VerificadorRepertorios;
