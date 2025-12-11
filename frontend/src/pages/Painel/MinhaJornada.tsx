import { useState, useEffect } from 'react';
import PanelLayout from '../../components/PanelLayout';
import api from '../../services/api';

interface GamificationProfile {
    xp_total: number;
    level: number;
    level_name: string;
    xp_in_level: number;
    xp_for_next_level: number;
    xp_progress_percent: number;
    current_streak: number;
    max_streak: number;
    lessons_completed: number;
    essays_count: number;
    new_achievements: Achievement[];
}

interface Achievement {
    code: string;
    name: string;
    description: string;
    icon: string;
    xp_reward: number;
    coin_reward: number;
    is_unlocked: boolean;
}

interface Challenge {
    id: number;
    title: string;
    description: string;
    icon: string;
    target: number;
    progress: number;
    is_completed: boolean;
    xp_reward: number;
    coin_reward: number;
}

interface Lesson {
    id: number;
    order: number;
    title: string;
    description: string;
    xp_reward: number;
    is_unlocked: boolean;
    is_completed: boolean;
}

interface Competency {
    competency: number;
    lessons: Lesson[];
}

// Vestibulares disponíveis
const EXAM_TYPES = [
    { id: 'enem', name: 'ENEM', icon: '📚' },
    { id: 'fuvest', name: 'FUVEST', icon: '🎓' },
    { id: 'unicamp', name: 'UNICAMP', icon: '🦄' },
    { id: 'unesp', name: 'UNESP', icon: '📖' },
    { id: 'ita', name: 'ITA/IME', icon: '🚀' },
    { id: 'uerj', name: 'UERJ', icon: '🏛️' },
    { id: 'ufmg', name: 'UFMG', icon: '⛏️' },
    { id: 'afa', name: 'AFA', icon: '✈️' },
    { id: 'cacd', name: 'CACD', icon: '🌍' },
    { id: 'sisu', name: 'SISU', icon: '🎯' },
    { id: 'ufac', name: 'UFAC', icon: '🌳' },
    { id: 'ufal', name: 'UFAL', icon: '🏖️' },
    { id: 'unifap', name: 'UNIFAP', icon: '🦜' },
    { id: 'ufam', name: 'UFAM', icon: '🐊' },
    { id: 'ufba', name: 'UFBA', icon: '🥁' },
    { id: 'ufc', name: 'UFC', icon: '☀️' },
    { id: 'unb', name: 'UnB', icon: '🏛️' },
    { id: 'udf', name: 'UDF', icon: '🌆' },
    { id: 'ufes', name: 'UFES', icon: '🌊' },
    { id: 'ufg', name: 'UFG', icon: '🌾' },
    { id: 'ufma', name: 'UFMA', icon: '🦞' },
    { id: 'ufmt', name: 'UFMT', icon: '🐆' },
    { id: 'ufms', name: 'UFMS', icon: '🐂' },
    { id: 'ufpa', name: 'UFPA', icon: '🌴' },
    { id: 'ufpb', name: 'UFPB', icon: '🎸' },
    { id: 'ufpr', name: 'UFPR', icon: '🌲' },
    { id: 'ufpe', name: 'UFPE', icon: '🎭' },
    { id: 'ufpi', name: 'UFPI', icon: '🌵' },
    { id: 'ufrn', name: 'UFRN', icon: '🏝️' },
    { id: 'ufrgs', name: 'UFRGS', icon: '🧉' },
    { id: 'unir', name: 'UNIR', icon: '🪵' },
    { id: 'uerr', name: 'UERR', icon: '⛰️' },
    { id: 'ufsc', name: 'UFSC', icon: '🌉' },
    { id: 'ufs', name: 'UFS', icon: '🦀' },
    { id: 'uft', name: 'UFT', icon: '🌅' },
    { id: 'pucsp', name: 'PUC-SP', icon: '✝️' },
    { id: 'puccampinas', name: 'PUC-Campinas', icon: '⛪' },
    { id: 'pucminas', name: 'PUC-Minas', icon: '⛏️' },
    { id: 'pucpr', name: 'PUCPR', icon: '🌲' },
    { id: 'pucrio', name: 'PUC-Rio', icon: '🏔️' },
    { id: 'pucgoias', name: 'PUC-Goiás', icon: '🌻' },
    { id: 'pucrs', name: 'PUCRS', icon: '🍇' },
    { id: 'ufrr', name: 'UFRR', icon: '🏔️' }
];

