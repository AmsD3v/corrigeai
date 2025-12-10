/**
 * Serviço para buscar critérios de vestibulares da API
 * Fonte única de verdade para nomes de competências
 */

import api from './api';

export interface ExamCriteria {
    id: string;
    name: string;
    short_name: string;
    max_score: number;
    competencies: string[];
    weights: number[];
    description: string;
}

export interface ExamListItem {
    id: string;
    name: string;
    short_name: string;
    max_score: number;
    num_competencies: number;
}

// Cache para evitar requisições repetidas
const criteriaCache: Record<string, ExamCriteria> = {};

/**
 * Busca critérios de um vestibular específico
 * Usa cache para evitar requisições repetidas
 */
export async function getExamCriteria(examType: string): Promise<ExamCriteria> {
    const type = examType.toLowerCase();

    // Verifica cache primeiro
    if (criteriaCache[type]) {
        console.log('📦 Cache hit para:', type);
        return criteriaCache[type];
    }

    try {
        console.log('🌐 Chamando API:', `/exam-criteria/${type}`);
        const response = await api.get<ExamCriteria>(`/exam-criteria/${type}`);
        console.log('📥 Resposta API:', response.data);
        criteriaCache[type] = response.data;
        return response.data;
    } catch (error) {
        console.error(`❌ Erro ao buscar critérios para ${examType}:`, error);
        // Fallback para ENEM se não encontrar
        return getDefaultCriteria();
    }
}


/**
 * Busca lista de todos os vestibulares disponíveis
 */
export async function listExamCriteria(): Promise<ExamListItem[]> {
    try {
        const response = await api.get<ExamListItem[]>('/exam-criteria');
        return response.data;
    } catch (error) {
        console.error('Erro ao listar vestibulares:', error);
        return [];
    }
}

/**
 * Retorna nome curto de uma competência (sem descrição após ":")
 */
export function getShortCompetencyName(fullName: string): string {
    const colonIndex = fullName.indexOf(':');
    return colonIndex > 0 ? fullName.substring(0, colonIndex).trim() : fullName;
}

/**
 * Critérios padrão ENEM como fallback
 */
function getDefaultCriteria(): ExamCriteria {
    return {
        id: 'enem',
        name: 'ENEM - Exame Nacional do Ensino Médio',
        short_name: 'ENEM',
        max_score: 1000,
        competencies: [
            'Demonstrar domínio da modalidade escrita formal da língua portuguesa',
            'Compreender a proposta de redação e aplicar conceitos das várias áreas de conhecimento',
            'Selecionar, relacionar, organizar e interpretar informações, fatos e argumentos',
            'Demonstrar conhecimento dos mecanismos linguísticos necessários para a argumentação',
            'Elaborar proposta de intervenção para o problema abordado, respeitando os direitos humanos'
        ],
        weights: [200, 200, 200, 200, 200],
        description: 'Redação dissertativo-argumentativa com proposta de intervenção obrigatória'
    };
}

export default {
    getExamCriteria,
    listExamCriteria,
    getShortCompetencyName
};
