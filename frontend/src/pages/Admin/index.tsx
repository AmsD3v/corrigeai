import { useState, useEffect } from 'react';
import AdminLayout from '../../components/AdminLayout';
import api from '../../services/api';

interface Metrics {
    totalUsers: number;
    activeUsers: number;
    totalEssays: number;
    totalRevenue: number;
    avgScore: number;
    pendingCorrections: number;
}

interface Activity {
    id: string;
    type: 'user' | 'essay' | 'purchase';
    description: string;
    time: string;
}

interface UserGrowth {
    month: string;
    year: number;
    users: number;
}

const AdminDashboard = () => {
    const [metrics, setMetrics] = useState<Metrics>({
        totalUsers: 0,
        activeUsers: 0,
        totalEssays: 0,
        totalRevenue: 0,
        avgScore: 0,
        pendingCorrections: 0
    });

    const [recentActivities, setRecentActivities] = useState<Activity[]>([]);
    const [userGrowth, setUserGrowth] = useState<UserGrowth[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchStats = async () => {
            try {
                const response = await api.get('/admin/stats');

                setMetrics({
                    totalUsers: response.data.total_users,
                    activeUsers: response.data.active_users,
                    totalEssays: response.data.total_essays,
                    totalRevenue: response.data.total_revenue / 100, // Converter de centavos para reais
                    avgScore: response.data.avg_score,
                    pendingCorrections: response.data.pending_corrections
                });
            } catch (error) {
                console.error('Erro ao carregar estatísticas:', error);
            }
        };

        const fetchActivities = async () => {
            try {
                const response = await api.get('/admin/recent-activities?limit=4');
                setRecentActivities(response.data);
            } catch (error) {
                console.error('Erro ao carregar atividades:', error);
            }
        };

        const fetchUserGrowth = async () => {
            try {
                const response = await api.get('/admin/user-growth?months=6');
                setUserGrowth(response.data);
            } catch (error) {
                console.error('Erro ao carregar crescimento:', error);
            }
        };

        Promise.all([fetchStats(), fetchActivities(), fetchUserGrowth()]).finally(() => {
            setLoading(false);
        });
    }, []);

    const MetricCard = ({ title, value, subtitle, icon, color }: any) => (
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
        </div>
    );

    return (
        <AdminLayout activePage="/admin">
            {/* Header */}
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Dashboard
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Visão geral do sistema CorrigeAI
                </p>
            </div>

            {/* Metrics Grid */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                gap: '20px',
                marginBottom: '32px'
            }}>
                <MetricCard
                    title="Total de Usuários"
                    value={metrics.totalUsers}
                    subtitle="Todos os cadastros"
                    icon="👥"
                    color="#10b981"
                />
                <MetricCard
                    title="Usuários Ativos"
                    value={metrics.activeUsers}
                    subtitle="Últimos 30 dias"
                    icon="✅"
                    color="#3b82f6"
                />
                <MetricCard
                    title="Total de Redações"
                    value={metrics.totalEssays}
                    subtitle="Redações corrigidas"
                    icon="📝"
                    color="#f59e0b"
                />
                <MetricCard
                    title="Receita Total"
                    value={`R$ ${metrics.totalRevenue.toLocaleString('pt-BR')}`}
                    subtitle="Estimado"
                    icon="💰"
                    color="#ef4444"
                />
                <MetricCard
                    title="Pontuação Média"
                    value={metrics.avgScore}
                    subtitle="De 1000 pontos"
                    icon="📊"
                    color="#8b5cf6"
                />
                <MetricCard
                    title="Pendentes"
                    value={metrics.pendingCorrections}
                    subtitle="Aguardando correção"
                    icon="⏳"
                    color="#64748b"
                />
            </div>

            {/* Two Column Layout */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: '2fr 1fr',
                gap: '24px'
            }}>
                {/* User Growth Chart */}
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
                        Crescimento de Usuários
                    </h2>
                    <div style={{
                        height: '300px',
                        background: '#0f1419',
                        borderRadius: '8px',
                        padding: '20px',
                        display: 'flex',
                        flexDirection: 'column'
                    }}>
                        {userGrowth.length > 0 ? (
                            <>
                                {/* Chart area */}
                                <div style={{
                                    flex: 1,
                                    display: 'flex',
                                    alignItems: 'flex-end',
                                    justifyContent: 'space-around',
                                    gap: '12px',
                                    paddingBottom: '8px'
                                }}>
                                    {(() => {
                                        const maxUsers = Math.max(...userGrowth.map(d => d.users), 1);
                                        return userGrowth.map((data, index) => {
                                            const heightPercent = (data.users / maxUsers) * 100;
                                            return (
                                                <div
                                                    key={index}
                                                    style={{
                                                        display: 'flex',
                                                        flexDirection: 'column',
                                                        alignItems: 'center',
                                                        flex: 1,
                                                        height: '100%',
                                                        justifyContent: 'flex-end'
                                                    }}
                                                >
                                                    {/* Value label */}
                                                    <div style={{
                                                        fontSize: '12px',
                                                        fontWeight: '600',
                                                        color: '#10b981',
                                                        marginBottom: '4px'
                                                    }}>
                                                        {data.users}
                                                    </div>
                                                    {/* Bar */}
                                                    <div
                                                        style={{
                                                            width: '100%',
                                                            maxWidth: '60px',
                                                            height: `${Math.max(heightPercent, 5)}%`,
                                                            background: 'linear-gradient(180deg, #10b981 0%, #059669 100%)',
                                                            borderRadius: '4px 4px 0 0',
                                                            transition: 'height 0.3s ease',
                                                            minHeight: '4px'
                                                        }}
                                                    />
                                                </div>
                                            );
                                        });
                                    })()}
                                </div>
                                {/* X-axis labels */}
                                <div style={{
                                    display: 'flex',
                                    justifyContent: 'space-around',
                                    borderTop: '1px solid #334155',
                                    paddingTop: '8px'
                                }}>
                                    {userGrowth.map((data, index) => (
                                        <div
                                            key={`label-${index}`}
                                            style={{
                                                flex: 1,
                                                textAlign: 'center',
                                                fontSize: '11px',
                                                color: '#64748b'
                                            }}
                                        >
                                            {data.month}
                                        </div>
                                    ))}
                                </div>
                            </>
                        ) : (
                            <div style={{
                                flex: 1,
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                color: '#64748b'
                            }}>
                                <div style={{ textAlign: 'center' }}>
                                    <div style={{ fontSize: '48px', marginBottom: '12px' }}>📈</div>
                                    <div>Carregando dados...</div>
                                </div>
                            </div>
                        )}
                    </div>
                </div>

                {/* Recent Activity */}
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
                        Atividades Recentes
                    </h2>
                    <div style={{
                        display: 'flex',
                        flexDirection: 'column',
                        gap: '12px'
                    }}>
                        {recentActivities.length > 0 ? (
                            recentActivities.map((activity) => (
                                <div
                                    key={activity.id}
                                    style={{
                                        padding: '12px',
                                        background: '#0f1419',
                                        borderRadius: '8px',
                                        borderLeft: `3px solid ${activity.type === 'user' ? '#10b981' :
                                            activity.type === 'essay' ? '#f59e0b' :
                                                '#ef4444'
                                            }`
                                    }}
                                >
                                    <div style={{
                                        fontSize: '13px',
                                        color: '#fff',
                                        marginBottom: '4px'
                                    }}>
                                        {activity.description}
                                    </div>
                                    <div style={{
                                        fontSize: '11px',
                                        color: '#64748b'
                                    }}>
                                        {activity.time}
                                    </div>
                                </div>
                            ))
                        ) : (
                            <div style={{
                                padding: '40px',
                                textAlign: 'center',
                                color: '#64748b'
                            }}>
                                Nenhuma atividade recente
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </AdminLayout>
    );
};

export default AdminDashboard;
