import React from 'react';
import { Navigate, Outlet } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';

interface ProtectedRouteProps {
  role?: 'admin' | 'aluno';
}

const ProtectedRoute: React.FC<ProtectedRouteProps> = ({ role }) => {
  const { token, user, isLoading } = useAuth();

  if (isLoading) {
    return <div className="min-h-screen flex items-center justify-center bg-[#0f1419] text-white">Carregando...</div>;
  }

  if (!token) {
    // Se não houver token, redireciona para a página de login
    return <Navigate to="/login" />;
  }

  if (role && user && user.role !== role) {
    // Se o usuário não tiver o papel necessário
    if (role === 'admin') {
      return <Navigate to="/painel" />;
    } else {
      return <Navigate to="/admin" />;
    }
  }

  // Se houver token e papel correto (ou sem restrição de papel), renderiza o conteúdo
  return <Outlet />;
};

export default ProtectedRoute;