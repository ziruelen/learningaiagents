#!/bin/bash
# setup-openclaw.sh
# Script de instalación automática de OpenClaw

set -e

echo "🚀 Instalando OpenClaw..."
echo ""

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Función para verificar comandos
check_command() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}❌ $1 no está instalado${NC}"
        return 1
    else
        echo -e "${GREEN}✓ $1 está instalado${NC}"
        return 0
    fi
}

# Verificar Node.js
echo "📦 Verificando Node.js..."
if ! check_command node; then
    echo -e "${YELLOW}Instalando Node.js v18...${NC}"
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo -e "${GREEN}✅ Node.js instalado${NC}"
fi

NODE_VERSION=$(node -v)
echo -e "${GREEN}Node.js versión: $NODE_VERSION${NC}"
echo ""

# Verificar npm
echo "📦 Verificando npm..."
if ! check_command npm; then
    echo -e "${RED}❌ npm no está disponible. Instala Node.js primero.${NC}"
    exit 1
fi

NPM_VERSION=$(npm -v)
echo -e "${GREEN}npm versión: $NPM_VERSION${NC}"
echo ""

# Verificar Docker (opcional pero recomendado)
echo "🐳 Verificando Docker..."
if ! check_command docker; then
    echo -e "${YELLOW}Docker no está instalado. Instalando...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    echo -e "${GREEN}✅ Docker instalado${NC}"
    echo -e "${YELLOW}⚠️  Necesitas cerrar sesión y volver a entrar para usar Docker sin sudo${NC}"
else
    DOCKER_VERSION=$(docker --version)
    echo -e "${GREEN}Docker versión: $DOCKER_VERSION${NC}"
fi
echo ""

# Instalar OpenClaw globalmente
echo "📥 Instalando OpenClaw..."
npm install -g openclaw

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ OpenClaw instalado correctamente${NC}"
else
    echo -e "${RED}❌ Error instalando OpenClaw${NC}"
    exit 1
fi
echo ""

# Crear directorio de configuración
echo "📁 Creando directorios de configuración..."
mkdir -p ~/.openclaw/{data,config,logs}
echo -e "${GREEN}✅ Directorios creados${NC}"
echo ""

# Copiar template de configuración
echo "📝 Configurando archivo .env..."
if [ ! -f ~/.openclaw/config/.env ]; then
    cat > ~/.openclaw/config/.env <<EOF
# OpenClaw Configuration
# Completa con tus API keys

ANTHROPIC_API_KEY=
OPENAI_API_KEY=
GOOGLE_API_KEY=

TELEGRAM_BOT_TOKEN=
DISCORD_BOT_TOKEN=
SLACK_BOT_TOKEN=

OPENCLAW_PORT=3000
OPENCLAW_HOST=0.0.0.0
OPENCLAW_LOG_LEVEL=info
EOF
    echo -e "${GREEN}✅ Archivo .env creado en ~/.openclaw/config/.env${NC}"
    echo -e "${YELLOW}⚠️  Edita ~/.openclaw/config/.env con tus API keys${NC}"
else
    echo -e "${YELLOW}⚠️  Archivo .env ya existe. No se sobrescribió.${NC}"
fi
echo ""

# Verificar instalación
echo "🔍 Verificando instalación..."
OPENCLAW_VERSION=$(openclaw --version 2>/dev/null || echo "unknown")
echo -e "${GREEN}OpenClaw versión: $OPENCLAW_VERSION${NC}"
echo ""

# Resumen
echo "═══════════════════════════════════════════════════════════════"
echo -e "${GREEN}✅ OpenClaw instalado correctamente${NC}"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "📝 Próximos pasos:"
echo "   1. Edita ~/.openclaw/config/.env con tus API keys"
echo "   2. Configura OpenClaw: openclaw configure"
echo "   3. Inicia el servidor: openclaw start"
echo ""
echo "📚 Documentación: https://openclawapi.org/es"
echo "🐙 GitHub: https://github.com/openclaw/openclaw"
echo ""

