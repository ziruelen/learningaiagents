# Stack de Observabilidad: Prometheus + Grafana + Loki

Stack completo de observabilidad para homelab con métricas (Prometheus), visualización (Grafana) y logs (Loki).

## 🚀 Inicio Rápido

```bash
# 1. Clonar o descargar este repositorio
cd prometheus-grafana-loki

# 2. Configurar variables de entorno (opcional)
export GRAFANA_PASSWORD="tu_password_seguro"

# 3. Iniciar el stack
docker-compose up -d

# 4. Acceder a Grafana
# URL: http://localhost:3000
# Usuario: admin
# Password: admin (o el que configuraste en GRAFANA_PASSWORD)
```

## 📊 Componentes

- **Prometheus** (puerto 9090): Recolección de métricas
- **Grafana** (puerto 3000): Visualización y dashboards
- **Loki** (puerto 3100): Agregación de logs
- **Promtail**: Agente que envía logs a Loki
- **Node Exporter** (puerto 9100): Métricas del sistema
- **cAdvisor** (puerto 8080): Métricas de contenedores Docker

## 📁 Estructura

```
.
├── docker-compose.yml           # Stack completo
├── prometheus/
│   ├── prometheus.yml          # Configuración Prometheus
│   └── alerts/                 # Reglas de alertas
├── grafana/
│   ├── provisioning/
│   │   ├── datasources/       # Datasources automáticos
│   │   └── dashboards/        # Config de dashboards
│   └── dashboards/            # Dashboards JSON (si quieres añadir más)
├── loki/
│   └── loki-config.yml        # Configuración Loki
└── promtail/
    └── promtail-config.yml    # Configuración Promtail
```

## 🔧 Configuración

### Retención de Datos

Por defecto:
- Prometheus: 90 días de métricas
- Loki: 30 días de logs

Puedes modificar estos valores en:
- `docker-compose.yml`: `--storage.tsdb.retention.time=90d` para Prometheus
- `loki/loki-config.yml`: `retention_period: 720h` para Loki

### Añadir más Targets a Prometheus

Edita `prometheus/prometheus.yml` y añade nuevos jobs en `scrape_configs`:

```yaml
- job_name: 'mi-servicio'
  static_configs:
    - targets: ['mi-servicio:puerto']
```

### Dashboards Recomendados

Una vez en Grafana, importa estos dashboards:
- Node Exporter Full: ID `1860`
- Docker Container & Host Metrics: ID `179`
- Loki Logs Dashboard: ID `15141`

## 📚 Documentación Completa

Para más detalles, consulta el artículo completo en El Diario IA:
https://www.eldiarioia.es/2025/11/23/prometheus-grafana-loki-observabilidad-homelab/

## ⚠️ Troubleshooting

Ver la sección de troubleshooting en el artículo completo.

## 📝 Licencia

Este stack es código abierto. Úsalo libremente en tu homelab.
