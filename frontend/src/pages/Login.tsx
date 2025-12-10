import React, { useState, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/api';
import { useAuth } from '../contexts/AuthContext';
import Header from '../components/Header';
import PasswordInput from '../components/PasswordInput';

type AuthMode = 'login' | 'forgot-email' | 'forgot-token' | 'new-password';

const Login: React.FC = () => {
  // Estados gerais
  const [authMode, setAuthMode] = useState<AuthMode>('login');
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  // Estados de login
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  // Estados de recuperação
  const [recoveryEmail, setRecoveryEmail] = useState('');
  const [tokenDigits, setTokenDigits] = useState(['', '', '', '', '', '']);
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');

  // Estados para toggle de senha
  const [showPassword, setShowPassword] = useState(false);
  const [showNewPassword, setShowNewPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);

  const { login } = useAuth();
  const navigate = useNavigate();

  // Refs para inputs de token
  const tokenInputRefs = useRef<(HTMLInputElement | null)[]>([]);

  // Validação de email
  const isValidEmail = (email: string): boolean => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  };

  // Limpar mensagens ao trocar de modo
  useEffect(() => {
    setError(null);
    setSuccess(null);
  }, [authMode]);

  // ==========================================
  // HANDLERS DE LOGIN
  // ==========================================

  const handleLogin = async (event: React.FormEvent) => {
    event.preventDefault();
    setError(null);
    setIsLoading(true);

    try {
      const response = await api.post('/login', {
        username: email.trim(),
        password: password.trim(),
      });

      if (response.data.access_token) {
        await login(response.data.access_token);

        const userResponse = await api.get('/users/me');
        const user = userResponse.data;

        if (user.role === 'admin') {
          navigate('/admin');
        } else {
          navigate('/painel');
        }
      }
    } catch (error: any) {
      setError(error.response?.data?.detail || 'Falha ao fazer login. Verifique suas credenciais.');
    } finally {
      setIsLoading(false);
    }
  };

  // ==========================================
  // HANDLERS DE RECUPERAÇÃO
  // ==========================================

  const handleSendToken = async () => {
    setError(null);
    setSuccess(null);

    // Validar formato de email
    if (!isValidEmail(recoveryEmail.trim())) {
      setError('Por favor, digite um e-mail válido.');
      return;
    }

    setIsLoading(true);

    try {
      const response = await api.post('/forgot-password', {
        email: recoveryEmail.trim()
      });

      setSuccess(response.data.message || 'Token enviado! Verifique seu email.');
      setAuthMode('forgot-token');
    } catch (error: any) {
      if (error.response?.status === 404) {
        setError('E-mail não cadastrado.');
      } else {
        setError(error.response?.data?.detail || 'Erro ao enviar token. Tente novamente.');
      }
    } finally {
      setIsLoading(false);
    }
  };

  const handleTokenInput = (index: number, value: string) => {
    // Aceitar apenas números
    if (value && !/^\d$/.test(value)) return;

    const newDigits = [...tokenDigits];
    newDigits[index] = value;
    setTokenDigits(newDigits);

    // Auto-focus próximo campo
    if (value && index < 5) {
      tokenInputRefs.current[index + 1]?.focus();
    }
  };

  const handleTokenPaste = (e: React.ClipboardEvent) => {
    e.preventDefault();
    const pastedData = e.clipboardData.getData('text').replace(/\D/g, '').slice(0, 6);

    if (pastedData.length > 0) {
      const newDigits = [...tokenDigits];
      for (let i = 0; i < pastedData.length && i < 6; i++) {
        newDigits[i] = pastedData[i];
      }
      setTokenDigits(newDigits);

      // Focus no último campo preenchido ou no próximo vazio
      const focusIndex = Math.min(pastedData.length, 5);
      tokenInputRefs.current[focusIndex]?.focus();
    }
  };

  const handleTokenKeyDown = (index: number, e: React.KeyboardEvent) => {
    // Backspace - voltar para campo anterior
    if (e.key === 'Backspace' && !tokenDigits[index] && index > 0) {
      tokenInputRefs.current[index - 1]?.focus();
    }

    // Enter - validar token
    if (e.key === 'Enter') {
      handleVerifyToken();
    }
  };

  const handleVerifyToken = async () => {
    const token = tokenDigits.join('');

    if (token.length !== 6) {
      setError('Digite o código completo de 6 dígitos.');
      return;
    }

    setError(null);
    setIsLoading(true);

    try {
      await api.post('/verify-reset-token', { token });
      setSuccess('Token válido! Agora defina sua nova senha.');
      setAuthMode('new-password');
    } catch (error: any) {
      setError(error.response?.data?.detail || 'Token inválido ou expirado.');
      setTokenDigits(['', '', '', '', '', '']);
      tokenInputRefs.current[0]?.focus();
    } finally {
      setIsLoading(false);
    }
  };

  const handleResetPassword = async () => {
    setError(null);

    if (newPassword.length < 6) {
      setError('A senha deve ter no mínimo 6 caracteres.');
      return;
    }

    if (newPassword !== confirmPassword) {
      setError('As senhas não coincidem.');
      return;
    }

    setIsLoading(true);
    const token = tokenDigits.join('');

    try {
      await api.post('/reset-password', {
        token,
        new_password: newPassword
      });

      setSuccess('Senha redefinida com sucesso!');
      setTimeout(() => {
        setAuthMode('login');
        setRecoveryEmail('');
        setTokenDigits(['', '', '', '', '', '']);
        setNewPassword('');
        setConfirmPassword('');
      }, 2000);
    } catch (error: any) {
      setError(error.response?.data?.detail || 'Erro ao redefinir senha.');
    } finally {
      setIsLoading(false);
    }
  };

  // ==========================================
  // RENDER
  // ==========================================

  return (
    <div className="min-h-screen bg-[#0B1121] flex flex-col">
      <Header />

      {/* MAIN CONTENT */}
      <div className="flex-1 flex items-center justify-center px-6 py-12">
        <div className="max-w-6xl relative flex flex-col lg:flex-row items-center justify-center gap-0">

          {/* LEFT: FORM */}
          <div className="order-2 lg:order-1 relative z-10 w-full lg:w-auto">
            <div className="mb-8 text-center">
              <p className="text-[#94A3B8] text-sm mb-2 uppercase tracking-wider font-semibold">Bem-vindo de volta</p>
              <h1 className="text-4xl font-bold text-white mb-2">Entrar</h1>
              <p className="text-[#94A3B8]">Acesse sua conta para continuar praticando suas redações.</p>
            </div>

            <div className="w-full max-w-md lg:w-160 lg:max-w-3xl bg-[#1E293B] border border-[#334155] rounded-2xl px-6 py-6 lg:px-12 mx-auto">
              {/* Título interno */}

              {/* ============================================ */}
              {/* MODO: LOGIN */}
              {/* ============================================ */}
              {authMode === 'login' && (
                <form onSubmit={handleLogin} className="space-y-4">
                  <div>
                    <label htmlFor="email" className="block text-white font-semibold mb-1">E-mail</label>
                    <input
                      type="email"
                      id="email"
                      placeholder="seu@email.com"
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      required
                      className="w-full px-4 py-2 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                    />
                  </div>

                  <PasswordInput
                    id="password"
                    label="Senha"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                  />

                  <div className="flex items-center justify-between">
                    <button
                      type="button"
                      onClick={() => setAuthMode('forgot-email')}
                      className="text-[#3B82F6] text-sm font-semibold hover:underline"
                    >
                      Esqueci minha senha
                    </button>
                  </div>

                  {error && (
                    <div className="bg-red-500/10 border border-red-500/50 text-red-400 px-4 py-3 rounded-lg text-sm">
                      {error}
                    </div>
                  )}

                  <button
                    type="submit"
                    disabled={isLoading}
                    className="w-full bg-[#3B82F6] hover:bg-[#2563EB] text-white px-6 py-2.5 rounded-lg font-bold transition-all shadow-lg hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {isLoading ? 'Entrando...' : 'Entrar'}
                  </button>

                  <div className="text-center text-[#94A3B8] text-sm">
                    Ainda não tem conta?{' '}
                    <button
                      type="button"
                      onClick={() => navigate('/cadastro')}
                      className="text-[#3B82F6] font-semibold hover:underline bg-transparent border-none cursor-pointer"
                    >
                      Criar conta
                    </button>
                  </div>
                </form>
              )}

              {/* ============================================ */}
              {/* MODO: PEDIR EMAIL PARA RECUPERAÇÃO */}
              {/* ============================================ */}
              {authMode === 'forgot-email' && (
                <div className="space-y-4">
                  <div className="bg-[#0F172A] border border-[#334155] rounded-lg p-7">
                    <p className="text-[#94A3B8] text-sm py-2">
                      Informe o e-mail da sua conta para enviarmos um código de recuperação de senha. O código tem validade de 1 hora.
                    </p>
                    <div>
                      <label htmlFor="recovery-email" className="block text-white font-semibold mb-4">
                        E-mail para recuperação
                      </label>
                      <input
                        type="email"
                        id="recovery-email"
                        placeholder="seu@email.com"
                        value={recoveryEmail}
                        onChange={(e) => setRecoveryEmail(e.target.value)}
                        className="w-full px-4 py-2 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                      />
                    </div>
                  </div>
                  {error && (
                    <div className="bg-red-500/10 border border-red-500/50 text-red-400 px-4 py-3 rounded-lg text-sm">
                      {error}
                    </div>
                  )}

                  {success && (
                    <div className="bg-green-500/10 border border-green-500/50 text-green-400 px-4 py-3 rounded-lg text-sm">
                      {success}
                    </div>
                  )}

                  <button
                    onClick={handleSendToken}
                    disabled={isLoading || !recoveryEmail.trim() || !isValidEmail(recoveryEmail.trim())}
                    className="w-full bg-[#3B82F6] hover:bg-[#2563EB] text-white px-6 py-2.5 rounded-lg font-bold transition-all shadow-lg disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {isLoading ? 'Enviando...' : 'Enviar token de recuperação'}
                  </button>

                  <button
                    onClick={() => setAuthMode('login')}
                    className="w-full text-[#94A3B8] hover:text-white text-sm font-semibold transition-colors"
                  >
                    ← Voltar para login
                  </button>
                </div>
              )}

              {/* ============================================ */}
              {/* MODO: INSERIR TOKEN DE 6 DÍGITOS */}
              {/* ============================================ */}
              {authMode === 'forgot-token' && (
                <div className="space-y-6">
                  <div className="bg-[#0F172A] border border-[#334155] rounded-lg p-4">
                    <p className="text-[#94A3B8] text-sm mb-4">
                      Token de recuperação enviado com sucesso. Verifique sua caixa de entrada e spam.
                      <span className="text-[#3B82F6] font-semibold"> O token expira em 1 hora.</span>
                    </p>
                    <p className="text-[#94A3B8] text-xs">
                      Enviamos de <strong className="text-white">contato@corrigeai.online</strong>
                    </p>
                  </div>

                  <div>
                    <label className="block text-white font-semibold mb-3">Token de 6 dígitos</label>
                    <div className="flex gap-2 justify-center">
                      {[0, 1, 2, 3, 4, 5].map((index) => (
                        <input
                          key={index}
                          ref={(el) => { tokenInputRefs.current[index] = el; }}
                          type="text"
                          maxLength={1}
                          value={tokenDigits[index]}
                          onChange={(e) => handleTokenInput(index, e.target.value)}
                          onKeyDown={(e) => handleTokenKeyDown(index, e)}
                          onPaste={handleTokenPaste}
                          className="w-12 h-14 text-center text-2xl font-bold bg-[#0B1121] border-2 border-[#334155] rounded-lg text-white focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                        />
                      ))}
                    </div>
                    <p className="text-[#64748B] text-xs mt-2 text-center">
                      Digite o código numérico enviado ao seu e-mail.
                    </p>
                  </div>

                  {error && (
                    <div className="bg-red-500/10 border border-red-500/50 text-red-400 px-4 py-3 rounded-lg text-sm">
                      {error}
                    </div>
                  )}

                  <button
                    onClick={handleVerifyToken}
                    disabled={isLoading || tokenDigits.join('').length !== 6}
                    className="w-full bg-[#3B82F6] hover:bg-[#2563EB] text-white px-6 py-3.5 rounded-lg font-bold transition-all shadow-lg disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {isLoading ? 'Validando...' : 'Validar token'}
                  </button>

                  <button
                    onClick={() => setAuthMode('forgot-email')}
                    className="w-full text-[#94A3B8] hover:text-white text-sm font-semibold transition-colors"
                  >
                    ← Voltar
                  </button>
                </div>
              )}

              {/* ============================================ */}
              {/* MODO: DEFINIR NOVA SENHA */}
              {/* ============================================ */}
              {authMode === 'new-password' && (
                <div className="space-y-6">
                  <div>
                    <label htmlFor="new-password" className="block text-white font-semibold mb-2">Nova senha</label>
                    <div className="relative">
                      <input
                        type={showNewPassword ? "text" : "password"}
                        id="new-password"
                        placeholder="Mínimo 6 caracteres"
                        value={newPassword}
                        onChange={(e) => setNewPassword(e.target.value)}
                        className="w-full px-4 py-3 pr-12 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                      />
                      <button
                        type="button"
                        onClick={() => setShowNewPassword(!showNewPassword)}
                        className="absolute right-3 top-1/2 -translate-y-1/2 text-[#64748B] hover:text-white transition-colors z-10 cursor-pointer p-1"
                      >
                        {showNewPassword ? (
                          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-5 h-5">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88" />
                          </svg>
                        ) : (
                          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-5 h-5">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z" />
                            <path strokeLinecap="round" strokeLinejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                          </svg>
                        )}
                      </button>
                    </div>
                  </div>

                  <div>
                    <label htmlFor="confirm-password" className="block text-white font-semibold mb-2">Confirmar nova senha</label>
                    <div className="relative">
                      <input
                        type={showConfirmPassword ? "text" : "password"}
                        id="confirm-password"
                        placeholder="Digite a senha novamente"
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        className="w-full px-4 py-3 pr-12 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                      />
                      <button
                        type="button"
                        onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                        className="absolute right-3 top-1/2 -translate-y-1/2 text-[#64748B] hover:text-white transition-colors z-10 cursor-pointer p-1"
                      >
                        {showConfirmPassword ? (
                          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-5 h-5">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65m0 0a3 3 0 10-4.243-4.243m4.242 4.242L9.88 9.88" />
                          </svg>
                        ) : (
                          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={1.5} stroke="currentColor" className="w-5 h-5">
                            <path strokeLinecap="round" strokeLinejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z" />
                            <path strokeLinecap="round" strokeLinejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                          </svg>
                        )}
                      </button>
                    </div>
                  </div>

                  {error && (
                    <div className="bg-red-500/10 border border-red-500/50 text-red-400 px-4 py-3 rounded-lg text-sm">
                      {error}
                    </div>
                  )}

                  {success && (
                    <div className="bg-green-500/10 border border-green-500/50 text-green-400 px-4 py-3 rounded-lg text-sm">
                      {success}
                    </div>
                  )}

                  <button
                    onClick={handleResetPassword}
                    disabled={isLoading || !newPassword || !confirmPassword}
                    className="w-full bg-[#3B82F6] hover:bg-[#2563EB] text-white px-6 py-3.5 rounded-lg font-bold transition-all shadow-lg disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {isLoading ? 'Redefinindo...' : 'Redefinir senha'}
                  </button>
                </div>
              )}

            </div>
          </div>

          {/* RIGHT: CHARACTER - Desktop Only */}
          <div className="hidden lg:flex order-1 lg:order-2 justify-start lg:justify-start relative z-20 lg:ml-[-55px]">
            <div className="relative">
              <img
                src="/owl-thumbs-up.png"
                alt="CorrigeAI Mascot"
                className="w-[250px] lg:w-[400px] drop-shadow-2xl"
                style={{ animation: 'pulse 10s ease-in-out infinite' }}
              />
            </div>
          </div>
        </div>
      </div>

      {/* FOOTER */}
      <footer className="py-6 px-6 border-t border-[#334155] text-center">
        <p className="text-[#64748B] text-sm">
          © 2025 CorrigeAI. Todos os direitos reservados.{' '}
          <a href="#" className="hover:text-white transition-colors">Privacidade</a> ·{' '}
          <a href="#" className="hover:text-white transition-colors">Termos</a>
        </p>
      </footer>

      <style>{`
        @keyframes pulse {
          0%, 100% { transform: scale(1); }
          50% { transform: scale(1.05); }
        }
      `}</style>
    </div>
  );
};

export default Login;