// Nomes das competências por vestibular
const COMPETENCY_NAMES: Record<string, Record<number, string>> = {
    enem: {
        1: 'Domínio da Norma Culta',
        2: 'Compreensão do Tema',
        3: 'Argumentação',
        4: 'Coesão e Coerência',
        5: 'Proposta de Intervenção'
    },
    fuvest: {
        1: 'Tema e Texto',
        2: 'Estrutura',
        3: 'Expressão',
        4: 'Adequação'
    },
    unicamp: {
        1: 'Gênero e Interlocução',
        2: 'Propósito Comunicativo',
        3: 'Argumentação',
        4: 'Linguagem'
    },
    unesp: {
        1: 'Desenvolvimento do Tema',
        2: 'Organização Textual',
        3: 'Coerência e Coesão',
        4: 'Norma Culta'
    },
    ita: {
        1: 'Argumentação Técnica',
        2: 'Estrutura Lógica',
        3: 'Linguagem Precisa',
        4: 'Repertório'
    },
    uerj: {
        1: 'Adequação ao Tema',
        2: 'Desenvolvimento Argumentativo',
        3: 'Progressão Textual',
        4: 'Adequação Linguística'
    },
    ufmg: {
        1: 'Adequação ao Tema e Gênero',
        2: 'Coerência e Coesão',
        3: 'Recursos Linguísticos',
        4: 'Aspectos Formais'
    },
    afa: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Organização',
        3: 'Argumentação e Fundamentação',
        4: 'Expressão e Norma Culta'
    },
    cacd: {
        1: 'Domínio do Tema',
        2: 'Estrutura Argumentativa',
        3: 'Linguagem Diplomática',
        4: 'Conhecimento Específico'
    },
    sisu: {
        1: 'Norma Culta (C1)',
        2: 'Tema e Repertório (C2)',
        3: 'Argumentação (C3)',
        4: 'Coesão (C4)',
        5: 'Proposta de Intervenção (C5)'
    },
    ufac: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Linguagem e Norma Culta'
    },
    ufal: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    unifap: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Linguagem e Norma Culta'
    },
    ufam: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Organização',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufba: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    ufc: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    unb: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coerência',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    udf: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufes: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    ufg: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufma: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    ufmt: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufms: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    ufpa: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufpb: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    ufpr: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufpe: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    ufpi: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufrn: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    ufrgs: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    unir: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    uerr: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufsc: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    ufs: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    uft: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    pucsp: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    puccampinas: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    pucminas: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    pucpr: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    pucrio: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    pucgoias: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    },
    pucrs: {
        1: 'Adequação ao Tema',
        2: 'Estrutura Textual',
        3: 'Argumentação',
        4: 'Domínio da Norma Culta'
    },
    ufrr: {
        1: 'Adequação ao Tema',
        2: 'Estrutura e Coesão',
        3: 'Argumentação',
        4: 'Domínio Linguístico'
    }
};

