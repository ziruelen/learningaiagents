# Gitea Self-Hosted - Ejemplos para Homelab

Ejemplos listos para usar de Gitea, un servidor Git ligero y auto-hospedado perfecto para homelabs.

## 📦 Archivos Incluidos

- **docker-compose.yml** - Configuración con PostgreSQL (recomendado para producción)
- **docker-compose.mysql.yml** - Configuración alternativa con MySQL
- **scripts/backup-gitea.sh** - Script de backup automático
- **configs/app.ini.example** - Ejemplo de configuración avanzada
- **.gitea/workflows/build-example.yml** - Ejemplo de workflow CI/CD

## 🚀 Inicio Rápido

### 1. Con PostgreSQL (Recomendado)

```bash
# Crear archivo .env con tus contraseñas
cat > .env << EOF
POSTGRES_PASSWORD=tu_password_seguro_aqui
GITEA_DOMAIN=git.tudominio.com
EOF

# Iniciar Gitea
docker-compose up -d

# Ver logs
docker-compose logs -f gitea
```

Accede a `http://localhost:3000` para la configuración inicial.

### 2. Con MySQL

```bash
# Crear archivo .env
cat > .env << EOF
MYSQL_ROOT_PASSWORD=tu_root_password
MYSQL_PASSWORD=tu_gitea_password
GITEA_DOMAIN=git.tudominio.com
EOF

# Iniciar con MySQL
docker-compose -f docker-compose.mysql.yml up -d
```

## 📋 Configuración Inicial

1. Accede a `http://localhost:3000` (o tu dominio)
2. Completa la instalación inicial:
   - Database Type: PostgreSQL (o MySQL)
   - Database Host: `postgres:5432` (o `mysql:3306`)
   - Database Name: `gitea`
   - Database User: `gitea`
   - Database Password: (la que configuraste en .env)
3. Crea tu usuario administrador

## 🔄 Backup Automático

El script `scripts/backup-gitea.sh` realiza backups de:
- Base de datos (PostgreSQL/MySQL)
- Repositorios Git
- Configuración

**Configurar backup diario con crontab:**

```bash
# Editar crontab
crontab -e

# Añadir línea (backup a las 2 AM)
0 2 * * * /ruta/a/scripts/backup-gitea.sh >> /var/log/gitea-backup.log 2>&1
```

**Variables de entorno del script:**
- `BACKUP_DIR` - Directorio donde guardar backups (default: `/backups/gitea`)
- `GITEA_DATA` - Ruta a datos de Gitea (default: `/data/gitea`)
- `RETENTION_DAYS` - Días para mantener backups (default: 30)

## ⚙️ Configuración Avanzada

Para personalizar Gitea, edita el archivo `/data/gitea/conf/app.ini` dentro del contenedor o usa el volumen para montar un archivo personalizado:

```yaml
volumes:
  - ./configs/app.ini:/data/gitea/conf/app.ini:ro
```

Consulta `configs/app.ini.example` para opciones disponibles.

## 🔗 CI/CD con Gitea Actions

Gitea incluye soporte para GitHub Actions compatible. Ver `.gitea/workflows/build-example.yml` para un ejemplo básico.

**Configurar runner:**
1. Ve a Settings → Actions → Runners en Gitea
2. Copia el token de registro
3. Ejecuta el runner en tu servidor (ver documentación oficial)

## 📚 Recursos

- [Documentación Oficial de Gitea](https://docs.gitea.com/)
- [GitHub de Gitea](https://github.com/go-gitea/gitea)
- [Docker Hub](https://hub.docker.com/r/gitea/gitea)

## 🔒 Seguridad

- ✅ Cambia todas las contraseñas por defecto
- ✅ Usa HTTPS con reverse proxy (Traefik/Nginx)
- ✅ Habilita 2FA para usuarios administradores
- ✅ Configura firewall para exponer solo puertos necesarios
- ✅ Realiza backups regulares

## 📝 Artículo Completo

Para una guía completa paso a paso, consulta el artículo:
[Gitea Self-Hosted: Git Ligero para Homelab - Guía Completa 2025](https://www.eldiarioia.es/)

---

**Nota:** Estos ejemplos están optimizados para homelabs. Para producción, ajusta según tus necesidades de seguridad y escalabilidad.

