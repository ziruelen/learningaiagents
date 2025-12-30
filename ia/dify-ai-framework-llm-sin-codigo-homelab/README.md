# Dify.AI: Framework LLM sin Código para Homelab

## 📋 Descripción

Ejemplos de código y configuraciones del artículo publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

Este repositorio contiene configuraciones Docker Compose, scripts de instalación, workflows de ejemplo y configuraciones para desplegar Dify.AI en tu homelab.

## 📁 Estructura

```
dify-ai-framework-llm-sin-codigo-homelab/
├── docker-compose.yml          # Configuración básica con Ollama
├── docker-compose.prod.yml     # Configuración para producción
├── scripts/
│   ├── setup.sh                # Instalación automática
│   └── backup.sh               # Backup de datos y knowledge bases
├── workflows/
│   ├── chatbot-basico.json     # Workflow chatbot simple
│   └── rag-documentos.json     # Workflow RAG con documentos
└── configs/
    ├── .env.example            # Variables de entorno de ejemplo
    └── nginx.conf              # Configuración reverse proxy

```

## 🚀 Uso

### Instalación Rápida

1. Clona este repositorio o descarga los archivos
2. Ejecuta el script de instalación:
   ```bash
   chmod +x scripts/setup.sh
   ./scripts/setup.sh
   ```

3. Accede a la interfaz web: http://localhost:3000
4. Login inicial: `admin@example.com` / `password`

### Instalación Manual

1. Copia `.env.example` a `.env` y ajusta las variables
2. Inicia los servicios:
   ```bash
   docker compose up -d
   ```

3. Verifica que todos los servicios estén corriendo:
   ```bash
   docker ps
   ```

### Configuración con Ollama

Si tienes GPU NVIDIA, Ollama se configurará automáticamente. Para usar modelos específicos:

```bash
# Descargar modelo
docker exec -it ollama ollama pull llama3.2:3b

# Verificar modelos disponibles
docker exec -it ollama ollama list
```

### Importar Workflows

1. Accede a Dify.AI: http://localhost:3000
2. Ve a "Workflows" → "Import"
3. Selecciona uno de los archivos JSON en `workflows/`
4. Ajusta la configuración según tu entorno

## 🔧 Configuración

### Variables de Entorno Importantes

- `SECRET_KEY`: Genera una clave segura con `openssl rand -hex 32`
- `DATABASE_URL`: URL de conexión a PostgreSQL
- `OLLAMA_API_BASE_URL`: URL de Ollama (por defecto: http://ollama:11434)
- `QDRANT_URL`: URL de Qdrant vector database

### Reverse Proxy (Nginx/Traefik)

Usa `configs/nginx.conf` como referencia para configurar un reverse proxy con SSL.

## 💾 Backup

Ejecuta el script de backup para guardar tus datos:

```bash
chmod +x scripts/backup.sh
./scripts/backup.sh
```

Los backups se guardan en `./backups/` con timestamp.

## 📖 Artículo Completo

Guía paso a paso: [Dify.AI: Framework LLM sin Código para Homelab (Guía Completa 2025)](https://www.eldiarioia.es)

## 🤝 Contribuir

¿Encontraste un error o tienes una mejora? Abre un issue o PR.

---

*Ejemplos mantenidos por [ElDiarioIA.es](https://www.eldiarioia.es)*

