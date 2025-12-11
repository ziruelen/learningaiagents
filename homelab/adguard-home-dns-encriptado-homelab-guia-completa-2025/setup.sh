#!/bin/bash
# setup-adguard.sh - Instalación automatizada de AdGuard Home

set -e

# Variables
ADGUARD_DIR="${ADGUARD_DIR:-$HOME/docker/adguard}"
COMPOSE_FILE="$ADGUARD_DIR/docker-compose.yml"

echo "🚀 Instalando AdGuard Home..."

# Crear directorios
mkdir -p "$ADGUARD_DIR"/{work,conf}
cd "$ADGUARD_DIR"

# Copiar docker-compose.yml si no existe
if [ ! -f "$COMPOSE_FILE" ]; then
    echo "📝 Creando docker-compose.yml..."
    cat > "$COMPOSE_FILE" << 'EOF'
version: '3.8'
services:
  adguard:
    image: adguard/adguardhome:latest
    container_name: adguard-home
    restart: unless-stopped
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "80:80/tcp"
      - "443:443/tcp"
      - "443:443/udp"
      - "853:853/tcp"
      - "784:784/udp"
      - "3000:3000/tcp"
    volumes:
      - ./work:/opt/adguardhome/work
      - ./conf:/opt/adguardhome/conf
    environment:
      TZ: Europe/Madrid
    cap_add:
      - NET_ADMIN
      - NET_RAW
EOF
fi

# Iniciar contenedor
echo "🐳 Iniciando contenedor Docker..."
docker compose up -d

# Esperar a que el contenedor esté listo
echo "⏳ Esperando a que AdGuard Home esté listo..."
sleep 5

# Obtener IP del servidor
SERVER_IP=$(hostname -I | awk '{print $1}')

echo ""
echo "✅ AdGuard Home instalado correctamente"
echo "🌐 Accede a http://${SERVER_IP}:3000 para configurar"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Completa la configuración inicial en el navegador"
echo "   2. Configura DNS encriptado (DoH/DoT/DoQ) en Settings → Encryption"
echo "   3. Añade blocklists en Filters → DNS blocklists"
echo "   4. Configura tu router para usar ${SERVER_IP} como DNS"
echo ""
