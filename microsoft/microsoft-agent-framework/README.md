# Microsoft Agent Framework (RC) - Ejemplos ElDiarioIA.es

## 📌 Descripcion

Ejemplos de codigo y configuracion para el articulo **Microsoft Agent Framework: multi-agente en Python/.NET (2026)**.

El foco de estos ejemplos es:
- Crear un agente (Python) y ejecutar una conversacion simple.
- Definir tools (function tools) y demostrar tool calling.
- Construir un workflow grafico sencillo (executor + edges).
- Mostrar un skeleton equivalente en .NET (Program.cs) siguiendo los patrones de Microsoft Learn.

## 📁 Estructura

```
microsoft-agent-framework/
├── README.md
├── docker-compose.yml
├── scripts/
│   ├── bootstrap.sh
│   └── run_python_demo.sh
└── src/
    ├── python_agent_app/
    │   ├── app.py
    │   └── tools.py
    └── dotnet_agent_app/
        └── Program.cs
```

## 🚀 Uso rapido (Python)

1. Revisar `docker-compose.yml` y variables de entorno necesarias.
2. Ejecutar:

```bash
./scripts/bootstrap.sh
./scripts/run_python_demo.sh
```

3. Ajustar variables en tu entorno (por ejemplo endpoints/deployment names segun tu proveedor).

