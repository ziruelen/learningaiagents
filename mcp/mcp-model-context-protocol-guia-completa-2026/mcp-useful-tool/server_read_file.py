#!/usr/bin/env python3
"""
Servidor MCP con Tool útil: read_file (solo rutas dentro del proyecto).
Seguridad: solo permite leer archivos bajo el directorio del servidor.
"""
import sys
from pathlib import Path
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("read-file")
ALLOWED_DIR = Path(__file__).parent.resolve()


@mcp.tool()
def read_file(relative_path: str) -> str:
    """Lee un archivo del directorio del proyecto (solo rutas relativas).
    Args:
        relative_path: Ruta relativa al directorio del servidor (ej. 'src/main.py').
    """
    try:
        full = (ALLOWED_DIR / relative_path).resolve()
        if not str(full).startswith(str(ALLOWED_DIR)):
            return "Error: ruta no permitida (fuera del proyecto)."
        if not full.exists():
            return f"Error: archivo no encontrado: {relative_path}"
        if not full.is_file():
            return "Error: no es un archivo."
        return full.read_text(encoding="utf-8", errors="replace")
    except Exception as e:
        return f"Error: {e}"


def main():
    mcp.run(transport="stdio")


if __name__ == "__main__":
    main()
