# CrewAI: Framework de Agentes Autónomos para Homelab

## 📋 Descripción

Ejemplos de código y configuraciones del artículo publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

Este repositorio contiene ejemplos prácticos para implementar CrewAI en tu homelab, incluyendo:
- Instalación con Docker
- Ejemplos básicos de crews
- Integración con Ollama (modelos locales)
- Configuraciones avanzadas

## 📁 Estructura

```
crewai-framework-agentes-autonomos-homelab/
├── docker-compose.yml          # Stack completo CrewAI + Ollama
├── Dockerfile                   # Imagen Docker para CrewAI
├── examples/
│   ├── basic_crew.py           # Primer ejemplo básico
│   └── research_crew.py        # Crew de investigación con 3 agentes
├── config/
│   └── crewai_config.yaml      # Configuración avanzada
└── scripts/
    └── setup.sh                # Script de instalación
```

## 🚀 Uso Rápido

### Opción 1: Docker Compose (Recomendado)

```bash
# Clonar o descargar este directorio
cd crewai-framework-agentes-autonomos-homelab

# Iniciar stack completo
docker-compose up -d

# Ver logs
docker-compose logs -f crewai-app
```

### Opción 2: Instalación Local

```bash
# Ejecutar script de instalación
./scripts/setup.sh

# Activar entorno virtual
source venv/bin/activate

# Ejecutar ejemplo
python examples/basic_crew.py
```

## 📝 Requisitos

- Python 3.11+
- Docker y Docker Compose (para opción Docker)
- Ollama instalado y corriendo (para modelos locales)
- 4GB+ RAM (recomendado 8GB+)

## 🔧 Configuración

### Configurar Ollama

1. Instalar Ollama: https://ollama.ai
2. Descargar modelo:
   ```bash
   ollama pull llama3.1
   ```
3. Verificar que Ollama está corriendo:
   ```bash
   curl http://localhost:11434/api/tags
   ```

### Configurar CrewAI

Edita `config/crewai_config.yaml` para personalizar:
- Modelo LLM a usar
- Roles de agentes
- Configuración de tareas

## 📚 Ejemplos

### Ejemplo 1: Crew Básico

```bash
python examples/basic_crew.py
```

Crea un crew con 2 agentes (Investigador + Escritor) que colaboran para crear contenido.

### Ejemplo 2: Crew de Investigación

```bash
python examples/research_crew.py
```

Crea un crew con 3 agentes (Investigador + Analista + Escritor) que investigan, analizan y generan informes.

## 🔗 Enlaces Útiles

- [Documentación CrewAI](https://docs.crewai.com)
- [GitHub CrewAI](https://github.com/crewAIInc/crewAI)
- [Ollama](https://ollama.ai)

## 📄 Licencia

Estos ejemplos son de código abierto y están disponibles para uso educativo y personal.

## 🤝 Contribuciones

Si encuentras errores o tienes mejoras, por favor abre un issue o pull request.