const MinhaJornada = () => {
    const [profile, setProfile] = useState<GamificationProfile | null>(null);
    const [achievements, setAchievements] = useState<{ total: number, unlocked: number, achievements: Achievement[] }>({ total: 0, unlocked: 0, achievements: [] });
    const [challenges, setChallenges] = useState<{ daily: Challenge[], weekly: Challenge[] }>({ daily: [], weekly: [] });
    const [lessons, setLessons] = useState<{ competencies: Competency[], total_lessons: number, completed: number }>({ competencies: [], total_lessons: 0, completed: 0 });
    const [loading, setLoading] = useState(true);
    const [activeTab, setActiveTab] = useState<'overview' | 'lessons' | 'achievements' | 'ranking'>('overview');
    const [selectedLesson, setSelectedLesson] = useState<any>(null);
    const [selectedExam, setSelectedExam] = useState('enem');

    useEffect(() => {
        loadData();
    }, [selectedExam]);

    const loadData = async () => {
        setLoading(true);
        try {
            // IMPORTANT: achievements must be called FIRST to unlock and add XP
            // Then profile will return the updated XP value
            const [achievementsRes, challengesRes, lessonsRes] = await Promise.all([
                api.get(`/gamification/achievements?exam_type=${selectedExam}`),
                api.get('/gamification/challenges'),
                api.get(`/gamification/lessons?exam_type=${selectedExam}`)
            ]);

            // Now get profile with updated XP
            const profileRes = await api.get('/gamification/profile');

            setProfile(profileRes.data);
            setAchievements(achievementsRes.data);
            setChallenges(challengesRes.data);
            setLessons(lessonsRes.data);
        } catch (error) {
            console.error('Erro ao carregar dados de gamificação:', error);
        } finally {
            setLoading(false);
        }
    };

    const openLesson = async (lessonId: number, isRepeat: boolean = false) => {
        try {
            const url = isRepeat
                ? `/gamification/lessons/${lessonId}?generate_new_quiz=true`
                : `/gamification/lessons/${lessonId}`;
            const response = await api.get(url);
            setSelectedLesson(response.data);
        } catch (error: any) {
            if (error.response?.status === 403) {
                const message = error.response?.data?.detail || 'Esta lição está bloqueada!';
                alert(message);
            }
        }
    };

    const completeLesson = async (lessonId: number, quizScore: number) => {
        try {
            const response = await api.post(`/gamification/lessons/${lessonId}/complete?quiz_score=${quizScore}`);
            alert(`🎉 Lição concluída! +${response.data.xp_gained} XP`);
            setSelectedLesson(null);
            loadData();
        } catch (error) {
            console.error('Erro ao completar lição:', error);
        }
    };

    if (loading) {
        return (
            <PanelLayout activePage="/painel/minha-jornada">
                <div style={{ textAlign: 'center', padding: '60px', color: '#64748b' }}>
                    <div style={{ fontSize: '48px', marginBottom: '16px' }}>🎮</div>
                    <div>Carregando sua jornada...</div>
                </div>
            </PanelLayout>
        );
    }

    return (
        <PanelLayout activePage="/painel/minha-jornada">
            {/* Header */}
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{ fontSize: '32px', fontWeight: '800', color: '#fff', marginBottom: '8px' }}>
                    🎓 Minha Jornada
                </h1>
                <p style={{ fontSize: '14px', color: '#94a3b8' }}>
                    Acompanhe seu progresso, complete lições e desbloqueie conquistas!
                </p>
            </div>

            {/* Profile Card */}
            {profile && (
                <div style={{
                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                    borderRadius: '16px',
                    padding: '24px',
                    marginBottom: '24px',
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(150px, 1fr))',
                    gap: '24px'
                }}>
                    {/* Level */}
                    <div>
                        <div style={{ fontSize: '14px', color: 'rgba(255,255,255,0.7)', marginBottom: '4px' }}>Nível</div>
                        <div style={{ fontSize: '32px', fontWeight: '800', color: '#fff' }}>{profile.level}</div>
                        <div style={{ fontSize: '14px', color: 'rgba(255,255,255,0.9)' }}>{profile.level_name}</div>
                    </div>

                    {/* XP Progress */}
                    <div style={{ gridColumn: 'span 2' }}>
                        <div style={{ fontSize: '14px', color: 'rgba(255,255,255,0.7)', marginBottom: '8px' }}>
                            XP: {profile.xp_in_level} / {profile.xp_for_next_level}
                        </div>
                        <div style={{
                            background: 'rgba(255,255,255,0.2)',
                            borderRadius: '8px',
                            height: '12px',
                            overflow: 'hidden'
                        }}>
                            <div style={{
                                background: '#10b981',
                                height: '100%',
                                width: `${profile.xp_progress_percent}%`,
                                borderRadius: '8px',
                                transition: 'width 0.5s ease'
                            }} />
                        </div>
                        <div style={{ fontSize: '12px', color: 'rgba(255,255,255,0.7)', marginTop: '4px' }}>
                            {profile.xp_total} XP total
                        </div>
                    </div>

                    {/* Streak */}
                    <div>
                        <div style={{ fontSize: '14px', color: 'rgba(255,255,255,0.7)', marginBottom: '4px' }}>🔥 Streak</div>
                        <div style={{ fontSize: '32px', fontWeight: '800', color: '#fff' }}>{profile.current_streak}</div>
                        <div style={{ fontSize: '12px', color: 'rgba(255,255,255,0.7)' }}>dias seguidos</div>
                    </div>

                    {/* Lessons */}
                    <div>
                        <div style={{ fontSize: '14px', color: 'rgba(255,255,255,0.7)', marginBottom: '4px' }}>📚 Lições</div>
                        <div style={{ fontSize: '32px', fontWeight: '800', color: '#fff' }}>{profile.lessons_completed}</div>
                        <div style={{ fontSize: '12px', color: 'rgba(255,255,255,0.7)' }}>completadas</div>
                    </div>

                    {/* Essays */}
                    <div>
                        <div style={{ fontSize: '14px', color: 'rgba(255,255,255,0.7)', marginBottom: '4px' }}>📝 Redações</div>
                        <div style={{ fontSize: '32px', fontWeight: '800', color: '#fff' }}>{profile.essays_count}</div>
                        <div style={{ fontSize: '12px', color: 'rgba(255,255,255,0.7)' }}>enviadas</div>
                    </div>
                </div>
            )}

            {/* Tabs + Exam Dropdown */}
            <div style={{ display: 'flex', gap: '8px', marginBottom: '24px', flexWrap: 'wrap', alignItems: 'center' }}>
                {[
                    { key: 'overview', label: '📊 Visão Geral' },
                    { key: 'lessons', label: '📚 Lições' },
                    { key: 'achievements', label: '🏆 Conquistas' },
                    { key: 'ranking', label: '🏅 Ranking' }
                ].map(tab => (
                    <button
                        key={tab.key}
                        onClick={() => setActiveTab(tab.key as any)}
                        style={{
                            padding: '12px 20px',
                            background: activeTab === tab.key ? '#4F46E5' : '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: activeTab === tab.key ? '#fff' : '#94a3b8',
                            fontSize: '14px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                    >
                        {tab.label}
                    </button>
                ))}

                {/* Separador visual */}
                <div style={{ width: '2px', height: '32px', background: '#334155', margin: '0 8px' }} />

                {/* Exam Type Dropdown */}
                <select
                    value={selectedExam}
                    onChange={(e) => setSelectedExam(e.target.value)}
                    style={{
                        padding: '12px 16px',
                        background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                        border: '2px solid #7C3AED',
                        borderRadius: '10px',
                        color: '#fff',
                        fontSize: '14px',
                        fontWeight: '700',
                        cursor: 'pointer',
                        outline: 'none'
                    }}
                >
                    {EXAM_TYPES.map(exam => (
                        <option key={exam.id} value={exam.id} style={{ background: '#1a1f2e', color: '#fff' }}>
                            {exam.icon} {exam.name}
                        </option>
                    ))}
                </select>
            </div>

            {/* Tab Content */}
            {activeTab === 'overview' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '24px' }}>
                    {/* Daily Challenges */}
                    <div style={{ background: '#1a1f2e', border: '1px solid #334155', borderRadius: '12px', padding: '20px' }}>
                        <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '16px' }}>
                            🎯 Desafios de Hoje
                        </h3>
                        {challenges.daily.map(challenge => (
                            <div key={challenge.id} style={{
                                display: 'flex',
                                alignItems: 'center',
                                gap: '12px',
                                padding: '12px',
                                background: challenge.is_completed ? '#10b98120' : '#0f1419',
                                borderRadius: '8px',
                                marginBottom: '8px'
                            }}>
                                <span style={{ fontSize: '24px' }}>{challenge.is_completed ? '✅' : challenge.icon}</span>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#fff' }}>{challenge.title}</div>
                                    <div style={{ fontSize: '12px', color: '#64748b' }}>
                                        {challenge.progress}/{challenge.target} • +{challenge.xp_reward} XP
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>

                    {/* Weekly Challenges */}
                    <div style={{ background: '#1a1f2e', border: '1px solid #334155', borderRadius: '12px', padding: '20px' }}>
                        <h3 style={{ fontSize: '18px', fontWeight: '700', color: '#fff', marginBottom: '16px' }}>
                            📅 Desafios da Semana
                        </h3>
                        {challenges.weekly.map(challenge => (
                            <div key={challenge.id} style={{
                                display: 'flex',
                                alignItems: 'center',
                                gap: '12px',
                                padding: '12px',
                                background: challenge.is_completed ? '#10b98120' : '#0f1419',
                                borderRadius: '8px',
                                marginBottom: '8px'
                            }}>
                                <span style={{ fontSize: '24px' }}>{challenge.is_completed ? '✅' : challenge.icon}</span>
                                <div style={{ flex: 1 }}>
                                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#fff' }}>{challenge.title}</div>
                                    <div style={{ fontSize: '12px', color: '#64748b' }}>
                                        {challenge.progress}/{challenge.target} • +{challenge.xp_reward} XP
                                        {challenge.coin_reward > 0 && ` • +${challenge.coin_reward} 🪙`}
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            )}

            {activeTab === 'lessons' && (
                <div>
                    <div style={{ marginBottom: '16px', color: '#94a3b8', fontSize: '14px' }}>
                        {lessons.completed}/{lessons.total_lessons} lições completadas
                    </div>
                    {lessons.competencies.map(comp => (
                        <div key={comp.competency} style={{
                            background: '#1a1f2e',
                            border: '1px solid #334155',
                            borderRadius: '12px',
                            padding: '20px',
                            marginBottom: '16px'
                        }}>
                            <h3 style={{ fontSize: '16px', fontWeight: '700', color: '#fff', marginBottom: '16px' }}>
                                Competência {comp.competency}: {COMPETENCY_NAMES[selectedExam]?.[comp.competency] || `Critério ${comp.competency}`}
                            </h3>
                            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: '12px' }}>
                                {comp.lessons.map((lesson: any) => {
                                    const inCooldown = lesson.is_completed && lesson.cooldown_remaining_seconds > 0;
                                    const canRedo = lesson.is_completed && lesson.can_redo;
                                    const cooldownHours = lesson.cooldown_remaining_seconds ? Math.ceil(lesson.cooldown_remaining_seconds / 3600) : 0;

                                    return (
                                        <button
                                            key={lesson.id}
                                            onClick={() => (lesson.is_unlocked && !inCooldown) && openLesson(lesson.id, canRedo)}
                                            disabled={!lesson.is_unlocked || inCooldown}
                                            style={{
                                                padding: '16px',
                                                background: inCooldown ? '#1a1f2e' : lesson.is_completed ? '#10b98120' : lesson.is_unlocked ? '#0f1419' : '#1a1f2e',
                                                border: `1px solid ${inCooldown ? '#f59e0b40' : lesson.is_completed ? '#10b981' : '#334155'}`,
                                                borderRadius: '8px',
                                                textAlign: 'left',
                                                cursor: (lesson.is_unlocked && !inCooldown) ? 'pointer' : 'not-allowed',
                                                opacity: lesson.is_unlocked ? 1 : 0.5,
                                                position: 'relative'
                                            }}
                                        >
                                            <div style={{ fontSize: '20px', marginBottom: '8px' }}>
                                                {inCooldown ? '⏳' : lesson.is_completed ? (canRedo ? '🔄' : '✅') : lesson.is_unlocked ? '📖' : '🔒'}
                                            </div>
                                            <div style={{ fontSize: '14px', fontWeight: '600', color: '#fff', marginBottom: '4px' }}>
                                                {lesson.title}
                                            </div>
                                            <div style={{ fontSize: '12px', color: '#64748b' }}>
                                                {inCooldown ? (
                                                    <span style={{ color: '#f59e0b' }}>Disponível em {cooldownHours}h</span>
                                                ) : canRedo ? (
                                                    <span style={{ color: '#10b981' }}>Refazer (+{Math.round(lesson.xp_reward * 0.5)} XP)</span>
                                                ) : (
                                                    `+${lesson.xp_reward} XP`
                                                )}
                                            </div>
                                            {lesson.times_completed > 0 && (
                                                <div style={{ fontSize: '10px', color: '#64748b', marginTop: '4px' }}>
                                                    Feito {lesson.times_completed}x
                                                </div>
                                            )}
                                        </button>
                                    );
                                })}
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {activeTab === 'achievements' && (
                <div>
                    <div style={{ marginBottom: '16px', color: '#94a3b8', fontSize: '14px' }}>
                        {achievements.unlocked}/{achievements.total} conquistas desbloqueadas
                    </div>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))', gap: '16px' }}>
                        {achievements.achievements.map(achievement => (
                            <div key={achievement.code} style={{
                                padding: '20px',
                                background: achievement.is_unlocked ? '#10b98120' : '#1a1f2e',
                                border: `1px solid ${achievement.is_unlocked ? '#10b981' : '#334155'}`,
                                borderRadius: '12px',
                                opacity: achievement.is_unlocked ? 1 : 0.6
                            }}>
                                <div style={{ fontSize: '40px', marginBottom: '12px' }}>{achievement.icon}</div>
                                <div style={{ fontSize: '16px', fontWeight: '700', color: '#fff', marginBottom: '4px' }}>
                                    {achievement.name}
                                </div>
                                <div style={{ fontSize: '13px', color: '#94a3b8', marginBottom: '8px' }}>
                                    {achievement.description}
                                </div>
                                <div style={{ fontSize: '12px', color: '#64748b' }}>
                                    +{achievement.xp_reward} XP
                                    {achievement.coin_reward > 0 && ` • +${achievement.coin_reward} 🪙`}
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            )}

            {activeTab === 'ranking' && <RankingTab />}

            {/* Lesson Modal */}
            {selectedLesson && (
                <LessonModal
                    lesson={selectedLesson}
                    onClose={() => setSelectedLesson(null)}
                    onComplete={completeLesson}
                />
            )}
        </PanelLayout>
    );
};

const RankingTab = () => {
    const [rankings, setRankings] = useState<any[]>([]);
    const [category, setCategory] = useState('xp');
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        loadRanking();
    }, [category]);

    const loadRanking = async () => {
        setLoading(true);
        try {
            const response = await api.get(`/gamification/ranking?category=${category}`);
            setRankings(response.data.rankings);
        } catch (error) {
            console.error('Erro ao carregar ranking:', error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{ background: '#1a1f2e', border: '1px solid #334155', borderRadius: '12px', padding: '20px' }}>
            <div style={{ display: 'flex', gap: '8px', marginBottom: '20px' }}>
                {[
                    { key: 'xp', label: '⭐ XP Total' },
                    { key: 'lessons', label: '📚 Lições' },
                    { key: 'streak', label: '🔥 Streak' }
                ].map(cat => (
                    <button
                        key={cat.key}
                        onClick={() => setCategory(cat.key)}
                        style={{
                            padding: '8px 16px',
                            background: category === cat.key ? '#4F46E5' : 'transparent',
                            border: '1px solid #334155',
                            borderRadius: '6px',
                            color: '#fff',
                            fontSize: '13px',
                            cursor: 'pointer'
                        }}
                    >
                        {cat.label}
                    </button>
                ))}
            </div>

            {loading ? (
                <div style={{ textAlign: 'center', padding: '40px', color: '#64748b' }}>Carregando...</div>
            ) : (
                <div>
                    {rankings.map((user, index) => (
                        <div key={index} style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: '16px',
                            padding: '12px',
                            background: index < 3 ? '#0f1419' : 'transparent',
                            borderRadius: '8px',
                            marginBottom: '8px'
                        }}>
                            <div style={{
                                width: '32px',
                                height: '32px',
                                borderRadius: '50%',
                                background: index === 0 ? '#fbbf24' : index === 1 ? '#94a3b8' : index === 2 ? '#cd7f32' : '#334155',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                fontSize: '14px',
                                fontWeight: '700',
                                color: '#fff'
                            }}>
                                {user.rank}
                            </div>
                            <div style={{ flex: 1 }}>
                                <div style={{ fontSize: '14px', fontWeight: '600', color: '#fff' }}>{user.user_name}</div>
                                <div style={{ fontSize: '12px', color: '#64748b' }}>Nível {user.level}</div>
                            </div>
                            <div style={{ fontSize: '16px', fontWeight: '700', color: '#10b981' }}>
                                {user.value}
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
};

// Função para parsear markdown de forma mais completa
const parseMarkdown = (content: string): string => {
    if (!content) return '';

    let html = content;

    // Escapar HTML perigoso, mas manter estrutura
    html = html.replace(/</g, '&lt;').replace(/>/g, '&gt;');

    // Títulos (# e ##) - deve vir antes de outras transformações
    html = html.replace(/^## (.+)$/gm, '<h4 style="color:#f59e0b;margin:16px 0 8px;font-weight:700;">$1</h4>');
    html = html.replace(/^# (.+)$/gm, '<h3 style="color:#10b981;margin:20px 0 10px;font-weight:700;font-size:18px;">$1</h3>');

    // Negrito (**texto**) - cor bem clara para destacar
    html = html.replace(/\*\*(.+?)\*\*/g, '<strong style="color:#f8fafc;font-weight:700;">$1</strong>');

    // Blockquotes (> texto) - texto mais claro
    html = html.replace(/^&gt; (.+)$/gm, '<div style="background:#1e293b;border-left:4px solid #10b981;padding:12px 16px;margin:12px 0;border-radius:4px;color:#e2e8f0;font-style:italic;">$1</div>');

    // Tabelas simples - converter | Nota | Descrição | para formato de lista
    // Primeira, remover linhas de separadores de tabela (|---|---|)
    html = html.replace(/^\|[-\s|]+\|$/gm, '');
    // Converter linhas de tabela em itens formatados
    html = html.replace(/^\| ?(\d+) ?\| ?(.+?) ?\|$/gm, '<div style="display:flex;gap:12px;padding:8px 0;border-bottom:1px solid #334155;"><strong style="color:#10b981;min-width:50px;">$1</strong><span style="color:#e2e8f0;">$2</span></div>');
    // Headers de tabela
    html = html.replace(/^\| ?(.+?) ?\| ?(.+?) ?\|$/gm, '<div style="display:flex;gap:12px;padding:8px 0;border-bottom:1px solid #475569;margin-bottom:4px;"><strong style="color:#f59e0b;min-width:50px;">$1</strong><strong style="color:#f59e0b;">$2</strong></div>');

    // Listas (- item) - texto mais claro
    html = html.replace(/^- (.+)$/gm, '<div style="display:flex;gap:8px;padding:4px 0;"><span style="color:#10b981;">•</span><span style="color:#e2e8f0;">$1</span></div>');

    // Quebras de linha
    html = html.replace(/\n\n/g, '<br><br>');
    html = html.replace(/\n/g, '<br>');

    // Limpar BRs duplicados
    html = html.replace(/(<br>){3,}/g, '<br><br>');

    return html;
};

const LessonModal = ({ lesson, onClose, onComplete }: { lesson: any, onClose: () => void, onComplete: (id: number, score: number) => void }) => {
    const [showQuiz, setShowQuiz] = useState(false);
    const [currentQuestion, setCurrentQuestion] = useState(0);
    const [answers, setAnswers] = useState<number[]>([]);
    const [showResults, setShowResults] = useState(false);

    const quiz = lesson.quiz || [];

    const handleAnswer = (answerIndex: number) => {
        const newAnswers = [...answers, answerIndex];
        setAnswers(newAnswers);

        if (currentQuestion < quiz.length - 1) {
            setCurrentQuestion(currentQuestion + 1);
        } else {
            setShowResults(true);
        }
    };

    const calculateScore = () => {
        let correct = 0;
        quiz.forEach((q: any, i: number) => {
            if (answers[i] === q.correct) correct++;
        });
        return Math.round((correct / quiz.length) * 100);
    };

    return (
        <div style={{
            position: 'fixed',
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            background: 'rgba(0,0,0,0.85)',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            zIndex: 1000,
            padding: '20px'
        }}>
            <div style={{
                background: '#0f1419',
                borderRadius: '16px',
                maxWidth: '700px',
                width: '100%',
                maxHeight: '90vh',
                overflow: 'auto',
                padding: '32px',
                border: '1px solid #334155'
            }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '24px' }}>
                    <h2 style={{ fontSize: '24px', fontWeight: '700', color: '#ffffff' }}>{lesson.title}</h2>
                    <button onClick={onClose} style={{
                        background: 'transparent',
                        border: 'none',
                        fontSize: '24px',
                        color: '#64748b',
                        cursor: 'pointer'
                    }}>✕</button>
                </div>

                {!showQuiz && !showResults && (
                    <>
                        <div
                            style={{
                                color: '#e2e8f0',
                                fontSize: '15px',
                                lineHeight: '1.8',
                                background: '#1a1f2e',
                                padding: '24px',
                                borderRadius: '12px',
                                border: '1px solid #334155'
                            }}
                            dangerouslySetInnerHTML={{ __html: parseMarkdown(lesson.content) }}
                        />
                        {quiz.length > 0 && (
                            <button
                                onClick={() => setShowQuiz(true)}
                                style={{
                                    width: '100%',
                                    padding: '16px',
                                    background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '16px',
                                    fontWeight: '600',
                                    cursor: 'pointer',
                                    marginTop: '24px'
                                }}
                            >
                                📝 Fazer Quiz ({quiz.length} questões)
                            </button>
                        )}
                        {quiz.length === 0 && (
                            <div style={{
                                padding: '16px',
                                background: 'rgba(234, 179, 8, 0.1)',
                                border: '1px solid rgba(234, 179, 8, 0.3)',
                                borderRadius: '8px',
                                color: '#fbbf24',
                                fontSize: '14px',
                                textAlign: 'center',
                                marginTop: '24px'
                            }}>
                                ⚠️ Quiz sendo gerado. Tente novamente em alguns minutos.
                            </div>
                        )}
                    </>
                )}

                {showQuiz && !showResults && quiz[currentQuestion] && (
                    <div>
                        <div style={{ fontSize: '14px', color: '#64748b', marginBottom: '16px' }}>
                            Questão {currentQuestion + 1} de {quiz.length}
                        </div>
                        <div style={{ fontSize: '18px', fontWeight: '600', color: '#fff', marginBottom: '24px' }}>
                            {quiz[currentQuestion].question}
                        </div>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                            {quiz[currentQuestion].options.map((option: string, index: number) => (
                                <button
                                    key={index}
                                    onClick={() => handleAnswer(index)}
                                    style={{
                                        padding: '16px',
                                        background: '#0f1419',
                                        border: '1px solid #334155',
                                        borderRadius: '8px',
                                        color: '#fff',
                                        fontSize: '15px',
                                        textAlign: 'left',
                                        cursor: 'pointer'
                                    }}
                                >
                                    {option}
                                </button>
                            ))}
                        </div>
                    </div>
                )}

                {showResults && (
                    <div style={{ textAlign: 'center' }}>
                        <div style={{ fontSize: '64px', marginBottom: '16px' }}>
                            {calculateScore() >= 80 ? '🎉' : calculateScore() >= 50 ? '👍' : '📚'}
                        </div>
                        <div style={{ fontSize: '32px', fontWeight: '800', color: '#fff', marginBottom: '8px' }}>
                            {calculateScore()}%
                        </div>
                        <div style={{ fontSize: '16px', color: '#94a3b8', marginBottom: '24px' }}>
                            {calculateScore() >= 80 ? 'Excelente!' : calculateScore() >= 50 ? 'Bom trabalho!' : 'Continue estudando!'}
                        </div>
                        <button
                            onClick={() => onComplete(lesson.id, calculateScore())}
                            style={{
                                padding: '16px 32px',
                                background: '#10b981',
                                border: 'none',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '16px',
                                fontWeight: '600',
                                cursor: 'pointer'
                            }}
                        >
                            Concluir Lição (+{lesson.xp_reward} XP)
                        </button>
                    </div>
                )}
            </div>
        </div>
    );
};

export default MinhaJornada;
