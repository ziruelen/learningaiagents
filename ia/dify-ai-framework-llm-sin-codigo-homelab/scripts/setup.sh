#!/bin/bash
# setup.sh - Instalación automática de Dify.AI

set -e

echo "🚀 Instalando Dify.AI..."

# Verificar Docker y Docker Compose
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Por favor instala Docker primero."
    exit 1
fi

if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose no está instalado."
    exit 1
fi

# Crear directorios necesarios
mkdir -p storage logs

# Generar SECRET_KEY si no existe
if [ ! -f .env ]; then
    SECRET_KEY=$(openssl rand -hex 32)
    echo "SECRET_KEY=${SECRET_KEY}" > .env
    echo "✅ SECRET_KEY generado"
else
    echo "ℹ️  .env ya existe, usando configuración existente"
fi

# Verificar si hay GPU disponible
if command -v nvidia-smi &> /dev/null; then
    echo "✅ GPU NVIDIA detectada"
    GPU_AVAILABLE=true
else
    echo "ℹ️  No se detectó GPU NVIDIA (Ollama usará CPU)"
    GPU_AVAILABLE=false
fi

# Iniciar servicios
echo ""
echo "📦 Iniciando servicios Docker..."
if docker compose version &> /dev/null; then
    docker compose up -d
else
    docker-compose up -d
fi

# Esperar a que los servicios estén listos
echo ""
echo "⏳ Esperando a que los servicios estén listos..."
sleep 10

# Verificar estado
echo ""
echo "🔍 Verificando estado de servicios..."
docker ps --filter "name=dify" --format "table {{.Names}}\t{{.Status}}"

echo ""
echo "✅ Dify.AI instalado correctamente"
echo ""
echo "🌐 Accede a: http://localhost:3000"
echo "🔑 Usuario por defecto: admin@example.com"
echo "🔑 Contraseña: password"
echo ""
echo "⚠️  IMPORTANTE: Cambia la contraseña después del primer login"
echo ""
echo "📚 Documentación: https://docs.dify.ai/"

