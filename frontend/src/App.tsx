import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import { lazy, Suspense } from 'react';
import { useAuth } from './contexts/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import './App.css';
import './responsive.css';

// Critical pages - loaded immediately
import LandingPage from './pages/LandingPage';
import Login from './pages/Login';
import Register from './pages/Register';

// Loading fallback component
const PageLoader = () => (
  <div style={{
    minHeight: '100vh',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    background: 'linear-gradient(180deg, #0f1419 0%, #1a1f2e 100%)',
    color: '#fff',
    fontSize: '18px'
  }}>
    <div style={{ textAlign: 'center' }}>
      <div style={{
        width: '40px',
        height: '40px',
        border: '3px solid #334155',
        borderTopColor: '#4F46E5',
        borderRadius: '50%',
        animation: 'spin 1s linear infinite',
        margin: '0 auto 16px'
      }} />
      Carregando...
    </div>
    <style>{`
      @keyframes spin {
        to { transform: rotate(360deg); }
      }
    `}</style>
  </div>
);

// =====================================
// LAZY LOADED PAGES (Code Splitting)
// =====================================

// Auth pages
const ForgotPassword = lazy(() => import('./pages/ForgotPassword'));
const ResetPassword = lazy(() => import('./pages/ResetPassword'));

// Public pages
const Blog = lazy(() => import('./pages/Blog'));
const BlogPostPage = lazy(() => import('./pages/BlogPost'));
const Sobre = lazy(() => import('./pages/Sobre'));
const Demonstracao = lazy(() => import('./pages/Demonstracao'));
const Repertorios = lazy(() => import('./pages/Repertorios'));

// Ferramentas públicas (SEO)
const Ferramentas = lazy(() => import('./pages/Ferramentas'));
const ContadorPalavras = lazy(() => import('./pages/Ferramentas/ContadorPalavras'));
const GeradorTemasPublico = lazy(() => import('./pages/Ferramentas/GeradorTemasPublico'));

// Panel pages (user dashboard)
const Painel = lazy(() => import('./pages/Painel'));
const RedigirRedacao = lazy(() => import('./pages/Painel/RedigirRedacao'));
const MinhasRedacoes = lazy(() => import('./pages/Painel/MinhasRedacoes'));
const MeuDesenvolvimento = lazy(() => import('./pages/Painel/MeuDesenvolvimento'));
const ComprarCreditos = lazy(() => import('./pages/Painel/ComprarCreditos'));
const MinhasCompras = lazy(() => import('./pages/Painel/MinhasCompras'));
const Configuracoes = lazy(() => import('./pages/Painel/Configuracoes'));
const Feedback = lazy(() => import('./pages/Painel/Feedback'));
const RedacaoDetalhes = lazy(() => import('./pages/Painel/RedacaoDetalhes'));
const CorrigindoRedacao = lazy(() => import('./pages/Painel/CorrigindoRedacao'));
const ResultadoCorrecao = lazy(() => import('./pages/Painel/ResultadoCorrecao'));
const MinhaJornada = lazy(() => import('./pages/Painel/MinhaJornada'));
const PagamentoSucesso = lazy(() => import('./pages/Painel/PagamentoSucesso'));
const PagamentoFalha = lazy(() => import('./pages/Painel/PagamentoFalha'));
const PagamentoPendente = lazy(() => import('./pages/Painel/PagamentoPendente'));

// Admin pages
const AdminDashboard = lazy(() => import('./pages/Admin'));
const Usuarios = lazy(() => import('./pages/Admin/Usuarios'));
const RedacoesAdmin = lazy(() => import('./pages/Admin/RedacoesAdmin'));
const Transacoes = lazy(() => import('./pages/Admin/Transacoes'));
const ConfiguracoesAdmin = lazy(() => import('./pages/Admin/Configuracoes'));
const Analytics = lazy(() => import('./pages/Admin/Analytics'));
const DropdownOptions = lazy(() => import('./pages/Admin/DropdownOptions'));
const FeedbackStats = lazy(() => import('./pages/Admin/FeedbackStats'));
const BlogAdmin = lazy(() => import('./pages/Admin/BlogAdmin'));
const BlogEditor = lazy(() => import('./pages/Admin/BlogEditor'));


