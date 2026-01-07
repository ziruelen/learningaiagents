# Vikunja - Gestión de Tareas Self-Hosted

Ejemplos de código y configuraciones del artículo publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

## 📋 Descripción

Este repositorio contiene ejemplos prácticos para instalar y configurar Vikunja, una aplicación de gestión de tareas self-hosted alternativa a Todoist y Notion.

## 📁 Estructura

```
vikunja-gestion-tareas-self-hosted-todoist-notion-alternativa-guia-completa-2026/
├── docker-compose.yml           # Stack básico de Vikunja
├── configs/
│   └── vikunja_env.example      # Variables de entorno de ejemplo
├── scripts/
│   └── backup_vikunja.sh        # Script de backup automático
└── README.md                    # Este archivo
```

## 🚀 Uso Rápido

### 1. Clonar o descargar

```bash
git clone https://github.com/ziruelen/learningaiagents.git
cd learningaiagents/homelab/vikunja-gestion-tareas-self-hosted-todoist-notion-alternativa-guia-completa-2026
```

### 2. Configurar variables de entorno

```bash
cp configs/vikunja_env.example .env
nano .env  # Edita los valores necesarios
```

### 3. Iniciar Vikunja

```bash
docker-compose up -d
```

### 4. Acceder a la interfaz

Abre tu navegador en `http://localhost` o la URL configurada en `VIKUNJA_URL`.

## 📚 Documentación

Para más detalles, consulta el artículo completo:
- **Artículo**: [Vikunja: Gestión de Tareas Self-Hosted (Alternativa a Todoist/Notion) - Guía Completa 2026](https://www.eldiarioia.es)

## 🔧 Ejemplos Incluidos

### Docker Compose Básico

Stack completo con PostgreSQL, API y proxy frontend.

### Script de Backup

Backup automático de base de datos y archivos:

```bash
./scripts/backup_vikunja.sh
```

### Configuración con Traefik

Para usar con Traefik reverse proxy, consulta el artículo completo.

## ⚠️ Importante

- Cambia todas las contraseñas por defecto
- Genera un JWT_SECRET seguro
- Configura SSL para producción
- Habilita backups automáticos

## 📝 Licencia

Ejemplos proporcionados bajo MIT License. Vikunja es software de código abierto.
