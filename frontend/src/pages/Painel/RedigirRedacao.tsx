import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';
import geminiService from '../../services/geminiService';
import apiClient from '../../services/api';

// Generate UUID v4
const generateUUID = () => {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
    const r = Math.random() * 16 | 0;
    const v = c === 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
};

const RedigirRedacao = () => {
  const navigate = useNavigate();
  const [title, setTitle] = useState('');
  const [theme, setTheme] = useState('');
  const [themeCategory, setThemeCategory] = useState('geral');
  const [content, setContent] = useState('');
  const [correctionType, setCorrectionType] = useState<'advanced' | 'premium'>('advanced'); // NEW
  const [examType, setExamType] = useState<string>('enem'); // NOVO - Tipo de vestibular
  const [generatingTheme, setGeneratingTheme] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [userCredits, setUserCredits] = useState<number>(0);
  const [freeCredits, setFreeCredits] = useState<number>(0);
  const [loadingCredits, setLoadingCredits] = useState(true);

  // Fetch user credits on mount
  useEffect(() => {
    const fetchCredits = async () => {
      try {
        const response = await apiClient.get('/users/me');
        setUserCredits(response.data.credits || 0);
        setFreeCredits(response.data.free_credits || 0);
      } catch (error) {
        console.error('Error fetching credits:', error);
        setUserCredits(0);
        setFreeCredits(0);
      } finally {
        setLoadingCredits(false);
      }
    };

    fetchCredits();
  }, []);

  const themesByCategory: Record<string, string[]> = {
    geral: [
      'Os desafios da mobilidade urbana sustentável no Brasil',
      'O papel da tecnologia na transformação social',
      'Desafios e oportunidades da economia digital'
    ],
    educacao: [
      'A importância da educação financeira para jovens brasileiros',
      'Desafios da educação à distância no Brasil',
      'O papel da tecnologia na democratização do ensino',
      'Evasão escolar: causas e possíveis soluções'
    ],
    tecnologia: [
      'Impactos da inteligência artificial no mercado de trabalho',
      'O futuro da identidade digital na era da IA',
      'Desafios éticos do uso de dados pessoais',
      'A transformação digital e a inclusão social'
    ],
    meio_ambiente: [
      'Desafios da preservação ambiental na Amazônia',
      'Mudanças climáticas e responsabilidade coletiva',
      'Gestão de resíduos sólidos nas grandes cidades',
      'Energias renováveis: desafios e perspectivas no Brasil'
    ],
    sociedade: [
      'O papel das redes sociais na formação da opinião pública',
      'Combate à intolerância religiosa no Brasil',
      'Desafios da inclusão de pessoas com deficiência',
      'A importância da diversidade cultural brasileira'
    ],
    saude: [
      'Saúde mental na sociedade contemporânea',
      'Desafios do Sistema Único de Saúde (SUS)',
      'Prevenção e combate às doenças crônicas',
      'A importância da vacinação para a saúde pública'
    ]
  };

  const handleGenerateTheme = async () => {
    setGeneratingTheme(true);
    setError(null);

    try {
      // Try to use real Gemini API
      const generatedTheme = await geminiService.generateTheme(themeCategory);
      setTheme(generatedTheme);
    } catch (err) {
      console.error('Error generating theme with AI:', err);

      // Fallback to mock data if API fails
      const categoryThemes = themesByCategory[themeCategory] || themesByCategory.geral;
      const randomTheme = categoryThemes[Math.floor(Math.random() * categoryThemes.length)];
      setTheme(randomTheme);

      // Show error message
      setError('Não foi possível conectar com a IA. Usando tema sugerido.');

      // Clear error after 5 seconds
      setTimeout(() => setError(null), 5000);
    } finally {
      setGeneratingTheme(false);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();

    if (!content.trim()) {
      alert('Por favor, escreva sua redação antes de enviar.');
      return;
    }

    try {
      // Submit to backend first to get numeric ID
      const { essayService } = await import('../../services/essayService');

      // Submit essay - backend returns with numeric ID
      const response = await apiClient.post('/submit', {
        title: title || 'Sem título',
        theme: theme || 'Tema livre',
        content: content,
        correction_type: correctionType,
        exam_type: examType
      });

      const essayId = response.data.id; // Use numeric ID from backend

      // Save essay data to localStorage for the processing page
      const essayData = {
        id: essayId,
        title,
        theme,
        content,
        correction_type: correctionType,
        exam_type: examType
      };

      localStorage.setItem(`essay_${essayId}`, JSON.stringify(essayData));

      // Navigate to processing page with numeric ID
      navigate(`/painel/redacao/${essayId}/corrigindo`);

    } catch (error) {
      console.error('Erro ao enviar redação:', error);
      alert('Erro ao enviar redação. Tente novamente.');
    }
  };

  return (
    <PanelLayout activePage="/painel/redigir-redacao">
      {/* Main Content */}
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <div className="bg-[#1a1f2e] border border-[#334155] rounded-2xl p-6 md:p-8 mb-8">
          <h1 className="text-2xl md:text-3xl font-extrabold text-white mb-2">
            Redigir Redação
          </h1>
          <p className="text-sm md:text-base text-[#94a3b8]">
            Escolha seu plano, escreva sua redação e envie para correção com IA.
          </p>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit}>
          <div className="bg-[#1a1f2e] border border-[#334155] rounded-2xl p-6 md:p-8">
            {/* Title Input */}
            <div className="mb-6">
              <label className="block text-xs md:text-sm font-semibold text-[#94a3b8] mb-2 uppercase tracking-wide">
                Título (Opcional)
              </label>
              <input
                type="text"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                placeholder="Ex: Os desafios da educação no Brasil"
                className="w-full px-4 py-3 md:py-3.5 bg-[#0f1419] border border-[#334155] rounded-lg text-white text-sm outline-none focus:border-[#4F46E5] transition-colors"
              />
            </div>

            {/* Theme Category Dropdown */}
            <div className="mb-6">
              <label className="block text-xs md:text-sm font-semibold text-[#94a3b8] mb-2 uppercase tracking-wide">
                Categoria do Tema
              </label>
              <select
                value={themeCategory}
                onChange={(e) => setThemeCategory(e.target.value)}
                className="w-full px-4 py-3 md:py-3.5 bg-[#0f1419] border border-[#334155] rounded-lg text-white text-sm outline-none cursor-pointer"
              >
                <option value="geral">Geral</option>
                <option value="educacao">Educação</option>
                <option value="tecnologia">Tecnologia</option>
                <option value="meio_ambiente">Meio Ambiente</option>
                <option value="sociedade">Sociedade</option>
                <option value="saude">Saúde</option>
              </select>
            </div>

            {/* Theme Input with AI Generation */}

            <div className="mb-6">
              <div className="flex flex-col sm:flex-row sm:justify-between sm:items-center mb-2 gap-2">
                <label className="text-xs md:text-sm font-semibold text-[#94a3b8] uppercase tracking-wide">
                  Tema (Opcional)
                </label>
                <button
                  type="button"
                  onClick={handleGenerateTheme}
                  disabled={generatingTheme}
                  className={`px-3 py-1.5 rounded-md text-xs md:text-sm font-semibold flex items-center justify-center gap-2 transition-all ${generatingTheme
                    ? 'bg-[#334155] text-[#64748b] cursor-not-allowed'
                    : 'bg-[#4F46E520] text-[#4F46E5] hover:bg-[#4F46E540] cursor-pointer'
                    }`}
                >
                  {generatingTheme ? (
                    <>
                      <span className="inline-block w-3 h-3 border-2 border-[#64748b] border-t-transparent rounded-full animate-spin" />
                      Gerando...
                    </>
                  ) : (
                    <>
                      ✨ Gerar Tema com IA
                    </>
                  )}
                </button>
              </div>
              <input
                type="text"
                value={theme}
                onChange={(e) => setTheme(e.target.value)}
                placeholder="Ex: Caminhos para combater a intolerância religiosa"
                className="w-full px-4 py-3 md:py-3.5 bg-[#0f1419] border border-[#334155] rounded-lg text-white text-sm outline-none focus:border-[#4F46E5] transition-colors"
              />

              {/* Error Notification */}
              {error && (
                <div style={{
                  marginTop: '12px',
                  padding: '12px 16px',
                  background: '#fbbf2420',
                  border: '1px solid #fbbf24',
                  borderRadius: '8px',
                  display: 'flex',
                  alignItems: 'center',
                  gap: '8px',
                  fontSize: '13px',
                  color: '#fbbf24'
                }}>
                  <span>⚠️</span>
                  <span>{error}</span>
                </div>
              )}
            </div>

            {/* Content Textarea */}
            <div className="mb-6">
              <label className="block text-xs md:text-sm font-semibold text-[#94a3b8] mb-2 uppercase tracking-wide">
                Sua Redação *
              </label>
              <textarea
                value={content}
                onChange={(e) => setContent(e.target.value)}
                placeholder="Escreva sua redação aqui..."
                required
                className="w-full min-h-[300px] md:min-h-[400px] p-4 bg-[#0f1419] border border-[#334155] rounded-lg text-white text-sm leading-relaxed font-mono resize-vertical outline-none focus:border-[#4F46E5] transition-colors"
              />
              <div className="text-right text-xs text-[#64748b] mt-2">
                {content.length} caracteres
              </div>
            </div>

            {/* Exam Type Selector (NOVO) */}
            <div className="mb-6">
              <label className="block text-xs md:text-sm font-semibold text-[#94a3b8] mb-3 uppercase tracking-wide">
                🎓 Selecione o Vestibular/Concurso
              </label>
              <select
                value={examType}
                onChange={(e) => setExamType(e.target.value)}
                className="w-full px-4 py-3 md:py-4 bg-[#0f1419] border-2 border-[#3B82F6] rounded-xl text-white text-sm md:text-base font-semibold cursor-pointer outline-none transition-all"
              >
                <option value="enem">📝 ENEM - Exame Nacional do Ensino Médio (0-1000)</option>
                <option value="fuvest">🎓 FUVEST - USP (0-50)</option>
                <option value="unicamp">🦄 UNICAMP (0-48)</option>
                <option value="ita">🚀 ITA - Instituto Tecnológico de Aeronáutica (0-100)</option>
                <option value="unesp">🌟 UNESP - Universidade Estadual Paulista (0-100)</option>
                <option value="uerj">🏛️ UERJ - Universidade do Estado do Rio de Janeiro (0-100)</option>
                <option value="ufmg">⚗️ UFMG - Universidade Federal de Minas Gerais (0-100)</option>
                <option value="afa">✈️ AFA - Academia da Força Aérea (0-100)</option>
                <option value="cacd">💼 CACD - Carreira Diplomática (0-100) - MAIS DIFÍCIL!</option>
                <option value="sisu">📊 SISU - Sistema de Seleção Unificada (usa ENEM)</option>
              </select>
              <p style={{
                fontSize: '12px',
                color: '#64748b',
                marginTop: '8px',
                fontStyle: 'italic'
              }}>
                Sua redação será corrigida com os critérios específicos do vestibular selecionado.
              </p>
            </div>

            {/* Correction Type Selector */}
            <div className="mb-6">
              <label className="block text-xs md:text-sm font-semibold text-[#94a3b8] mb-3 uppercase tracking-wide">
                Tipo de Correção
              </label>
              <div className="flex flex-col md:flex-row gap-4">
                {/* Advanced Option */}
                <label className={`flex-1 p-5 rounded-xl cursor-pointer transition-all ${correctionType === 'advanced'
                  ? 'border-2 border-[#10b981] bg-[#10b98110]'
                  : 'border border-[#334155] bg-[#0f1419]'
                  }`}>
                  <input
                    type="radio"
                    value="advanced"
                    checked={correctionType === 'advanced'}
                    onChange={(e) => setCorrectionType(e.target.value as 'advanced')}
                    className="mr-3"
                  />
                  <div className="inline-block">
                    <div>
                      <strong className="text-white text-sm md:text-base">⚡ Correção Avançada</strong>
                    </div>
                    <p className="text-xs md:text-sm text-[#94a3b8] mt-1">
                      Rápida e precisa • <strong className="text-[#10b981]">1 crédito</strong>
                    </p>
                  </div>
                </label>

                {/* Premium Option */}
                <label className={`flex-1 p-5 rounded-xl cursor-pointer transition-all relative ${correctionType === 'premium'
                  ? 'border-2 border-[#f59e0b] bg-[#f59e0b10]'
                  : 'border border-[#334155] bg-[#0f1419]'
                  }`}>
                  <input
                    type="radio"
                    value="premium"
                    checked={correctionType === 'premium'}
                    onChange={(e) => setCorrectionType(e.target.value as 'premium')}
                    className="mr-3"
                  />
                  <div className="inline-block">
                    <div>
                      <strong className="text-white text-sm md:text-base">💎 Correção Premium</strong>
                      <span className="bg-[#f59e0b] text-[#0f1419] px-2 py-0.5 rounded text-[10px] md:text-xs font-bold ml-2">RECOMENDADO</span>
                    </div>
                    <p className="text-xs md:text-sm text-[#94a3b8] mt-1">
                      Análise profunda com insights • <strong className="text-[#f59e0b]">3 créditos</strong>
                    </p>
                  </div>
                </label>
              </div>
            </div>

            {/* Submit Button */}
            <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 pt-6 border-t border-[#334155]">
              <div className="text-xs md:text-sm text-[#94a3b8]">
                <span className="text-[#fbbf24]">⚠️</span> Custo: <strong className="text-white">{correctionType === 'premium' ? '3' : '1'} crédito{correctionType === 'premium' ? 's' : ''}</strong>
                {!loadingCredits && (
                  <span className={`ml-3 ${(freeCredits + userCredits) < (correctionType === 'premium' ? 3 : 1) ? 'text-[#ef4444]' : 'text-[#10b981]'}`}>
                    (Você tem:
                    {freeCredits > 0 && <><strong className="text-[#10b981]">{freeCredits}</strong> <span className="text-[#10b981]">grátis</span></>}
                    {freeCredits > 0 && userCredits > 0 && ' + '}
                    {userCredits > 0 && <><strong className="text-[#fbbf24]">{userCredits}</strong> <span className="text-[#fbbf24]">CorriCoin{userCredits === 1 ? '' : 's'}</span></>}
                    {freeCredits === 0 && userCredits === 0 && <strong>0</strong>}
                    )
                  </span>
                )}
              </div>
              <button
                type="submit"
                disabled={!content.trim() || (freeCredits + userCredits) < (correctionType === 'premium' ? 3 : 1)}
                className={`w-full sm:w-auto px-6 md:px-8 py-3 md:py-3.5 rounded-xl text-sm md:text-base font-semibold transition-all ${(content.trim() && (freeCredits + userCredits) >= (correctionType === 'premium' ? 3 : 1))
                  ? 'bg-[#4F46E5] hover:bg-[#4338ca] text-white cursor-pointer'
                  : 'bg-[#334155] text-[#64748b] cursor-not-allowed'
                  }`}
              >
                Enviar para Correção
              </button>
            </div>
          </div>
        </form>
      </div>

      {/* Animation for spinner */}
      <style>{`
        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }
      `}</style>
    </PanelLayout>
  );
};

export default RedigirRedacao;