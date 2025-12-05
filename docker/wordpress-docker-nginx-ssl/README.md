# WordPress en Docker con Nginx y SSL

Stack completo para instalar WordPress en Docker con Nginx como reverse proxy y certificados SSL automáticos con Let's Encrypt.

## 🚀 Inicio Rápido

### 1. Clonar o copiar este directorio

```bash
cd /ruta/a/tu/proyecto
```

### 2. Configurar variables de entorno

```bash
cp .env.example .env
nano .env  # Editar con tus valores
```

**IMPORTANTE:** Cambia los passwords por defecto antes de iniciar.

### 3. Configurar dominio en Nginx

Edita `nginx/wordpress.conf` y reemplaza `${DOMAIN}` por tu dominio real, o usa un script de reemplazo:

```bash
sed -i "s/\${DOMAIN}/tudominio.com/g" nginx/wordpress.conf
```

### 4. Iniciar el stack

```bash
docker compose up -d
```

### 5. Obtener certificado SSL

```bash
docker compose exec certbot certbot certonly \
    --webroot \
    --webroot-path=/var/www/certbot \
    --email ${LETSENCRYPT_EMAIL} \
    --agree-tos \
    --no-eff-email \
    -d ${DOMAIN} \
    -d www.${DOMAIN}
```

### 6. Reiniciar Nginx

```bash
docker compose restart nginx
```

### 7. Acceder a WordPress

Abre tu navegador en `https://tudominio.com` y completa la instalación de WordPress.

## 📁 Estructura del Proyecto

```
wordpress-docker-nginx-ssl/
├── docker-compose.yml      # Stack completo
├── .env.example            # Template de variables
├── uploads.ini             # Configuración PHP
├── nginx/
│   ├── nginx.conf          # Configuración principal Nginx
│   └── wordpress.conf      # Configuración WordPress + SSL
└── scripts/
    ├── backup.sh           # Script de backup
    └── restore.sh          # Script de restauración
```

## 🔧 Configuración

### Variables de Entorno (.env)

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `DB_NAME` | Nombre de la base de datos | `wordpress` |
| `DB_USER` | Usuario MySQL | `wp_user` |
| `DB_PASSWORD` | Password MySQL | `Password_Seguro_123!` |
| `MYSQL_ROOT_PASSWORD` | Password root MySQL | `Root_Password_456!` |
| `DOMAIN` | Tu dominio | `tudominio.com` |
| `EMAIL` | Email para Let's Encrypt | `admin@tudominio.com` |

### Puertos

- **80:** HTTP (redirige a HTTPS)
- **443:** HTTPS (WordPress con SSL)

### Volúmenes

- `wp_data`: Archivos WordPress (themes, plugins, uploads)
- `db_data`: Base de datos MySQL
- `certbot_data`: Certificados SSL
- `certbot_www`: Archivos de validación Let's Encrypt

## 💾 Backups

### Backup Manual

```bash
chmod +x scripts/backup.sh
./scripts/backup.sh
```

Los backups se guardan en `/backups/wordpress/` (configurable en `.env`).

### Restaurar desde Backup

```bash
chmod +x scripts/restore.sh
./scripts/restore.sh /backups/wordpress/wordpress_backup_20251205_120000.tar.gz
```

### Backup Automático (Cron)

Añade a tu crontab:

```bash
0 2 * * * cd /ruta/a/proyecto && ./scripts/backup.sh >> /var/log/wordpress_backup.log 2>&1
```

## 🔒 Seguridad

### Cambiar Passwords

**NUNCA** uses los passwords por defecto. Edita `.env` antes de iniciar:

```bash
# Generar password seguro
openssl rand -base64 32
```

### Firewall

Bloquea todos los puertos excepto 80 y 443:

```bash
# UFW (Ubuntu/Debian)
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable
```

### Actualizar Contenedores

```bash
docker compose pull
docker compose up -d
```

## 🐛 Troubleshooting

### Error: "Error establishing database connection"

1. Verifica que MySQL está corriendo: `docker ps | grep db`
2. Verifica variables de entorno: `docker exec wordpress env | grep WORDPRESS_DB`
3. Revisa logs: `docker logs wordpress_db`

### SSL no funciona

1. Verifica DNS: `dig tudominio.com`
2. Verifica puerto 80 accesible desde internet
3. Revisa logs: `docker logs wordpress_certbot`
4. Renovar manualmente: `docker compose exec certbot certbot renew --force-renewal`

### WordPress muy lento

1. Instala plugin de caché (WP Super Cache, W3 Total Cache)
2. Aumenta memoria PHP en `uploads.ini`
3. Aumenta recursos Docker: `docker update --memory=2g wordpress`

## 📚 Recursos

- [Artículo completo en El Diario IA](https://www.eldiarioia.es/)
- [Documentación Docker Compose](https://docs.docker.com/compose/)
- [Documentación Nginx](https://nginx.org/en/docs/)
- [Let's Encrypt](https://letsencrypt.org/)

## 📝 Licencia

Este proyecto es de código abierto. Úsalo libremente en tus proyectos.

## 🤝 Contribuciones

Si encuentras errores o mejoras, abre un issue o pull request en el repositorio.

---

**¿Problemas?** Revisa la sección de Troubleshooting o abre un issue en GitHub.

