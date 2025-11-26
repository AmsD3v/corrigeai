import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000/api';

// Get auth token from localStorage
const getAuthToken = () => {
    return localStorage.getItem('token');
};

// Axios instance with auth
const apiClient = axios.create({
    baseURL: API_BASE_URL,
    headers: {
        'Content-Type': 'application/json',
    },
});

// Add auth token to requests
apiClient.interceptors.request.use((config) => {
    const token = getAuthToken();
    if (token) {
        config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
});

// Submit data interface
export interface SubmitEssayData {
    title?: string;
    theme?: string;
    content: string;
    correction_type?: 'advanced' | 'premium';
}

// Types
export interface Essay {
    id: string;
    user_id: string;
    title?: string;
    theme?: string;
    content: string;
    status: 'pending' | 'processing' | 'completed' | 'failed';
    plan_type: 'basic' | 'premium';
    credits_used: number;
    submitted_at: string;
    completed_at?: string;
    created_at: string;
    updated_at: string;
}

export interface Correction {
    id: string;
    essay_id: string;
    total_score: number;
    competence_1_score: number;
    competence_2_score: number;
    competence_3_score: number;
    competence_4_score: number;
    competence_5_score: number;
    competence_1_feedback: string;
    competence_2_feedback: string;
    competence_3_feedback: string;
    competence_4_feedback: string;
    competence_5_feedback: string;
    strengths: string[];
    improvements: string[];
    general_comments: string;
    created_at: string;
    competencias?: any[]; // Full competencias array from Gemini with detailed feedback
}

export interface EssayWithCorrection extends Essay {
    correction?: Correction;
}

export interface SubmitEssayData {
    title?: string;
    theme?: string;
    content: string;
    plan_type: 'basic' | 'premium';
}

// API Service
export const essayService = {
    /**
     * Submit a new essay for correction
     */
    async submitEssay(data: SubmitEssayData): Promise<Essay> {
        const response = await apiClient.post<Essay>('/essays', data);
        return response.data;
    },

    /**
     * Request correction for an essay
     */
    async correctEssay(essayId: string): Promise<Correction> {
        const response = await apiClient.post<Correction>(`/essays/${essayId}/correct`);
        return response.data;
    },

    /**
     * Get all essays for the current user
     */
    async getEssays(params?: { status?: string; page?: number; limit?: number }): Promise<Essay[]> {
        const response = await apiClient.get<Essay[]>('/essays', { params });
        return response.data;
    },

    /**
     * Get a specific essay with its correction
     */
    async getEssay(essayId: string): Promise<EssayWithCorrection> {
        const response = await apiClient.get<EssayWithCorrection>(`/essays/${essayId}`);
        return response.data;
    },

    /**
     * Delete an essay
     */
    async deleteEssay(essayId: string): Promise<void> {
        await apiClient.delete(`/essays/${essayId}`);
    },

    /**
     * Submit and immediately request correction (combined operation)
     * Now properly integrated with backend API
     */
    async submitAndCorrect(data: SubmitEssayData): Promise<{ essay: Essay; correction: Correction }> {
        console.log('📤 Enviando redação para o backend...');

        try {
            // Submit essay to backend /submit endpoint
            const submitResponse = await apiClient.post('/submit', {
                title: data.title || 'Sem título',
                theme: data.theme || 'Tema livre',
                content: data.content,
                correction_type: data.correction_type || 'advanced'  // NEW: Send correction type
            });

            const submission = submitResponse.data;

            console.log('✅ Redação submetida! ID:', submission.id, 'Status:', submission.status);

            // Poll for correction completion (wait up to 90 seconds)
            const maxAttempts = 18; // 18 * 5s = 90s
            let attempts = 0;
            let correctionData = null;

            while (attempts < maxAttempts) {
                await new Promise(resolve => setTimeout(resolve, 5000)); // Wait 5s
                attempts++;

                console.log(`🔍 Verificando correção (tentativa ${attempts}/${maxAttempts})...`);

                try {
                    // Check correction status via /get-correction endpoint
                    const correctionResponse = await apiClient.get(`/get-correction/${submission.id}`);
                    correctionData = correctionResponse.data;

                    console.log('✅ Correção encontrada! Nota:', correctionData.total_score);
                    break;
                } catch (error: any) {
                    if (error.response?.status === 404) {
                        console.log('⏳ Correção ainda não pronta, aguardando...');
                        continue;
                    }
                    throw error;
                }
            }

            if (!correctionData) {
                throw new Error('Timeout: Correção não foi concluída em 90 segundos');
            }

            // Convert to expected format
            const essay: Essay = {
                id: submission.id.toString(),
                user_id: submission.owner_id.toString(),
                title: submission.title,
                theme: submission.theme,
                content: submission.content,
                status: submission.status as any,
                plan_type: 'basic',
                credits_used: 1,
                submitted_at: new Date().toISOString(),
                created_at: new Date().toISOString(),
                updated_at: new Date().toISOString()
            };

            // Parse JSON strings from backend
            const strengths = typeof correctionData.strengths === 'string'
                ? JSON.parse(correctionData.strengths)
                : correctionData.strengths;
            const improvements = typeof correctionData.improvements === 'string'
                ? JSON.parse(correctionData.improvements)
                : correctionData.improvements;

            // Safe handling for all fields with fallbacks
            const correction: Correction = {
                id: correctionData.id ? correctionData.id.toString() : submission.id.toString(),
                essay_id: essay.id,
                total_score: correctionData.total_score || 0,
                competence_1_score: correctionData.competence_1_score || 0,
                competence_2_score: correctionData.competence_2_score || 0,
                competence_3_score: correctionData.competence_3_score || 0,
                competence_4_score: correctionData.competence_4_score || 0,
                competence_5_score: correctionData.competence_5_score || 0,
                competence_1_feedback: correctionData.competence_1_feedback || 'Feedback não disponível',
                competence_2_feedback: correctionData.competence_2_feedback || 'Feedback não disponível',
                competence_3_feedback: correctionData.competence_3_feedback || 'Feedback não disponível',
                competence_4_feedback: correctionData.competence_4_feedback || 'Feedback não disponível',
                competence_5_feedback: correctionData.competence_5_feedback || 'Feedback não disponível',
                strengths: strengths || [],
                improvements: improvements || [],
                general_comments: correctionData.general_comments || 'Sem comentários gerais',
                created_at: new Date().toISOString()
            };

            console.log('🎉 Correção completa! Nota final:', correction.total_score);
            console.log('📊 Correção detalhada:', correction);

            return { essay, correction };

        } catch (error: any) {
            console.error('❌ Erro ao processar correção:', error);
            throw error; // Re-throw error instead of broken fallback
        }
    },
};

export default essayService;
