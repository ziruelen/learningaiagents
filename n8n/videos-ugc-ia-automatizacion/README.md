# Videos UGC con IA: Automatización con n8n y Stable Diffusion

## 📋 Descripción

Ejemplos de código y configuraciones del artículo publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

Este repositorio contiene:
- Docker Compose completo para stack ComfyUI + n8n + FFmpeg
- Workflows n8n para automatización de generación de videos UGC
- Scripts FFmpeg para procesamiento de video
- Scripts Python para generación batch

## 📁 Estructura

```
videos-ugc-ia-automatizacion/
├── docker-compose.yml          # Stack completo Docker
├── scripts/
│   ├── create-video.sh         # Script básico FFmpeg
│   ├── create-video-advanced.sh # Script avanzado con transiciones
│   └── generate-ugc-batch.py   # Script Python para batch
├── n8n-workflows/
│   └── ugc-video-generator.json # Workflow n8n completo
├── configs/                     # Configuraciones de ejemplo
└── README.md                   # Este archivo
```

## 🚀 Uso Rápido

### 1. Instalación

```bash
# Clonar o descargar este repositorio
git clone https://github.com/ziruelen/learningaiagents.git
cd learningaiagents/n8n/videos-ugc-ia-automatizacion

# Crear directorios necesarios
mkdir -p comfyui_models/Stable-diffusion
mkdir -p comfyui_output
mkdir -p video_output

# Levantar servicios
docker-compose up -d
```

### 2. Descargar Modelo Stable Diffusion

```bash
# Descarga un modelo desde Civitai o Hugging Face a:
# comfyui_models/Stable-diffusion/
# Ejemplo: Realistic Vision v5
```

### 3. Generar Video con Python

```bash
# Instalar dependencias
pip install requests pillow

# Generar video
python3 scripts/generate-ugc-batch.py "a person unboxing a smartphone, authentic UGC style"
```

### 4. Usar Workflow n8n

1. Accede a n8n: http://localhost:5678
2. Importa el workflow: `n8n-workflows/ugc-video-generator.json`
3. Configura los prompts según tus necesidades
4. Activa el workflow

## 📖 Artículo Completo

Para instrucciones detalladas, troubleshooting y mejores prácticas, consulta el artículo completo:

**🔗 [Videos UGC con IA: Automatiza Creación de Contenido con n8n y Stable Diffusion](https://www.eldiarioia.es)**

## 🔧 Configuración

### Variables de Entorno

Edita `docker-compose.yml` para personalizar:

- **Puertos**: Cambia `5678:5678` si el puerto está ocupado
- **Modelos**: Ajusta rutas de volúmenes según tu estructura
- **GPU**: Verifica que `nvidia` driver esté configurado

### Requisitos

- Docker y Docker Compose
- GPU NVIDIA (recomendado, mínimo 4GB VRAM)
- FFmpeg instalado (o usar contenedor Docker)
- 16GB RAM mínimo
- 50GB espacio en disco (para modelos y videos)

## 🐛 Troubleshooting

### FFmpeg no encuentra imágenes

```bash
# Verificar que las imágenes existen
ls -la comfyui_output/ugc_video_*.png

# Verificar permisos
chmod 644 comfyui_output/*.png
```

### Video sin audio

```bash
# Añadir audio de fondo
ffmpeg -i video.mp4 -i audio.mp3 -c:v copy -c:a aac -shortest output.mp4
```

### ComfyUI no responde

```bash
# Verificar logs
docker logs comfyui

# Verificar puerto
curl http://localhost:8188/queue
```

## 📚 Recursos

- [FFmpeg Documentation](https://ffmpeg.org/documentation.html)
- [n8n Documentation](https://docs.n8n.io/)
- [ComfyUI GitHub](https://github.com/comfyanonymous/ComfyUI)

## 📝 Licencia

Estos ejemplos son de código abierto. Úsalos libremente en tus proyectos.

---

**¿Problemas?** Abre un issue en el repositorio o consulta el artículo completo.

