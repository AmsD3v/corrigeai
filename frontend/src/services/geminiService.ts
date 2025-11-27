import api from './api';

export const geminiService = {
  /**
   * Generate essay theme based on category
   * Now uses backend endpoint for security
   */
  async generateTheme(category: string): Promise<string> {
    try {
      const response = await api.post('/api/gemini/generate-theme', {
        category
      });

      if (response.data.success && response.data.theme) {
        return response.data.theme;
      } else {
        throw new Error('Falha ao gerar tema');
      }
    } catch (error: any) {
      console.error('Error generating theme:', error);

      if (error.response?.status === 401) {
        throw new Error('Sessão expirada. Faça login novamente.');
      }

      throw new Error(
        error.response?.data?.detail ||
        'Não foi possível gerar o tema. Tente novamente.'
      );
    }
  },

/**
 * Correct essay using Gemini AI - Real implementation
 */
// NOTA: Este serviço não é mais usado diretamente.
// A correção agora é feita pelo backend via essayService.ts
/*
async correctEssay(essayContent: string, _planType: 'basic' | 'premium'): Promise<any> {
    if (!import.meta.env.VITE_GEMINI_API_KEY) {
        throw new Error('VITE_GEMINI_API_KEY não configurada');
    }

    const prompt = `Você é um corretor especializado e amigável de redações ENEM. Analise a seguinte redação com um tom encorajador e construtivo, sempre destacando os pontos positivos antes de sugerir melhorias.

REDAÇÃO:
${essayContent}

INSTRUÇÕES:
Avalie a redação nas 5 competências do ENEM com carinho e profissionalismo, atribuindo notas de 0 a 200 para cada:

1. Domínio da escrita formal da língua portuguesa
2. Compreensão da proposta de redação e aplicação de conceitos
3. Seleção, organização e interpretação de informações
4. Demonstração de conhecimento dos mecanismos linguísticos
5. Proposta de intervenção para o problema abordado

Retorne APENAS um JSON válido (sem markdown, sem backticks) no seguinte formato:

{
"nota_final": 880,
"competencias": [
{
  "numero": 1,
  "titulo": "Domínio da escrita formal da língua portuguesa",
  "nota": 180,
  "feedback": "Análise geral da competência 1.",
  "pontos_fortes": [
    "Ponto forte específico 1",
    "Ponto forte específico 2",
    "Ponto forte específico 3"
  ],
  "pontos_fracos": [
    "Ponto fraco específico 1",
    "Ponto fraco específico 2"
  ]
},
{
  "numero": 2,
  "titulo": "Compreensão da proposta de redação",
  "nota": 180,
  "feedback": "Análise geral da competência 2.",
  "pontos_fortes": [
    "Ponto forte específico 1",
    "Ponto forte específico 2"
  ],
  "pontos_fracos": [
    "Ponto fraco específico 1",
    "Ponto fraco específico 2"
  ]
},
{
  "numero": 3,
  "titulo": "Seleção e organização das informações",
  "nota": 160,
  "feedback": "Análise geral da competência 3.",
  "pontos_fortes": [
    "Ponto forte específico 1",
    "Ponto forte específico 2"
  ],
  "pontos_fracos": [
    "Ponto fraco específico 1",
    "Ponto fraco específico 2"
  ]
},
{
  "numero": 4,
  "titulo": "Demonstração de conhecimento da língua",
  "nota": 180,
  "feedback": "Análise geral da competência 4.",
  "pontos_fortes": [
    "Ponto forte específico 1",
    "Ponto forte específico 2"
  ],
  "pontos_fracos": [
    "Ponto fraco específico 1",
    "Ponto fraco específico 2"
  ]
},
{
  "numero": 5,
  "titulo": "Proposta de intervenção",
  "nota": 180,
  "feedback": "Análise geral da competência 5.",
  "pontos_fortes": [
    "Ponto forte específico 1",
    "Ponto forte específico 2"
  ],
  "pontos_fracos": [
    "Ponto fraco específico 1",
    "Ponto fraco específico 2"
  ]
}
],
"feedback_geral": "Resumo geral da redação com pontos fortes e áreas de melhoria."
}

CRITÉRIOS IMPORTANTES:
- Seja criterioso e realista nas notas (use toda a escala de 0-200)
- A nota_final deve ser a SOMA exata das 5 competências
- Para cada competência, liste 2-4 pontos fortes e 1-3 pontos fracos ESPECÍFICOS
- Use um tom ENCORAJADOR e AMIGÁVEL - celebre os acertos antes de sugerir melhorias
- Nos pontos fracos, use linguagem positiva como "Você pode melhorar..." ao invés de "Está ruim..."
- Mencione exemplos concretos do texto quando possível
- Use linguagem profissional mas acessível e calorosa
- Seja detalhado, construtivo e motivador
- Lembre-se: o objetivo é ENSINAR e MOTIVAR, não apenas apontar erros!

Retorne APENAS o JSON, sem texto adicional.`;

    const requestBody: GeminiRequest = {
        contents: [
            {
                parts: [
                    {
                        text: prompt
                    }
                ]
            }
        ]
    };

    try {
        console.log('🤖 Enviando redação para correção com IA...');

        const response = await fetch(`${GEMINI_API_URL}?key=${GEMINI_API_KEY}`, {
            method: 'POST',
            headers: {
        let generatedText = data.candidates[0].content.parts[0].text.trim();

        console.log('📝 Resposta bruta da IA:', generatedText.substring(0, 200) + '...');

        // Remove markdown code blocks if present
        generatedText = generatedText.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim();

        // Parse JSON response
        const correction = JSON.parse(generatedText);

        // Validate response structure
        if (!correction.nota_final || !correction.competencias || correction.competencias.length !== 5) {
            throw new Error('Resposta da IA em formato inválido');
        }

        console.log('✅ Correção com IA concluída! Nota final:', correction.nota_final);

        return correction;
    } catch (error) {
        console.error('❌ Error correcting essay with AI:', error);

        // Fallback to mock data if AI fails
        console.warn('⚠️ Usando correção mock devido a erro na IA');
        return {
            nota_final: 880,
            competencias: [
                {
                    numero: 1,
                    titulo: 'Domínio da escrita formal da língua portuguesa',
                    nota: 180,
                    feedback: 'Excelente domínio da norma culta. A redação apresenta poucos desvios gramaticais e demonstra conhecimento sólido das regras da língua portuguesa.'
                },
                {
                    numero: 2,
                    titulo: 'Compreensão da proposta de redação',
                    nota: 180,
                    feedback: 'Ótima compreensão do tema proposto. O texto desenvolve argumentação pertinente e mantém-se dentro do tema solicitado.'
                },
                {
                    numero: 3,
                    titulo: 'Seleção e organização das informações',
                    nota: 160,
                    feedback: 'Boa organização de ideias com argumentos bem estruturados. Poderia aprofundar mais alguns pontos para alcançar nota máxima.'
                },
                {
                    numero: 4,
                    titulo: 'Demonstração de conhecimento da língua',
                    nota: 180,
                    feedback: 'Excelente uso de conectivos e recursos coesivos. O texto flui naturalmente e apresenta boa articulação entre as partes.'
                },
                {
                    numero: 5,
                    titulo: 'Proposta de intervenção',
                    nota: 180,
                    feedback: 'Proposta completa e detalhada, contemplando todos os elementos necessários: agente, ação, modo, finalidade e detalhamento.'
                }
            ],
            feedback_geral: 'Redação de alto nível! Continue praticando. (Nota: Esta é uma correção de exemplo pois houve erro na IA)'
        };
    }
}
};

export default geminiService;
