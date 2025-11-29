import { useState } from 'react';
import { Link } from 'react-router-dom';
import api from '../services/api';

const ForgotPassword = () => {
    const [email, setEmail] = useState('');
    const [loading, setLoading] = useState(false);
    const [success, setSuccess] = useState(false);
    const [error, setError] = useState('');

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError('');

        try {
            await api.post('/forgot-password', { email });
            setSuccess(true);
        } catch (err: any) {
            setError(err.response?.data?.detail || 'Erro ao enviar email. Tente novamente.');
        } finally {
            setLoading(false);
        }
    };

    if (success) {
        return (
            <div style={{
                minHeight: '100vh',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
                padding: '20px'
            }}>
                <div style={{
                    background: 'white',
                    borderRadius: '16px',
                    padding: '40px',
                    maxWidth: '480px',
                    width: '100%',
                    boxShadow: '0 20px 60px rgba(0,0,0,0.3)',
                    textAlign: 'center'
                }}>
                    <div style={{
                        fontSize: '64px',
                        marginBottom: '24px'
                    }}>
                        ✅
                    </div>
                    <h1 style={{
                        fontSize: '28px',
                        fontWeight: '800',
                        color: '#1a202c',
                        marginBottom: '16px'
                    }}>
                        Email Enviado!
                    </h1>
                    <p style={{
                        fontSize: '16px',
                        color: '#4a5568',
                        marginBottom: '32px',
                        lineHeight: '1.6'
                    }}>
                        Se o email <strong>{email}</strong> estiver cadastrado em nossa base,
                        você receberá instruções para redefinir sua senha.
                    </p>
                    <p style={{
                        fontSize: '14px',
                        color: '#718096',
                        marginBottom: '24px'
                    }}>
                        Verifique sua caixa de entrada e spam.
                    </p>
                    <Link
                        to="/login"
                        style={{
                            display: 'inline-block',
                            padding: '12px 32px',
                            background: '#667eea',
                            color: 'white',
                            textDecoration: 'none',
                            borderRadius: '8px',
                            fontWeight: '600',
                            transition: 'all 0.3s'
                        }}
                    >
                        Voltar ao Login
                    </Link>
                </div>
            </div>
        );
    }

    return (
        <div style={{
            minHeight: '100vh',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
            padding: '20px'
        }}>
            <div style={{
                background: 'white',
                borderRadius: '16px',
                padding: '40px',
                maxWidth: '480px',
                width: '100%',
                boxShadow: '0 20px 60px rgba(0,0,0,0.3)'
            }}>
                <div style={{
                    textAlign: 'center',
                    marginBottom: '32px'
                }}>
                    <div style={{
                        fontSize: '48px',
                        marginBottom: '16px'
                    }}>
                        🔐
                    </div>
                    <h1 style={{
                        fontSize: '28px',
                        fontWeight: '800',
                        color: '#1a202c',
                        marginBottom: '8px'
                    }}>
                        Esqueci Minha Senha
                    </h1>
                    <p style={{
                        fontSize: '14px',
                        color: '#718096'
                    }}>
                        Insira seu email para receber instruções de recuperação
                    </p>
                </div>

                <form onSubmit={handleSubmit}>
                    <div style={{ marginBottom: '24px' }}>
                        <label style={{
                            display: 'block',
                            fontSize: '14px',
                            fontWeight: '600',
                            color: '#2d3748',
                            marginBottom: '8px'
                        }}>
                            Email
                        </label>
                        <input
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            required
                            placeholder="seu@email.com"
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                border: '2px solid #e2e8f0',
                                borderRadius: '8px',
                                fontSize: '16px',
                                transition: 'all 0.3s',
                                outline: 'none'
                            }}
                            onFocus={(e) => e.target.style.borderColor = '#667eea'}
                            onBlur={(e) => e.target.style.borderColor = '#e2e8f0'}
                        />
                    </div>

                    {error && (
                        <div style={{
                            padding: '12px',
                            background: '#fed7d7',
                            color: '#c53030',
                            borderRadius: '8px',
                            fontSize: '14px',
                            marginBottom: '16px'
                        }}>
                            {error}
                        </div>
                    )}

                    <button
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%',
                            padding: '14px',
                            background: loading ? '#a0aec0' : '#667eea',
                            color: 'white',
                            border: 'none',
                            borderRadius: '8px',
                            fontSize: '16px',
                            fontWeight: '700',
                            cursor: loading ? 'not-allowed' : 'pointer',
                            transition: 'all 0.3s',
                            marginBottom: '16px'
                        }}
                    >
                        {loading ? 'Enviando...' : 'Enviar Link de Recuperação'}
                    </button>

                    <div style={{
                        textAlign: 'center',
                        fontSize: '14px',
                        color: '#718096'
                    }}>
                        Lembrou sua senha?{' '}
                        <Link
                            to="/login"
                            style={{
                                color: '#667eea',
                                textDecoration: 'none',
                                fontWeight: '600'
                            }}
                        >
                            Fazer Login
                        </Link>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default ForgotPassword;
