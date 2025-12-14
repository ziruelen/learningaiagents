# Ejemplos SCP - Transferir Archivos

## Subir Archivo

\`\`\`bash
# Archivo simple
scp archivo.txt usuario@servidor:/ruta/destino/

# Con puerto personalizado
scp -P 2222 archivo.txt usuario@servidor:/ruta/destino/

# Con clave específica
scp -i ~/.ssh/id_ed25519 archivo.txt usuario@servidor:/ruta/destino/
\`\`\`

## Descargar Archivo

\`\`\`bash
# Descargar archivo
scp usuario@servidor:/ruta/archivo.txt ./

# Descargar a ubicación específica
scp usuario@servidor:/ruta/archivo.txt /home/usuario/descargas/
\`\`\`

## Copiar Directorio

\`\`\`bash
# Copiar directorio completo (recursivo)
scp -r carpeta/ usuario@servidor:/ruta/destino/

# Preservar permisos y timestamps
scp -rp carpeta/ usuario@servidor:/ruta/destino/
\`\`\`

## Opciones Útiles

\`\`\`bash
# Mostrar progreso
scp -v archivo.txt usuario@servidor:/ruta/

# Comprimir durante transferencia
scp -C archivo.txt usuario@servidor:/ruta/

# Limitar velocidad (KB/s)
scp -l 1000 archivo.txt usuario@servidor:/ruta/
\`\`\`

## Usar con Config File

Si tienes configurado \`~/.ssh/config\`:

\`\`\`bash
# En lugar de:
scp archivo.txt usuario@servidor:/ruta/

# Puedes usar:
scp archivo.txt servidor:/ruta/
\`\`\`
