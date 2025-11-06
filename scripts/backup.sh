#!/bin/bash
# backup-npm.sh

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/backups/npm"

# Crear backup del contenedor
docker exec nginx-proxy-manager cp /data/database.sqlite /data/backup-$DATE.sqlite

# Copiar archivos al host
docker cp nginx-proxy-manager:/data/backup-$DATE.sqlite $BACKUP_DIR/
tar czf $BACKUP_DIR/npm-full-backup-$DATE.tar.gz data/ letsencrypt/

# Subir a cloud (ejemplo: rclone)
rclone copy $BACKUP_DIR/ gdrive:backups/npm/

# Retener solo últimos 30 días
find $BACKUP_DIR -name "*.tar.gz" -mtime +30 -delete

echo "✅ Backup completado: npm-full-backup-$DATE.tar.gz"