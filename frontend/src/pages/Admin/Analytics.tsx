import { useState, useEffect } from 'react';
import AdminLayout from '../../components/AdminLayout';
import api from '../../services/api';

interface AnalyticsData {
    userMetrics: {
        totalUsers: number;
        activeUsers: number;
        newUsersThisMonth: number;
        retentionRate: number;
        churnRate: number;
    };
    essayMetrics: {
        totalEssays: number;
        avgScore: number;
        essaysThisMonth: number;
        avgCompetencyScores: number[];
    };
    revenueMetrics: {
        totalRevenue: number;
        mrr: number;
        arpu: number;
        ltv: number;
    };
}

const Analytics = () => {
    const [analytics, setAnalytics] = useState<AnalyticsData>({
        userMetrics: {
            totalUsers: 0,
            activeUsers: 0,
            newUsersThisMonth: 0,
            retentionRate: 0,
            churnRate: 0
        },
        essayMetrics: {
            totalEssays: 0,
            avgScore: 0,
            essaysThisMonth: 0,
            avgCompetencyScores: [0, 0, 0, 0, 0]
        },
        revenueMetrics: {
            totalRevenue: 0,
            mrr: 0,
            arpu: 0,
            ltv: 0
        }
    });

    useEffect(() => {
        const fetchAnalytics = async () => {
            try {
                const response = await api.get('/admin/analytics');
                const data = response.data;

                setAnalytics({
                    userMetrics: {
                        totalUsers: data.user_metrics.total_users,
                        activeUsers: data.user_metrics.active_users,
                        newUsersThisMonth: data.user_metrics.new_users_this_month,
                        retentionRate: data.user_metrics.retention_rate,
                        churnRate: data.user_metrics.churn_rate
                    },
                    essayMetrics: {
                        totalEssays: data.essay_metrics.total_essays,
                        avgScore: data.essay_metrics.avg_score,
                        essaysThisMonth: data.essay_metrics.essays_this_month,
                        avgCompetencyScores: data.essay_metrics.avg_competency_scores || [0, 0, 0, 0, 0]
                    },
                    revenueMetrics: {
                        totalRevenue: data.revenue_metrics.total_revenue,
                        mrr: data.revenue_metrics.mrr,
                        arpu: data.revenue_metrics.arpu,
                        ltv: data.revenue_metrics.ltv
                    }
                });
            } catch (error) {
                console.error('Erro ao carregar analytics:', error);
            }
        };

        fetchAnalytics();
    }, []);

    const MetricCard = ({ title, value, subtitle, icon, color, trend }: any) => (
        <div style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '12px',
            padding: '24px',
            position: 'relative',
            overflow: 'hidden'
        }}>
            <div style={{
                position: 'absolute',
                top: '-20px',
                right: '-20px',
                fontSize: '80px',
                opacity: 0.1
            }}>
                {icon}
            </div>
            <div style={{
                fontSize: '14px',
                color: '#94a3b8',
                marginBottom: '8px',
                fontWeight: '500'
            }}>
                {title}
            </div>
            <div style={{
                fontSize: '32px',
                fontWeight: '800',
                color: color || '#fff',
                marginBottom: '4px'
            }}>
                {value}
            </div>
            {subtitle && (
                <div style={{
                    fontSize: '12px',
                    color: '#64748b'
                }}>
                    {subtitle}
                </div>
            )}
            {trend && (
                <div style={{
                    fontSize: '12px',
                    color: trend > 0 ? '#10b981' : '#ef4444',
                    marginTop: '8px',
                    fontWeight: '600'
                }}>
                    {trend > 0 ? '↑' : '↓'} {Math.abs(trend)}% vs mês anterior
                </div>
            )}
        </div>
    );

    return (
        <AdminLayout activePage="/admin/analytics">
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Analytics Avançado
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Métricas detalhadas de negócio e performance
                </p>
            </div>

            {/* User Analytics */}
            <div style={{ marginBottom: '32px' }}>
                <h2 style={{
                    fontSize: '20px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    📊 Métricas de Usuários
                </h2>
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                    gap: '16px'
                }}>
                    <MetricCard
                        title="Total de Usuários"
                        value={analytics.userMetrics.totalUsers}
                        icon="👥"
                        color="#10b981"
                        trend={15}
                    />
                    <MetricCard
                        title="Usuários Ativos"
                        value={analytics.userMetrics.activeUsers}
                        subtitle="Últimos 30 dias"
                        icon="✅"
                        color="#3b82f6"
                        trend={8}
                    />
                    <MetricCard
                        title="Novos Usuários"
                        value={analytics.userMetrics.newUsersThisMonth}
                        subtitle="Este mês"
                        icon="🆕"
                        color="#f59e0b"
                        trend={22}
                    />
                    <MetricCard
                        title="Taxa de Retenção"
                        value={`${analytics.userMetrics.retentionRate}%`}
                        subtitle="Usuários que retornam"
                        icon="🔄"
                        color="#8b5cf6"
                        trend={5}
                    />
                    <MetricCard
                        title="Taxa de Churn"
                        value={`${analytics.userMetrics.churnRate}%`}
                        subtitle="Usuários que saíram"
                        icon="📉"
                        color="#ef4444"
                        trend={-3}
                    />
                </div>
            </div>

            {/* Essay Analytics */}
            <div style={{ marginBottom: '32px' }}>
                <h2 style={{
                    fontSize: '20px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    📝 Métricas de Redações
                </h2>
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                    gap: '16px',
                    marginBottom: '24px'
                }}>
                    <MetricCard
                        title="Total de Redações"
                        value={analytics.essayMetrics.totalEssays}
                        icon="📄"
                        color="#10b981"
                        trend={18}
                    />
                    <MetricCard
                        title="Pontuação Média"
                        value={analytics.essayMetrics.avgScore}
                        subtitle="De 1000 pontos"
                        icon="⭐"
                        color="#f59e0b"
                        trend={2}
                    />
                    <MetricCard
                        title="Redações Este Mês"
                        value={analytics.essayMetrics.essaysThisMonth}
                        icon="📈"
                        color="#3b82f6"
                        trend={25}
                    />
                </div>

                {/* Competency Performance */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '24px'
                }}>
                    <h3 style={{
                        fontSize: '16px',
                        fontWeight: '700',
                        color: '#fff',
                        marginBottom: '20px'
                    }}>
                        Performance por Competência
                    </h3>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                        {[
                            'Domínio da escrita formal',
                            'Compreensão do tema e repertório',
                            'Seleção e organização de ideias',
                            'Coesão e coerência',
                            'Proposta de intervenção'
                        ].map((name, index) => {
                            const score = analytics.essayMetrics.avgCompetencyScores[index];
                            const percentage = (score / 200) * 100;
                            const color = percentage >= 80 ? '#10b981' : percentage >= 60 ? '#f59e0b' : '#ef4444';

                            return (
                                <div key={index}>
                                    <div style={{
                                        display: 'flex',
                                        justifyContent: 'space-between',
                                        marginBottom: '8px'
                                    }}>
                                        <span style={{ fontSize: '14px', color: '#fff', fontWeight: '500' }}>
                                            Competência {index + 1}: {name}
                                        </span>
                                        <span style={{ fontSize: '14px', color, fontWeight: '700' }}>
                                            {score}/200 ({Math.round(percentage)}%)
                                        </span>
                                    </div>
                                    <div style={{
                                        width: '100%',
                                        height: '8px',
                                        background: '#0f1419',
                                        borderRadius: '4px',
                                        overflow: 'hidden'
                                    }}>
                                        <div style={{
                                            width: `${percentage}%`,
                                            height: '100%',
                                            background: color,
                                            borderRadius: '4px',
                                            transition: 'width 0.3s ease'
                                        }} />
                                    </div>
                                </div>
                            );
                        })}
                    </div>
                </div>
            </div>

            {/* Revenue Analytics */}
            <div style={{ marginBottom: '32px' }}>
                <h2 style={{
                    fontSize: '20px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '16px'
                }}>
                    💰 Métricas de Receita
                </h2>
                <div style={{
                    display: 'grid',
                    gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                    gap: '16px'
                }}>
                    <MetricCard
                        title="Receita Total"
                        value={`R$ ${analytics.revenueMetrics.totalRevenue.toLocaleString('pt-BR')}`}
                        icon="💵"
                        color="#10b981"
                        trend={20}
                    />
                    <MetricCard
                        title="MRR"
                        value={`R$ ${analytics.revenueMetrics.mrr.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}`}
                        subtitle="Monthly Recurring Revenue"
                        icon="🔄"
                        color="#3b82f6"
                        trend={12}
                    />
                    <MetricCard
                        title="ARPU"
                        value={`R$ ${analytics.revenueMetrics.arpu.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}`}
                        subtitle="Average Revenue Per User"
                        icon="👤"
                        color="#f59e0b"
                        trend={7}
                    />
                    <MetricCard
                        title="LTV"
                        value={`R$ ${analytics.revenueMetrics.ltv.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}`}
                        subtitle="Lifetime Value"
                        icon="💎"
                        color="#8b5cf6"
                        trend={15}
                    />
                </div>
            </div>

            {/* Growth Chart Placeholder */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '24px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px'
                }}>
                    Crescimento ao Longo do Tempo
                </h2>
                <div style={{
                    height: '300px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    background: '#0f1419',
                    borderRadius: '8px',
                    color: '#64748b'
                }}>
                    <div style={{ textAlign: 'center' }}>
                        <div style={{ fontSize: '48px', marginBottom: '12px' }}>📊</div>
                        <div>Gráfico de crescimento</div>
                        <div style={{ fontSize: '12px', marginTop: '8px' }}>
                            Integre uma biblioteca de gráficos (Chart.js, Recharts)
                        </div>
                    </div>
                </div>
            </div>
        </AdminLayout>
    );
};

export default Analytics;
