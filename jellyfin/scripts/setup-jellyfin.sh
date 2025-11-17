#!/bin/bash
# Script de instalación automatizada de Jellyfin con Docker

set -e

echo "🚀 Instalación de Jellyfin Media Server"
echo "========================================"

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Instalando..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    echo "✅ Docker instalado. Por favor, cierra sesión y vuelve a entrar."
    exit 0
fi

# Verificar Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Instalando..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "✅ Docker Compose instalado"
fi

# Crear estructura de carpetas
echo "📁 Creando estructura de carpetas..."
mkdir -p ~/docker/jellyfin/{config,cache}
mkdir -p ~/media/{peliculas,series,musica}

# Crear docker-compose.yml
echo "📝 Creando docker-compose.yml..."
cat > ~/docker/jellyfin/docker-compose.yml << 'EOF'
version: '3.8'

services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    network_mode: 'host'
    volumes:
      - ./config:/config
      - ./cache:/cache
      - ~/media/peliculas:/data/movies
      - ~/media/series:/data/tvshows
      - ~/media/musica:/data/music
    environment:
      - PUID=$(id -u)
      - PGID=$(id -g)
      - TZ=$(cat /etc/timezone)
    restart: unless-stopped
EOF

# Iniciar Jellyfin
echo "🎬 Iniciando Jellyfin..."
cd ~/docker/jellyfin
docker-compose up -d

echo ""
echo "✅ Jellyfin instalado y ejecutándose!"
echo "🌐 Accede a: http://localhost:8096"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Completa el asistente de configuración"
echo "   2. Añade tus bibliotecas de medios"
echo "   3. Configura usuarios y permisos"
echo ""
echo "📚 Para más información, visita:"
echo "   https://www.eldiarioia.es/2025/11/17/jellyfin-media-server-homelab-guia-completa/"

