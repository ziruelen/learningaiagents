# Ejemplo 3: Nginx con Ingress

Nginx expuesto al exterior usando Ingress (Traefik viene con K3s).

## Comparación con Docker

**Docker Compose:**
```yaml
services:
  nginx:
    image: nginx:latest
    ports:
      - "80:80"
```

**Kubernetes:**
- Ingress: Reverse proxy integrado (no necesitas servicio separado)
- Traefik: Ingress Controller incluido en K3s

## Desplegar

```bash
# Aplicar recursos
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

# Verificar
kubectl get ingress
kubectl get pods -n kube-system | grep traefik

# Configurar DNS
# Añadir en /etc/hosts o DNS:
# <IP_DEL_NODO> nginx.tudominio.com
```

## Notas

- K3s incluye Traefik como Ingress Controller por defecto
- No necesitas instalar nada adicional
- Cambia `nginx.tudominio.com` por tu dominio real
- Para SSL automático, instala cert-manager

