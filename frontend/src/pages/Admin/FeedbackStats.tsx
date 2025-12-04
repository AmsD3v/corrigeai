import { useState, useEffect } from 'react';
import AdminLayout from '../../components/AdminLayout';
import api from '../../services/api';

interface FeedbackStats {
    total_feedbacks: number;
    positive_count: number;
    negative_count: number;
    positive_percentage: number;
    negative_percentage: number;
    latest_feedbacks: LatestFeedback[];
    daily_stats: DailyStat[];
    period_days: number;
}

interface LatestFeedback {
    id: number;
    submission_id: number;
    essay_title: string;
    score: number;
    is_helpful: boolean;
    user_name: string;
    created_at: string;
}

interface DailyStat {
    date: string;
    positive: number;
    negative: number;
}

const FeedbackStats = () => {
    const [stats, setStats] = useState<FeedbackStats>({
        total_feedbacks: 0,
        positive_count: 0,
        negative_count: 0,
        positive_percentage: 0,
        negative_percentage: 0,
        latest_feedbacks: [],
        daily_stats: [],
        period_days: 30
    });
    const [loading, setLoading] = useState(true);
    const [period, setPeriod] = useState(30);

    useEffect(() => {
        fetchStats();
    }, [period]);

    const fetchStats = async () => {
        setLoading(true);
        try {
            const response = await api.get(`/admin/feedback-stats?days=${period}`);
            setStats(response.data);
        } catch (error) {
            console.error('Erro ao carregar estatísticas de feedback:', error);
        } finally {
            setLoading(false);
        }
    };

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

    if (loading) {
        return (
            <AdminLayout activePage="/admin/feedback-stats">
                <div style={{ textAlign: 'center', padding: '60px', color: '#64748b' }}>
                    <div style={{ fontSize: '48px', marginBottom: '16px' }}>📊</div>
                    <div>Carregando estatísticas...</div>
                </div>
            </AdminLayout>
        );
    }

    return (
        <AdminLayout activePage="/admin/feedback-stats">
            {/* Header */}
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Estatísticas de Feedback
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Acompanhe a satisfação dos usuários com as correções
                </p>
            </div>

            {/* Period Filter */}
            <div style={{ marginBottom: '24px' }}>
                <label style={{
                    display: 'block',
                    fontSize: '14px',
                    fontWeight: '600',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Período:
                </label>
                <select
                    value={period}
                    onChange={(e) => setPeriod(Number(e.target.value))}
                    style={{
                        padding: '10px 14px',
                        background: '#1a1f2e',
                        border: '1px solid #334155',
                        borderRadius: '8px',
                        color: '#fff',
                        fontSize: '14px',
                        cursor: 'pointer',
                        outline: 'none'
                    }}
                >
                    <option value={7}>Últimos 7 dias</option>
                    <option value={30}>Últimos 30 dias</option>
                    <option value={90}>Últimos 90 dias</option>
                </select>
            </div>

            {/* Summary Cards */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
                gap: '16px',
                marginBottom: '32px'
            }}>
                <MetricCard
                    title="Total de Feedbacks"
                    value={stats.total_feedbacks}
                    subtitle={`Últimos ${period} dias`}
                    icon="📊"
                    color="#3b82f6"
                />
                <MetricCard
                    title="Feedbacks Positivos"
                    value={stats.positive_count}
                    subtitle={`${stats.positive_percentage}%`}
                    icon="👍"
                    color="#10b981"
                />
                <MetricCard
                    title="Feedbacks Negativos"
                    value={stats.negative_count}
                    subtitle={`${stats.negative_percentage}%`}
                    icon="👎"
                    color="#ef4444"
                />
            </div>

            {/* Pie Chart */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '24px',
                marginBottom: '32px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px'
                }}>
                    Distribuição de Feedback
                </h2>
                <div style={{
                    maxWidth: '400px',
                    margin: '0 auto',
                    textAlign: 'center'
                }}>
                    {stats.total_feedbacks > 0 ? (
                        <>
                            {/* Simple Pie Chart representation */}
                            <div style={{
                                width: '200px',
                                height: '200px',
                                margin: '0 auto 24px',
                                borderRadius: '50%',
                                background: `conic-gradient(
                                    #10b981 0deg ${stats.positive_percentage * 3.6}deg,
                                    #ef4444 ${stats.positive_percentage * 3.6}deg 360deg
                                )`,
                                position: 'relative'
                            }}>
                                <div style={{
                                    position: 'absolute',
                                    top: '50%',
                                    left: '50%',
                                    transform: 'translate(-50%, -50%)',
                                    width: '140px',
                                    height: '140px',
                                    background: '#1a1f2e',
                                    borderRadius: '50%',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    flexDirection: 'column'
                                }}>
                                    <div style={{ fontSize: '32px', fontWeight: '800', color: '#fff' }}>
                                        {stats.positive_percentage}%
                                    </div>
                                    <div style={{ fontSize: '12px', color: '#64748b' }}>
                                        Positivos
                                    </div>
                                </div>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'center', gap: '24px' }}>
                                <div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '4px' }}>
                                        <div style={{ width: '12px', height: '12px', background: '#10b981', borderRadius: '2px' }}></div>
                                        <span style={{ fontSize: '14px', color: '#fff', fontWeight: '600' }}>Positivos</span>
                                    </div>
                                    <div style={{ fontSize: '12px', color: '#64748b', paddingLeft: '20px' }}>
                                        {stats.positive_count} ({stats.positive_percentage}%)
                                    </div>
                                </div>
                                <div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '4px' }}>
                                        <div style={{ width: '12px', height: '12px', background: '#ef4444', borderRadius: '2px' }}></div>
                                        <span style={{ fontSize: '14px', color: '#fff', fontWeight: '600' }}>Negativos</span>
                                    </div>
                                    <div style={{ fontSize: '12px', color: '#64748b', paddingLeft: '20px' }}>
                                        {stats.negative_count} ({stats.negative_percentage}%)
                                    </div>
                                </div>
                            </div>
                        </>
                    ) : (
                        <div style={{ padding: '40px', color: '#64748b' }}>
                            <div style={{ fontSize: '48px', marginBottom: '12px' }}>📊</div>
                            <div>Nenhum feedback registrado neste período</div>
                        </div>
                    )}
                </div>
            </div>

            {/* Trend Chart */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '24px',
                marginBottom: '32px'
            }}>
                <h2 style={{
                    fontSize: '18px',
                    fontWeight: '700',
                    color: '#fff',
                    marginBottom: '20px'
                }}>
                    Tendência (Últimos 7 dias)
                </h2>
                <div style={{
                    display: 'flex',
                    alignItems: 'flex-end',
                    justifyContent: 'space-around',
                    height: '200px',
                    gap: '4px',
                    padding: '20px 0'
                }}>
                    {stats.daily_stats.map((day, index) => {
                        const total = day.positive + day.negative;
                        const maxTotal = Math.max(...stats.daily_stats.map(d => d.positive + d.negative), 1);
                        const height = total > 0 ? (total / maxTotal) * 160 : 10;
                        const positiveHeight = total > 0 ? (day.positive / total) * height : 0;
                        const negativeHeight = total > 0 ? (day.negative / total) * height : 0;

                        return (
                            <div key={index} style={{
                                flex: 1,
                                display: 'flex',
                                flexDirection: 'column',
                                alignItems: 'center',
                                gap: '8px'
                            }}>
                                <div style={{
                                    width: '100%',
                                    display: 'flex',
                                    flexDirection: 'column-reverse',
                                    alignItems: 'center',
                                    gap: '2px'
                                }}>
                                    {positiveHeight > 0 && (
                                        <div style={{
                                            width: '100%',
                                            maxWidth: '40px',
                                            height: `${positiveHeight}px`,
                                            background: '#10b981',
                                            borderRadius: '4px 4px 0 0',
                                            transition: 'height 0.3s ease'
                                        }}></div>
                                    )}
                                    {negativeHeight > 0 && (
                                        <div style={{
                                            width: '100%',
                                            maxWidth: '40px',
                                            height: `${negativeHeight}px`,
                                            background: '#ef4444',
                                            borderRadius: '0 0 4px 4px',
                                            transition: 'height 0.3s ease'
                                        }}></div>
                                    )}
                                </div>
                                <div style={{
                                    fontSize: '10px',
                                    color: '#64748b',
                                    textAlign: 'center',
                                    whiteSpace: 'nowrap'
                                }}>
                                    {new Date(day.date).toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit' })}
                                </div>
                            </div>
                        );
                    })}
                </div>
            </div>

            {/* Latest Feedbacks Table */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                overflow: 'hidden'
            }}>
                <div style={{ padding: '24px 24px 16px' }}>
                    <h2 style={{
                        fontSize: '18px',
                        fontWeight: '700',
                        color: '#fff'
                    }}>
                        Feedbacks Recentes
                    </h2>
                </div>

                {stats.latest_feedbacks.length > 0 ? (
                    <div style={{ overflowX: 'auto' }}>
                        <table style={{
                            width: '100%',
                            borderCollapse: 'collapse'
                        }}>
                            <thead>
                                <tr style={{ borderTop: '1px solid #334155', borderBottom: '1px solid #334155' }}>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                        Redação
                                    </th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                        Usuário
                                    </th>
                                    <th style={{ padding: '12px 24px', textAlign: 'center', fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                        Nota
                                    </th>
                                    <th style={{ padding: '12px 24px', textAlign: 'center', fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                        Feedback
                                    </th>
                                    <th style={{ padding: '12px 24px', textAlign: 'left', fontSize: '12px', fontWeight: '600', color: '#94a3b8', textTransform: 'uppercase' }}>
                                        Data
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                {stats.latest_feedbacks.map((feedback) => (
                                    <tr key={feedback.id} style={{
                                        borderBottom: '1px solid #334155',
                                        transition: 'background 0.2s'
                                    }}
                                        onMouseEnter={(e) => e.currentTarget.style.background = '#0f1419'}
                                        onMouseLeave={(e) => e.currentTarget.style.background = 'transparent'}
                                    >
                                        <td style={{ padding: '16px 24px' }}>
                                            <div style={{ fontSize: '14px', fontWeight: '500', color: '#fff', marginBottom: '2px' }}>
                                                {feedback.essay_title}
                                            </div>
                                            <div style={{ fontSize: '12px', color: '#64748b' }}>
                                                ID: {feedback.submission_id}
                                            </div>
                                        </td>
                                        <td style={{ padding: '16px 24px', fontSize: '14px', color: '#94a3b8' }}>
                                            {feedback.user_name}
                                        </td>
                                        <td style={{ padding: '16px 24px', textAlign: 'center' }}>
                                            <span style={{
                                                padding: '4px 12px',
                                                borderRadius: '8px',
                                                fontSize: '14px',
                                                fontWeight: '700',
                                                background: '#10b98120',
                                                color: '#10b981'
                                            }}>
                                                {feedback.score}
                                            </span>
                                        </td>
                                        <td style={{ padding: '16px 24px', textAlign: 'center', fontSize: '24px' }}>
                                            {feedback.is_helpful ? '👍' : '👎'}
                                        </td>
                                        <td style={{ padding: '16px 24px', fontSize: '14px', color: '#94a3b8' }}>
                                            {new Date(feedback.created_at).toLocaleString('pt-BR')}
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                ) : (
                    <div style={{ padding: '40px', textAlign: 'center', color: '#64748b' }}>
                        Nenhum feedback registrado neste período
                    </div>
                )}
            </div>
        </AdminLayout>
    );
};

export default FeedbackStats;
