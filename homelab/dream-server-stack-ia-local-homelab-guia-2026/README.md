# Dream Server — referencia homelab (abril 2026)

Esta carpeta **no duplica** el upstream: documenta cómo encajar [Dream Server](https://github.com/Light-Heart-Labs/DreamServer) en un homelab serio (prerrequisitos, comprobaciones y enlaces oficiales).

## Instalación oficial (resumen)

Según el README del proyecto:

```bash
git clone https://github.com/Light-Heart-Labs/DreamServer.git
cd DreamServer/dream-server
./install.sh
```

También publican un instalador remoto (`get-dream-server.sh`); **léelo antes de ejecutarlo** (`curl | bash`) y ejecútalo solo si confías en el origen y en tu snapshot de máquina.

## Prerrequisitos

Ejecuta `bash scripts/check_prereqs.sh` en este directorio para comprobar Docker, Compose v2 y (opcional) NVIDIA.

## Variables útiles

Copia `.env.example` a `.env` como recordatorio de convenciones; el stack real toma variables del repositorio upstream — sincroniza con su documentación vigente.

## Seguridad

No expongas todos los puertos del stack a Internet sin TLS, autenticación y ACL de red. Para acceso remoto seguro revisa VPN mesh en tu blog (Tailscale / Headscale).

## Licencia del upstream

El repositorio Dream Server indica licencia **Apache-2.0**; los modelos y datasets que descargues pueden tener otras licencias — revísalas aparte.
