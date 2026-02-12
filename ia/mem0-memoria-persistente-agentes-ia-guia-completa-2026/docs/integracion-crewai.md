# Integración de Mem0 con CrewAI

Esta guía explica cómo añadir memoria persistente a tus agentes CrewAI usando Mem0.

## Concepto

Mem0 permite que los agentes CrewAI compartan memoria entre sesiones, recordando:
- Conversaciones anteriores
- Información del usuario
- Contexto de tareas pasadas
- Preferencias y patrones

## Configuración

### 1. Instalar Dependencias

```bash
pip install crewai mem0ai qdrant-client
```

### 2. Inicializar Memoria Compartida

```python
from mem0 import Memory
from crewai import Agent

# Crear memoria compartida para todos los agentes
memory = Memory(
    vector_store={
        "provider": "qdrant",
        "config": {
            "url": "http://localhost:6333",
            "collection_name": "crewai_memories"
        }
    }
)
```

### 3. Añadir Memoria a Agentes

```python
from crewai import Agent, Task, Crew

# Agente con memoria
researcher = Agent(
    role='Investigador',
    goal='Investigar y recordar información relevante',
    backstory='Eres un investigador que aprende de investigaciones anteriores',
    memory=memory,  # Añadir memoria
    verbose=True
)

writer = Agent(
    role='Escritor',
    goal='Escribir basado en investigación previa',
    backstory='Eres un escritor que recuerda el estilo del usuario',
    memory=memory,  # Misma memoria compartida
    verbose=True
)
```

## Casos de Uso

### Caso 1: Crew que Aprende del Usuario

Los agentes recuerdan preferencias del usuario y adaptan su comportamiento.

### Caso 2: Memoria Compartida entre Agentes

Múltiples agentes comparten contexto, evitando repetir trabajo.

### Caso 3: Persistencia entre Ejecuciones

El crew recuerda tareas anteriores incluso después de reiniciar.

## Ejemplo Completo

Ver `examples/crewai_mem0.py` para un ejemplo completo de integración.

## Mejores Prácticas

1. **Usar memoria compartida**: Todos los agentes del crew usan la misma instancia de Memory
2. **Configurar límites**: Evitar que la memoria crezca indefinidamente
3. **Optimizar búsquedas**: Usar queries específicas para recuperar contexto relevante
4. **Monitorear uso**: Trackear cuánta memoria se está usando

