# Integración de Mem0 con Ollama

Esta guía explica cómo integrar Mem0 con Ollama para tener memoria persistente completamente local sin costos de API.

## Requisitos Previos

- Ollama instalado y corriendo en `http://localhost:11434`
- Modelo de embeddings descargado: `ollama pull nomic-embed-text`
- Modelo LLM descargado: `ollama pull llama3` (o el que prefieras)

## Configuración Básica

### 1. Iniciar Ollama

```bash
# Si usas Docker
docker run -d -p 11434:11434 ollama/ollama

# O si tienes Ollama instalado localmente
ollama serve
```

### 2. Descargar Modelos

```bash
# Modelo de embeddings (requerido)
ollama pull nomic-embed-text

# Modelo LLM (opcional, para el agente)
ollama pull llama3
```

### 3. Configurar Mem0 con Ollama

```python
from mem0 import Memory
from langchain_ollama import ChatOllama

# Configurar Mem0 con embeddings de Ollama
memory = Memory(
    embedding_model={
        "provider": "ollama",
        "config": {
            "model": "nomic-embed-text",
            "base_url": "http://localhost:11434"
        }
    }
)

# Crear agente con Ollama + Mem0
llm = ChatOllama(model="llama3", base_url="http://localhost:11434")
```

## Ventajas de Usar Ollama

- ✅ **100% Local**: Sin costos de API
- ✅ **Privacidad Total**: Todo queda en tu homelab
- ✅ **Sin Límites**: No hay rate limits
- ✅ **Rápido**: Latencia baja en red local

## Troubleshooting

### Error: "Model not found"

**Solución:**
```bash
# Verificar modelos disponibles
ollama list

# Descargar modelo faltante
ollama pull nomic-embed-text
```

### Error: "Connection refused"

**Solución:**
```bash
# Verificar que Ollama esté corriendo
curl http://localhost:11434/api/tags

# Si no responde, iniciar Ollama
ollama serve
```

## Ejemplo Completo

Ver `examples/chatbot_memoria.py` para un ejemplo completo de integración.

