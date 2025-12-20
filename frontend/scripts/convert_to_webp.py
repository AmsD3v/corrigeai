"""
Script para converter imagens PNG para WebP com compressão otimizada.
Reduz significativamente o tamanho das imagens mantendo qualidade visual.
"""
from PIL import Image
import os

# Diretório das imagens
PUBLIC_DIR = r"f:\corrigeai\frontend\public"

# Imagens a converter (exceto favicons e apple-touch-icon)
IMAGES_TO_CONVERT = [
    "owl-thumbs-up-plate.png",  # Hero image - crítica para LCP
    "owl-thumbs-up.png",
    "owl-desk.png",
    "corricoin.png",
    "og-image.png",
    "owl-character.png",
    "owl_custom.png",
]

def convert_to_webp(filename: str, quality: int = 80):
    """Converte PNG para WebP com compressão."""
    input_path = os.path.join(PUBLIC_DIR, filename)
    output_filename = filename.replace('.png', '.webp')
    output_path = os.path.join(PUBLIC_DIR, output_filename)
    
    if not os.path.exists(input_path):
        print(f"❌ Arquivo não encontrado: {filename}")
        return
    
    # Abrir imagem
    img = Image.open(input_path)
    
    # Se tem transparência (RGBA), manter
    if img.mode in ('RGBA', 'LA') or (img.mode == 'P' and 'transparency' in img.info):
        # WebP suporta transparência
        img.save(output_path, 'WEBP', quality=quality, method=6)
    else:
        # Converter para RGB se necessário
        if img.mode != 'RGB':
            img = img.convert('RGB')
        img.save(output_path, 'WEBP', quality=quality, method=6)
    
    # Comparar tamanhos
    original_size = os.path.getsize(input_path) / 1024
    new_size = os.path.getsize(output_path) / 1024
    reduction = ((original_size - new_size) / original_size) * 100
    
    print(f"✅ {filename}")
    print(f"   Original: {original_size:.0f} KB")
    print(f"   WebP: {new_size:.0f} KB")
    print(f"   Redução: {reduction:.1f}%")
    print()

def main():
    print("=" * 50)
    print("Convertendo imagens para WebP")
    print("=" * 50)
    print()
    
    total_original = 0
    total_new = 0
    
    for filename in IMAGES_TO_CONVERT:
        input_path = os.path.join(PUBLIC_DIR, filename)
        output_filename = filename.replace('.png', '.webp')
        output_path = os.path.join(PUBLIC_DIR, output_filename)
        
        if os.path.exists(input_path):
            original_size = os.path.getsize(input_path) / 1024
            convert_to_webp(filename, quality=80)
            if os.path.exists(output_path):
                new_size = os.path.getsize(output_path) / 1024
                total_original += original_size
                total_new += new_size
    
    print("=" * 50)
    print(f"TOTAL Original: {total_original:.0f} KB ({total_original/1024:.2f} MB)")
    print(f"TOTAL WebP: {total_new:.0f} KB ({total_new/1024:.2f} MB)")
    print(f"Economia: {total_original - total_new:.0f} KB ({((total_original - total_new)/total_original)*100:.1f}%)")
    print("=" * 50)

if __name__ == "__main__":
    main()
