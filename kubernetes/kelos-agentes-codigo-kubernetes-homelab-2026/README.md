# Kelos — agentes de código en Kubernetes (homelab)

Referencias mínimas para evaluar [Kelos](https://github.com/kelos-dev/kelos) en un clúster de laboratorio (`kind` / k3d). **No** sustituye la documentación oficial ni el chart Helm OCI en GHCR.

## Contenido de esta carpeta

- `scripts/kind-bootstrap.sh` — crea un clúster kind sencillo (ajústalo a tu red).
- `configs/namespace-lab.yaml` — namespace dedicado para pruebas.
- `configs/taskspawner-snippet.yaml` — **fragmento ilustrativo** basado en patrones públicos del README; debe fusionarse con manifiestos oficiales y revisarse antes de aplicar.

## Instalación (enlace oficial)

Sigue el *Quick Start* del repositorio: script `hack/install.sh`, CLI `kelos` vía `go install`, o Helm según la guía vigente. Verifica versión de Kubernetes **1.28+**.

## Seguridad

Namespace aislado, RBAC mínimo, secretos con rotación corta y `maxConcurrency` acotado en TaskSpawners para no disparar rate limits de proveedores LLM.
