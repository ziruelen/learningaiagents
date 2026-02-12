# Mem0: Memoria Persistente para Agentes de IA

Ejemplos prácticos para implementar memoria persistente en agentes de IA usando Mem0.

## 📋 Contenido

- `docker-compose.yml` - Stack completo Mem0 + Qdrant + Ollama
- `docker-compose.production.yml` - Configuración para producción
- `scripts/setup_mem0.sh` - Script de instalación automatizada
- `configs/mem0.env` - Variables de entorno
- `examples/crewai_mem0.py` - Integración con CrewAI
- `examples/chatbot_memoria.py` - Chatbot con memoria persistente
- `docs/integracion-ollama.md` - Guía de integración con Ollama
- `docs/integracion-crewai.md` - Guía de integración con CrewAI

## 🚀 Inicio Rápido

### 1. Instalación

```bash
# Clonar o descargar este repositorio
cd mem0-memoria-persistente-agentes-ia-guia-completa-2026

# Ejecutar script de setup
chmod +x scripts/setup_mem0.sh
./scripts/setup_mem0.sh
```

### 2. Configuración

```bash
# Copiar y editar configuración
cp configs/mem0.env .env
nano .env  # Ajustar según tu entorno
```

### 3. Ejecutar Ejemplos

```bash
# Chatbot con memoria
python examples/chatbot_memoria.py

# CrewAI con Mem0
python examples/crewai_mem0.py
```

## 📚 Documentación

- [Integración con Ollama](docs/integracion-ollama.md)
- [Integración con CrewAI](docs/integracion-crewai.md)

## 🔧 Requisitos

- Docker y Docker Compose
- Python 3.9+
- Ollama (para modelos locales)
- Qdrant (incluido en docker-compose.yml)

## 📖 Artículo Completo

Para la guía completa, visita:
https://www.eldiarioia.es/2026/02/12/mem0-memoria-persistente-agentes-ia-guia-completa-2026/

## 📝 Licencia

Estos ejemplos son de código abierto y están disponibles para uso personal y educativo.

