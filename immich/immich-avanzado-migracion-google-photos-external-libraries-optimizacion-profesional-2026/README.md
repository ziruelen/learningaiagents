# Immich Avanzado - Ejemplos y Scripts

Ejemplos prácticos para configuración avanzada de Immich: migración desde Google Photos, external libraries, optimización y automatizaciones.

## 📁 Estructura

```
immich-avanzado/
├── docker-compose.avanzado.yml    # Configuración optimizada con external libraries
├── scripts/
│   ├── migracion_google_photos.sh    # Migración completa desde Google Takeout
│   ├── normalizar_metadatos.py       # Normalización de metadatos EXIF
│   ├── deduplicar_visual.sh          # Deduplicación visual con immich-deduper
│   └── backup_immich_db.sh           # Backup automatizado (DB + library)
├── configs/
│   └── immich_external_libraries.yml # Configuración de external libraries
├── n8n/
│   └── workflows/
│       └── immich_backup_automatico.json  # Workflow n8n para backup automático
└── README.md
```

## 🚀 Inicio Rápido

### 1. Migración desde Google Photos

```bash
# 1. Exportar desde Google Takeout
# - Ir a https://takeout.google.com/
# - Seleccionar "Fotos de Google" incluyendo metadatos JSON
# - Descargar todos los archivos ZIP

# 2. Ejecutar script de migración
./scripts/migracion_google_photos.sh \
  /mnt/storage/google_takeout \
  /mnt/storage/immich_library \
  /var/log/immich_migration.log

# 3. Configurar external library en Immich
# - Settings → Libraries → Create External Library
# - Path: /mnt/storage/immich_library
# - Iniciar escaneo
```

### 2. Configurar External Libraries

```bash
# 1. Editar docker-compose.avanzado.yml
# Añadir volúmenes para external libraries:
volumes:
  - /mnt/nas/fotos_antiguas:/mnt/nas/fotos_antiguas:ro

# 2. Reiniciar contenedores
docker-compose -f docker-compose.avanzado.yml up -d

# 3. Crear external library desde UI
# Settings → Libraries → Create External Library
# - Nombre: "Fotos Antiguas NAS"
# - Path: /mnt/nas/fotos_antiguas
# - User: admin
# - Exclusions: *.raw, *.cr2
# - Read-only: true
```

### 3. Optimización de IA/ML

```bash
# Editar docker-compose.avanzado.yml
# Cambiar modelo CLIP según hardware:

# Hardware potente (32GB+ RAM):
- IMMICH_CLIP_MODEL=ViT-L-14

# Hardware modesto (16GB RAM):
- IMMICH_CLIP_MODEL=ViT-B-32

# Habilitar GPU (si está disponible):
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: 1
          capabilities: [gpu]
```

### 4. Deduplicación Visual

```bash
# 1. Instalar immich-deduper
pip3 install immich-deduper

# 2. Obtener API key y Library ID desde Immich
# Settings → API Keys → Create New Key
# Settings → Libraries → Copiar Library ID

# 3. Ejecutar deduplicación (dry-run primero)
./scripts/deduplicar_visual.sh \
  https://immich.tu-dominio.com \
  tu-api-key \
  library-id \
  0.95 \
  true

# 4. Revisar resultados
cat duplicates_*.json | jq '.[] | select(.similarity > 0.98)'

# 5. Ejecutar eliminación real (quitar --dry-run)
./scripts/deduplicar_visual.sh \
  https://immich.tu-dominio.com \
  tu-api-key \
  library-id \
  0.98 \
  false
```

### 5. Backup Automatizado

```bash
# 1. Configurar script de backup
chmod +x scripts/backup_immich_db.sh

# 2. Ejecutar manualmente
./scripts/backup_immich_db.sh \
  /mnt/backups/immich \
  immich-postgres \
  immich \
  immich \
  ./library \
  30

# 3. Añadir a crontab (backup diario a las 2 AM)
0 2 * * * /ruta/a/scripts/backup_immich_db.sh >> /var/log/immich_backup.log 2>&1
```

## 🔧 Configuración Avanzada

### External Libraries: Mejores Prácticas

1. **Siempre usar read-only** para proteger archivos originales
2. **Fragmentar bibliotecas grandes** en múltiples external libraries más pequeñas
3. **Configurar exclusiones** para archivos que no quieres procesar (RAW, temporales)
4. **Escaneo manual** para bibliotecas estáticas (fotos antiguas)
5. **Escaneo diario/semanal** para bibliotecas que cambian frecuentemente

### Optimización de Recursos

**Para bibliotecas grandes (>500K fotos):**
- CPU: 16+ cores
- RAM: 64GB+
- GPU: NVIDIA con CUDA (opcional pero recomendado)
- Almacenamiento: SSD para thumbnails, HDD para archivos originales

**Para bibliotecas medianas (100K-500K fotos):**
- CPU: 8 cores
- RAM: 32GB
- Almacenamiento: SSD mixto

**Para bibliotecas pequeñas (<100K fotos):**
- CPU: 4 cores
- RAM: 16GB
- Almacenamiento: Cualquiera

## 📚 Recursos

- [Documentación oficial Immich](https://immich.app/docs/)
- [Immich External Libraries Guide](https://immich.app/docs/guides/external-library/)
- [Immich-Deduper](https://github.com/immich-app/immich-deduper)
- [Immich Power Tools](https://github.com/immich-app/immich-power-tools)
- [Artículo básico Immich](https://www.eldiarioia.es/2025/11/08/immich-la-alternativa-self-hosted-a-google-photos-con-ia-que-controlas-tu-guia-completa-2025/)

## ⚠️ Notas Importantes

- **Backups**: Siempre hacer backup antes de ejecutar scripts de deduplicación o migración
- **Permisos**: Verificar permisos de lectura en external libraries
- **Recursos**: Monitorear uso de CPU/RAM durante escaneos grandes
- **Actualizaciones**: Revisar changelog antes de actualizar Immich

## 🔗 Artículos Relacionados

- [Immich Básico: Alternativa Self-Hosted a Google Photos](https://www.eldiarioia.es/2025/11/08/immich-la-alternativa-self-hosted-a-google-photos-con-ia-que-controlas-tu-guia-completa-2025/)
- [Nextcloud: Tu Nube Privada Self-Hosted](https://www.eldiarioia.es/2025/12/14/nextcloud-tu-nube-privada-self-hosted-guia-completa-2025/)
- [n8n: Automatiza 100+ Tareas Sin Código](https://www.eldiarioia.es/2025/XX/XX/n8n-automatizacion/)

