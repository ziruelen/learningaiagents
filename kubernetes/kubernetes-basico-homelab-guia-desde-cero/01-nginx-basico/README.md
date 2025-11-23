# Ejemplo 1: Nginx Básico

Primer despliegue en Kubernetes: Nginx con Deployment + Service.

## Comparación con Docker

**Docker:**
```bash
docker run -d --name nginx -p 8080:80 nginx:latest
```

**Kubernetes:**
- Deployment: Gestiona réplicas y auto-restart
- Service: Expone pods internamente

## Desplegar

```bash
# Aplicar recursos
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# Verificar
kubectl get pods
kubectl get svc

# Acceder (port-forward)
kubectl port-forward svc/nginx-service 8080:80
# Abrir http://localhost:8080
```

## Comandos Útiles

```bash
# Ver logs
kubectl logs -l app=nginx

# Escalar
kubectl scale deployment nginx-deployment --replicas=3

# Eliminar
kubectl delete -f deployment.yaml -f service.yaml
```

