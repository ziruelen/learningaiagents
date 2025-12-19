"""
Crew de investigación: 3 agentes colaborando para investigación completa
"""
from crewai import Agent, Task, Crew, Tool
from langchain_community.llms import Ollama
from langchain.tools import DuckDuckGoSearchRun

# Configurar LLM
llm = Ollama(model="llama3.1", base_url="http://localhost:11434")

# Herramienta de búsqueda
search_tool = Tool(
    name="Búsqueda Web",
    func=DuckDuckGoSearchRun().run,
    description="Busca información actualizada en internet"
)

# Crear agentes especializados
researcher = Agent(
    role='Investigador Principal',
    goal='Recopilar información relevante y actualizada',
    backstory='Eres un investigador experto en encontrar información precisa',
    tools=[search_tool],
    llm=llm,
    verbose=True
)

analyst = Agent(
    role='Analista',
    goal='Analizar y sintetizar la información recopilada',
    backstory='Eres un analista experto en identificar patrones y tendencias',
    llm=llm,
    verbose=True
)

writer = Agent(
    role='Escritor de Informes',
    goal='Crear informes estructurados y profesionales',
    backstory='Eres un escritor técnico especializado en informes ejecutivos',
    llm=llm,
    verbose=True
)

# Crear tareas
research_task = Task(
    description='Investiga sobre las últimas tendencias en IA agéntica para 2025. Busca información actualizada.',
    agent=researcher,
    expected_output='Lista de tendencias encontradas con fuentes'
)

analysis_task = Task(
    description='Analiza las tendencias encontradas y identifica las más relevantes. Prioriza por impacto y viabilidad.',
    agent=analyst,
    expected_output='Análisis priorizado de tendencias'
)

report_task = Task(
    description='Crea un informe ejecutivo de 1500 palabras basado en el análisis. Incluye conclusiones y recomendaciones.',
    agent=writer,
    expected_output='Informe ejecutivo completo'
)

# Crear crew
crew = Crew(
    agents=[researcher, analyst, writer],
    tasks=[research_task, analysis_task, report_task],
    verbose=2
)

# Ejecutar
if __name__ == "__main__":
    print("🔍 Iniciando crew de investigación...")
    result = crew.kickoff()
    print("\n📊 Resultado:")
    print(result)