function App() {
  const { token } = useAuth();

  return (
    <Router>
      <Suspense fallback={<PageLoader />}>
        <Routes>
          <Route path="/" element={token ? <Navigate to="/painel" /> : <LandingPage />} />
          <Route path="/login" element={<Login />} />
          <Route path="/cadastro" element={<Register />} />
          <Route path="/forgot-password" element={<ForgotPassword />} />
          <Route path="/reset-password/:token" element={<ResetPassword />} />

          {/* Blog Público */}
          <Route path="/blog" element={<Blog />} />
          <Route path="/blog/:slug" element={<BlogPostPage />} />

          {/* Páginas Institucionais e SEO */}
          <Route path="/sobre" element={<Sobre />} />
          <Route path="/demonstracao" element={<Demonstracao />} />
          <Route path="/repertorios" element={<Repertorios />} />

          {/* Ferramentas Públicas (SEO) */}
          <Route path="/ferramentas" element={<Ferramentas />} />
          <Route path="/ferramentas/contador-palavras" element={<ContadorPalavras />} />
          <Route path="/ferramentas/gerador-temas" element={<GeradorTemasPublico />} />
          <Route path="/recuperar-senha" element={<ForgotPassword />} />

          {/* Rotas Protegidas */}
          <Route element={<ProtectedRoute />}>
            <Route path="/painel" element={<Painel />} />
            <Route path="/painel/redigir-redacao" element={<RedigirRedacao />} />
            <Route path="/painel/minhas-redacoes" element={<MinhasRedacoes />} />
            <Route path="/painel/desenvolvimento" element={<MeuDesenvolvimento />} />
            <Route path="/painel/comprar-creditos" element={<ComprarCreditos />} />
            <Route path="/painel/transacoes" element={<MinhasCompras />} />
            <Route path="/painel/configuracoes" element={<Configuracoes />} />
            <Route path="/painel/feedback" element={<Feedback />} />
            <Route path="/painel/redacao/:id" element={<RedacaoDetalhes />} />
            <Route path="/painel/redacao/:id/corrigindo" element={<CorrigindoRedacao />} />
            <Route path="/painel/redacao/:id/resultado" element={<ResultadoCorrecao />} />
            <Route path="/painel/pagamento/sucesso" element={<PagamentoSucesso />} />
            <Route path="/painel/pagamento/falha" element={<PagamentoFalha />} />
            <Route path="/painel/pagamento/pendente" element={<PagamentoPendente />} />
            <Route path="/painel/minha-jornada" element={<MinhaJornada />} />
          </Route>

          {/* Admin Routes */}
          <Route element={<ProtectedRoute role="admin" />}>
            <Route path="/admin" element={<AdminDashboard />} />
            <Route path="/admin/usuarios" element={<Usuarios />} />
            <Route path="/admin/redacoes" element={<RedacoesAdmin />} />
            <Route path="/admin/transacoes" element={<Transacoes />} />
            <Route path="/admin/configuracoes" element={<ConfiguracoesAdmin />} />
            <Route path="/admin/analytics" element={<Analytics />} />
            <Route path="/admin/dropdown-options" element={<DropdownOptions />} />
            <Route path="/admin/feedback-stats" element={<FeedbackStats />} />
            <Route path="/admin/blog" element={<BlogAdmin />} />
            <Route path="/admin/blog/novo" element={<BlogEditor />} />
            <Route path="/admin/blog/editar/:id" element={<BlogEditor />} />
          </Route>

        </Routes>
      </Suspense>
    </Router>
  );
}

export default App;
