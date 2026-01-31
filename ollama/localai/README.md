# LocalAI: Cliente OpenAI Compatible 100% Local

Ejemplos prácticos para instalar y usar LocalAI en tu homelab.

## 📋 Contenido

- `docker-compose.yml` - Instalación básica con CPU
- `docker-compose.gpu.yml` - Instalación con soporte GPU
- `configs/models.yaml` - Configuración de modelos
- `scripts/` - Scripts de migración y testing
- `examples/` - Ejemplos en Python, Node.js y n8n

## 🚀 Inicio Rápido

### 1. Instalación Básica (CPU)

```bash
# Crear carpetas necesarias
mkdir -p models config

# Iniciar LocalAI
docker-compose up -d

# Verificar que está corriendo
curl http://localhost:8080/ready
```

### 2. Descargar un Modelo

```bash
# Ejemplo: Descargar Llama 2 7B Chat (Q4)
cd models
wget https://huggingface.co/TheBloke/Llama-2-7B-Chat-GGUF/resolve/main/llama-2-7b-chat.Q4_0.gguf
```

### 3. Configurar Modelo

Copia `configs/models.yaml` a `config/models.yaml` y ajusta la ruta del modelo:

```yaml
- name: gpt-4
  backend: llama-cpp
  parameters:
    model: /models/llama-2-7b-chat.Q4_0.gguf
    # ... resto de configuración
```

### 4. Probar la API

```bash
# Hacer ejecutable el script de test
chmod +x scripts/test_localai_api.sh

# Ejecutar test
./scripts/test_localai_api.sh
```

## 📝 Ejemplos de Uso

### Python

```bash
cd examples/python
pip install openai
python3 chat_completion.py
```

### Node.js

```bash
cd examples/nodejs
npm install openai
node chat_completion.js
```

### n8n

Importa el workflow desde `examples/n8n/workflow_localai.json` en tu instancia de n8n.

## 🔄 Migración desde OpenAI

Usa el script de migración para convertir código existente:

```bash
python3 scripts/migrate_openai_to_localai.py tu_archivo.py
```

Esto creará `tu_archivo.py.localai` con las URLs actualizadas.

## 📚 Recursos

- [Documentación LocalAI](https://localai.io/)
- [GitHub LocalAI](https://github.com/mudler/LocalAI)
- [Artículo completo](https://www.eldiarioia.es/2026/01/31/localai-cliente-openai-compatible-local-homelab-guia-completa-2026/)

## ⚠️ Notas Importantes

- LocalAI requiere modelos en formato GGUF
- El rendimiento depende del hardware disponible
- Para GPU, usa `docker-compose.gpu.yml` y la imagen `latest-cublas`
- Los modelos grandes requieren mucha RAM/VRAM

