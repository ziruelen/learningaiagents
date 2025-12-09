# Nextcloud - Tu Nube Privada Self-Hosted

Ejemplos de código y configuraciones del artículo publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

## 📋 Descripción

Este repositorio contiene configuraciones Docker Compose listas para usar para desplegar Nextcloud con todas sus características principales:

- ✅ Nextcloud con MariaDB y Redis
- ✅ Integración con OnlyOffice (edición colaborativa)
- ✅ Integración con Collabora Online (alternativa a OnlyOffice)
- ✅ Script de backup automático
- ✅ Configuración de seguridad optimizada

## 📁 Estructura

```
nextcloud/
├── docker-compose.yml              # Stack básico (Nextcloud + MariaDB + Redis)
├── docker-compose.onlyoffice.yml   # Extensión con OnlyOffice
├── docker-compose.collabora.yml    # Extensión con Collabora
├── backup.sh                       # Script de backup automático
├── env.example                     # Template de variables de entorno
└── README.md                       # Este archivo
```

## 🚀 Uso Rápido

### 1. Preparación

```bash
# Clonar o descargar este repositorio
cd /ruta/a/nextcloud

# Copiar y editar variables de entorno
cp env.example .env
nano .env  # Editar valores según tu entorno
```

### 2. Instalación Básica

```bash
# Levantar stack básico
docker compose up -d

# Ver logs
docker compose logs -f
```

Accede a Nextcloud en `http://localhost:8080` y completa la configuración inicial.

### 3. Instalación con OnlyOffice (Opcional)

```bash
# Levantar stack con OnlyOffice
docker compose -f docker-compose.yml -f docker-compose.onlyoffice.yml up -d
```

Luego configura OnlyOffice en Nextcloud:
1. Ve a Apps → Instala "OnlyOffice"
2. Configura → OnlyOffice
3. URL del servidor: `http://onlyoffice:80`
4. JWT Secret: (el mismo que en `.env`)

### 4. Instalación con Collabora (Alternativa a OnlyOffice)

```bash
# Levantar stack con Collabora
docker compose -f docker-compose.yml -f docker-compose.collabora.yml up -d
```

Luego configura Collabora en Nextcloud:
1. Ve a Apps → Instala "Collabora Online"
2. Configura → Collabora Online
3. URL del servidor: `http://collabora:9980`

### 5. Configurar Backup Automático

```bash
# Hacer ejecutable el script
chmod +x backup.sh

# Editar variables en backup.sh o usar variables de entorno
export DB_PASSWORD="tu_password"
export BACKUP_DIR="/backups/nextcloud"

# Ejecutar backup manualmente
./backup.sh

# O configurar cron para backup diario a las 2am
crontab -e
# Añadir: 0 2 * * * /ruta/a/backup.sh
```

## 🔧 Configuración Avanzada

### Variables de Entorno Importantes

- `MYSQL_ROOT_PASSWORD`: Password del usuario root de MariaDB
- `MYSQL_PASSWORD`: Password del usuario nextcloud de MariaDB
- `REDIS_PASSWORD`: Password de Redis
- `NEXTCLOUD_DOMAIN`: Dominio donde accederás a Nextcloud
- `NEXTCLOUD_IP`: IP del servidor (para acceso directo)
- `ONLYOFFICE_JWT_SECRET`: Secret para JWT de OnlyOffice (mínimo 32 caracteres)
- `COLLABORA_PASSWORD`: Password de administrador de Collabora

### Configuración de Redis en Nextcloud

Después de la instalación inicial, configura Redis en `config.php`:

```php
'memcache.local' => '\OC\Memcache\Redis',
'memcache.locking' => '\OC\Memcache\Redis',
'redis' => array(
    'host' => 'redis',
    'port' => 6379,
    'password' => 'tu_redis_password',
    'timeout' => 0.0,
),
```

### Configuración de HTTPS

Para producción, usa un reverse proxy (Nginx, Traefik, Caddy) con Let's Encrypt:

- **Nginx Proxy Manager**: [Guía completa](https://www.eldiarioia.es/2025/11/06/nginx-proxy-manager-reverse-proxy-ssl-gui/)
- **Traefik**: [Guía completa](https://www.eldiarioia.es/2025/11/17/traefik-reverse-proxy-guia-completa-homelab-2025/)

## 🔒 Seguridad

1. **Cambia todas las contraseñas** en `.env`
2. **Habilita HTTPS** con reverse proxy
3. **Configura 2FA** en Nextcloud (Settings → Security)
4. **Configura firewall** para solo exponer puertos necesarios
5. **Haz backups regulares** con el script incluido

## 📖 Artículo Completo

Para una guía detallada paso a paso, configuración avanzada, troubleshooting y mejores prácticas, consulta el artículo completo:

**[Nextcloud: Tu Nube Privada Self-Hosted (Guía Completa 2025)](https://www.eldiarioia.es)**

## 🐛 Troubleshooting

### Error: "Database connection failed"
- Verifica que el contenedor de DB esté corriendo: `docker ps`
- Verifica variables de entorno en `.env`
- Revisa logs: `docker logs nextcloud-db`

### Error: "Trusted domain error"
- Añade tu dominio/IP a `NEXTCLOUD_TRUSTED_DOMAINS` en `.env`
- O edita `config.php` directamente

### Error: "Redis connection failed"
- Verifica que Redis esté corriendo: `docker ps | grep redis`
- Verifica password de Redis en `config.php`

## 📚 Recursos Adicionales

- [Documentación oficial de Nextcloud](https://docs.nextcloud.com/)
- [Foro de la comunidad](https://help.nextcloud.com/)
- [Apps disponibles](https://apps.nextcloud.com/)

## 📝 Licencia

Estos ejemplos son de código abierto y están disponibles para uso libre. Nextcloud es licenciado bajo AGPLv3.

## 🤝 Contribuciones

Si encuentras errores o mejoras, por favor abre un issue o pull request en el repositorio.

---

**Creado para [ElDiarioIA.es](https://www.eldiarioia.es)** - El blog donde la IA y el humano aprenden juntos

