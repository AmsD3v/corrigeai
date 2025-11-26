"""
Script de Restauração do Fluxo de Correção
===========================================

PROPÓSITO:
- Salva versões funcionais dos arquivos do fluxo de correção
- Permite restaurar rapidamente para uma versão que funciona
- Evita debugging repetitivo

USO:
    python restore_correction_flow.py --save     # Salva estado atual como "bom"
    python restore_correction_flow.py --restore  # Restaura última versão salva
    python restore_correction_flow.py --status   # Mostra status dos backups
"""

import os
import shutil
import argparse
from datetime import datetime
import json

# Diretórios
BACKUP_DIR = "flow_backups"
SRC_DIR = "src"

# Arquivos críticos do fluxo de correção
CRITICAL_FILES = [
    "src/ai_service.py",
    "src/correction_service.py",
    "src/main.py",
    "src/models.py",
    ".env"
]

def ensure_backup_dir():
    """Cria diretório de backup se não existir"""
    if not os.path.exists(BACKUP_DIR):
        os.makedirs(BACKUP_DIR)
        print(f"✅ Diretório de backup criado: {BACKUP_DIR}")

def save_current_state():
    """Salva estado atual dos arquivos como backup"""
    ensure_backup_dir()
    
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_subdir = os.path.join(BACKUP_DIR, f"backup_{timestamp}")
    os.makedirs(backup_subdir)
    
    print(f"\n{'='*60}")
    print(f"💾 SALVANDO ESTADO ATUAL")
    print(f"{'='*60}")
    
    saved_files = []
    for file_path in CRITICAL_FILES:
        if os.path.exists(file_path):
            # Criar subdiretórios necessários
            backup_file_path = os.path.join(backup_subdir, file_path)
            os.makedirs(os.path.dirname(backup_file_path), exist_ok=True)
            
            # Copiar arquivo
            shutil.copy2(file_path, backup_file_path)
            print(f"✅ {file_path}")
            saved_files.append(file_path)
        else:
            print(f"⚠️  {file_path} (não encontrado)")
    
    # Salvar metadados
    metadata = {
        "timestamp": timestamp,
        "files": saved_files,
        "description": "Backup automático do fluxo de correção"
    }
    
    with open(os.path.join(backup_subdir, "metadata.json"), 'w') as f:
        json.dump(metadata, f, indent=2)
    
    # Atualizar symlink para "latest"
    latest_link = os.path.join(BACKUP_DIR, "latest")
    if os.path.exists(latest_link):
        os.remove(latest_link)
    
    # No Windows, copiar ao invés de symlink
    if os.name == 'nt':
        if os.path.exists(latest_link):
            shutil.rmtree(latest_link)
        shutil.copytree(backup_subdir, latest_link)
    else:
        os.symlink(backup_subdir, latest_link)
    
    print(f"\n✅ Backup salvo em: {backup_subdir}")
    print(f"📁 Link rápido: {latest_link}")
    print(f"{'='*60}\n")

def restore_from_backup(backup_name="latest"):
    """Restaura arquivos de um backup específico"""
    backup_path = os.path.join(BACKUP_DIR, backup_name)
    
    if not os.path.exists(backup_path):
        print(f"❌ Backup não encontrado: {backup_path}")
        print(f"\n💡 Use --save primeiro para criar um backup")
        return
    
    # Ler metadados
    metadata_file = os.path.join(backup_path, "metadata.json")
    if os.path.exists(metadata_file):
        with open(metadata_file, 'r') as f:
            metadata = json.load(f)
            print(f"\n📋 Restaurando backup de: {metadata['timestamp']}")
    
    print(f"\n{'='*60}")
    print(f"🔄 RESTAURANDO BACKUP")
    print(f"{'='*60}")
    
    for file_path in CRITICAL_FILES:
        backup_file_path = os.path.join(backup_path, file_path)
        
        if os.path.exists(backup_file_path):
            # Criar backup do arquivo atual antes de sobrescrever
            if os.path.exists(file_path):
                pre_restore_backup = f"{file_path}.pre_restore"
                shutil.copy2(file_path, pre_restore_backup)
                print(f"💾 Backup pré-restauração: {pre_restore_backup}")
            
            # Restaurar arquivo
            os.makedirs(os.path.dirname(file_path), exist_ok=True)
            shutil.copy2(backup_file_path, file_path)
            print(f"✅ Restaurado: {file_path}")
        else:
            print(f"⚠️  Não encontrado no backup: {file_path}")
    
    print(f"\n{'='*60}")
    print(f"✅ RESTAURAÇÃO COMPLETA!")
    print(f"{'='*60}")
    print(f"\n🚀 Reinicie o backend:\n   uvicorn src.main:app --reload\n")

def show_status():
    """Mostra status dos backups disponíveis"""
    ensure_backup_dir()
    
    backups = [d for d in os.listdir(BACKUP_DIR) if d.startswith("backup_") and os.path.isdir(os.path.join(BACKUP_DIR, d))]
    backups.sort(reverse=True)
    
    print(f"\n{'='*60}")
    print(f"📦 BACKUPS DISPONÍVEIS")
    print(f"{'='*60}\n")
    
    if not backups:
        print("⚠️  Nenhum backup encontrado.")
        print("💡 Use --save para criar um backup\n")
        return
    
    for backup in backups[:5]:  # Mostrar últimos 5
        backup_path = os.path.join(BACKUP_DIR, backup)
        metadata_file = os.path.join(backup_path, "metadata.json")
        
        if os.path.exists(metadata_file):
            with open(metadata_file, 'r') as f:
                metadata = json.load(f)
                print(f"📁 {backup}")
                print(f"   📅 {metadata['timestamp']}")
                print(f"   📄 {len(metadata['files'])} arquivos")
                print()
    
    print(f"{'='*60}\n")

def main():
    parser = argparse.ArgumentParser(description="Gerenciador de backups do fluxo de correção")
    parser.add_argument('--save', action='store_true', help='Salvar estado atual')
    parser.add_argument('--restore', action='store_true', help='Restaurar último backup')
    parser.add_argument('--status', action='store_true', help='Mostrar status dos backups')
    
    args = parser.parse_args()
    
    if args.save:
        save_current_state()
    elif args.restore:
        restore_from_backup()
    elif args.status:
        show_status()
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
