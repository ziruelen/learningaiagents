# Headscale: control plane Tailscale self-hosted (homelab)

Ejemplos mínimos para levantar [Headscale](https://github.com/juanfont/headscale) con Docker Compose y una `config.yaml` alineada con la versión pinneada en la imagen.

## Requisitos

- Docker y Docker Compose v2
- Un nombre DNS y certificado TLS válidos delante del servicio en producción (Caddy, Traefik, NPM, etc.)

## Pasos

1. Copia `.env.example` a `.env` y ajusta variables.
2. Ejecuta `bash scripts/bootstrap_config.sh` para descargar `config-example.yaml` oficial como `config/config.yaml`.
3. Edita `config/config.yaml`:
   - `server_url`: debe ser la URL HTTPS que usan los clientes (coincide con tu proxy).
   - `listen_addr`: `0.0.0.0:8080` dentro del contenedor.
   - Revisa `metrics_listen_addr` y `grpc_listen_addr` según tu modelo de amenazas.
4. `docker compose up -d`
5. Crea usuario y claves con la CLI según la documentación vigente de Headscale (`headscale users create`, `headscale preauthkeys create`, etc.).
6. En cada cliente: `tailscale up --login-server="${HEADSCALE_PUBLIC_URL}"` (ajusta flags según necesidad de subnets y exit nodes).

## Backups

Incluye en copias de seguridad el directorio `data/` (SQLite y claves) y `config/` versionado sin secretos innecesarios en git público.

## Referencias

- [Repositorio headscale](https://github.com/juanfont/headscale)
- [Tailscale KB](https://tailscale.com/kb/)
- Artículo asociado en [El Diario IA](https://www.eldiarioia.es/) (draft / publicación según estado).
