#!/bin/bash

# Script de instalación automática de Traefik
# Uso: ./setup.sh

set -e

echo "🚀 Configurando Traefik Reverse Proxy..."

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Por favor, instálalo primero."
    exit 1
fi

# Verificar Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Por favor, instálalo primero."
    exit 1
fi

# Crear red Docker
echo "📡 Creando red Docker traefik-net..."
docker network create traefik-net 2>/dev/null || echo "   Red ya existe, continuando..."

# Crear directorios necesarios
echo "📁 Creando directorios..."
mkdir -p logs config

# Crear archivo acme.json
echo "🔐 Creando archivo acme.json..."
touch acme.json
chmod 600 acme.json

# Verificar archivo .env
if [ ! -f .env ]; then
    echo "⚠️  Archivo .env no encontrado. Creando plantilla..."
    cat > .env << EOF
DOMAIN=tu-dominio.com
EMAIL=tu-email@dominio.com
CLOUDFLARE_EMAIL=
CLOUDFLARE_API_KEY=
EOF
    echo "   Por favor, edita .env con tus valores antes de continuar."
    exit 1
fi

# Cargar variables de entorno
source .env

# Verificar que DOMAIN y EMAIL están configurados
if [ "$DOMAIN" = "tu-dominio.com" ] || [ -z "$DOMAIN" ]; then
    echo "❌ Por favor, configura DOMAIN en .env"
    exit 1
fi

if [ "$EMAIL" = "tu-email@dominio.com" ] || [ -z "$EMAIL" ]; then
    echo "❌ Por favor, configura EMAIL en .env"
    exit 1
fi

# Actualizar traefik.yml con el email
echo "📝 Actualizando traefik.yml con tu email..."
sed -i "s/tuemail@dominio.com/$EMAIL/g" traefik.yml

echo "✅ Configuración completada!"
echo ""
echo "📋 Próximos pasos:"
echo "1. Configura los registros DNS para tu dominio"
echo "2. Ejecuta: docker-compose -f docker-compose.traefik.yml up -d"
echo "3. Accede al dashboard en: https://traefik.$DOMAIN"
echo ""
echo "📖 Para más información, consulta el README.md"

