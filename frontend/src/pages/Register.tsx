import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import PasswordStrengthIndicator from '../components/PasswordStrengthIndicator';

const Register: React.FC = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    setError(null);

    if (password !== confirmPassword) {
      setError('As senhas não conferem.');
      return;
    }

    setIsLoading(true);
    try {
      // Simular delay de rede para feedback visual
      await new Promise(resolve => setTimeout(resolve, 500));

      // Registro real no backend
      await api.post('/users/', {
        email: email.trim(),
        password: password.trim(),
        full_name: `${firstName} ${lastName}`.trim(),
      });

      // Redirecionar para login após sucesso
      navigate('/login');

    } catch (err: any) {
      console.error('Erro no registro:', err);
      if (err.response && err.response.data && err.response.data.detail) {
        setError(err.response.data.detail);
      } else {
        setError('Erro ao criar conta. Tente novamente.');
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
            onClick={() => navigate('/login')}
            className="bg-[#3B82F6] hover:bg-[#2563EB] text-white px-6 py-2 rounded-lg font-bold transition-all shadow-lg"
          >
            Entrar
          </button>
        </nav>
      </header>

      {/* MAIN CONTENT */}
      <div className="flex-1 flex items-center justify-center px-6 py-12">
        <div className="w-full max-w-6xl relative flex flex-col lg:flex-row items-center justify-center gap-0">

          {/* LEFT: FORM */}
          <div className="order-2 lg:order-1 relative z-10 w-full lg:w-auto">
            <div className="mb-8">
              <p className="text-[#94A3B8] text-sm mb-2 uppercase tracking-wider font-semibold">Comece agora</p>
              <h1 className="text-4xl font-bold text-white mb-2">Criar conta</h1>
              <p className="text-[#94A3B8]">Cadastre-se para treinar redações com feedback imediato.</p>
            </div>

            <div className="bg-[#1E293B] border border-[#334155] rounded-2xl p-8">
              <form onSubmit={handleSubmit} className="space-y-5">
                {/* Nome e Sobrenome */}
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label htmlFor="firstName" className="block text-white font-semibold mb-2">Nome</label>
                    <input
                      type="text"
                      id="firstName"
                      placeholder="Seu nome"
                      value={firstName}
                      onChange={(e) => setFirstName(e.target.value)}
                      required
                      className="w-full px-4 py-3 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                    />
                  </div>
                  <div>
                    <label htmlFor="lastName" className="block text-white font-semibold mb-2">Sobrenome</label>
                    <input
                      type="text"
                      id="lastName"
                      placeholder="Seu sobrenome"
                      value={lastName}
                      onChange={(e) => setLastName(e.target.value)}
                      required
                      className="w-full px-4 py-3 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                    />
                  </div>
                </div>

                {/* E-mail */}
                <div>
                  <label htmlFor="email" className="block text-white font-semibold mb-2">E-mail</label>
                  <input
                    type="email"
                    placeholder="••••••••"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    className="w-full px-4 py-3 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                  />
                  <PasswordStrengthIndicator password={password} />
                </div>
                <div>
                  <label htmlFor="confirmPassword" className="block text-white font-semibold mb-2">Confirmar</label>
                  <input
                    type="password"
                    id="confirmPassword"
                    placeholder="••••••••"
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    required
                    className="w-full px-4 py-3 bg-[#0B1121] border border-[#334155] rounded-lg text-white placeholder-[#64748B] focus:outline-none focus:border-[#3B82F6] focus:ring-2 focus:ring-[#3B82F6]/20 transition-all"
                  />
                </div>
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
                  Criando conta...
                </span>
              ) : (
                'Criar conta'
              )}
            </button>

            <div className="text-center text-[#94A3B8] text-sm">
              Já tem conta?{' '}
              <a href="/login" className="text-[#3B82F6] font-semibold hover:underline">
                Entrar
              </a>
            </div>
          </form>
        </div>
      </div>

      {/* RIGHT: CHARACTER - in front of form with higher z-index */}
      <div className="order-1 lg:order-2 flex justify-start lg:justify-start relative z-20 lg:ml-[-70px]">
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
      </div >

  {/* FOOTER */ }
  < footer className = "py-6 px-6 border-t border-[#334155] text-center" >
    <p className="text-[#64748B] text-sm">
      © 2025 CorrigeAI. Todos os direitos reservados.{' '}
      <a href="#" className="hover:text-white transition-colors">Privacidade</a> ·{' '}
      <a href="#" className="hover:text-white transition-colors">Termos</a>
    </p>
      </footer >

  <style>{`
        @keyframes pulse {
          0%, 100% { transform: scale(1); }
          50% { transform: scale(1.05); }
        }
      `}</style>
    </div >
  );
};

export default Register;