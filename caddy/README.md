# Caddy Reverse Proxy - Ejemplos para Homelab

Ejemplos prácticos de configuración de Caddy como reverse proxy con SSL automático para homelabs.

## 📋 Contenido

- `docker-compose.yml`: Stack completo con Caddy + servicios de ejemplo
- `Caddyfile`: Configuración básica con 3 servicios
- `Caddyfile.advanced`: Configuración avanzada con autenticación y load balancing
- `Caddyfile.authelia`: Integración con Authelia para SSO

## 🚀 Inicio Rápido

### 1. Configuración Básica

```bash
# Clonar o descargar este repositorio
cd caddy

# Editar Caddyfile con tus dominios
nano Caddyfile

# Iniciar servicios
docker-compose up -d
```

### 2. Configurar DNS

Asegúrate de que tus dominios apunten a la IP de tu servidor:

```
portainer.example.com  →  TU_IP_PUBLICA
n8n.example.com        →  TU_IP_PUBLICA
grafana.example.com    →  TU_IP_PUBLICA
```

### 3. Verificar

Accede a tus servicios:
- https://portainer.example.com
- https://n8n.example.com
- https://grafana.example.com

Caddy obtendrá automáticamente los certificados SSL de Let's Encrypt.

## 📝 Configuraciones

### Caddyfile Básico

Configuración simple con 3 servicios (Portainer, n8n, Grafana).

**Características:**
- SSL automático con Let's Encrypt
- Compresión gzip
- Headers de seguridad básicos
- Logging en JSON

### Caddyfile Avanzado

Configuración con características avanzadas:

**Características:**
- Autenticación básica
- Load balancing
- Wildcard subdomains
- Headers de seguridad completos
- Compresión gzip + zstd

### Caddyfile con Authelia

Integración con Authelia para SSO (Single Sign-On).

**Requisitos:**
- Authelia corriendo en `authelia:9091`
- Configuración de Authelia completa

**Características:**
- Forward auth con Authelia
- Múltiples servicios protegidos
- Headers de usuario copiados

## 🔧 Personalización

### Cambiar Dominios

Edita el `Caddyfile` y reemplaza `example.com` con tu dominio:

```caddyfile
portainer.tudominio.com {
    reverse_proxy portainer:9000
}
```

### Añadir Nuevos Servicios

Añade un nuevo bloque en el `Caddyfile`:

```caddyfile
nuevo-servicio.example.com {
    reverse_proxy nuevo-servicio:8080
    encode gzip
}
```

### Generar Hash de Contraseña (Basic Auth)

```bash
docker run --rm caddy:latest caddy hash-password
# Introduce tu contraseña cuando se solicite
```

Copia el hash generado al `Caddyfile.advanced`.

## 🐛 Troubleshooting

### Certificados SSL no se obtienen

1. Verifica que el dominio apunta a tu IP:
   ```bash
   dig portainer.example.com
   ```

2. Verifica que los puertos 80 y 443 están abiertos:
   ```bash
   sudo ufw allow 80/tcp
   sudo ufw allow 443/tcp
   ```

3. Revisa los logs de Caddy:
   ```bash
   docker logs caddy
   ```

### Error: Connection refused

1. Verifica que los servicios están corriendo:
   ```bash
   docker ps
   ```

2. Verifica que están en la misma red Docker:
   ```bash
   docker network inspect caddy_homelab
   ```

3. Usa el nombre del contenedor, no `localhost`:
   ```caddyfile
   # ❌ Incorrecto
   reverse_proxy localhost:8080
   
   # ✅ Correcto
   reverse_proxy servicio:8080
   ```

## 📚 Recursos

- [Documentación oficial de Caddy](https://caddyserver.com/docs/)
- [Caddyfile Syntax](https://caddyserver.com/docs/caddyfile)
- [Caddy Community Forum](https://caddy.community/)

## 📄 Licencia

Estos ejemplos son de dominio público. Úsalos libremente en tus proyectos.

---

**Artículo relacionado:** [Caddy Reverse Proxy: SSL Automático y Configuración Simple para Homelab 2025](https://www.eldiarioia.es)

