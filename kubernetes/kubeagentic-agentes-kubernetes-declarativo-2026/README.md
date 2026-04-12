# KubeAgentic — referencia homelab 2026 (YAML + API OpenAI)

Material de apoyo para el artículo **KubeAgentic: agentes IA declarativos en K8s**. No sustituye el README del proyecto ni una revisión de tu commit concreto.

## Fuentes oficiales

- [KubeAgentic-Community/KubeAgenticOperator](https://github.com/KubeAgentic-Community/KubeAgenticOperator)
- [kubeagentic.com](https://kubeagentic.com/) y [Guías](https://kubeagentic.com/guides)
- Paquete PyPI: [kubeagentic](https://pypi.org/project/kubeagentic/)

## Contenido de esta carpeta

| Ruta | Uso |
|------|-----|
| `scripts/local-pip-smoke.sh` | Comandos de comprobación en máquina local (`pip`, `kubeagentic serve`). |
| `scripts/docker-run-example.sh` | Plantilla `docker run` con volumen de configuración (ajusta imagen/tag). |
| `configs/agent-minimal.yaml.example` | Ejemplo ilustrativo de agente en YAML (valida contra la versión que instales). |

## Advertencia sobre manifiestos remotos

Antes de `kubectl apply -f https://...` comprueba con `curl -I` que la URL devuelve **200**. Los layouts de GitHub cambian; el artículo enlazado documenta URLs *raw* que llegaron a responder **404** en verificaciones pasadas.

## Artículo asociado

Carpeta del blog: `2026-04-12_kubeagentic-agentes-kubernetes-declarativo-2026`.
