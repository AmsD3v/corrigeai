import React from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

interface DataPoint {
    name: string;
    value: number;
}

interface TopCoursesChartProps {
    data: DataPoint[];
}

const TopCoursesChart: React.FC<TopCoursesChartProps> = ({ data }) => {
    return (
        <div style={{
            background: '#1a1f2e',
            border: '1px solid #334155',
            borderRadius: '12px',
            padding: '24px'
        }}>
            <h3 style={{
                fontSize: '18px',
                fontWeight: '700',
                color: '#fff',
                marginBottom: '20px'
            }}>
                Top 10 Cursos Pretendidos
            </h3>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={data}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
                    <XAxis dataKey="name" stroke="#94a3b8" angle={-45} textAnchor="end" height={100} />
                    <YAxis stroke="#94a3b8" />
                    <Tooltip
                        contentStyle={{
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: '#fff'
                        }}
                    />
                    <Bar dataKey="value" fill="#ec4899" name="Usuários" />
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
};

export default TopCoursesChart;
