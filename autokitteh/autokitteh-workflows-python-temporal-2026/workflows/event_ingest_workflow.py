"""Workflow de ejemplo para procesamiento durable de eventos."""

from dataclasses import dataclass


@dataclass
class DeployEvent:
    service: str
    commit_sha: str


def validate_event(event: DeployEvent) -> bool:
    return bool(event.service and event.commit_sha)


def run_workflow(event: DeployEvent) -> dict:
    if not validate_event(event):
        raise ValueError("Evento inválido")

    return {
        "status": "accepted",
        "service": event.service,
        "commit": event.commit_sha,
        "next": "trigger_ci_pipeline",
    }


if __name__ == "__main__":
    sample = DeployEvent(service="api-gateway", commit_sha="a1b2c3d4")
    print(run_workflow(sample))
