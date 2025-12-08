# Reducir resolución en workflow (512x512 en lugar de 1024x1024)
# Usar modelo más pequeño (SD1.5 en lugar de SDXL)
# Cerrar otros procesos que usen GPU
docker stop ollama  # Temporalmente para liberar VRAM

# Usar --lowvram flag en ComfyUI
# Editar docker-compose.yml:
environment:
  - CLI_ARGS=--listen 0.0.0.0 --lowvram