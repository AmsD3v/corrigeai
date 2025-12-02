import React, { useState, useEffect } from 'react';
import api from '../../services/api';

const apiClient = api;

interface ComplementaryInfoProps {
    user: any;
    onUpdate: () => void;
}

interface DropdownOption {
    id: number;
    value: string;
    label: string;
}

interface BrazilState {
    id: number;
    code: string;
    name: string;
}

interface BrazilCity {
    id: number;
    name: string;
    state_code: string;
}

const ComplementaryInfo: React.FC<ComplementaryInfoProps> = ({ user, onUpdate }) => {
    const [formData, setFormData] = useState({
        school_level: user?.school_level || '',
        intended_course: user?.intended_course || '',
        state: user?.state || '',
        city: user?.city || '',
        enem_attempts: user?.enem_attempts || '',
        previous_scores: user?.previous_scores || '',
        main_goal: user?.main_goal || '',
        study_method: user?.study_method || ''
    });

    const [schoolLevelOptions, setSchoolLevelOptions] = useState<DropdownOption[]>([]);
    const [enemAttemptsOptions, setEnemAttemptsOptions] = useState<DropdownOption[]>([]);
    const [mainGoalOptions, setMainGoalOptions] = useState<DropdownOption[]>([]);
    const [studyMethodOptions, setStudyMethodOptions] = useState<DropdownOption[]>([]);
    const [states, setStates] = useState<BrazilState[]>([]);
    const [cities, setCities] = useState<BrazilCity[]>([]);
    const [loading, setLoading] = useState(false);
    const [saved, setSaved] = useState(false);

    useEffect(() => {
        loadDropdownOptions();
        loadStates();
    }, []);

    useEffect(() => {
        if (formData.state) {
            loadCities(formData.state);
        } else {
            setCities([]);
        }
    }, [formData.state]);

    const loadDropdownOptions = async () => {
        try {
            const [schoolLevel, enemAttempts, mainGoal, studyMethod] = await Promise.all([
                apiClient.get('/api/dropdown-options?category=school_level'),
                apiClient.get('/api/dropdown-options?category=enem_attempts'),
                apiClient.get('/api/dropdown-options?category=main_goal'),
                apiClient.get('/api/dropdown-options?category=study_method')
            ]);

            setSchoolLevelOptions(schoolLevel.data);
            setEnemAttemptsOptions(enemAttempts.data);
            setMainGoalOptions(mainGoal.data);
            setStudyMethodOptions(studyMethod.data);
        } catch (error) {
            console.error('Error loading dropdown options:', error);
        }
    };

    const loadStates = async () => {
        try {
            const response = await apiClient.get('/api/locations/states');
            setStates(response.data);
        } catch (error) {
            console.error('Error loading states:', error);
        }
    };

    const loadCities = async (stateCode: string) => {
        try {
            const response = await apiClient.get(`/api/locations/cities?state=${stateCode}`);
            setCities(response.data);
        } catch (error) {
            console.error('Error loading cities:', error);
        }
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);

        try {
            await apiClient.put('/users/me/profile', formData);
            setSaved(true);
            setTimeout(() => setSaved(false), 3000);
            onUpdate();
        } catch (error) {
            console.error('Error saving complementary info:', error);
            alert('Erro ao salvar informações complementares');
        } finally {
            setLoading(false);
        }
    };

    const handleChange = (field: string, value: string) => {
        setFormData(prev => ({
            ...prev,
            [field]: value
        }));

        // Reset city quando o estado mudar
        if (field === 'state') {
            setFormData(prev => ({
                ...prev,
                city: ''
            }));
        }
    };

    return (
        <div style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '12px',
            padding: '24px',
            marginTop: '24px'
        }}>
            <h2 style={{
                fontSize: '20px',
                fontWeight: '700',
                color: '#fff',
                marginBottom: '8px'
            }}>
                Informações Complementares
            </h2>
            <p style={{
                fontSize: '14px',
                color: '#94a3b8',
                marginBottom: '24px'
            }}>
                Preencher estes campos é opcional, mas nos ajuda a entender melhor quem usa o RedaAI para aprimorarmos cada vez mais sua experiência e desenvolvermos recursos sob medida para você!
            </p>

            <form onSubmit={handleSubmit}>
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(2, 1fr)',
                    gap: '16px',
                    marginBottom: '24px'
                }}>
                    {/* Ano/Nível Escolar */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Ano/Nível Escolar:
                        </label>
                        <select
                            value={formData.school_level}
                            onChange={(e) => handleChange('school_level', e.target.value)}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: formData.school_level ? '#fff' : '#64748b',
                                fontSize: '14px',
                                cursor: 'pointer'
                            }}
                        >
                            <option value="">Selecione ou pesquise o nível escolar</option>
                            {schoolLevelOptions.map(opt => (
                                <option key={opt.id} value={opt.value}>{opt.label}</option>
                            ))}
                        </select>
                    </div>

                    {/* Curso Pretendido */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Curso Pretendido:
                        </label>
                        <input
                            type="text"
                            value={formData.intended_course}
                            onChange={(e) => handleChange('intended_course', e.target.value)}
                            placeholder="Ex: Medicina, Engenharia, Direito..."
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px'
                            }}
                        />
                    </div>

                    {/* Estado */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Estado:
                        </label>
                        <select
                            value={formData.state}
                            onChange={(e) => handleChange('state', e.target.value)}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: formData.state ? '#fff' : '#64748b',
                                fontSize: '14px',
                                cursor: 'pointer'
                            }}
                        >
                            <option value="">Selecione ou pesquise um estado</option>
                            {states.map(state => (
                                <option key={state.id} value={state.code}>{state.name}</option>
                            ))}
                        </select>
                    </div>

                    {/* Cidade */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Cidade:
                        </label>
                        <select
                            value={formData.city}
                            onChange={(e) => handleChange('city', e.target.value)}
                            disabled={!formData.state}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: !formData.state ? '#0a0e14' : '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: formData.city ? '#fff' : '#64748b',
                                fontSize: '14px',
                                cursor: formData.state ? 'pointer' : 'not-allowed',
                                opacity: formData.state ? 1 : 0.5
                            }}
                        >
                            <option value="">Selecione um estado primeiro</option>
                            {cities.map(city => (
                                <option key={city.id} value={city.name}>{city.name}</option>
                            ))}
                        </select>
                    </div>

                    {/* Quantas vezes já fez o ENEM? */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Quantas vezes já fez o ENEM?
                        </label>
                        <select
                            value={formData.enem_attempts}
                            onChange={(e) => handleChange('enem_attempts', e.target.value)}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: formData.enem_attempts ? '#fff' : '#64748b',
                                fontSize: '14px',
                                cursor: 'pointer'
                            }}
                        >
                            <option value="">Selecione ou pesquise</option>
                            {enemAttemptsOptions.map(opt => (
                                <option key={opt.id} value={opt.value}>{opt.label}</option>
                            ))}
                        </select>
                    </div>

                    {/* Notas anteriores de redação */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Notas anteriores de redação:
                        </label>
                        <input
                            type="text"
                            value={formData.previous_scores}
                            onChange={(e) => handleChange('previous_scores', e.target.value)}
                            placeholder="Ex: 780, 920, 800... (separar por vírgulas)"
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px'
                            }}
                        />
                    </div>

                    {/* Objetivo principal? */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Objetivo principal?
                        </label>
                        <select
                            value={formData.main_goal}
                            onChange={(e) => handleChange('main_goal', e.target.value)}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: formData.main_goal ? '#fff' : '#64748b',
                                fontSize: '14px',
                                cursor: 'pointer'
                            }}
                        >
                            <option value="">Selecione ou pesquise</option>
                            {mainGoalOptions.map(opt => (
                                <option key={opt.id} value={opt.value}>{opt.label}</option>
                            ))}
                        </select>
                    </div>

                    {/* Como você estuda? */}
                    <div>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '8px',
                            fontWeight: '500'
                        }}>
                            Como você estuda?
                        </label>
                        <select
                            value={formData.study_method}
                            onChange={(e) => handleChange('study_method', e.target.value)}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                background: '#0f1419',
                                border: '1px solid #334155',
                                borderRadius: '8px',
                                color: formData.study_method ? '#fff' : '#64748b',
                                fontSize: '14px',
                                cursor: 'pointer'
                            }}
                        >
                            <option value="">Selecione ou pesquise</option>
                            {studyMethodOptions.map(opt => (
                                <option key={opt.id} value={opt.value}>{opt.label}</option>
                            ))}
                        </select>
                    </div>
                </div>

                {/* Botão Salvar */}
                <button
                    type="submit"
                    disabled={loading}
                    style={{
                        padding: '16px 32px',
                        background: saved ? '#10b981' : '#ef4444',
                        border: 'none',
                        borderRadius: '8px',
                        color: '#fff',
                        fontSize: '16px',
                        fontWeight: '700',
                        cursor: loading ? 'not-allowed' : 'pointer',
                        opacity: loading ? 0.7 : 1,
                        transition: 'all 0.3s'
                    }}
                >
                    {loading ? 'Salvando...' : saved ? '✅ Salvo!' : 'Salvar Alterações Complementares'}
                </button>
            </form>
        </div>
    );
};

export default ComplementaryInfo;
