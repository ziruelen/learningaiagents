#!/usr/bin/env python3
"""
Servidor MCP mínimo: una sola Tool (get_current_time).
Uso: Añadir a Cursor en .cursor/mcp.json y reiniciar.
"""
import sys
from datetime import datetime
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("minimal")


@mcp.tool()
def get_current_time() -> str:
    """Devuelve la hora actual del sistema en formato ISO."""
    return datetime.now().isoformat()


def main():
    mcp.run(transport="stdio")


if __name__ == "__main__":
    main()
