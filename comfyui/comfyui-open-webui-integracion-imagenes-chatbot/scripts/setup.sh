#!/bin/bash
# Script de instalación rápida para ComfyUI + Open WebUI + Ollama

set -e

echo "🚀 Instalando stack ComfyUI + Open WebUI + Ollama..."

# Crear directorios necesarios
mkdir -p comfyui_models/Stable-diffusion
mkdir -p comfyui_models/VAE
mkdir -p comfyui_models/Lora
mkdir -p comfyui_output
mkdir -p workflows

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Instala Docker primero."
    exit 1
fi

# Verificar Docker Compose
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose no está instalado. Instala Docker Compose primero."
    exit 1
fi

# Verificar NVIDIA GPU (opcional pero recomendado)
if command -v nvidia-smi &> /dev/null; then
    echo "✅ GPU NVIDIA detectada:"
    nvidia-smi --query-gpu=name,memory.total --format=csv,noheader
else
    echo "⚠️  GPU NVIDIA no detectada. ComfyUI funcionará con CPU (muy lento)."
fi

# Levantar servicios
echo "📦 Levantando contenedores..."
docker-compose up -d

# Esperar a que los servicios estén listos
echo "⏳ Esperando a que los servicios estén listos..."
sleep 10

# Verificar Ollama
echo "🔍 Verificando Ollama..."
if docker exec ollama ollama list &> /dev/null; then
    echo "✅ Ollama funcionando"
else
    echo "⚠️  Ollama aún no está listo. Espera unos segundos más."
fi

# Verificar ComfyUI
echo "🔍 Verificando ComfyUI..."
if curl -s http://localhost:8188/queue &> /dev/null; then
    echo "✅ ComfyUI funcionando"
else
    echo "⚠️  ComfyUI aún no está listo. Espera unos segundos más."
fi

# Verificar Open WebUI
echo "🔍 Verificando Open WebUI..."
if curl -s http://localhost:3000 &> /dev/null; then
    echo "✅ Open WebUI funcionando"
else
    echo "⚠️  Open WebUI aún no está listo. Espera unos segundos más."
fi

echo ""
echo "✅ Instalación completada!"
echo ""
echo "📋 Servicios disponibles:"
echo "  - Ollama: http://localhost:11434"
echo "  - ComfyUI: http://localhost:8188"
echo "  - Open WebUI: http://localhost:3000"
echo ""
echo "📖 Próximos pasos:"
echo "  1. Descarga un modelo de Ollama: docker exec -it ollama ollama pull llama3.1:8b"
echo "  2. Descarga un modelo de Stable Diffusion a comfyui_models/Stable-diffusion/"
echo "  3. Accede a Open WebUI: http://localhost:3000"
echo "  4. Configura la integración con ComfyUI (ver artículo completo)"

