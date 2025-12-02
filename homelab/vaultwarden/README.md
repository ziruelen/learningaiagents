# 🔐 Vaultwarden - Gestor de Contraseñas Self-Hosted

Configuraciones Docker para desplegar Vaultwarden en tu homelab.

📖 **Artículo completo:** [Vaultwarden: Tu Gestor de Contraseñas Self-Hosted](https://www.eldiarioia.es/2025/12/02/vaultwarden-gestor-contrasenas-self-hosted-homelab/)

## 📁 Archivos

| Archivo | Descripción |
|---------|-------------|
| `docker-compose.yml` | Configuración básica (puertos expuestos) |
| `docker-compose-traefik.yml` | Con Traefik reverse proxy + SSL automático |
| `backup.sh` | Script de backup automatizado |
| `.env.example` | Variables de entorno de ejemplo |

## 🚀 Inicio Rápido

### 1. Clonar y configurar

```bash
git clone https://github.com/ziruelen/learningaiagents.git
cd learningaiagents/homelab/vaultwarden

# Configurar variables de entorno
cp .env.example .env
nano .env  # Editar con tus valores
```

### 2. Generar ADMIN_TOKEN

```bash
openssl rand -base64 48
```

### 3. Iniciar Vaultwarden

```bash
# Opción A: Sin reverse proxy
docker-compose up -d

# Opción B: Con Traefik
docker-compose -f docker-compose-traefik.yml up -d
```

### 4. Acceder

- **Sin proxy:** http://localhost:8080
- **Con Traefik:** https://vault.tudominio.com

## ⚙️ Configuración

### Variables de entorno importantes

| Variable | Descripción | Valor por defecto |
|----------|-------------|-------------------|
| `DOMAIN` | URL completa con HTTPS | Requerido |
| `SIGNUPS_ALLOWED` | Permitir registros públicos | `false` |
| `ADMIN_TOKEN` | Token para panel admin | Generar con openssl |
| `WEBSOCKET_ENABLED` | Notificaciones tiempo real | `true` |

### Panel de Administración

Accede a `/admin` con tu ADMIN_TOKEN para:
- Ver usuarios registrados
- Invitar usuarios
- Configurar SMTP
- Ver logs

## 💾 Backup

### Manual

```bash
./backup.sh /ruta/destino
```

### Automático (cron)

```bash
# Backup diario a las 3:00 AM
0 3 * * * /ruta/a/backup.sh >> /var/log/vaultwarden-backup.log 2>&1
```

## 🔒 Seguridad

1. **Nunca exponer sin HTTPS** - Usa Traefik o Nginx Proxy Manager
2. **Desactivar registros públicos** - `SIGNUPS_ALLOWED=false`
3. **Habilitar 2FA** - Desde Settings > Two-step Login
4. **Backups regulares** - Mínimo diario
5. **Actualizar regularmente** - `docker-compose pull && docker-compose up -d`

## 📱 Clientes

Usa los clientes oficiales de Bitwarden:
- [Extensión Chrome](https://chrome.google.com/webstore/detail/bitwarden)
- [Extensión Firefox](https://addons.mozilla.org/firefox/addon/bitwarden-password-manager/)
- [App Android](https://play.google.com/store/apps/details?id=com.x8bit.bitwarden)
- [App iOS](https://apps.apple.com/app/bitwarden-password-manager/id1137397744)

En la configuración, establece tu servidor: `https://vault.tudominio.com`

## 🆘 Troubleshooting

### WebSocket no conecta
Verifica que el puerto 3012 esté accesible y configurado en tu reverse proxy.

### Error "Unauthorized"
1. Verifica que `DOMAIN` coincida exactamente con tu URL
2. Cierra sesión y vuelve a iniciar

### Container reinicia
```bash
sudo chown -R 1000:1000 ./vw-data
```

---

**Más guías en:** [ElDiarioIA.es](https://www.eldiarioia.es)

