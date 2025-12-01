# 🛡️ Pi-hole: Bloqueador de Anuncios DNS para Homelab

Configuración completa de Pi-hole con Docker, incluyendo integración con Unbound para DNS recursivo privado.

**📖 Guía completa:** https://www.eldiarioia.es/pi-hole-bloqueador-dns-homelab

---

## 📁 Estructura

```
pi-hole/
├── docker-compose.yml          # Configuración básica
├── docker-compose-unbound.yml  # Con Unbound (DNS recursivo)
├── configs/
│   └── unbound.conf           # Configuración de Unbound
├── scripts/
│   ├── install.sh             # Instalación automática
│   └── backup.sh              # Backup automático
└── README.md
```

---

## 🚀 Instalación Rápida

### Opción 1: Solo Pi-hole (básico)

```bash
# Clonar repositorio
git clone https://github.com/ziruelen/learningaiagents.git
cd learningaiagents/homelab/pi-hole

# Crear directorios
mkdir -p etc-pihole etc-dnsmasq.d

# Editar password en docker-compose.yml
nano docker-compose.yml

# Iniciar
docker compose up -d
```

### Opción 2: Pi-hole + Unbound (máxima privacidad)

```bash
# Crear directorios
mkdir -p etc-pihole etc-dnsmasq.d unbound

# Copiar configuración de Unbound
cp configs/unbound.conf unbound/

# Descargar root hints
wget https://www.internic.net/domain/named.root -O unbound/root.hints

# Iniciar
docker compose -f docker-compose-unbound.yml up -d
```

---

## 🔧 Configuración del Router

Para que todos los dispositivos usen Pi-hole:

1. Accede a la configuración de tu router
2. Busca la sección DHCP/DNS
3. Cambia el servidor DNS primario a la IP de Pi-hole
4. Reinicia el router

---

## 📊 Panel de Administración

- **URL:** `http://TU_IP/admin`
- **Password:** El que configuraste en docker-compose.yml

---

## 📋 Comandos Útiles

```bash
# Ver estado
docker exec pihole pihole status

# Actualizar Pi-hole
docker exec pihole pihole -up

# Actualizar listas de bloqueo
docker exec pihole pihole -g

# Ver logs en tiempo real
docker exec pihole pihole -t

# Desactivar temporalmente (5 minutos)
docker exec pihole pihole disable 5m
```

---

## 📦 Listas de Bloqueo Recomendadas

Añade estas URLs en **Group Management > Adlists**:

```
# OISD - Lista unificada
https://big.oisd.nl/

# Hagezi Pro
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/pro.txt

# 1Hosts Lite
https://o0.pages.dev/Lite/domains.txt
```

---

## 💾 Backup

```bash
# Ejecutar script de backup
./scripts/backup.sh

# O manualmente desde el panel
# Settings > Teleporter > Export
```

---

## 🔗 Enlaces

- [Documentación oficial Pi-hole](https://docs.pi-hole.net/)
- [GitHub Pi-hole Docker](https://github.com/pi-hole/docker-pi-hole)
- [Guía Unbound](https://docs.pi-hole.net/guides/dns/unbound/)
- [Comunidad Discord ElDiarioIA](https://discord.gg/HZXBmUyNCG)

---

**Creado para [ElDiarioIA](https://www.eldiarioia.es) - El blog donde la IA y el humano aprenden juntos**


