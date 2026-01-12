# WireGuard Manual - Ejemplos de Configuración

Ejemplos prácticos para configurar WireGuard manualmente en tu homelab.

## 📁 Estructura

```
wireguard-manual/
├── docker-compose.yml          # Servidor WireGuard en Docker
├── configs/
│   ├── wg0-server.conf         # Configuración del servidor (template)
│   └── wg0-client.conf         # Configuración del cliente (template)
├── scripts/
│   ├── generar_claves.sh       # Generar claves para un peer
│   ├── add_peer.sh             # Añadir nuevo peer al servidor
│   └── remove_peer.sh          # Eliminar peer del servidor
└── README.md                   # Este archivo
```

## 🚀 Inicio Rápido

### 1. Generar Claves

```bash
# Generar claves para el servidor
./scripts/generar_claves.sh server

# Generar claves para un cliente
./scripts/generar_claves.sh laptop
```

### 2. Configurar Servidor

1. Editar `configs/wg0-server.conf`:
   - Reemplazar `[CLAVE_PRIVADA_SERVIDOR]` con la clave privada generada
   - Añadir peers (clientes) con sus claves públicas

2. Copiar configuración al servidor:
```bash
sudo cp configs/wg0-server.conf /etc/wireguard/wg0.conf
```

3. Iniciar WireGuard:
```bash
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0
```

### 3. Configurar Cliente

1. Editar `configs/wg0-client.conf`:
   - Reemplazar `[CLAVE_PRIVADA_CLIENTE]` con la clave privada del cliente
   - Reemplazar `[CLAVE_PUBLICA_SERVIDOR]` con la clave pública del servidor
   - Ajustar `Endpoint` con la IP/dominio del servidor

2. Importar en cliente:
   - **Linux**: `sudo wg-quick up configs/wg0-client.conf`
   - **Windows/iOS/Android**: Importar archivo `.conf` en la app WireGuard

## 🐳 Docker Compose

Para usar el servidor WireGuard en Docker:

```bash
# Editar docker-compose.yml y ajustar variables de entorno
nano docker-compose.yml

# Iniciar contenedor
docker-compose up -d

# Ver configuración generada
ls -la wireguard-config/
```

## 📝 Scripts Útiles

### Añadir Nuevo Peer

```bash
./scripts/add_peer.sh laptop 10.0.0.5
```

Esto:
1. Genera claves para el peer
2. Añade el peer al servidor
3. Crea archivo de configuración para el cliente

### Eliminar Peer

```bash
./scripts/remove_peer.sh laptop
```

## 🔒 Seguridad

- **Nunca compartas claves privadas**
- Guarda las claves en lugar seguro
- Rota las claves periódicamente (cada 6-12 meses)
- Usa firewall restrictivo (solo puerto 51820/UDP desde IPs conocidas)

## 📚 Recursos

- [Documentación oficial WireGuard](https://www.wireguard.com/)
- [WireGuard Quick Start](https://www.wireguard.com/quickstart/)
- [Artículo completo en ElDiarioIA](https://www.eldiarioia.es/)

## ⚠️ Notas

- Ajustar `eth0` en `PostUp/PostDown` por tu interfaz de red principal
- Ajustar `SERVERURL` en `docker-compose.yml` por tu dominio/IP
- Verificar que el puerto 51820/UDP esté abierto en el firewall

