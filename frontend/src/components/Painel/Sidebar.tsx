import { Button } from "@/components/ui/button"
import { Home, FileText, Settings } from 'lucide-react';

const Sidebar: React.FC = () => {
  return (
    <aside className="w-64 bg-gray-950 p-6 flex flex-col">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-white">CorrigE Aí</h1>
      </div>
      <nav className="flex flex-col space-y-2">
        <Button variant="ghost" className="justify-start text-white hover:bg-gray-800 hover:text-white">
          <a href="/painel" className="flex items-center">
            <Home className="w-5 h-5 mr-3" />
            Início
          </a>
        </Button>
        <Button variant="ghost" className="justify-start text-white hover:bg-gray-800 hover:text-white">
          <a href="/painel/corrigir-redacao" className="flex items-center">
            <FileText className="w-5 h-5 mr-3" />
            Corrigir Redação
          </a>
        </Button>
        <Button variant="ghost" className="justify-start text-white hover:bg-gray-800 hover:text-white">
          <a href="/painel/configuracoes" className="flex items-center">
            <Settings className="w-5 h-5 mr-3" />
            Configurações
          </a>
        </Button>
      </nav>
    </aside>
  );
};

export default Sidebar;
