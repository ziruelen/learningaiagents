# Verificar permisos
docker exec -it gitlab chown -R git:git /var/opt/gitlab/backups

# Verificar espacio
df -h