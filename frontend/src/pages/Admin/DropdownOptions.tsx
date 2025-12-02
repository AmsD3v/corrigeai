import { useState, useEffect } from 'react';
import api from '../../services/api';
import AdminLayout from '../../components/AdminLayout';
import ToggleSwitch from '../../components/ToggleSwitch';

interface DropdownOption {
    id: number;
    category: string;
    value: string;
    label: string;
    order: number;
    is_active: boolean;
}

const CATEGORIES = [
    { value: 'school_level', label: 'Ano/Nível Escolar' },
    { value: 'enem_attempts', label: 'Tentativas ENEM' },
    { value: 'main_goal', label: 'Objetivo Principal' },
    { value: 'study_method', label: 'Método de Estudo' }
];

const DropdownOptionsAdmin = () => {
    const [selectedCategory, setSelectedCategory] = useState('school_level');
    const [options, setOptions] = useState<DropdownOption[]>([]);
    const [loading, setLoading] = useState(true);
    const [editingId, setEditingId] = useState<number | null>(null);
    const [showNewForm, setShowNewForm] = useState(false);

    // Form states
    const [formData, setFormData] = useState({
        value: '',
        label: '',
        order: 0,
        is_active: true
    });

    useEffect(() => {
        loadOptions();
    }, [selectedCategory]);

    const loadOptions = async () => {
        try {
            setLoading(true);
            const response = await api.get(`/api/admin/dropdown-options?category=${selectedCategory}`);
            setOptions(response.data);
        } catch (error) {
            console.error('Error loading options:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleCreate = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            await api.post('/api/admin/dropdown-options', {
                ...formData,
                category: selectedCategory
            });

            // Reset form
            setFormData({ value: '', label: '', order: 0, is_active: true });
            setShowNewForm(false);
            loadOptions();
        } catch (error: any) {
            alert(error.response?.data?.detail || 'Erro ao criar opção');
        }
    };

    const handleUpdate = async (id: number) => {
        const option = options.find(opt => opt.id === id);
        if (!option) return;

        try {
            await api.put(`/api/admin/dropdown-options/${id}`, {
                value: option.value,
                label: option.label,
                order: option.order,
                is_active: option.is_active
            });

            setEditingId(null);
            loadOptions();
        } catch (error: any) {
            alert(error.response?.data?.detail || 'Erro ao atualizar opção');
        }
    };

    const handleDelete = async (id: number) => {
        if (!confirm('Tem certeza que deseja excluir esta opção?')) return;

        try {
            await api.delete(`/api/admin/dropdown-options/${id}`);
            loadOptions();
        } catch (error: any) {
            alert(error.response?.data?.detail || 'Erro ao excluir opção');
        }
    };

    const handleToggleActive = async (id: number, currentStatus: boolean) => {
        const option = options.find(opt => opt.id === id);
        if (!option) return;

        try {
            await api.put(`/api/admin/dropdown-options/${id}`, {
                ...option,
                is_active: !currentStatus
            });

            loadOptions();
        } catch (error: any) {
            alert(error.response?.data?.detail || 'Erro ao atualizar status');
        }
    };

    const updateOption = (id: number, field: string, value: any) => {
        setOptions(options.map(opt =>
            opt.id === id ? { ...opt, [field]: value } : opt
        ));
    };

    return (
        <AdminLayout activePage="/admin/dropdown-options">
            <div style={{
                maxWidth: '1200px',
                margin: '0 auto',
                padding: '32px'
            }}>
                {/* Header */}
                <div style={{ marginBottom: '32px' }}>
                    <h1 style={{
                        fontSize: '32px',
                        fontWeight: '800',
                        color: '#fff',
                        marginBottom: '8px'
                    }}>
                        Gerenciar Opções de Dropdown
                    </h1>
                    <p style={{
                        fontSize: '16px',
                        color: '#94a3b8'
                    }}>
                        Configure as opções disponíveis para informações complementares dos usuários
                    </p>
                </div>

                {/* Category Selector */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '24px',
                    marginBottom: '24px'
                }}>
                    <label style={{
                        display: 'block',
                        fontSize: '14px',
                        fontWeight: '600',
                        color: '#94a3b8',
                        marginBottom: '12px'
                    }}>
                        Selecione a Categoria:
                    </label>
                    <select
                        value={selectedCategory}
                        onChange={(e) => setSelectedCategory(e.target.value)}
                        style={{
                            width: '100%',
                            maxWidth: '400px',
                            padding: '12px 16px',
                            background: '#0f1419',
                            border: '1px solid #334155',
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '14px',
                            cursor: 'pointer'
                        }}
                    >
                        {CATEGORIES.map(cat => (
                            <option key={cat.value} value={cat.value}>
                                {cat.label}
                            </option>
                        ))}
                    </select>
                </div>

                {/* Add New Button */}
                <div style={{ marginBottom: '24px' }}>
                    <button
                        onClick={() => setShowNewForm(!showNewForm)}
                        style={{
                            padding: '12px 24px',
                            background: '#4F46E5',
                            border: 'none',
                            borderRadius: '8px',
                            color: '#fff',
                            fontSize: '14px',
                            fontWeight: '600',
                            cursor: 'pointer',
                            transition: 'all 0.2s'
                        }}
                        onMouseEnter={(e) => e.currentTarget.style.background = '#4338ca'}
                        onMouseLeave={(e) => e.currentTarget.style.background = '#4F46E5'}
                    >
                        {showNewForm ? '✕ Cancelar' : '+ Nova Opção'}
                    </button>
                </div>

                {/* New Option Form */}
                {showNewForm && (
                    <form onSubmit={handleCreate} style={{
                        background: '#1a1f2e',
                        border: '1px solid #334155',
                        borderRadius: '12px',
                        padding: '24px',
                        marginBottom: '24px'
                    }}>
                        <h3 style={{
                            fontSize: '18px',
                            fontWeight: '700',
                            color: '#fff',
                            marginBottom: '16px'
                        }}>
                            Nova Opção - {CATEGORIES.find(c => c.value === selectedCategory)?.label}
                        </h3>

                        <div style={{
                            display: 'grid',
                            gridTemplateColumns: 'repeat(2, 1fr)',
                            gap: '16px',
                            marginBottom: '16px'
                        }}>
                            <div>
                                <label style={{
                                    display: 'block',
                                    fontSize: '13px',
                                    fontWeight: '600',
                                    color: '#94a3b8',
                                    marginBottom: '8px'
                                }}>
                                    Valor (usado no banco):
                                </label>
                                <input
                                    type="text"
                                    value={formData.value}
                                    onChange={(e) => setFormData({ ...formData, value: e.target.value })}
                                    required
                                    placeholder="ex: 3_ano_em"
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

                            <div>
                                <label style={{
                                    display: 'block',
                                    fontSize: '13px',
                                    fontWeight: '600',
                                    color: '#94a3b8',
                                    marginBottom: '8px'
                                }}>
                                    Rótulo (exibido ao usuário):
                                </label>
                                <input
                                    type="text"
                                    value={formData.label}
                                    onChange={(e) => setFormData({ ...formData, label: e.target.value })}
                                    required
                                    placeholder="ex: 3º Ano Ensino Médio"
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

                            <div>
                                <label style={{
                                    display: 'block',
                                    fontSize: '13px',
                                    fontWeight: '600',
                                    color: '#94a3b8',
                                    marginBottom: '8px'
                                }}>
                                    Ordem:
                                </label>
                                <input
                                    type="number"
                                    value={formData.order}
                                    onChange={(e) => setFormData({ ...formData, order: parseInt(e.target.value) })}
                                    required
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

                            <div style={{
                                display: 'flex',
                                alignItems: 'flex-end'
                            }}>
                                <label style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '8px',
                                    fontSize: '14px',
                                    color: '#94a3b8',
                                    cursor: 'pointer'
                                }}>
                                    <input
                                        type="checkbox"
                                        checked={formData.is_active}
                                        onChange={(e) => setFormData({ ...formData, is_active: e.target.checked })}
                                        style={{ cursor: 'pointer' }}
                                    />
                                    Ativo
                                </label>
                            </div>
                        </div>

                        <button
                            type="submit"
                            style={{
                                padding: '12px 24px',
                                background: '#10b981',
                                border: 'none',
                                borderRadius: '8px',
                                color: '#fff',
                                fontSize: '14px',
                                fontWeight: '600',
                                cursor: 'pointer',
                                transition: 'all 0.2s'
                            }}
                            onMouseEnter={(e) => e.currentTarget.style.background = '#059669'}
                            onMouseLeave={(e) => e.currentTarget.style.background = '#10b981'}
                        >
                            Criar Opção
                        </button>
                    </form>
                )}

                {/* Options List */}
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    overflow: 'hidden'
                }}>
                    <div style={{
                        padding: '20px 24px',
                        borderBottom: '1px solid #334155',
                        background: '#0f1419'
                    }}>
                        <h2 style={{
                            fontSize: '18px',
                            fontWeight: '700',
                            color: '#fff'
                        }}>
                            Opções de {CATEGORIES.find(c => c.value === selectedCategory)?.label}
                        </h2>
                    </div>

                    {loading ? (
                        <div style={{
                            padding: '40px',
                            textAlign: 'center',
                            color: '#94a3b8'
                        }}>
                            Carregando...
                        </div>
                    ) : options.length === 0 ? (
                        <div style={{
                            padding: '40px',
                            textAlign: 'center',
                            color: '#94a3b8'
                        }}>
                            Nenhuma opção cadastrada ainda
                        </div>
                    ) : (
                        <div style={{ padding: '16px' }}>
                            {options.map((option) => (
                                <div key={option.id} style={{
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    padding: '16px',
                                    marginBottom: '12px',
                                    display: 'grid',
                                    gridTemplateColumns: editingId === option.id ? '2fr 2fr 1fr 80px 120px' : '2fr 2fr 1fr 80px 120px',
                                    gap: '12px',
                                    alignItems: 'center'
                                }}>
                                    {editingId === option.id ? (
                                        <>
                                            <input
                                                type="text"
                                                value={option.value}
                                                onChange={(e) => updateOption(option.id, 'value', e.target.value)}
                                                style={{
                                                    padding: '8px 12px',
                                                    background: '#1a1f2e',
                                                    border: '1px solid #334155',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '13px'
                                                }}
                                            />
                                            <input
                                                type="text"
                                                value={option.label}
                                                onChange={(e) => updateOption(option.id, 'label', e.target.value)}
                                                style={{
                                                    padding: '8px 12px',
                                                    background: '#1a1f2e',
                                                    border: '1px solid #334155',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '13px'
                                                }}
                                            />
                                            <input
                                                type="number"
                                                value={option.order}
                                                onChange={(e) => updateOption(option.id, 'order', parseInt(e.target.value))}
                                                style={{
                                                    padding: '8px 12px',
                                                    background: '#1a1f2e',
                                                    border: '1px solid #334155',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '13px',
                                                    width: '80px'
                                                }}
                                            />
                                        </>
                                    ) : (
                                        <>
                                            <div style={{
                                                fontSize: '13px',
                                                color: '#94a3b8',
                                                fontFamily: 'monospace'
                                            }}>
                                                {option.value}
                                            </div>
                                            <div style={{
                                                fontSize: '14px',
                                                color: '#fff',
                                                fontWeight: '500'
                                            }}>
                                                {option.label}
                                            </div>
                                            <div style={{
                                                fontSize: '13px',
                                                color: '#94a3b8'
                                            }}>
                                                Ordem: {option.order}
                                            </div>
                                        </>
                                    )}

                                    <ToggleSwitch
                                        checked={option.is_active}
                                        onChange={() => handleToggleActive(option.id, option.is_active)}
                                    />

                                    <div style={{
                                        display: 'flex',
                                        gap: '8px',
                                        justifyContent: 'flex-end'
                                    }}>
                                        {editingId === option.id ? (
                                            <>
                                                <button
                                                    onClick={() => handleUpdate(option.id)}
                                                    style={{
                                                        padding: '6px 12px',
                                                        background: '#10b981',
                                                        border: 'none',
                                                        borderRadius: '6px',
                                                        color: '#fff',
                                                        fontSize: '12px',
                                                        fontWeight: '600',
                                                        cursor: 'pointer'
                                                    }}
                                                >
                                                    ✓
                                                </button>
                                                <button
                                                    onClick={() => setEditingId(null)}
                                                    style={{
                                                        padding: '6px 12px',
                                                        background: '#64748b',
                                                        border: 'none',
                                                        borderRadius: '6px',
                                                        color: '#fff',
                                                        fontSize: '12px',
                                                        fontWeight: '600',
                                                        cursor: 'pointer'
                                                    }}
                                                >
                                                    ✕
                                                </button>
                                            </>
                                        ) : (
                                            <>
                                                <button
                                                    onClick={() => setEditingId(option.id)}
                                                    style={{
                                                        padding: '6px 12px',
                                                        background: '#3b82f6',
                                                        border: 'none',
                                                        borderRadius: '6px',
                                                        color: '#fff',
                                                        fontSize: '12px',
                                                        fontWeight: '600',
                                                        cursor: 'pointer'
                                                    }}
                                                >
                                                    ✎
                                                </button>
                                                <button
                                                    onClick={() => handleDelete(option.id)}
                                                    style={{
                                                        padding: '6px 12px',
                                                        background: '#ef4444',
                                                        border: 'none',
                                                        borderRadius: '6px',
                                                        color: '#fff',
                                                        fontSize: '12px',
                                                        fontWeight: '600',
                                                        cursor: 'pointer'
                                                    }}
                                                >
                                                    🗑
                                                </button>
                                            </>
                                        )}
                                    </div>
                                </div>
                            ))}
                        </div>
                    )}
                </div>
            </div>
        </AdminLayout>
    );
};

export default DropdownOptionsAdmin;
