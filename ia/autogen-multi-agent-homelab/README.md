# Microsoft AutoGen - Multi-Agent en Homelab

Ejemplos para el artículo [AutoGen: Multi-Agent en Homelab con Ollama (Guía 2026)](https://www.eldiarioia.es).

## Contenido

- **scripts/setup_autogen.sh** — Instalación de AutoGen Studio en venv
- **configs/autogen.env** — Variables de entorno para Ollama
- **examples/agent_chat_ollama.py** — Ejemplo conceptual AgentChat con Ollama

## Requisitos

- Python 3.10+
- [Ollama](https://ollama.ai) instalado y un modelo descargado (ej. `ollama pull llama3.2`)

## Uso rápido

```bash
# Cargar variables (opcional)
source configs/autogen.env

# Instalar y arrancar AutoGen Studio
./scripts/setup_autogen.sh
# Luego: autogenstudio ui --port 8081
```

En AutoGen Studio configurar LLM: Base URL `http://localhost:11434/v1`, Model `llama3.2`, API Key vacío.
