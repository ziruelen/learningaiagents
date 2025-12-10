#!/bin/bash
# Script de instalación rápida de Heimdall
# Uso: ./setup.sh

set -e

echo "🚀 Instalando Heimdall Dashboard..."

# Obtener PUID y PGID del usuario actual
PUID=$(id -u)
PGID=$(id -g)

echo "📋 PUID: $PUID, PGID: $PGID"

# Crear directorio si no existe
mkdir -p config

# Crear docker-compose.yml si no existe
if [ ! -f docker-compose.yml ]; then
    cat > docker-compose.yml <<EOF
version: '3.8'

services:
  heimdall:
    image: lscr.io/linuxserver/heimdall:latest
    container_name: heimdall
    environment:
      - PUID=$PUID
      - PGID=$PGID
      - TZ=Europe/Madrid
    volumes:
      - ./config:/config
    ports:
      - "8080:80"
      - "8443:443"
    restart: unless-stopped
EOF
    echo "✅ docker-compose.yml creado"
else
    echo "⚠️  docker-compose.yml ya existe, no se sobrescribe"
fi

# Iniciar contenedor
echo "🐳 Iniciando contenedor..."
docker compose up -d

echo ""
echo "✅ Heimdall instalado correctamente!"
echo "🌐 Accede a: http://localhost:8080"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Crea una cuenta de administrador"
echo "   2. Añade tus aplicaciones"
echo "   3. Personaliza tu dashboard"
echo ""
