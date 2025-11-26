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
        const credits = response.data.credits || 0;
        const freeCredits = response.data.free_credits || 0;
        console.log('🔍 RedigirRedacao - Credits:', credits);
        console.log('🔍 RedigirRedacao - Free Credits:', freeCredits);
        console.log('🔍 RedigirRedacao - Total:', credits + freeCredits);
        setUserCredits(credits);
        setFreeCredits(freeCredits);
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

    // Generate UUID for the essay
    const essayId = generateUUID();

    // Clean up old essays from localStorage (keep only last 5)
    const allKeys = Object.keys(localStorage);
    const essayKeys = allKeys.filter(key => key.startsWith('essay_')).sort().reverse();
    const correctionKeys = allKeys.filter(key => key.startsWith('correction_')).sort().reverse();

    // Remove old essays (keep only 5 most recent)
    if (essayKeys.length > 5) {
      essayKeys.slice(5).forEach(key => localStorage.removeItem(key));
    }
    if (correctionKeys.length > 5) {
      correctionKeys.slice(5).forEach(key => localStorage.removeItem(key));
    }

    // Save essay data to localStorage for the processing page
    const essayData = {
      id: essayId,
      title,
      theme,
      content,
      correction_type: correctionType
    };

    localStorage.setItem(`essay_${essayId}`, JSON.stringify(essayData));

    // Navigate to processing page
    navigate(`/painel/redacao/${essayId}/corrigindo`);
  };

  return (
    <PanelLayout activePage="/painel/redigir-redacao">
      {/* Main Content */}
      <div style={{ flex: 1, padding: '40px', maxWidth: '1200px', margin: '64px auto 0' }}>
        {/* Header */}
        <div style={{
          background: '#1a1f2e',
          border: '1px solid #334155',
          borderRadius: '16px',
          padding: '32px',
          marginBottom: '32px'
        }}>
          <h1 style={{
            fontSize: '32px',
            fontWeight: '800',
            color: '#fff',
            marginBottom: '8px'
          }}>
            Redigir Redação
          </h1>
          <p style={{
            fontSize: '14px',
            color: '#94a3b8'
          }}>
            Escolha seu plano, escreva sua redação e envie para correção com IA.
          </p>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit}>
          <div style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '16px',
            padding: '32px'
          }}>
            {/* Title Input */}
            <div style={{ marginBottom: '24px' }}>
              <label style={{
                display: 'block',
                fontSize: '13px',
                fontWeight: '600',
                color: '#94a3b8',
                marginBottom: '8px',
                textTransform: 'uppercase',
                letterSpacing: '0.5px'
              }}>
                Título (Opcional)
              </label>
              <input
                type="text"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                placeholder="Ex: Os desafios da educação no Brasil"
                style={{
                  width: '100%',
                  padding: '14px 16px',
                  background: '#0f1419',
                  border: '1px solid #334155',
                  borderRadius: '8px',
                  color: '#fff',
                  fontSize: '14px',
                  outline: 'none'
                }}
              />
            </div>

            {/* Theme Category Dropdown */}
            <div style={{ marginBottom: '24px' }}>
              <label style={{
                display: 'block',
                fontSize: '13px',
                fontWeight: '600',
                color: '#94a3b8',
                marginBottom: '8px',
                textTransform: 'uppercase',
                letterSpacing: '0.5px'
              }}>
                Categoria do Tema
              </label>
              <select
                value={themeCategory}
                onChange={(e) => setThemeCategory(e.target.value)}
                style={{
                  width: '100%',
                  padding: '14px 16px',
                  background: '#0f1419',
                  border: '1px solid #334155',
                  borderRadius: '8px',
                  color: '#fff',
                  fontSize: '14px',
                  outline: 'none',
                  cursor: 'pointer'
                }}
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

            <div style={{ marginBottom: '24px' }}>
              <div style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                marginBottom: '8px'
              }}>
                <label style={{
                  fontSize: '13px',
                  fontWeight: '600',
                  color: '#94a3b8',
                  textTransform: 'uppercase',
                  letterSpacing: '0.5px'
                }}>
                  Tema (Opcional)
                </label>
                <button
                  type="button"
                  onClick={handleGenerateTheme}
                  disabled={generatingTheme}
                  style={{
                    padding: '6px 12px',
                    background: generatingTheme ? '#334155' : '#4F46E520',
                    color: generatingTheme ? '#64748b' : '#4F46E5',
                    border: 'none',
                    borderRadius: '6px',
                    fontSize: '12px',
                    fontWeight: '600',
                    cursor: generatingTheme ? 'not-allowed' : 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    gap: '6px',
                    transition: 'all 0.2s'
                  }}
                  onMouseEnter={(e) => {
                    if (!generatingTheme) {
                      e.currentTarget.style.background = '#4F46E540';
                    }
                  }}
                  onMouseLeave={(e) => {
                    if (!generatingTheme) {
                      e.currentTarget.style.background = '#4F46E520';
                    }
                  }}
                >
                  {generatingTheme ? (
                    <>
                      <span style={{
                        display: 'inline-block',
                        width: '12px',
                        height: '12px',
                        border: '2px solid #64748b',
                        borderTop: '2px solid transparent',
                        borderRadius: '50%',
                        animation: 'spin 1s linear infinite'
                      }} />
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
                style={{
                  width: '100%',
                  padding: '14px 16px',
                  background: '#0f1419',
                  border: '1px solid #334155',
                  borderRadius: '8px',
                  color: '#fff',
                  fontSize: '14px',
                  outline: 'none'
                }}
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
            <div style={{ marginBottom: '24px' }}>
              <label style={{
                display: 'block',
                fontSize: '13px',
                fontWeight: '600',
                color: '#94a3b8',
                marginBottom: '8px',
                textTransform: 'uppercase',
                letterSpacing: '0.5px'
              }}>
                Sua Redação *
              </label>
              <textarea
                value={content}
                onChange={(e) => setContent(e.target.value)}
                placeholder="Escreva sua redação aqui..."
                required
                style={{
                  width: '100%',
                  minHeight: '400px',
                  padding: '16px',
                  background: '#0f1419',
                  border: '1px solid #334155',
                  borderRadius: '8px',
                  color: '#fff',
                  fontSize: '14px',
                  lineHeight: '1.8',
                  fontFamily: 'monospace',
                  resize: 'vertical',
                  outline: 'none'
                }}
              />
              <div style={{
                textAlign: 'right',
                fontSize: '12px',
                color: '#64748b',
                marginTop: '8px'
              }}>
                {content.length} caracteres
              </div>
            </div>

            {/* Correction Type Selector */}
            <div style={{ marginBottom: '24px' }}>
              <label style={{
                display: 'block',
                fontSize: '13px',
                fontWeight: '600',
                color: '#94a3b8',
                marginBottom: '12px',
                textTransform: 'uppercase',
                letterSpacing: '0.5px'
              }}>
                Tipo de Correção
              </label>
              <div style={{ display: 'flex', gap: '16px' }}>
                {/* Advanced Option */}
                <label style={{
                  flex: 1,
                  padding: '20px',
                  border: correctionType === 'advanced' ? '2px solid #10b981' : '1px solid #334155',
                  borderRadius: '12px',
                  cursor: 'pointer',
                  background: correctionType === 'advanced' ? '#10b98110' : '#0f1419',
                  transition: 'all 0.2s'
                }}>
                  <input
                    type="radio"
                    value="advanced"
                    checked={correctionType === 'advanced'}
                    onChange={(e) => setCorrectionType(e.target.value as 'advanced')}
                    style={{ marginRight: '12px' }}
                  />
                  <div style={{ display: 'inline-block' }}>
                    <div>
                      <strong style={{ color: '#fff', fontSize: '15px' }}>⚡ Correção Avançada</strong>
                    </div>
                    <p style={{ fontSize: '13px', color: '#94a3b8', margin: '4px 0 0 0' }}>
                      Rápida e precisa • <strong style={{ color: '#10b981' }}>1 crédito</strong>
                    </p>
                  </div>
                </label>

                {/* Premium Option */}
                <label style={{
                  flex: 1,
                  padding: '20px',
                  border: correctionType === 'premium' ? '2px solid #f59e0b' : '1px solid #334155',
                  borderRadius: '12px',
                  cursor: 'pointer',
                  background: correctionType === 'premium' ? '#f59e0b10' : '#0f1419',
                  transition: 'all 0.2s',
                  position: 'relative'
                }}>
                  <input
                    type="radio"
                    value="premium"
                    checked={correctionType === 'premium'}
                    onChange={(e) => setCorrectionType(e.target.value as 'premium')}
                    style={{ marginRight: '12px' }}
                  />
                  <div style={{ display: 'inline-block' }}>
                    <div>
                      <strong style={{ color: '#fff', fontSize: '15px' }}>💎 Correção Premium</strong>
                      <span style={{
                        background: '#f59e0b',
                        color: '#0f1419',
                        padding: '2px 8px',
                        borderRadius: '4px',
                        fontSize: '11px',
                        fontWeight: '700',
                        marginLeft: '8px'
                      }}>RECOMENDADO</span>
                    </div>
                    <p style={{ fontSize: '13px', color: '#94a3b8', margin: '4px 0 0 0' }}>
                      Análise profunda com insights • <strong style={{ color: '#f59e0b' }}>3 créditos</strong>
                    </p>
                  </div>
                </label>
              </div>
            </div>

            {/* Submit Button */}
            <div style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'space-between',
              paddingTop: '24px',
              borderTop: '1px solid #334155'
            }}>
              <div style={{
                fontSize: '13px',
                color: '#94a3b8'
              }}>
                <span style={{ color: '#fbbf24' }}>⚠️</span> Custo: <strong style={{ color: '#fff' }}>{correctionType === 'premium' ? '3' : '1'} crédito{correctionType === 'premium' ? 's' : ''}</strong>
                {!loadingCredits && (
                  <span style={{ marginLeft: '12px', color: (freeCredits + userCredits) < (correctionType === 'premium' ? 3 : 1) ? '#ef4444' : '#10b981' }}>
                    (Você tem:
                    {freeCredits > 0 && <><strong style={{ color: '#10b981' }}>{freeCredits}</strong> <span style={{ color: '#10b981' }}>grátis</span></>}
                    {freeCredits > 0 && userCredits > 0 && ' + '}
                    {userCredits > 0 && <><strong style={{ color: '#fbbf24' }}>{userCredits}</strong> <span style={{ color: '#fbbf24' }}>CorriCoin{userCredits === 1 ? '' : 's'}</span></>}
                    {freeCredits === 0 && userCredits === 0 && <strong>0</strong>}
                    )
                  </span>
                )}
              </div>
              <button
                type="submit"
                disabled={(() => {
                  const hasContent = !!content.trim();
                  const totalCredits = freeCredits + userCredits;
                  const requiredCredits = correctionType === 'premium' ? 3 : 1;
                  const hasEnoughCredits = totalCredits >= requiredCredits;
                  const isDisabled = !hasContent || !hasEnoughCredits;

                  console.log('🔍 Button Check:', {
                    hasContent,
                    freeCredits,
                    userCredits,
                    totalCredits,
                    requiredCredits,
                    hasEnoughCredits,
                    isDisabled
                  });

                  return isDisabled;
                })()}
                style={{
                  padding: '14px 32px',
                  background: (content.trim() && (freeCredits + userCredits) >= (correctionType === 'premium' ? 3 : 1)) ? '#4F46E5' : '#334155',
                  color: (content.trim() && (freeCredits + userCredits) >= (correctionType === 'premium' ? 3 : 1)) ? '#fff' : '#64748b',
                  border: 'none',
                  borderRadius: '12px',
                  fontSize: '15px',
                  fontWeight: '600',
                  cursor: (content.trim() && (freeCredits + userCredits) >= (correctionType === 'premium' ? 3 : 1)) ? 'pointer' : 'not-allowed',
                  transition: 'all 0.2s'
                }}
                onMouseEnter={(e) => {
                  if (content.trim() && userCredits >= (correctionType === 'premium' ? 3 : 1)) {
                    e.currentTarget.style.background = '#4338ca';
                  }
                }}
                onMouseLeave={(e) => {
                  if (content.trim() && userCredits >= (correctionType === 'premium' ? 3 : 1)) {
                    e.currentTarget.style.background = '#4F46E5';
                  }
                }}
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