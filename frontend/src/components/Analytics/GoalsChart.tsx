import React from 'react';
import { PieChart, Pie, Cell, ResponsiveContainer, Legend, Tooltip } from 'recharts';

interface DataPoint {
    name: string;
    value: number;
}

interface GoalsChartProps {
    data: DataPoint[];
}

const COLORS = ['#ef4444', '#f59e0b', '#10b981', '#3b82f6', '#8b5cf6'];

const LABEL_MAP: { [key: string]: string } = {
    'enem': 'Passar no ENEM',
    'vestibular': 'Vestibular específico',
    'improve_writing': 'Melhorar escrita',
    'school_grades': 'Notas escolares',
    'other': 'Outro'
};

const GoalsChart: React.FC<GoalsChartProps> = ({ data }) => {
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
                Objetivos Principais
            </h3>
            <ResponsiveContainer width="100%" height={300}>
                <PieChart>
                    <Pie
                        data={formattedData}
                        cx="50%"
                        cy="50%"
                        labelLine={false}
                        label={({ name, percent }) => `${name}: ${(percent * 100).toFixed(0)}%`}
                        outerRadius={80}
                        fill="#8884d8"
                        dataKey="value"
                    >
                        {formattedData.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                    </Pie>
                    <Tooltip
                        contentStyle={{
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: '#fff'
                        }}
                    />
                    <Legend />
                </PieChart>
            </ResponsiveContainer>
        </div>
    );
};

export default GoalsChart;
