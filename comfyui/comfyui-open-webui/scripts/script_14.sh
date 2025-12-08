# Verificar que ComfyUI está corriendo
docker ps | grep comfyui

# Verificar que el puerto 8188 está expuesto
docker port comfyui

# Ver logs
docker logs comfyui

# Reiniciar si es necesario
docker restart comfyui