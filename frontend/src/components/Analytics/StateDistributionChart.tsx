import React from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from 'recharts';

interface DataPoint {
    name: string;
    value: number;
}

interface StateDistributionChartProps {
    data: DataPoint[];
}

const StateDistributionChart: React.FC<StateDistributionChartProps> = ({ data }) => {
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
                Top 10 Estados
            </h3>
            <ResponsiveContainer width="100%" height={300}>
                <BarChart data={data} layout="vertical" margin={{ left: 20 }}>
                    <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
                    <XAxis type="number" stroke="#94a3b8" />
                    <YAxis type="category" dataKey="name" stroke="#94a3b8" width={40} />
                    <Tooltip
                        contentStyle={{
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: '#fff'
                        }}
                    />
                    <Bar dataKey="value" fill="#3b82f6" name="Usuários" />
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
};

export default StateDistributionChart;
