# Perplexica / Vane — investigación IA self-hosted (homelab)

Ejemplos mínimos para desplegar **Vane** (`itzcrazykns1337/vane`), el motor open source conocido en la comunidad como **Perplexica**, con Docker Compose.

## Requisitos

- Docker / Docker Compose v2
- (Opcional) Instancia **SearXNG** si usas la variante `slim` del README oficial

## Uso rápido

```bash
docker compose up -d
```

Abre `http://localhost:3000` y completa el asistente de configuración (proveedores LLM, etc.).

## Prueba de humo

```bash
chmod +x scripts/smoke.sh
./scripts/smoke.sh http://127.0.0.1:3000
```

## Artículo

Guía completa en [ElDiarioIA.es](https://www.eldiarioia.es/) (ruta publicada tras el draft).
