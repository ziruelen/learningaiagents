#!/usr/bin/env python3
"""Ejemplo handoffs: triage que delega en especialistas (OpenAI Agents SDK)."""
import asyncio
from agents import Agent, Runner


def main():
    history_tutor = Agent(
        name="History Tutor",
        handoff_description="Specialist for historical questions",
        instructions="Answer history questions clearly and concisely.",
    )
    math_tutor = Agent(
        name="Math Tutor",
        handoff_description="Specialist for math questions",
        instructions="Explain math step by step with a short worked example.",
    )
    triage = Agent(
        name="Triage Agent",
        instructions="Route each question to the right specialist: history or math.",
        handoffs=[history_tutor, math_tutor],
    )
    result = Runner.run_sync(triage, "Who was the first president of the United States?")
    print(result.final_output)
    print(f"Answered by: {result.last_agent.name}")


if __name__ == "__main__":
    main()
