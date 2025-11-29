import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import Register from './pages/Register';
import ForgotPassword from './pages/ForgotPassword';
import ResetPassword from './pages/ResetPassword';
import Painel from './pages/Painel';
import RedigirRedacao from './pages/Painel/RedigirRedacao';
import MinhasRedacoes from './pages/Painel/MinhasRedacoes';
import MeuDesenvolvimento from './pages/Painel/MeuDesenvolvimento';
import ComprarCreditos from './pages/Painel/ComprarCreditos';
import MinhasCompras from './pages/Painel/MinhasCompras';
import Configuracoes from './pages/Painel/Configuracoes';
import Feedback from './pages/Painel/Feedback';
import RedacaoDetalhes from './pages/Painel/RedacaoDetalhes';
import CorrigindoRedacao from './pages/Painel/CorrigindoRedacao';
import ResultadoCorrecao from './pages/Painel/ResultadoCorrecao';
import ProtectedRoute from './components/ProtectedRoute';
import { useAuth } from './contexts/AuthContext';
import './App.css';
import './responsive.css';
import LandingPage from './pages/LandingPage';
import AdminDashboard from './pages/Admin';
import Usuarios from './pages/Admin/Usuarios';
import RedacoesAdmin from './pages/Admin/RedacoesAdmin';
import Transacoes from './pages/Admin/Transacoes';
import ConfiguracoesAdmin from './pages/Admin/Configuracoes';
import Analytics from './pages/Admin/Analytics';
import PagamentoSucesso from './pages/Painel/PagamentoSucesso';
import PagamentoFalha from './pages/Painel/PagamentoFalha';
import PagamentoPendente from './pages/Painel/PagamentoPendente';



function App() {
  const { token } = useAuth();

  // DEBUG: Print the environment variable to the console
  console.log('VITE_API_BASE_URL:', import.meta.env.VITE_API_BASE_URL);

  return (
    <Router>
      <Routes>
        <Route path="/" element={token ? <Navigate to="/painel" /> : <LandingPage />} />
        <Route path="/login" element={<Login />} />
        <Route path="/register" element={<Register />} />
        <Route path="/forgot-password" element={<ForgotPassword />} />
        <Route path="/reset-password/:token" element={<ResetPassword />} />

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
        </Route>

        {/* Admin Routes */}
        <Route element={<ProtectedRoute role="admin" />}>
          <Route path="/admin" element={<AdminDashboard />} />
          <Route path="/admin/usuarios" element={<Usuarios />} />
          <Route path="/admin/redacoes" element={<RedacoesAdmin />} />
          <Route path="/admin/transacoes" element={<Transacoes />} />
          <Route path="/admin/configuracoes" element={<ConfiguracoesAdmin />} />
          <Route path="/admin/analytics" element={<Analytics />} />
        </Route>

      </Routes>
    </Router>
  );
}

export default App;
