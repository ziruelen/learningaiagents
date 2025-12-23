"""
Plugin de ejemplo para Open WebUI
Guarda este archivo en: /app/backend/data/plugins/example-plugin/plugin.py
"""

from openwebui import Plugin, register_plugin

class ExamplePlugin(Plugin):
    name = "Example Plugin"
    version = "1.0.0"
    description = "Plugin de ejemplo que responde a comandos personalizados"
    
    def on_message(self, message: str) -> str:
        """
        Procesa mensajes y responde a comandos personalizados
        """
        message_lower = message.lower().strip()
        
        # Comando /help
        if message_lower.startswith("/help"):
            return """
**Comandos disponibles:**
- `/help` - Muestra esta ayuda
- `/time` - Muestra la hora actual
- `/echo <texto>` - Repite el texto
            """
        
        # Comando /time
        if message_lower.startswith("/time"):
            from datetime import datetime
            return f"🕐 Hora actual: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"
        
        # Comando /echo
        if message_lower.startswith("/echo"):
            text = message[5:].strip()
            return f"📢 Echo: {text}"
        
        # No procesar si no es un comando
        return None
    
    def on_chat_start(self):
        """
        Se ejecuta cuando inicia una nueva conversación
        """
        print("Example Plugin: Nueva conversación iniciada")
    
    def on_chat_end(self):
        """
        Se ejecuta cuando termina una conversación
        """
        print("Example Plugin: Conversación finalizada")

# Registrar el plugin
register_plugin(ExamplePlugin())

