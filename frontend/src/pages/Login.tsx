import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../services/api';
import { useAuth } from '../contexts/AuthContext';

const Login: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    setError(null);
    setIsLoading(true);

    try {
      // Simular delay de rede
      await new Promise(resolve => setTimeout(resolve, 500));

      // Login com backend real
      const response = await api.post('/login', {
        username: email.trim(),
        password: password.trim(),
      });

      if (response.data.access_token) {
        await login(response.data.access_token);

        // Fetch user profile to check role
        try {
          const userResponse = await api.get('/users/me');
          const user = userResponse.data;

          if (user.role === 'admin') {
            navigate('/admin');
          } else {
            navigate('/painel');
          }
        } catch (e) {
          // Fallback if user fetch fails
          navigate('/painel');
        }
      } else {
        setError('Credenciais inválidas.');
      }
    } catch (error: any) {
      console.error('Login error details:', error);
      if (error.response) {
        console.error('Response data:', error.response.data);
        console.error('Response status:', error.response.status);
        setError(error.response.data.detail || 'Falha ao fazer login. Verifique suas credenciais.');
      } else if (error.request) {
        console.error('No response received:', error.request);
        setError('Erro de conexão com o servidor. Verifique se o backend está rodando.');
      } else {
        console.error('Error message:', error.message);
        setError('Ocorreu um erro inesperado. Tente novamente.');
      }
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-[#0B1121] flex flex-col">
      {/* HEADER */}
      <header className="h-20 px-6 lg:px-12 flex items-center justify-between border-b border-[#334155]">
        <div className="flex items-center gap-2 font-extrabold text-xl cursor-pointer" onClick={() => navigate('/')}>
          <div className="w-10 h-10 bg-gradient-to-br from-[#3B82F6] to-[#2563EB] rounded-xl flex items-center justify-center text-white shadow-lg">
            <span className="text-2xl">🦉</span>
          </div>
          <span className="text-white tracking-tight text-lg">Corrige<span className="text-[#3B82F6]">AI</span></span>
        </div>

        <nav className="flex items-center gap-6 text-sm font-semibold">
          <a href="/" className="text-[#94A3B8] hover:text-[#3B82F6] transition-colors hidden sm:block">Início</a>
          <a href="/#como-funciona" className="text-[#94A3B8] hover:text-[#3B82F6] transition-colors hidden sm:block">Como funciona</a>
          <a href="/#precos" className="text-[#94A3B8] hover:text-[#3B82F6] transition-colors hidden sm:block">Preços</a>
          <button
            onClick={() => navigate('/register')}
            className="bg-[#3B82F6] hover:bg-[#2563EB] text-white px-6 py-2 rounded-lg font-bold transition-all shadow-lg"
          >
            Começar correção grátis
          </button>
        </nav>
      </header>

      {/* MAIN CONTENT */}
      <div className="flex-1 flex items-center justify-center px-6 py-12">
        <div className="w-full max-w-6xl relative flex flex-col lg:flex-row items-center justify-center gap-0">

          {/* LEFT: FORM */}
          <div className="order-2 lg:order-1 relative z-10 w-full lg:w-auto">
            <div className="mb-8">
              <p className="text-[#94A3B8] text-sm mb-2 uppercase tracking-wider font-semibold">Bem-vindo de volta</p>
              <h1 className="text-4xl font-bold text-white mb-2">Entrar</h1>
              <p className="text-[#94A3B8]">Acesse sua conta para continuar praticando suas redações.</p>
            </div>

            <div className="bg-[#1E293B] border border-[#334155] rounded-2xl p-8">
              <form onSubmit={handleSubmit} className="space-y-6">
                <div>
                  <label htmlFor="email" className="block text-white font-semibold mb-2">E-mail</label>
                  <input
                    type="email"
                    id="email"
                    placeholder="seu@email.com"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    className="w-full px-4 py-3 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                  />
                </div>

                <div>
                  <label htmlFor="password" className="block text-white font-semibold mb-2">Senha</label>
                  <input
                    type="password"
                    id="password"
                    placeholder="••••••••"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    className="w-full px-4 py-3 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                  />
                </div>

                <div className="flex items-center justify-between">
                  <a href="#" className="text-[#3B82F6] text-sm font-semibold hover:underline">Esqueci minha senha</a>
                </div>

                {error && (
                  <div className="bg-red-500/10 border border-red-500/50 text-red-400 px-4 py-3 rounded-lg text-sm">
                    {error}
                  </div>
                )}

                <button
                  type="submit"
                  disabled={isLoading}
                  className="w-full bg-[#3B82F6] hover:bg-[#2563EB] text-white px-6 py-3.5 rounded-lg font-bold transition-all shadow-lg hover:shadow-xl disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {isLoading ? (
                    <span className="flex items-center justify-center gap-2">
                      <svg className="animate-spin h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                        <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                        <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                      </svg>
                      Entrando...
                    </span>
                  ) : (
                    'Entrar'
                  )}
                </button>

                <div className="text-center text-[#94A3B8] text-sm">
                  Ainda não tem conta?{' '}
                  <a href="/register" className="text-[#3B82F6] font-semibold hover:underline">
                    Criar conta
                  </a>
                </div>
              </form>
            </div>
          </div>

          {/* RIGHT: CHARACTER - in front of form with higher z-index */}
          <div className="order-1 lg:order-2 flex justify-start lg:justify-start relative z-20 lg:ml-[-80px]">
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