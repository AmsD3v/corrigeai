import axios from 'axios';

const api = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000/api',
});

api.interceptors.request.use((config) => {
  // Public routes that don't need authentication
  const publicRoutes = ['/users/', '/login', '/register'];
  const isPublicRoute = publicRoutes.some(route => config.url?.includes(route));

  // Only add token if it's not a public route
  if (!isPublicRoute) {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
  }

  return config;
});

export default api;