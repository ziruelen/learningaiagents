#!/bin/bash
# backup_vikunja.sh - Script de backup automático para Vikunja

BACKUP_DIR="${BACKUP_DIR:-/backups/vikunja}"
DATE=$(date +%Y%m%d_%H%M%S)
CONTAINER_DB="${CONTAINER_DB:-vikunja-db}"
CONTAINER_API="${CONTAINER_API:-vikunja-api}"

# Crear directorio de backup
mkdir -p "$BACKUP_DIR/$DATE"

echo "🔄 Iniciando backup de Vikunja..."

# Backup de base de datos
if docker ps | grep -q "$CONTAINER_DB"; then
    echo "📦 Haciendo backup de la base de datos..."
    docker exec $CONTAINER_DB pg_dump -U vikunja vikunja > "$BACKUP_DIR/$DATE/database.sql" 2>/dev/null || \
    docker exec $CONTAINER_DB mysqldump -u vikunja -p${DB_PASSWORD} vikunja > "$BACKUP_DIR/$DATE/database.sql" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "  ✅ Base de datos respaldada"
    else
        echo "  ❌ Error al respaldar base de datos"
        exit 1
    fi
else
    echo "  ⚠️ Contenedor $CONTAINER_DB no encontrado"
fi

# Backup de archivos adjuntos (si existen)
if docker ps | grep -q "$CONTAINER_API"; then
    if docker exec $CONTAINER_API ls /app/vikunja/files 2>/dev/null | grep -q .; then
        echo "📎 Haciendo backup de archivos adjuntos..."
        docker cp $CONTAINER_API:/app/vikunja/files "$BACKUP_DIR/$DATE/" 2>/dev/null
        echo "  ✅ Archivos respaldados"
    fi
fi

# Comprimir backup
echo "🗜️ Comprimiendo backup..."
tar -czf "$BACKUP_DIR/vikunja_$DATE.tar.gz" -C "$BACKUP_DIR" "$DATE" 2>/dev/null
rm -rf "$BACKUP_DIR/$DATE"

if [ -f "$BACKUP_DIR/vikunja_$DATE.tar.gz" ]; then
    SIZE=$(du -h "$BACKUP_DIR/vikunja_$DATE.tar.gz" | cut -f1)
    echo "✅ Backup completado: vikunja_$DATE.tar.gz ($SIZE)"
    
    # Eliminar backups antiguos (más de 30 días)
    echo "🧹 Eliminando backups antiguos (>30 días)..."
    find "$BACKUP_DIR" -name "vikunja_*.tar.gz" -mtime +30 -delete 2>/dev/null
    echo "✅ Backup finalizado"
else
    echo "❌ Error al comprimir backup"
    exit 1
fi
