#!/bin/bash
# setup_mem0.sh - Script de instalación automatizada de Mem0

set -e

echo "🚀 Configurando Mem0 para Agentes de IA..."

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado. Por favor instala Docker primero."
    exit 1
fi

echo -e "${GREEN}✅ Docker encontrado${NC}"

# Verificar Docker Compose
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose no está instalado."
    exit 1
fi

echo -e "${GREEN}✅ Docker Compose encontrado${NC}"

# Iniciar servicios
echo -e "${YELLOW}📦 Iniciando Qdrant y Ollama...${NC}"
docker-compose up -d qdrant ollama

# Esperar a que Qdrant esté listo
echo -e "${YELLOW}⏳ Esperando a que Qdrant esté listo...${NC}"
for i in {1..30}; do
    if curl -s http://localhost:6333/health > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Qdrant listo${NC}"
        break
    fi
    sleep 2
done

# Esperar a que Ollama esté listo
echo -e "${YELLOW}⏳ Esperando a que Ollama esté listo...${NC}"
for i in {1..30}; do
    if curl -s http://localhost:11434/api/tags > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Ollama listo${NC}"
        break
    fi
    sleep 2
done

# Descargar modelo de embeddings
echo -e "${YELLOW}📥 Descargando modelo de embeddings (nomic-embed-text)...${NC}"
docker exec mem0_ollama ollama pull nomic-embed-text

# Verificar instalación
echo -e "${YELLOW}🔍 Verificando instalación...${NC}"

# Verificar Qdrant
if curl -s http://localhost:6333/collections | grep -q "mem0_memories" || true; then
    echo -e "${GREEN}✅ Qdrant funcionando${NC}"
else
    echo -e "${YELLOW}⚠️  Qdrant funcionando (colección se creará automáticamente)${NC}"
fi

# Verificar Ollama
if docker exec mem0_ollama ollama list | grep -q "nomic-embed-text"; then
    echo -e "${GREEN}✅ Modelo de embeddings instalado${NC}"
else
    echo -e "${YELLOW}⚠️  Modelo de embeddings no encontrado${NC}"
fi

# Instalar dependencias Python
echo -e "${YELLOW}📦 Instalando dependencias Python...${NC}"
pip install mem0ai qdrant-client ollama langchain-ollama || {
    echo "❌ Error instalando dependencias Python"
    exit 1
}

echo -e "${GREEN}✅ Mem0 configurado correctamente${NC}"
echo ""
echo "📝 Próximos pasos:"
echo "1. Configura las variables de entorno en configs/mem0.env"
echo "2. Ejecuta los ejemplos en examples/"
echo "3. Consulta la documentación en docs/"

