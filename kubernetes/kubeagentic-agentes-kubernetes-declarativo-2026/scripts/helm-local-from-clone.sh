#!/usr/bin/env bash
set -euo pipefail
# Tras clonar KubeAgenticOperator, instala el chart local si existe en tu revisión (ruta puede variar).

REPO_URL="${KUBEAGENTIC_REPO:-https://github.com/KubeAgentic-Community/KubeAgenticOperator.git}"
WORKDIR="${KUBEAGENTIC_CLONE_DIR:-$HOME/src/KubeAgenticOperator}"

if [[ ! -d "$WORKDIR/.git" ]]; then
  git clone "$REPO_URL" "$WORKDIR"
fi
cd "$WORKDIR"

if [[ -d helm/kubeagentic ]]; then
  helm upgrade --install kubeagentic ./helm/kubeagentic \
    --namespace kubeagentic --create-namespace
else
  echo "No se encontró helm/kubeagentic en esta revisión. Revisa el árbol del repo y la guía en kubeagentic.com/guides" >&2
  exit 1
fi
