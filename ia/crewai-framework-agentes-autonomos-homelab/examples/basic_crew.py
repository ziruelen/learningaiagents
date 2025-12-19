"""
Ejemplo básico de CrewAI: Primer crew con 2 agentes
"""
from crewai import Agent, Task, Crew
from langchain_community.llms import Ollama

# Configurar LLM local (Ollama)
llm = Ollama(model="llama3.1", base_url="http://localhost:11434")

# Crear agentes
researcher = Agent(
    role='Investigador',
    goal='Investigar sobre el tema asignado de forma exhaustiva',
    backstory='Eres un investigador experto en tecnología con años de experiencia',
    llm=llm,
    verbose=True
)

writer = Agent(
    role='Escritor',
    goal='Escribir contenido de alta calidad basado en la investigación',
    backstory='Eres un escritor técnico profesional especializado en documentación',
    llm=llm,
    verbose=True
)

# Crear tareas
research_task = Task(
    description='Investiga sobre CrewAI y sus características principales. Incluye: arquitectura, casos de uso, y comparación con otros frameworks.',
    agent=researcher,
    expected_output='Un resumen detallado de 500 palabras sobre CrewAI'
)

write_task = Task(
    description='Escribe un artículo de 1000 palabras basado en la investigación realizada. El artículo debe ser claro, estructurado y técnico.',
    agent=writer,
    expected_output='Un artículo completo y bien estructurado sobre CrewAI'
)

# Crear crew
crew = Crew(
    agents=[researcher, writer],
    tasks=[research_task, write_task],
    verbose=2
)

# Ejecutar
if __name__ == "__main__":
    print("🚀 Iniciando crew...")
    result = crew.kickoff()
    print("\n✅ Resultado:")
    print(result)
