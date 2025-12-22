# Memoria de Agentes de IA: Ejemplos Prácticos

Ejemplos de código y configuraciones del artículo **"Memoria de Agentes de IA: Persistencia y Contexto para Sistemas Agénticos (Guía Completa 2025)"** publicado en [ElDiarioIA.es](https://www.eldiarioia.es).

## 📋 Descripción

Este repositorio contiene ejemplos prácticos de implementación de memoria en agentes de IA usando LangChain, CrewAI y Ollama. Incluye:

- **Buffer Memory**: Memoria básica con historial completo
- **Summary Memory**: Memoria con resúmenes automáticos
- **Entity Memory**: Memoria de entidades estructuradas
- **Persistencia**: SQLite, Redis y PostgreSQL
- **Docker Compose**: Stack completo para desarrollo

## 📁 Estructura

```
memoria-agentes-ia/
├── examples/
│   ├── buffer_memory.py      # Memoria básica
│   ├── summary_memory.py     # Memoria con resúmenes
│   ├── entity_memory.py      # Memoria de entidades
│   ├── persist_memory.py      # Persistencia SQLite
│   └── redis_memory.py       # Persistencia Redis
├── config/
├── docker-compose.yml        # Stack completo
└── README.md
```

## 🚀 Uso Rápido

### 1. Iniciar Stack con Docker Compose

```bash
docker-compose up -d
```

Esto inicia:
- **Ollama** (puerto 11434): Modelos LLM locales
- **Redis** (puerto 6379): Memoria distribuida
- **PostgreSQL** (puerto 5432): Persistencia robusta

### 2. Instalar Dependencias Python

```bash
pip install langchain ollama redis psycopg2-binary
```

### 3. Ejecutar Ejemplos

```bash
# Memoria básica
python3 examples/buffer_memory.py

# Memoria con resúmenes
python3 examples/summary_memory.py

# Memoria de entidades
python3 examples/entity_memory.py

# Persistencia SQLite
python3 examples/persist_memory.py

# Persistencia Redis
python3 examples/redis_memory.py
```

## 📚 Ejemplos Detallados

### Buffer Memory

Almacena todas las interacciones en orden cronológico. Ideal para conversaciones cortas.

```python
from langchain.memory import ConversationBufferMemory

memory = ConversationBufferMemory(return_messages=True)
memory.save_context({"input": "Hola"}, {"output": "¡Hola!"})
```

### Summary Memory

Genera resúmenes automáticos de conversaciones largas. Escalable y eficiente.

```python
from langchain.memory import ConversationSummaryMemory
from langchain.llms import Ollama

llm = Ollama(model="llama3.2")
memory = ConversationSummaryMemory(llm=llm, max_token_limit=1000)
```

### Entity Memory

Extrae y almacena información estructurada (nombres, fechas, preferencias).

```python
from langchain.memory import ConversationEntityMemory

memory = ConversationEntityMemory(llm=llm)
# Extrae automáticamente entidades de las conversaciones
```

### Persistencia SQLite

Guarda memoria entre sesiones usando SQLite (simple y local).

```python
from langchain.memory.chat_message_histories import SQLChatMessageHistory

history = SQLChatMessageHistory(
    connection_string="sqlite:///memory.db",
    session_id="user_123"
)
```

### Persistencia Redis

Memoria distribuida para producción con múltiples instancias.

```python
from langchain.memory.chat_message_histories import RedisChatMessageHistory
import redis

redis_client = redis.Redis(host='localhost', port=6379)
history = RedisChatMessageHistory(
    redis_client=redis_client,
    session_id="user_456"
)
```

## 🔧 Configuración

### Variables de Entorno

```bash
# Ollama
export OLLAMA_BASE_URL=http://localhost:11434
export OLLAMA_MODEL=llama3.2

# Redis
export REDIS_HOST=localhost
export REDIS_PORT=6379

# PostgreSQL
export POSTGRES_HOST=localhost
export POSTGRES_PORT=5432
export POSTGRES_DB=agentdb
export POSTGRES_USER=agentuser
export POSTGRES_PASSWORD=agentpass
```

## 📖 Artículo Completo

Guía completa con explicaciones detalladas, comparativas y mejores prácticas:

**[Memoria de Agentes de IA: Persistencia y Contexto para Sistemas Agénticos (Guía Completa 2025)](https://www.eldiarioia.es)**

## 🤝 Contribuciones

Si encuentras errores o mejoras, abre un issue o pull request.

## 📄 Licencia

Estos ejemplos son de código abierto y están disponibles para uso educativo y comercial.

---

**Creado para:** ElDiarioIA.es  
**Última actualización:** Diciembre 2025

