import { useState, useEffect } from 'react';
import AdminLayout from '../../components/AdminLayout';
import apiClient from '../../services/api';

interface User {
    id: number;
    full_name: string;
    email: string;
    created_at: string;
    credits: number;
    free_credits?: number;
    is_admin?: boolean;
}

const Usuarios = () => {
    const [users, setUsers] = useState<User[]>([]);
    const [searchTerm, setSearchTerm] = useState('');
    const [loading, setLoading] = useState(true);
    const [editingUser, setEditingUser] = useState<User | null>(null);
    const [editForm, setEditForm] = useState({
        full_name: '',
        email: '',
        credits: 0,
        free_credits: 0
    });

    useEffect(() => {
        loadUsers();
    }, []);

    const loadUsers = async () => {
        try {
            setLoading(true);
            const response = await apiClient.get('/admin/users');
            setUsers(response.data || []);
        } catch (error) {
            console.error('Error loading users:', error);
            setUsers([]);
        } finally {
            setLoading(false);
        }
    };

    const filteredUsers = users.filter(user =>
        user.full_name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        user.email.toLowerCase().includes(searchTerm.toLowerCase())
    );

    const handleEditUser = (user: User) => {
        setEditingUser(user);
        setEditForm({
            full_name: user.full_name || '',
            email: user.email || '',
            credits: user.credits || 0,
            free_credits: user.free_credits || 0
        });
    };

    const handleSaveUser = async () => {
        if (!editingUser) return;

        try {
            await apiClient.patch(`/admin/users/${editingUser.id}`, editForm);
            setEditingUser(null);
            await loadUsers();
        } catch (error: any) {
            console.error('Error updating user:', error);
            const errorMsg = error.response?.data?.detail || 'Erro ao atualizar usuário';
            alert(errorMsg);
        }
    };

    return (
        <AdminLayout activePage="/admin/usuarios">
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{
                    fontSize: '32px',
                    fontWeight: '800',
                    color: '#fff',
                    marginBottom: '8px'
                }}>
                    Gestão de Usuários
                </h1>
                <p style={{
                    fontSize: '14px',
                    color: '#94a3b8'
                }}>
                    Gerencie todos os usuários da plataforma
                </p>
            </div>

            {/* Stats */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
                gap: '16px',
                marginBottom: '24px'
            }}>
                <div style={{
                    background: '#1a1f2e',
                    border: '1px solid #334155',
                    borderRadius: '12px',
                    padding: '20px'
                }}>
                    <div style={{ fontSize: '14px', color: '#94a3b8', marginBottom: '8px' }}>
                        Total de Usuários
                    </div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#10b981' }}>
                        {users.length}
                    </div>
                </div>
            </div>

            {/* Search */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                padding: '20px',
                marginBottom: '24px'
            }}>
                <input
                    type="text"
                    placeholder="Buscar por nome ou email..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
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

            {/* Users Table */}
            <div style={{
                background: '#1a1f2e',
                border: '1px solid #334155',
                borderRadius: '12px',
                overflow: 'hidden'
            }}>
                <div style={{ overflowX: 'auto' }}>
                    <table style={{
                        width: '100%',
                        borderCollapse: 'collapse'
                    }}>
                        <thead>
                            <tr style={{ background: '#0f1419' }}>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Nome</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Email</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Cadastro</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>CorriCoins</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Grátis</th>
                                <th style={{ padding: '16px', textAlign: 'left', color: '#94a3b8', fontSize: '13px', fontWeight: '600' }}>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            {loading ? (
                                <tr>
                                    <td colSpan={6} style={{ padding: '60px', textAlign: 'center', color: '#64748b' }}>
                                        Carregando...
                                    </td>
                                </tr>
                            ) : filteredUsers.length === 0 ? (
                                <tr>
                                    <td colSpan={6} style={{ padding: '60px', textAlign: 'center', color: '#64748b' }}>
                                        Nenhum usuário encontrado
                                    </td>
                                </tr>
                            ) : (
                                filteredUsers.map((user) => (
                                    <tr key={user.id} style={{ borderTop: '1px solid #334155' }}>
                                        <td style={{ padding: '16px', color: '#fff', fontSize: '14px' }}>{user.full_name || 'Sem nome'}</td>
                                        <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>{user.email}</td>
                                        <td style={{ padding: '16px', color: '#94a3b8', fontSize: '14px' }}>
                                            {user.created_at ? new Date(user.created_at).toLocaleDateString('pt-BR') : '-'}
                                        </td>
                                        <td style={{ padding: '16px', color: '#fbbf24', fontSize: '14px', fontWeight: '600' }}>
                                            🪙 {user.credits || 0}
                                        </td>
                                        <td style={{ padding: '16px', color: '#10b981', fontSize: '14px', fontWeight: '600' }}>
                                            ⚡ {user.free_credits || 0}
                                        </td>
                                        <td style={{ padding: '16px' }}>
                                            <button
                                                onClick={() => handleEditUser(user)}
                                                style={{
                                                    padding: '8px 16px',
                                                    background: '#4F46E5',
                                                    border: 'none',
                                                    borderRadius: '6px',
                                                    color: '#fff',
                                                    fontSize: '13px',
                                                    fontWeight: '600',
                                                    cursor: 'pointer'
                                                }}
                                            >
                                                Editar
                                            </button>
                                        </td>
                                    </tr>
                                ))
                            )}
                        </tbody>
                    </table>
                </div>
            </div>

            {/* Edit User Modal */}
            {editingUser && (
                <div style={{
                    position: 'fixed',
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    background: 'rgba(0, 0, 0, 0.8)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    zIndex: 9999
                }}>
                    <div style={{
                        background: '#1a1f2e',
                        border: '1px solid #334155',
                        borderRadius: '16px',
                        padding: '32px',
                        width: '100%',
                        maxWidth: '500px'
                    }}>
                        <h2 style={{
                            fontSize: '24px',
                            fontWeight: '700',
                            color: '#fff',
                            marginBottom: '8px'
                        }}>
                            Editar Usuário
                        </h2>
                        <p style={{
                            fontSize: '14px',
                            color: '#94a3b8',
                            marginBottom: '24px'
                        }}>
                            ID: {editingUser.id}
                        </p>

                        {/* Name */}
                        <div style={{ marginBottom: '16px' }}>
                            <label style={{
                                display: 'block',
                                fontSize: '14px',
                                fontWeight: '600',
                                color: '#94a3b8',
                                marginBottom: '8px'
                            }}>
                                👤 Nome Completo
                            </label>
                            <input
                                type="text"
                                value={editForm.full_name}
                                onChange={(e) => setEditForm({ ...editForm, full_name: e.target.value })}
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '16px'
                                }}
                            />
                        </div>

                        {/* Email */}
                        <div style={{ marginBottom: '16px' }}>
                            <label style={{
                                display: 'block',
                                fontSize: '14px',
                                fontWeight: '600',
                                color: '#94a3b8',
                                marginBottom: '8px'
                            }}>
                                📧 Email
                            </label>
                            <input
                                type="email"
                                value={editForm.email}
                                onChange={(e) => setEditForm({ ...editForm, email: e.target.value })}
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '16px'
                                }}
                            />
                        </div>

                        {/* CorriCoins */}
                        <div style={{ marginBottom: '16px' }}>
                            <label style={{
                                display: 'block',
                                fontSize: '14px',
                                fontWeight: '600',
                                color: '#94a3b8',
                                marginBottom: '8px'
                            }}>
                                🪙 CorriCoins (Comprados)
                            </label>
                            <input
                                type="number"
                                value={editForm.credits}
                                onChange={(e) => setEditForm({ ...editForm, credits: parseInt(e.target.value) || 0 })}
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '16px',
                                    fontWeight: '600'
                                }}
                            />
                        </div>

                        {/* Free Credits */}
                        <div style={{ marginBottom: '24px' }}>
                            <label style={{
                                display: 'block',
                                fontSize: '14px',
                                fontWeight: '600',
                                color: '#94a3b8',
                                marginBottom: '8px'
                            }}>
                                ⚡ Créditos Grátis
                            </label>
                            <input
                                type="number"
                                value={editForm.free_credits}
                                onChange={(e) => setEditForm({ ...editForm, free_credits: parseInt(e.target.value) || 0 })}
                                style={{
                                    width: '100%',
                                    padding: '12px 16px',
                                    background: '#0f1419',
                                    border: '1px solid #334155',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '16px',
                                    fontWeight: '600'
                                }}
                            />
                        </div>

                        <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end' }}>
                            <button
                                onClick={() => setEditingUser(null)}
                                style={{
                                    padding: '12px 24px',
                                    background: '#334155',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: 'pointer'
                                }}
                            >
                                Cancelar
                            </button>
                            <button
                                onClick={handleSaveUser}
                                style={{
                                    padding: '12px 24px',
                                    background: '#10b981',
                                    border: 'none',
                                    borderRadius: '8px',
                                    color: '#fff',
                                    fontSize: '14px',
                                    fontWeight: '600',
                                    cursor: 'pointer'
                                }}
                            >
                                Salvar
                            </button>
                        </div>
                    </div>
                </div>
            )}
        </AdminLayout>
    );
};

export default Usuarios;
