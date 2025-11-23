# GitLab Self-Hosted: Ejemplos y Configuraciones para Homelab

Este repositorio contiene ejemplos y configuraciones para instalar y configurar GitLab Self-Hosted en tu homelab.

## 📁 Estructura

```
gitlab/
├── README.md                    # Este archivo
├── docker-compose.yml           # Configuración básica GitLab
├── docker-compose.proxy.yml     # GitLab con reverse proxy externo
├── gitlab-runner/               # Configuración GitLab Runner
│   ├── docker-compose.yml
│   └── config.toml.example
├── examples/                    # Ejemplos de pipelines CI/CD
│   ├── nodejs-pipeline/
│   ├── python-pipeline/
│   └── docker-pipeline/
└── scripts/                     # Scripts de utilidad
    ├── backup.sh
    └── restore.sh
```

## 🚀 Inicio Rápido

### 1. Instalación Básica

```bash
# Clonar o descargar este repositorio
cd gitlab

# Editar docker-compose.yml y cambiar:
# - hostname: 'gitlab.example.com'
# - external_url

# Iniciar GitLab
docker-compose up -d

# Esperar 5-10 minutos para que GitLab inicie completamente
# Acceder a http://gitlab.example.com
# Usuario inicial: root
# Contraseña: Se solicita en el primer acceso
```

### 2. Configuración con Reverse Proxy

Si usas Nginx Proxy Manager o Traefik:

```bash
# Usar docker-compose.proxy.yml
docker-compose -f docker-compose.proxy.yml up -d
```

### 3. Configurar GitLab Runner

```bash
cd gitlab-runner
# Editar docker-compose.yml con tu URL de GitLab
docker-compose up -d

# Registrar runner
docker exec -it gitlab-runner gitlab-runner register
```

## 📚 Ejemplos de Pipelines

### Node.js Pipeline
Ver `examples/nodejs-pipeline/.gitlab-ci.yml`

### Python Pipeline
Ver `examples/python-pipeline/.gitlab-ci.yml`

### Docker Pipeline
Ver `examples/docker-pipeline/.gitlab-ci.yml`

## 🔧 Scripts

### Backup
```bash
./scripts/backup.sh
```

### Restore
```bash
./scripts/restore.sh backup.tar
```

## 📖 Documentación Completa

Para una guía completa paso a paso, consulta el artículo:
[GitLab Self-Hosted: CI/CD Completo en tu Homelab 2025](https://www.eldiarioia.es/)

## ⚠️ Requisitos

- Docker y Docker Compose instalados
- Mínimo 4GB RAM (8GB recomendado)
- 20GB+ espacio en disco
- Ubuntu 20.04+ o distribución Linux compatible

## 📝 Notas

- GitLab tarda 5-10 minutos en iniciar completamente después del primer `docker-compose up`
- La contraseña inicial de root se solicita en el primer acceso
- Para producción, configura SSL/TLS y backups automatizados

## 🤝 Contribuciones

Si encuentras errores o mejoras, abre un issue o pull request.

## 📄 Licencia

Estos ejemplos son de dominio público. Úsalos libremente en tus proyectos.

