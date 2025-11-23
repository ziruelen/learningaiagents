#!/bin/bash
# Script de backup para GitLab
# Uso: ./backup.sh

GITLAB_CONTAINER="gitlab"
BACKUP_DIR="/var/opt/gitlab/backups"
LOCAL_BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "🔄 Iniciando backup de GitLab..."

# Crear directorio de backups local si no existe
mkdir -p "$LOCAL_BACKUP_DIR"

# Ejecutar backup en GitLab
docker exec -t "$GITLAB_CONTAINER" gitlab-backup create

# Copiar backup al directorio local
LATEST_BACKUP=$(docker exec "$GITLAB_CONTAINER" ls -t "$BACKUP_DIR" | head -1)
docker cp "$GITLAB_CONTAINER:$BACKUP_DIR/$LATEST_BACKUP" "$LOCAL_BACKUP_DIR/"

# Comprimir backup
tar -czf "$LOCAL_BACKUP_DIR/gitlab_backup_$TIMESTAMP.tar.gz" -C "$LOCAL_BACKUP_DIR" "$LATEST_BACKUP"

# Eliminar backup sin comprimir
rm "$LOCAL_BACKUP_DIR/$LATEST_BACKUP"

echo "✅ Backup completado: $LOCAL_BACKUP_DIR/gitlab_backup_$TIMESTAMP.tar.gz"

# Opcional: Eliminar backups antiguos (más de 7 días)
find "$LOCAL_BACKUP_DIR" -name "gitlab_backup_*.tar.gz" -mtime +7 -delete

echo "🧹 Backups antiguos eliminados"

