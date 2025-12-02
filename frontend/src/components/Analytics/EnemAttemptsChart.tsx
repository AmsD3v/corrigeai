import React from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

interface DataPoint {
    name: string;
    value: number;
}

interface EnemAttemptsChartProps {
    data: DataPoint[];
}

const LABEL_MAP: { [key: string]: string } = {
    'never': 'Nunca fiz',
    'once': '1 vez',
    'twice': '2 vezes',
    'three_times': '3 vezes',
    'more_than_three': 'Mais de 3'
};

const EnemAttemptsChart: React.FC<EnemAttemptsChartProps> = ({ data }) => {
    const formattedData = data.map(item => ({
        ...item,
        name: LABEL_MAP[item.name] || item.name
    }));

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
                Tentativas no ENEM
            </h3>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={formattedData}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
                    <XAxis dataKey="name" stroke="#94a3b8" />
                    <YAxis stroke="#94a3b8" />
                    <Tooltip
                        contentStyle={{
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: '#fff'
                        }}
                    />
                    <Bar dataKey="value" fill="#10b981" name="Usuários" />
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
};

export default EnemAttemptsChart;
