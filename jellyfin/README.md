# Jellyfin Media Server - Ejemplos de Configuración

Ejemplos prácticos para instalar y configurar Jellyfin en tu homelab.

## 📋 Contenido

- `docker-compose-basico.yml` - Configuración básica sin GPU
- `docker-compose-gpu-nvidia.yml` - Configuración con NVIDIA GPU para transcodificación
- `docker-compose-quicksync.yml` - Configuración con Intel QuickSync
- `nginx-reverse-proxy.conf` - Configuración Nginx para acceso remoto seguro
- `cloudflared-config.yml` - Configuración Cloudflare Tunnel
- `scripts/setup-jellyfin.sh` - Script de instalación automatizada
- `scripts/backup-jellyfin.sh` - Script de backup de configuración
- `scripts/update-jellyfin.sh` - Script de actualización

## 🚀 Inicio Rápido

### Instalación Básica (Docker)

```bash
# 1. Clonar o descargar este repositorio
cd jellyfin

# 2. Editar docker-compose-basico.yml y ajustar rutas
nano docker-compose-basico.yml

# 3. Iniciar Jellyfin
docker-compose -f docker-compose-basico.yml up -d

# 4. Acceder a http://localhost:8096
```

### Con GPU NVIDIA

```bash
# 1. Verificar que nvidia-docker está instalado
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi

# 2. Iniciar con GPU
docker-compose -f docker-compose-gpu-nvidia.yml up -d
```

## 📚 Documentación Completa

Para la guía completa paso a paso, visita:
**https://www.eldiarioia.es/2025/11/17/jellyfin-media-server-homelab-guia-completa/**

## ⚙️ Requisitos

- Docker y Docker Compose instalados
- Linux (Ubuntu/Debian recomendado)
- GPU opcional pero recomendada para transcodificación

## 🔧 Configuración

Ajusta las rutas en los archivos `docker-compose*.yml` según tu estructura:

- `/ruta/a/config` → Carpeta de configuración de Jellyfin
- `/ruta/a/cache` → Carpeta de caché
- `/ruta/a/medios` → Carpeta con tus películas, series, música

## 📝 Licencia

Estos ejemplos son de código abierto. Úsalos libremente en tu homelab.

