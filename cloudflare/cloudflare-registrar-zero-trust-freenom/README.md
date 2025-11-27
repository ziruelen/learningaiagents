# Cloudflare Registrar + Zero Trust: Ejemplos para Homelab

Ejemplos prácticos para migrar dominios a Cloudflare Registrar y configurar Zero Trust tras el cierre de Freenom.

## 📁 Estructura

```
.
├── scripts/
│   ├── cf-transfer-check.sh          # Verificar elegibilidad de transferencia
│   └── cf-zero-trust-bootstrap.sh    # Bootstrap rápido de Zero Trust
├── docker-compose/
│   └── cloudflared-zero-trust.yml    # Docker Compose con cloudflared
├── configs/
│   ├── access-policy.yaml            # Ejemplo de política Access
│   ├── terraform-registrar.tf        # Terraform para DNS
│   └── dns-template.json             # Plantilla de registros DNS
└── README.md
```

## 🚀 Inicio Rápido

### 1. Verificar Elegibilidad de Transferencia

```bash
chmod +x scripts/cf-transfer-check.sh
./scripts/cf-transfer-check.sh tudominio.com
```

### 2. Bootstrap Zero Trust

```bash
chmod +x scripts/cf-zero-trust-bootstrap.sh
./scripts/cf-zero-trust-bootstrap.sh tudominio.com admin@tudominio.com
```

### 3. Configurar Docker Compose

```bash
cd docker-compose
# Editar cloudflared-zero-trust.yml con tus servicios
# Añadir TUNNEL_TOKEN al .env
docker-compose -f cloudflared-zero-trust.yml up -d
```

### 4. Usar Terraform para DNS

```bash
cd configs
# Editar terraform-registrar.tf con tu dominio
export TF_VAR_cloudflare_api_token="tu_token"
terraform init
terraform plan
terraform apply
```

## 📚 Documentación

- **Artículo completo**: [Cloudflare Registrar + Zero Trust: Migra tus dominios tras Freenom](https://www.eldiarioia.es/)
- **Cloudflare Docs**: https://developers.cloudflare.com/
- **Zero Trust**: https://www.cloudflare.com/zero-trust/

## 🔧 Requisitos

- `cloudflared` instalado (para scripts)
- Docker y Docker Compose (para docker-compose)
- Terraform (para Terraform)
- API Token de Cloudflare con permisos apropiados

## 📝 Notas

- Reemplazar `tudominio.com` con tu dominio real
- Reemplazar IPs placeholder con IPs reales
- Ajustar configuraciones según tus necesidades
- Revisar políticas de Access antes de aplicar

## 🤝 Contribuir

¿Mejoras o correcciones? Abre un issue o PR en el repositorio.

## 📄 Licencia

MIT License - Usa libremente en tus proyectos.

