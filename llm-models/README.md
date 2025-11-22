# Top 10 LLMs Open Source 2025 - Ejemplos y Scripts

Guía práctica para instalar y usar los mejores modelos LLM open source en tu homelab.

## Instalación Rápida

### Ollama (Recomendado para empezar)

```bash
# Instalar Ollama
curl https://ollama.ai/install.sh | sh

# Descargar modelos top 5
ollama pull llama3.1:8b
ollama pull qwen2.5:8b
ollama pull mistral:7b
ollama pull deepseek-coder:6.7b
ollama pull llama3.1:70b
```

### vLLM (Para producción)

Ver scripts en `vllm/` para setup completo.

## Uso Básico

### Ollama

```bash
# Chat interactivo
ollama run llama3.1:8b

# API REST
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.1:8b",
  "prompt": "¿Qué es un LLM?",
  "stream": false
}'
```

### Python con Ollama

```python
import requests

response = requests.post('http://localhost:11434/api/generate',
    json={
        'model': 'llama3.1:8b',
        'prompt': 'Explica qué es un LLM',
        'stream': False
    }
)

print(response.json()['response'])
```

## Benchmarks

Ejecuta `benchmarks/test-speed.sh` para medir velocidad de inferencia.

## Más Información

Artículo completo: [Modelos Open Source 2025: Top 10 LLMs para Homelab](https://www.eldiarioia.es)

