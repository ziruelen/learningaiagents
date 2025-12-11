# Configuración Recomendada de Shares en Unraid

## Shares Esenciales

### appdata
- **Propósito**: Datos de aplicaciones Docker
- **Cache setting**: Prefer
- **Descripción**: Contenedores Docker se ejecutan desde cache para mejor rendimiento

### domains
- **Propósito**: Máquinas virtuales (VMs)
- **Cache setting**: Prefer
- **Descripción**: VMs se ejecutan desde cache para mejor rendimiento

### isos
- **Propósito**: Imágenes ISO para VMs
- **Cache setting**: No
- **Descripción**: No necesita velocidad, se escribe directamente al array

### media
- **Propósito**: Contenido multimedia (películas, series, música)
- **Cache setting**: Yes
- **Descripción**: Escribe rápido al cache, luego mueve al array durante la noche

### downloads
- **Propósito**: Descargas temporales
- **Cache setting**: Yes
- **Descripción**: Escribe rápido al cache, luego mueve al array

### backups
- **Propósito**: Backups del sistema
- **Cache setting**: No
- **Descripción**: No necesita velocidad, se escribe directamente al array

## Configuración de Permisos

### Usuario por defecto
- **Usuario**: nobody
- **Grupo**: users
- **Permisos**: 755 (directorios), 644 (archivos)

### Para compartir con SMB
- Habilitar SMB en Settings → SMB
- Configurar usuarios en Settings → Users
- Asignar permisos por share

## Mejores Prácticas

1. **appdata y domains siempre en cache**: Mejor rendimiento
2. **media con cache Yes**: Velocidad de escritura, luego se mueve
3. **isos y backups sin cache**: No necesitan velocidad
4. **Monitorear espacio en cache**: Evitar llenar cache completamente
5. **Programar Mover**: Ejecutar durante horas de bajo uso (3:40 AM por defecto)
