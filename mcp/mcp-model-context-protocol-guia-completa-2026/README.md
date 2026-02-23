# MCP (Model Context Protocol) – Ejemplos de la guía ElDiarioIA

Ejemplos de código del artículo **MCP (Model Context Protocol): Guía Completa para Conectar Herramientas con IA (2026)** en [ElDiarioIA.es](https://www.eldiarioia.es).

## Requisitos

- Python 3.10+
- `pip install mcp[cli]` o `uv add "mcp[cli]"` en cada carpeta de ejemplo

## Estructura

```
mcp-model-context-protocol-guia-completa-2026/
├── mcp-minimal/              # Una Tool: get_current_time
│   ├── server_minimal.py
│   └── requirements.txt
├── mcp-with-resource/        # Tool + Resource (file://readme)
│   ├── server_with_resource.py
│   ├── README.md
│   └── requirements.txt
├── mcp-useful-tool/         # Tool read_file (rutas relativas al proyecto)
│   ├── server_read_file.py
│   └── requirements.txt
├── .cursor/
│   └── mcp.json.example     # Ejemplo de configuración para Cursor
└── README.md
```

## Uso en Cursor

1. Copia `.cursor/mcp.json.example` a tu proyecto como `.cursor/mcp.json` (o a `~/.cursor/mcp.json` para uso global).
2. Sustituye todas las rutas `/ruta/absoluta/al/repo` por la ruta real de esta carpeta en tu máquina.
3. Para `command` con Python: usa la ruta absoluta al ejecutable del venv (ej. `.../venv/bin/python`).
4. Reinicia Cursor por completo para que cargue los servidores MCP.
5. Las Tools aparecerán en el agente (Composer).

## Probar un servidor a mano

```bash
cd mcp-minimal
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate
pip install mcp[cli]
python server_minimal.py
```

El proceso quedará esperando mensajes JSON-RPC por stdin. Para usarlo de verdad, configúralo en Cursor y habla con el agente.

## Artículo completo

Guía paso a paso: [MCP Model Context Protocol – Guía Completa 2026](https://www.eldiarioia.es) (enlace al artículo cuando esté publicado).

---

*Ejemplos mantenidos por [ElDiarioIA.es](https://www.eldiarioia.es)*
