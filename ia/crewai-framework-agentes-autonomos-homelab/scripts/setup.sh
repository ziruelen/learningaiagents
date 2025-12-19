#!/bin/bash
# Script de instalación de CrewAI

echo "🚀 Instalando CrewAI..."

# Crear entorno virtual
python3 -m venv venv
source venv/bin/activate

# Instalar dependencias
pip install --upgrade pip
pip install crewai langchain-community langchain-openai duckduckgo-search

# Verificar instalación
python3 -c "import crewai; print(f'CrewAI versión: {crewai.__version__}')"

echo "✅ Instalación completada"
echo "📝 Para usar: source venv/bin/activate"
