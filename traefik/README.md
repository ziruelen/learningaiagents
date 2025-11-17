# Traefik Reverse Proxy - Ejemplos para Homelab

Ejemplos prácticos y configuración completa de Traefik como reverse proxy para homelab.

## 📋 Requisitos Previos

- Docker y Docker Compose instalados
- Dominio con acceso a DNS (para SSL)
- Puertos 80 y 443 disponibles
- Conocimientos básicos de línea de comandos

## 🚀 Inicio Rápido

### 1. Crear Red Docker

```bash
docker network create traefik-net
```

### 2. Configurar Variables de Entorno

Crea un archivo `.env` con tus valores:

```bash
DOMAIN=tu-dominio.com
EMAIL=tu-email@dominio.com
CLOUDFLARE_EMAIL=tu-email@dominio.com
CLOUDFLARE_API_KEY=tu-api-key-de-cloudflare
```

### 3. Iniciar Traefik

```bash
docker-compose -f docker-compose.traefik.yml up -d
```

### 4. Verificar Funcionamiento

```bash
docker logs traefik
```

Accede al dashboard en: `https://traefik.tu-dominio.com`

## 📁 Estructura de Archivos

- `docker-compose.traefik.yml` - Configuración básica de Traefik
- `traefik.yml` - Configuración estática de Traefik
- `dynamic.yml` - Configuración dinámica (opcional)
- `docker-compose.portainer.yml` - Ejemplo: Portainer
- `docker-compose.nextcloud.yml` - Ejemplo: Nextcloud
- `docker-compose.authelia.yml` - Ejemplo: Authelia + Traefik
- `docker-compose.completo.yml` - Stack completo
- `scripts/` - Scripts de utilidad

## 🔧 Configuración

### DNS

Configura los siguientes registros DNS en tu proveedor:

```
A     @              → IP_PUBLICA
A     traefik        → IP_PUBLICA
A     portainer      → IP_PUBLICA
A     nextcloud      → IP_PUBLICA
A     auth           → IP_PUBLICA
```

### SSL

Traefik obtendrá automáticamente certificados SSL de Let's Encrypt usando HTTP Challenge. Para certificados wildcard, configura DNS Challenge con Cloudflare (ver `traefik.yml`).

## 📚 Ejemplos

### Ejemplo 1: Portainer

```bash
docker-compose -f docker-compose.portainer.yml up -d
```

Accede en: `https://portainer.tu-dominio.com`

### Ejemplo 2: Nextcloud

```bash
docker-compose -f docker-compose.nextcloud.yml up -d
```

Accede en: `https://nextcloud.tu-dominio.com`

### Ejemplo 3: Authelia + Traefik

```bash
docker-compose -f docker-compose.authelia.yml up -d
```

Accede en: `https://auth.tu-dominio.com`

### Stack Completo

```bash
docker-compose -f docker-compose.completo.yml up -d
```

## 🛠️ Scripts

### setup.sh

Script de instalación automática:

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### generate-password.sh

Genera contraseñas encriptadas para BasicAuth:

```bash
chmod +x scripts/generate-password.sh
./scripts/generate-password.sh usuario contraseña
```

### backup-certificates.sh

Hace backup de los certificados SSL:

```bash
chmod +x scripts/backup-certificates.sh
./scripts/backup-certificates.sh
```

## 🔒 Seguridad

- **Nunca expongas el dashboard sin autenticación**
- **Usa `exposedByDefault: false`** en la configuración
- **Protege acme.json** con permisos 600: `chmod 600 acme.json`
- **Mantén Traefik actualizado** regularmente

## 📖 Documentación

Para más información, consulta el artículo completo:

**Traefik Reverse Proxy: Guía Completa para Homelab 2025**
https://www.eldiarioia.es/2025/11/17/traefik-reverse-proxy-homelab-guia-completa-2025/

## 🐛 Troubleshooting

### Error: "No valid certificate found"

1. Verifica que el puerto 80 está accesible desde internet
2. Verifica DNS: `dig tu-dominio.com`
3. Revisa logs: `docker logs traefik | grep acme`

### Error: "Service not found"

Verifica que el servicio está en la misma red:

```yaml
networks:
  - traefik-net

networks:
  traefik-net:
    external: true
```

### Dashboard no accesible

Verifica que el dashboard está habilitado en `traefik.yml`:

```yaml
api:
  dashboard: true
  insecure: false
```

## 📝 Licencia

Estos ejemplos son de código abierto y están disponibles para uso personal y educativo.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor, abre un issue o pull request.

