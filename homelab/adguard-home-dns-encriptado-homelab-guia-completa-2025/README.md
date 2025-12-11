# AdGuard Home - DNS Encriptado para Homelab

Ejemplos de configuración para desplegar AdGuard Home en Docker con DNS encriptado (DoH/DoT/DoQ).

## 📋 Contenido

- `docker-compose.yml` - Configuración básica de AdGuard Home
- `docker-compose.advanced.yml` - Configuración avanzada con healthchecks
- `setup.sh` - Script de instalación automatizada
- `config/upstream-dns-encrypted.yaml` - Configuración de DNS encriptado
- `config/filtering-rules.txt` - Ejemplos de reglas de filtrado personalizadas
- `config/blocklists-recommended.txt` - Lista de blocklists recomendadas

## 🚀 Instalación Rápida

```bash
# 1. Clonar o descargar estos archivos
cd ~/docker/adguard

# 2. Crear directorios necesarios
mkdir -p work conf

# 3. Copiar docker-compose.yml
cp docker-compose.yml .

# 4. Iniciar AdGuard Home
docker compose up -d

# 5. Acceder a la interfaz web
# http://TU_IP:3000
```

## ⚙️ Configuración

### DNS Encriptado (DoH/DoT/DoQ)

1. Accede a Settings → Encryption Settings
2. Habilita "Encryption"
3. Configura certificado SSL (Let's Encrypt recomendado)
4. Configura puertos:
   - DoH: 443
   - DoT: 853
   - DoQ: 784

### Upstream DNS

Edita `config/upstream-dns-encrypted.yaml` y añade la configuración en AdGuardHome.yaml:

```yaml
dns:
  upstream_dns:
    - https://dns.cloudflare.com/dns-query
    - tls://one.one.one.one
```

### Blocklists

Añade las blocklists de `config/blocklists-recommended.txt` en:
- Filters → DNS blocklists → Add blocklist

### Reglas Personalizadas

Añade reglas de `config/filtering-rules.txt` en:
- Filters → Custom filtering rules

## 🔧 Uso

### Configurar Router

Configura tu router para usar la IP de AdGuard Home como DNS:
- DNS primario: `192.168.1.10` (IP de tu servidor)
- DNS secundario: `1.1.1.1` (fallback)

### Verificar Funcionamiento

```bash
# Verificar que AdGuard Home responde
nslookup example.org 192.168.1.10

# Verificar DNS encriptado (DoH)
curl -H "accept: application/dns-json" \
  "https://TU_DOMINIO/dns-query?name=example.org&type=A"
```

## 📚 Documentación

- [Artículo completo](https://www.eldiarioia.es/2025/12/11/adguard-home-dns-encriptado-homelab-guia-completa-2025/)
- [Documentación oficial AdGuard Home](https://github.com/AdguardTeam/AdGuardHome)
- [Guía de DNS encriptado](https://adguard-dns.io/kb/general/dns-providers/)

## 🔒 Seguridad

- Cambia las credenciales por defecto
- Configura HTTPS obligatorio
- Usa certificados SSL válidos (Let's Encrypt)
- Limita acceso a la interfaz web (firewall)

## 🐛 Troubleshooting

### Dispositivos no usan AdGuard Home

Verifica que el router esté configurado con la IP correcta:
```bash
nslookup example.org
# Debe mostrar la IP de AdGuard Home
```

### DNS lento

Optimiza upstreams y cache:
```yaml
dns:
  all_servers: true
  fastest_addr: true
  cache_size: 4194304
```

## 📝 Licencia

Estos ejemplos son de dominio público. Úsalos libremente en tu homelab.
