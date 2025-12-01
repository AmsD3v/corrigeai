import { useEffect, useState, useRef } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import PanelLayout from '../../components/PanelLayout';

const CorrigindoRedacao = () => {
  const { id: rawId } = useParams<{ id: string }>();
  // Remove "M" prefix if it exists (from old localStorage data)
  const id = rawId?.startsWith('M') ? rawId.substring(1) : rawId;
  const navigate = useNavigate();
  const [progress, setProgress] = useState(0);
  const hasCalledRef = useRef(false);

  // Retrieve essay data for display
  const essayData = (() => {
    try {
      const data = localStorage.getItem(`essay_${id}`);
      return data ? JSON.parse(data) : null;
    } catch {
      return null;
    }
  })();

  // Redirect if URL has "M" prefix (clean URL)
  useEffect(() => {
    if (rawId?.startsWith('M')) {
      navigate(`/painel/redacao/${id}/corrigindo`, { replace: true });
      return;
    }
  }, [rawId, id, navigate]);

  useEffect(() => {
    // Prevent duplicate calls
    if (hasCalledRef.current) return;
    hasCalledRef.current = true;

    // Get essay data from localStorage
    const essayDataStr = localStorage.getItem(`essay_${id}`);

    if (!essayDataStr) {
      console.error('Essay data not found');
      navigate('/painel/redigir-redacao');
      return;
    }

    const essayData = JSON.parse(essayDataStr);

    // Simulate progress
    const interval = setInterval(() => {
      setProgress((prev) => {
        if (prev >= 95) {
          clearInterval(interval);
          return 95;
        }
        return prev + 5;
      });
    }, 500);

    // Call AI correction service
    const correctEssay = async () => {
      try {
        const { essayService } = await import('../../services/essayService');

        console.log('🚀 Iniciando correção com IA...');

        const result = await essayService.submitAndCorrect({
          title: essayData.title,
          theme: essayData.theme,
          content: essayData.content,
          plan_type: essayData.correction_type as 'basic' | 'premium',
          correction_type: essayData.correction_type,
          exam_type: essayData.exam_type || 'enem' // ADICIONAR exam_type
        });

        console.log('✅ Correção concluída!', result);

        // Save correction result to localStorage
        localStorage.setItem(`correction_${id}`, JSON.stringify({
          ...result.correction,
          exam_type: result.essay.exam_type || essayData.exam_type || 'enem'
        }));

        // Complete progress
        setProgress(100);

        // Navigate to result page after a short delay
        setTimeout(() => {
          clearInterval(interval);
          navigate(`/painel/redacao/${id}/resultado`);
        }, 1000);

      } catch (error) {
        console.error('❌ Erro ao corrigir redação:', error);
        // Still navigate to result page (will show mock data)
        setTimeout(() => {
          clearInterval(interval);
          navigate(`/painel/redacao/${id}/resultado`);
        }, 2000);
      }
    };

    correctEssay();

    return () => {
      clearInterval(interval);
    };
  }, [id, navigate]);

  return (
    <PanelLayout activePage="/painel/minhas-redacoes">
      <div style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        minHeight: 'calc(100vh - 164px)'
      }}>
        <div style={{
          maxWidth: '500px',
          width: '100%',
          textAlign: 'center'
        }}>
          {/* Loading Card */}
          <div style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '16px',
            padding: '48px 32px',
            position: 'relative',
            overflow: 'hidden'
          }}>
            {/* Animated gradient background */}
            <div style={{
              position: 'absolute',
              top: '-50%',
              left: '-50%',
              width: '200%',
              height: '200%',
              background: 'radial-gradient(circle, rgba(79, 70, 229, 0.1) 0%, transparent 70%)',
              animation: 'pulse 3s ease-in-out infinite'
            }} />

            {/* Spinner */}
            <div style={{
              width: '80px',
              height: '80px',
              margin: '0 auto 24px',
              border: '4px solid #334155',
              borderTop: '4px solid #4F46E5',
              borderRadius: '50%',
              animation: 'spin 1s linear infinite',
              position: 'relative',
              zIndex: 1
            }} />

            <h1 style={{
              fontSize: '24px',
              fontWeight: '800',
              color: '#fff',
              marginBottom: '12px',
              position: 'relative',
              zIndex: 1
            }}>
              Estamos corrigindo sua redação...
            </h1>

            <p style={{
              fontSize: '14px',
              color: '#94a3b8',
              marginBottom: '32px',
              position: 'relative',
              zIndex: 1
            }}>
              Calculando notas por competência
            </p>

            {/* Progress Bar */}
            <div style={{
              width: '100%',
              height: '8px',
              background: '#0f1419',
              borderRadius: '4px',
              overflow: 'hidden',
              marginBottom: '12px',
              position: 'relative',
              zIndex: 1
            }}>
              <div style={{
                width: `${progress}%`,
                height: '100%',
                background: 'linear-gradient(90deg, #4F46E5 0%, #7C3AED 100%)',
                borderRadius: '4px',
                transition: 'width 0.5s ease'
              }} />
            </div>

            <p style={{
              fontSize: '12px',
              color: '#64748b',
              position: 'relative',
              zIndex: 1
            }}>
              Isso pode levar menos de 1 minuto. Você será avisado automaticamente quando terminar.
            </p>
          </div>

          {/* Info */}
          <div style={{
            marginTop: '24px',
            padding: '16px',
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '12px',
            textAlign: 'left'
          }}>
            <div style={{
              display: 'flex',
              alignItems: 'flex-start',
              gap: '12px'
            }}>
              <span style={{ fontSize: '20px' }}>💡</span>
              <div>
                <h3 style={{
                  fontSize: '14px',
                  fontWeight: '600',
                  color: '#fff',
                  marginBottom: '8px'
                }}>
                  Enquanto isso...
                </h3>
                <p style={{
                  fontSize: '13px',
                  color: '#94a3b8',
                  lineHeight: '1.6',
                  margin: 0
                }}>
                  Nossa IA está analisando sua redação em todas as competências do <strong>{(essayData?.exam_type || 'enem').toUpperCase()}</strong>.
                  Você pode fechar esta página e voltar depois - te avisaremos quando estiver pronto!
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Animations */}
      <style>{`
        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }
        
        @keyframes pulse {
          0%, 100% { opacity: 0.5; transform: scale(1); }
          50% { opacity: 1; transform: scale(1.1); }
        }
      `}</style>
    </PanelLayout>
  );
};

export default CorrigindoRedacao;
