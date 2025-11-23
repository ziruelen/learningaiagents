# Ejemplo 2: Nginx con Volumen Persistente

Nginx con almacenamiento persistente usando PV (PersistentVolume) y PVC (PersistentVolumeClaim).

## Comparación con Docker

**Docker:**
```yaml
volumes:
  - ./html:/usr/share/nginx/html
```

**Kubernetes:**
- PV: Disco físico (recurso del cluster)
- PVC: Solicitud de espacio (lo que pide tu aplicación)

## Desplegar

```bash
# Aplicar en orden
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Verificar
kubectl get pv
kubectl get pvc
kubectl get pods

# Verificar persistencia
kubectl exec -it deployment/nginx-deployment -- ls /usr/share/nginx/html
```

## Notas

- K3s usa `local-path` como StorageClass por defecto
- ReadWriteOnce significa que solo un pod puede montar el volumen a la vez
- Los datos persisten aunque reinicies el pod

