# Ejemplo 4: WordPress Completo

Despliegue completo de WordPress + MySQL con persistencia e Ingress.

## Componentes

- MySQL Deployment + Service + PVC (base de datos)
- WordPress Deployment + Service (aplicación)
- Ingress (acceso web)

## Comparación con Docker Compose

Ver `docker-compose-equivalente/docker-compose.yml` para comparar.

## Desplegar

```bash
# Aplicar todos los recursos
kubectl apply -f mysql-pvc.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml
kubectl apply -f wordpress-deployment.yaml
kubectl apply -f wordpress-service.yaml
kubectl apply -f ingress.yaml

# Verificar
kubectl get pods
kubectl get svc
kubectl get ingress

# Esperar a que MySQL esté listo
kubectl wait --for=condition=ready pod -l app=mysql --timeout=300s

# Acceder
# Configurar DNS: <IP_NODO> wordpress.tudominio.com
# Abrir http://wordpress.tudominio.com
```

## Ventajas sobre Docker Compose

- Escalado horizontal de WordPress (réplicas)
- Rolling updates sin downtime
- Auto-restart si un pod falla
- Ingress con SSL automático

