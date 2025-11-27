# Paperless-ngx: Gestión Documental Self-Hosted

> 📚 Guía completa: [ElDiarioIA.es - Paperless-ngx](https://www.eldiarioia.es/paperless-ngx-digitaliza-documentos-ia-homelab/)

## 🚀 Inicio Rápido

```bash
# 1. Clonar y configurar
git clone https://github.com/ziruelen/learningaiagents.git
cd learningaiagents/paperless-ngx/paperless-setup

# 2. Configurar variables
cp .env.example .env
nano .env  # Ajustar passwords y zona horaria

# 3. Crear carpetas
mkdir -p consume export

# 4. Iniciar
docker compose up -d

# 5. Acceder
# http://localhost:8000
# Usuario: admin (o el que pongas en .env)
```

## 📁 Estructura

```
paperless-setup/
├── docker-compose.yml          # Stack principal
├── docker-compose.traefik.yml  # Con Traefik + SSL
├── .env.example                # Variables de ejemplo
├── consume/                    # Dejar documentos aquí
├── export/                     # Exportaciones
└── scripts/
    ├── backup.sh              # Backup automático
    └── restore.sh             # Restaurar backup
```

## 🔧 Configuración

### Idiomas OCR
Edita `.env`:
```env
# Español + Inglés
PAPERLESS_OCR_LANGUAGE=spa+eng

# Solo español
PAPERLESS_OCR_LANGUAGE=spa

# Español + Catalán + Inglés
PAPERLESS_OCR_LANGUAGE=spa+cat+eng
```

### Documentos Office (DOCX, XLSX)
```bash
# Activar Tika + Gotenberg
docker compose --profile office up -d
```

### Con Traefik (SSL automático)
```bash
# Añadir dominio en .env
PAPERLESS_DOMAIN=docs.tudominio.com

# Usar compose de Traefik
docker compose -f docker-compose.traefik.yml up -d
```

## 💾 Backup y Restauración

```bash
# Backup
./scripts/backup.sh ./backups

# Restaurar
./scripts/restore.sh ./backups/paperless_backup_FECHA.tar.gz
```

## 📱 Flujos de Consumo

### 1. Carpeta local
Deja PDFs en `./consume/` → Se procesan automáticamente

### 2. Email (Gmail)
Edita `.env`:
```env
PAPERLESS_EMAIL_HOST=imap.gmail.com
PAPERLESS_EMAIL_PORT=993
PAPERLESS_EMAIL_HOST_USER=tu@gmail.com
PAPERLESS_EMAIL_HOST_PASSWORD=app_password
```

### 3. API REST
```bash
curl -X POST http://localhost:8000/api/documents/post_document/ \
  -H "Authorization: Token TU_TOKEN" \
  -F "document=@factura.pdf"
```

## 🔗 Enlaces

- [Documentación oficial](https://docs.paperless-ngx.com/)
- [GitHub Paperless-ngx](https://github.com/paperless-ngx/paperless-ngx)
- [Comunidad Discord ElDiarioIA](https://discord.gg/HZXBmUyNCG)

---
*Generado por [ElDiarioIA.es](https://www.eldiarioia.es) - El blog donde la IA y el humano aprenden juntos*

