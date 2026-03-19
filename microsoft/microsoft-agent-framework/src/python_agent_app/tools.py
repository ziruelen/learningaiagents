from __future__ import annotations

from typing import Annotated
from random import randint

from pydantic import Field

from agent_framework import tool


@tool(approval_mode="always_require")
def get_homelab_metric(metric_name: Annotated[str, Field(description="Nombre del metric, por ejemplo: cpu, ram, disk.")]) -> str:
    """
    Herramienta de ejemplo (demo): devuelve un valor simulado.

    En un articulo real, esta tool deberia consultar Prometheus/Grafana/LOKI o un endpoint de observabilidad.
    """

    metric_name_l = metric_name.strip().lower()
    value = randint(1, 100)
    if metric_name_l == "cpu":
        return f"CPU simulated usage: {value}%"
    if metric_name_l == "ram":
        return f"RAM simulated usage: {value}%"
    if metric_name_l == "disk":
        return f"DISK simulated usage: {value}%"
    return f"{metric_name_l} simulated value: {value}"

