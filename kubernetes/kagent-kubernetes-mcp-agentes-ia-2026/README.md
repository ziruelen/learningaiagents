# kagent en Kubernetes (referencia homelab 2026)

Scripts y fragmentos **no ejecutables en ciego**: revisa [Installing kagent](https://kagent.dev/docs/kagent/introduction/installation) y el repositorio [kagent-dev/kagent](https://github.com/kagent-dev/kagent) antes de aplicar nada en producción.

## Contenido

| Archivo | Uso |
|---------|-----|
| `scripts/install-cli-demo.sh` | Instalación vía **kagent CLI** con perfil `demo` (requiere `OPENAI_API_KEY`). |
| `scripts/install-helm-openai.sh` | Instalación Helm CRDs + chart con proveedor OpenAI. |
| `scripts/smoke-ui.sh` | `kubectl port-forward` hacia `kagent-ui` en el puerto 8080. |
| `configs/helm-values-fragments.yaml` | Fragmentos documentados para `providers` y `controller.env`. |

## Prerrequisitos

- Cluster Kubernetes funcional (`kind`, `k3s`, managed, etc.).
- `kubectl` y `helm` 3.x.
- Claves de proveedor LLM según el perfil que elijas (OpenAI, Anthropic, Ollama…).

## Documentación oficial

- [kagent.dev](https://kagent.dev/)
- [Helm reference](https://kagent.dev/docs/kagent/resources/helm)
- [Uninstall](https://kagent.dev/docs/kagent/operations/uninstall)

## Artículo asociado

Guía en ElDiarioIA (carpeta `2026-04-12_kagent-kubernetes-mcp-agentes-ia-2026`).
