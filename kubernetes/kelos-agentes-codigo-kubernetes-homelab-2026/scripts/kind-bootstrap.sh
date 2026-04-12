#!/usr/bin/env bash
set -euo pipefail
CLUSTER_NAME="${KIND_CLUSTER_NAME:-kelos-lab}"
kind create cluster --name "$CLUSTER_NAME" || kind get clusters | grep -q "$CLUSTER_NAME"
kubectl config use-context "kind-${CLUSTER_NAME}"
kubectl get nodes
echo "Listo. Instala Kelos según https://github.com/kelos-dev/kelos"
