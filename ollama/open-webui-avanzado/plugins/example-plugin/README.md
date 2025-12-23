# Example Plugin para Open WebUI

Plugin de ejemplo que demuestra cómo crear plugins personalizados para Open WebUI.

## Instalación

1. Copia esta carpeta a `/app/backend/data/plugins/example-plugin/`
2. Reinicia el contenedor: `docker-compose restart open-webui`

## Comandos

- `/help` - Muestra ayuda
- `/time` - Muestra la hora actual
- `/echo <texto>` - Repite el texto

## Desarrollo

Edita `plugin.py` para personalizar el comportamiento del plugin.

