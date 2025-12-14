# Ejemplos RSYNC - Sincronizar Archivos

## Sincronización Básica

\`\`\`bash
# Sincronizar directorio
rsync -avz carpeta/ usuario@servidor:/ruta/destino/

# Flags explicados:
# -a: archive mode (preserva permisos, timestamps, etc.)
# -v: verbose (muestra progreso)
# -z: compresión durante transferencia
\`\`\`

## Excluir Archivos

\`\`\`bash
# Excluir archivos específicos
rsync -avz --exclude '*.log' --exclude '*.tmp' carpeta/ usuario@servidor:/ruta/

# Excluir directorios
rsync -avz --exclude 'node_modules' --exclude '.git' carpeta/ usuario@servidor:/ruta/

# Usar archivo de exclusiones
rsync -avz --exclude-from='exclude.txt' carpeta/ usuario@servidor:/ruta/
\`\`\`

## Sincronización con Eliminación

\`\`\`bash
# Eliminar archivos que no existen en origen
rsync -avz --delete carpeta/ usuario@servidor:/ruta/

# Dry-run primero (ver qué se haría sin hacerlo)
rsync -avz --delete --dry-run carpeta/ usuario@servidor:/ruta/
\`\`\`

## Progreso y Límites

\`\`\`bash
# Mostrar progreso detallado
rsync -avz --progress carpeta/ usuario@servidor:/ruta/

# Limitar ancho de banda (KB/s)
rsync -avz --bwlimit=1000 carpeta/ usuario@servidor:/ruta/

# Mostrar estadísticas al final
rsync -avz --stats carpeta/ usuario@servidor:/ruta/
\`\`\`

## Casos de Uso

### Backup Incremental

\`\`\`bash
rsync -avz --delete \
  --exclude '*.log' \
  --exclude '*.tmp' \
  /ruta/local/ usuario@servidor:/backup/
\`\`\`

### Despliegue de Aplicación

\`\`\`bash
rsync -avz --exclude 'node_modules' \
  --exclude '.git' \
  ./dist/ usuario@servidor:/var/www/app/
\`\`\`

### Sincronización Bidireccional

\`\`\`bash
# Primero: local -> remoto
rsync -avz carpeta/ usuario@servidor:/ruta/

# Luego: remoto -> local (solo cambios)
rsync -avz usuario@servidor:/ruta/ carpeta/
\`\`\`
