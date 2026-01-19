#!/bin/bash
# migracion_google_photos.sh
# Script para migrar fotos desde Google Takeout a Immich

set -e

GOOGLE_TAKEOUT_DIR="${1:-/mnt/storage/google_takeout}"
IMMICH_LIBRARY="${2:-/mnt/storage/immich_library}"
LOG_FILE="${3:-/var/log/immich_migration.log}"

echo "🔄 Iniciando migración desde Google Photos..."
echo "📂 Origen: $GOOGLE_TAKEOUT_DIR"
echo "📂 Destino: $IMMICH_LIBRARY"
echo "📝 Log: $LOG_FILE"

# Crear directorio de destino si no existe
mkdir -p "$IMMICH_LIBRARY"
mkdir -p "$(dirname "$LOG_FILE")"

# 1. Descomprimir archivos de Google Takeout
echo "📦 Descomprimiendo archivos de Google Takeout..."
EXTRACTED_DIR="$GOOGLE_TAKEOUT_DIR/extracted"
mkdir -p "$EXTRACTED_DIR"

find "$GOOGLE_TAKEOUT_DIR" -maxdepth 1 -name "*.zip" -o -name "*.tgz" | while read archive; do
    echo "   Descomprimiendo: $(basename "$archive")"
    if [[ "$archive" == *.zip ]]; then
        unzip -q "$archive" -d "$EXTRACTED_DIR" 2>&1 | tee -a "$LOG_FILE"
    elif [[ "$archive" == *.tgz ]]; then
        tar -xzf "$archive" -C "$EXTRACTED_DIR" 2>&1 | tee -a "$LOG_FILE"
    fi
done

# 2. Normalizar estructura por fecha usando exiftool
echo "📅 Normalizando estructura por fecha..."
if ! command -v exiftool &> /dev/null; then
    echo "⚠️  exiftool no está instalado. Instalando..."
    sudo apt-get update && sudo apt-get install -y libimage-exiftool-perl
fi

find "$EXTRACTED_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.heic" -o -iname "*.mov" -o -iname "*.mp4" \) | while read file; do
    # Extraer fecha de EXIF
    DATE=$(exiftool -DateTimeOriginal -d "%Y/%Y-%m/%Y-%m-%d" "$file" 2>/dev/null | awk -F': ' '{print $2}' | head -1)
    
    if [ -z "$DATE" ] || [ "$DATE" == "" ]; then
        # Si no hay EXIF, usar fecha de modificación del archivo
        DATE=$(stat -c %y "$file" 2>/dev/null | cut -d' ' -f1 | sed 's/-/\//g')
    fi
    
    if [ -z "$DATE" ]; then
        # Fallback: usar fecha actual
        DATE=$(date +%Y/%Y-%m/%Y-%m-%d)
    fi
    
    # Crear estructura de carpetas
    DEST_DIR="$IMMICH_LIBRARY/$DATE"
    mkdir -p "$DEST_DIR"
    
    # Copiar archivo manteniendo nombre original
    FILENAME=$(basename "$file")
    cp "$file" "$DEST_DIR/$FILENAME"
    
    echo "   Copiado: $FILENAME → $DATE/" | tee -a "$LOG_FILE"
done

# 3. Deduplicación por hash
echo "🔍 Detectando duplicados por hash..."
if command -v fdupes &> /dev/null; then
    fdupes -rdN "$IMMICH_LIBRARY" >> "$LOG_FILE" 2>&1
    echo "   Duplicados eliminados (ver $LOG_FILE)"
else
    echo "⚠️  fdupes no está instalado. Instalando..."
    sudo apt-get install -y fdupes
    fdupes -rdN "$IMMICH_LIBRARY" >> "$LOG_FILE" 2>&1
fi

# 4. Estadísticas finales
TOTAL_FILES=$(find "$IMMICH_LIBRARY" -type f | wc -l)
TOTAL_SIZE=$(du -sh "$IMMICH_LIBRARY" | cut -f1)

echo ""
echo "✅ Migración completada!"
echo "   Archivos migrados: $TOTAL_FILES"
echo "   Tamaño total: $TOTAL_SIZE"
echo "   Log completo: $LOG_FILE"
echo ""
echo "📋 Próximos pasos:"
echo "   1. Configurar external library en Immich apuntando a: $IMMICH_LIBRARY"
echo "   2. Iniciar escaneo desde Settings → Libraries"
echo "   3. Verificar que todos los archivos se importaron correctamente"

