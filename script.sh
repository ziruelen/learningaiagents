# 1. Backup ANTES de actualizar (CRÍTICO)
docker exec nginx-proxy-manager cp /data/database.sqlite /data/backup-pre-update.sqlite

# 2. Pull imagen actualizada
docker pull jc21/nginx-proxy-manager:latest

# 3. Recrear contenedor
docker-compose up -d

# 4. Verificar funciona correctamente
docker logs nginx-proxy-manager

# 5. Si algo sale mal, rollback:
docker cp nginx-proxy-manager:/data/backup-pre-update.sqlite /data/database.sqlite
docker restart nginx-proxy-manager