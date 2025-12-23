# Open WebUI Avanzado: Personalización, Plugins e Integraciones

Ejemplos de código y configuraciones del artículo publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

## 📁 Estructura

```
open-webui-avanzado/
├── docker/
│   ├── docker-compose.yml              # Configuración básica
│   └── docker-compose.rag-qdrant.yml  # Configuración con Qdrant para RAG
├── plugins/
│   └── example-plugin/                # Plugin de ejemplo
│       ├── plugin.py
│       ├── requirements.txt
│       └── README.md
├── nginx/
│   └── nginx.conf                      # Configuración Nginx con load balancing
├── scripts/
│   ├── backup-open-webui.sh           # Script de backup
│   └── setup-integration-n8n.sh        # Script de integración con n8n
├── custom.css                          # Tema personalizado CSS
└── README.md                           # Este archivo
```

## 🚀 Uso Rápido

### Instalación Básica

```bash
cd docker
docker-compose up -d
```

Accede a: http://localhost:3000

### Instalación con RAG (Qdrant)

```bash
cd docker
docker-compose -f docker-compose.rag-qdrant.yml up -d
```

### Instalar Plugin de Ejemplo

```bash
# Copiar plugin a volumen de datos
docker cp plugins/example-plugin open-webui:/app/backend/data/plugins/

# Reiniciar contenedor
docker-compose restart open-webui
```

## 📚 Documentación

Para más detalles, consulta el artículo completo en ElDiarioIA.es.

## 🔧 Configuración Avanzada

### Variables de Entorno Importantes

- `OLLAMA_BASE_URL`: URL del servidor Ollama
- `ENABLE_RAG_HYBRID_SEARCH`: Habilita búsqueda híbrida RAG
- `RAG_EMBEDDING_ENGINE`: Motor de embeddings (ollama, qdrant, pinecone)
- `WEBUI_SECRET_KEY`: Clave secreta para sesiones
- `ENABLE_PLUGINS`: Habilitar sistema de plugins

### Integración con n8n

1. Ejecutar script de configuración:
```bash
cd scripts
chmod +x setup-integration-n8n.sh
./setup-integration-n8n.sh
```

2. Usar ejemplo de envío:
```bash
./send-to-n8n-example.sh "Tu mensaje" llama3
```

## 🛠️ Troubleshooting

### Error: "Cannot connect to Ollama"

Verificar que Ollama está en la misma red Docker:
```bash
docker network inspect ollama-network
```

### Error: "Plugin not loading"

Verificar logs:
```bash
docker logs open-webui | grep -i plugin
```

### Error: "Out of memory"

Limitar modelos simultáneos en variables de entorno:
```yaml
- MAX_CONCURRENT_MODELS=2
```

## 📝 Licencia

Estos ejemplos son de código abierto y están disponibles para uso libre.

## 🤝 Contribuciones

Si encuentras errores o mejoras, por favor abre un issue en el repositorio.

