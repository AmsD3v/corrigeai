import React, { useState, useEffect } from 'react';
import api from '../../services/api';
import KPICard from '../../components/Analytics/KPICard';
import SchoolLevelChart from '../../components/Analytics/SchoolLevelChart';
import StateDistributionChart from '../../components/Analytics/StateDistributionChart';
import EnemAttemptsChart from '../../components/Analytics/EnemAttemptsChart';
import GoalsChart from '../../components/Analytics/GoalsChart';
import StudyMethodChart from '../../components/Analytics/StudyMethodChart';
import TopCoursesChart from '../../components/Analytics/TopCoursesChart';
import ExportButton from '../../components/Analytics/ExportButton';

interface ProfileStatsData {
    total_users: number;
    users_with_complementary_data: number;
    completion_rate: number;
    distributions: {
        school_level: { name: string; value: number }[];
        state: { name: string; value: number }[];
        enem_attempts: { name: string; value: number }[];
        main_goal: { name: string; value: number }[];
        study_method: { name: string; value: number }[];
        top_courses: { name: string; value: number }[];
    };
}

const UserProfileAnalytics: React.FC = () => {
    const [stats, setStats] = useState<ProfileStatsData | null>(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                setLoading(true);
                const response = await api.get<ProfileStatsData>('/admin/user-profile-stats');
                setStats(response.data);
                setError(null);
            } catch (err: any) {
                console.error('Error loading profile stats:', err);
                setError('Erro ao carregar estatísticas');
            } finally {
                setLoading(false);
            }
        };

        fetchStats();
    }, []);

    if (loading) {
        return (
            <div style={{
                padding: '48px',
                textAlign: 'center',
                color: '#94a3b8'
            }}>
                <div style={{ fontSize: '48px', marginBottom: '16px' }}>⏳</div>
                <div>Carregando estatísticas...</div>
            </div>
        );
    }

    if (error || !stats) {
        return (
            <div style={{
                padding: '48px',
                textAlign: 'center',
                color: '#ef4444'
            }}>
                <div style={{ fontSize: '48px', marginBottom: '16px' }}>❌</div>
                <div>{error || 'Erro ao carregar dados'}</div>
            </div>
        );
    }

    return (
        <div>
            {/* Section Header */}
            <div style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                marginBottom: '24px'
            }}>
                <div>
                    <h2 style={{
                        fontSize: '24px',
                        fontWeight: '700',
                        color: '#fff',
                        marginBottom: '8px'
                    }}>
                        📋 Informações Complementares dos Usuários
                    </h2>
                    <p style={{
                        fontSize: '14px',
                        color: '#94a3b8'
                    }}>
                        Dados demográficos e perfis de estudo
                    </p>
                </div>
                <ExportButton />
            </div>

            {/* KPI Cards */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                gap: '16px',
                marginBottom: '32px'
            }}>
                <KPICard
                    title="Total de Usuários"
                    value={stats.total_users.toLocaleString('pt-BR')}
                    icon="👥"
                    subtitle="Cadastrados na plataforma"
                />
                <KPICard
                    title="Com Dados Complementares"
                    value={stats.users_with_complementary_data.toLocaleString('pt-BR')}
                    icon="✅"
                    subtitle="Preencheram pelo menos um campo"
                />
                <KPICard
                    title="Taxa de Preenchimento"
                    value={`${stats.completion_rate}%`}
                    icon="📊"
                    subtitle="Usuários com dados vs total"
                />
                <KPICard
                    title="Curso Mais Popular"
                    value={stats.distributions.top_courses[0]?.name || 'N/A'}
                    icon="🎓"
                    subtitle={`${stats.distributions.top_courses[0]?.value || 0} usuários`}
                />
            </div>

            {/* Charts Grid */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(500px, 1fr))',
                gap: '24px'
            }}>
                {stats.distributions.school_level.length > 0 && (
                    <SchoolLevelChart data={stats.distributions.school_level} />
                )}

                {stats.distributions.state.length > 0 && (
                    <StateDistributionChart data={stats.distributions.state} />
                )}

                {stats.distributions.enem_attempts.length > 0 && (
                    <EnemAttemptsChart data={stats.distributions.enem_attempts} />
                )}

                {stats.distributions.main_goal.length > 0 && (
                    <GoalsChart data={stats.distributions.main_goal} />
                )}

                {stats.distributions.study_method.length > 0 && (
                    <StudyMethodChart data={stats.distributions.study_method} />
                )}

                {stats.distributions.top_courses.length > 0 && (
                    <TopCoursesChart data={stats.distributions.top_courses} />
                )}
            </div>
        </div>
    );
};

export default UserProfileAnalytics;
