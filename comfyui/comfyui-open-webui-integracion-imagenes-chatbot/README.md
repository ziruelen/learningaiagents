# ComfyUI + Open WebUI: Integración de Generación de Imágenes

## 📋 Descripción

Ejemplos de código y configuraciones del artículo publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

Este repositorio contiene:
- Docker Compose completo para stack Ollama + ComfyUI + Open WebUI
- Scripts Python para interactuar con ComfyUI API
- Workflows JSON reutilizables
- Scripts de instalación automatizada

## 📁 Estructura

```
comfyui-open-webui-integracion-imagenes-chatbot/
├── docker-compose.yml          # Stack completo Docker
├── scripts/
│   ├── comfyui_api.py          # Cliente Python para ComfyUI API
│   └── setup.sh                # Script de instalación
├── workflows/
│   └── basic_workflow.json     # Workflow básico de ejemplo
└── README.md                   # Este archivo
```

## 🚀 Uso Rápido

### 1. Instalación

```bash
# Clonar o descargar este repositorio
git clone https://github.com/ziruelen/learningaiagents.git
cd learningaiagents/homelab/comfyui-open-webui-integracion-imagenes-chatbot

# Ejecutar script de instalación
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### 2. Descargar Modelos

```bash
# Modelo LLM para Ollama
docker exec -it ollama ollama pull llama3.1:8b

# Modelo Stable Diffusion para ComfyUI
# Descarga desde Civitai o Hugging Face a:
# comfyui_models/Stable-diffusion/
```

### 3. Generar Imagen con Python

```bash
# Instalar dependencias
pip install requests pillow

# Generar imagen
python3 scripts/comfyui_api.py "a cyberpunk robot with red mohawk"
```

## 📖 Artículo Completo

Para instrucciones detalladas, troubleshooting y mejores prácticas, consulta el artículo completo:

**🔗 [ComfyUI + Open WebUI: Integra Generación de Imágenes con tu Chatbot Local](https://www.eldiarioia.es)**

## 🔧 Configuración

### Variables de Entorno

Edita `docker-compose.yml` para personalizar:

- **Puertos**: Cambia `3000:8080` si el puerto 3000 está ocupado
- **Modelos**: Ajusta rutas de volúmenes según tu estructura
- **GPU**: Verifica que `nvidia` driver esté configurado

### Requisitos

- Docker y Docker Compose
- GPU NVIDIA (recomendado, mínimo 4GB VRAM)
- 16GB RAM mínimo
- 50GB espacio en disco (para modelos)

## 🐛 Troubleshooting

### ComfyUI no responde

```bash
# Verificar logs
docker logs comfyui

# Verificar puerto
curl http://localhost:8188/queue
```

### Error "Out of Memory"

- Reduce resolución en workflow (512x512 en lugar de 1024x1024)
- Cierra otros procesos que usen GPU
- Usa modelo más pequeño (SD1.5 en lugar de SDXL)

### Open WebUI no conecta con ComfyUI

- Verifica que ambos contenedores están en la misma red Docker
- Usa nombre del servicio: `http://comfyui:8188` (no `localhost`)

## 📚 Recursos

- [ComfyUI GitHub](https://github.com/comfyanonymous/ComfyUI)
- [Open WebUI GitHub](https://github.com/open-webui/open-webui)
- [Ollama Docs](https://ollama.ai/docs)

## 📝 Licencia

Estos ejemplos son de código abierto. Úsalos libremente en tus proyectos.

---

**¿Problemas?** Abre un issue en el repositorio o consulta el artículo completo.

