#!/usr/bin/env python3
"""
Servidor MCP con una Tool y un Resource.
- Tool: get_current_time
- Resource: contenido de README.md del proyecto
"""
import sys
from pathlib import Path
from datetime import datetime
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("with-resource")
BASE_DIR = Path(__file__).parent.resolve()


@mcp.tool()
def get_current_time() -> str:
    """Devuelve la hora actual del sistema en formato ISO."""
    return datetime.now().isoformat()


@mcp.resource("file://readme")
def read_readme() -> str:
    """Contenido del README del proyecto."""
    path = BASE_DIR / "README.md"
    if not path.exists():
        return "README.md no encontrado."
    return path.read_text(encoding="utf-8", errors="replace")


def main():
    mcp.run(transport="stdio")


if __name__ == "__main__":
    main()
