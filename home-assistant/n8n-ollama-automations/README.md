# Home Assistant + n8n + Ollama: Automatizaciones con IA Local

Stack completo para crear automatizaciones inteligentes en tu hogar usando **Home Assistant**, **n8n** y **Ollama** (LLM local). Todo 100% self-hosted, sin costes mensuales, con tus datos bajo control.

## 🎯 ¿Qué incluye?

- **Docker Compose completo** para levantar todo el stack
- **5 workflows n8n funcionales** listos para importar
- Integración Home Assistant ↔ n8n ↔ Ollama
- Decisiones contextuales con IA (clima, hora, presencia)
- Control por voz en lenguaje natural
- Optimización energética automática
- Detección de anomalías de seguridad
- Sistema de notificaciones priorizadas por IA

## 📋 Requisitos

- Docker + Docker Compose
- 4GB RAM mínimo (8GB recomendado para modelos LLM)
- 20GB espacio disco para modelos Ollama
- (Opcional) GPU NVIDIA para inferencia más rápida

## 🚀 Instalación Rápida

### 1. Clonar y levantar servicios

```bash
# Clonar este repositorio
git clone https://github.com/ziruelen/learningaiagents.git
cd learningaiagents/home-assistant/n8n-ollama-automations

# Levantar todos los servicios
docker-compose up -d
```

### 2. Configurar Home Assistant

Accede a `http://tu-ip:8123` y completa el wizard inicial.

Edita `homeassistant/configuration.yaml` y añade:

```yaml
# Habilitar API REST
api:

# Permitir CORS para n8n
http:
  cors_allowed_origins:
    - http://localhost:5678
    - http://tu-ip:5678

# Webhooks para n8n
automation: !include automations.yaml
```

Reinicia Home Assistant.

### 3. Generar token API Home Assistant

1. Ve a tu perfil en Home Assistant
2. Scroll hasta "Tokens de acceso de larga duración"
3. Crea un nuevo token y cópialo

### 4. Configurar n8n

Accede a `http://tu-ip:5678`

**Configurar credenciales Home Assistant:**

1. Ve a Credentials → New
2. Selecciona "Home Assistant"
3. Nombre: `Home Assistant Local`
4. Host: `http://homeassistant:8123` (si usas Docker) o `http://tu-ip:8123`
5. Access Token: pega el token del paso anterior
6. Guarda

### 5. Descargar modelo Ollama

```bash
# Descargar modelo Llama 3.2 (recomendado, 2GB)
docker exec -it ollama ollama pull llama3.2

# O un modelo más pequeño si tienes poca RAM
docker exec -it ollama ollama pull llama3.2:1b

# Verificar que funciona
docker exec -it ollama ollama run llama3.2 "Hola, ¿funcionas?"
```

### 6. Importar workflows n8n

1. En n8n, ve a Workflows → Import from File
2. Importa cada archivo de la carpeta `workflows/`:
   - `1-llegar-casa-contexto.json`
   - `2-comando-voz-natural.json`
   - `3-optimizacion-energia.json`
   - `4-notificaciones-inteligentes.json`
   - `5-seguridad-anomalias.json`

3. En cada workflow, verifica que las credenciales de Home Assistant estén correctamente asignadas
4. Activa los workflows que quieras usar

## 📚 Descripción de Workflows

### 1️⃣ Automatización Llegada Casa con Contexto IA

**Qué hace:** Cuando llegas a casa, la IA analiza clima exterior, temperatura interior y hora del día para decidir qué hacer.

**Ejemplo:**
- Si hace frío afuera → Enciende calefacción
- Si es de noche → Enciende luces
- Te envía notificación: "Bienvenido. He encendido la calefacción a 21°C porque hace 5°C afuera"

**Entidades necesarias:**
- `person.usuario` (tu persona en HA)
- `weather.home` (integración meteorológica)
- `sensor.interior_temperature`
- `light.salon`
- `climate.termostato`

### 2️⃣ Control por Voz Natural con IA

**Qué hace:** Webhook que recibe comandos en lenguaje natural y la IA los interpreta para ejecutar acciones.

**Ejemplos de uso:**

```bash
# Encender luces del salón
curl -X POST http://tu-ip:5678/webhook/voice-command \
  -H "Content-Type: application/json" \
  -d '{"text": "Enciende las luces del salón"}'

# Ajustar temperatura
curl -X POST http://tu-ip:5678/webhook/voice-command \
  -H "Content-Type: application/json" \
  -d '{"text": "Pon la calefacción a 22 grados"}'

# Bajar persianas
curl -X POST http://tu-ip:5678/webhook/voice-command \
  -H "Content-Type: application/json" \
  -d '{"text": "Baja las persianas del dormitorio"}'
```

**Integración con asistentes de voz:**
- Puedes llamar este webhook desde Google Home, Alexa o Siri usando rutinas

### 3️⃣ Optimización Energética con IA

**Qué hace:** Cada hora, analiza consumo eléctrico, precio de la luz y presencia en casa para optimizar.

**Acciones automáticas:**
- Apaga dispositivos en standby si precio es alto y no hay nadie
- Ajusta calefacción basándose en precio/hora
- Apaga luces innecesarias
- Te notifica el ahorro estimado

**Entidades necesarias:**
- `sensor.energia_consumo_actual`
- `sensor.precio_electricidad` (integración PVPC/precio luz)
- `binary_sensor.presence_home`
- `switch.enchufes_standby`
- `climate.termostato`

### 4️⃣ Notificaciones Inteligentes Priorizadas

**Qué hace:** Captura TODOS los eventos de Home Assistant y la IA decide cuáles son importantes y cómo notificarte.

**Niveles de prioridad:**
- **Crítico:** Alarma sonora + notificación push inmediata
- **Alto:** Notificación push normal
- **Medio/Bajo:** Notificación silenciosa o log

**Ejemplos:**
- Puerta abierta a las 3 AM → Crítico
- Temperatura >30°C → Alto
- Luz encendida 2h → Medio
- Sensor batería baja → Bajo

**Entidades necesarias:**
- `binary_sensor.modo_no_molestar`
- Servicio de notificaciones configurado (ej: `notify.mobile_app`)

### 5️⃣ Detección Anomalías Seguridad con IA

**Qué hace:** Cada 15 minutos, analiza patrones de actividad (red, puertas, intentos de login) y detecta comportamientos anormales.

**Anomalías que detecta:**
- Picos inusuales de tráfico de red (posible malware)
- Puertas/ventanas abiertas en horarios raros
- Múltiples intentos de login fallidos
- Actividad cuando no debería haber nadie

**Acciones automáticas:**
- Riesgo crítico → Activa modo seguridad + captura cámaras + alerta push
- Riesgo alto → Notificación inmediata
- Riesgo medio → Log y notificación silenciosa

**Entidades necesarias:**
- `sensor.consumo_red`
- `binary_sensor.puertas_ventanas`
- `sensor.intentos_login`
- `camera.todas` (grupo de cámaras)

## ⚙️ Personalización

### Cambiar modelo de IA

Edita los workflows y modifica el campo `"model": "llama3.2"` por otro:

```json
{
  "model": "llama3.2:1b"  // Más rápido, menos preciso
  "model": "mistral"      // Alternativa
  "model": "phi3"         // Muy ligero (1.5GB)
}
```

### Ajustar prompts

Cada workflow tiene un nodo "Consultar Ollama" con el prompt. Puedes editarlo para cambiar el comportamiento:

```javascript
"prompt": "Eres un asistente domótico. [Tu contexto aquí]. Responde SOLO con JSON..."
```

**Tip:** Pide SIEMPRE que responda en formato JSON estructurado para que n8n pueda parsearlo fácilmente.

### Añadir tus entidades

Sustituye las entidades de ejemplo (`light.salon`, `sensor.temperatura`, etc.) por las tuyas:

1. En Home Assistant, ve a Developer Tools → States
2. Copia el `entity_id` exacto
3. Reemplaza en los workflows de n8n

## 🐛 Troubleshooting

### Ollama no responde

```bash
# Verificar que el contenedor está corriendo
docker ps | grep ollama

# Ver logs
docker logs ollama

# Probar manualmente
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2",
  "prompt": "Hola",
  "stream": false
}'
```

### n8n no puede conectar con Home Assistant

- Verifica que el token API es correcto
- Comprueba que CORS está habilitado en `configuration.yaml`
- Si usas HTTPS en HA, cambia la URL en credenciales n8n a `https://`

### Workflows no se activan

- Verifica que están activados (toggle en la esquina superior derecha)
- Comprueba que las entidades existen en Home Assistant
- Revisa los logs de ejecución en n8n (panel derecho)

### Error "JSON parse"

- El modelo de IA no está respondiendo en formato JSON válido
- Edita el prompt y enfatiza: "Responde SOLAMENTE con JSON, sin texto adicional"
- Prueba con un modelo más grande/preciso

## 📊 Recursos del Sistema

**Consumo típico:**

- Home Assistant: ~200MB RAM
- n8n: ~150MB RAM
- Ollama (sin modelo cargado): ~100MB RAM
- Ollama con llama3.2 activo: ~2.5GB RAM
- Ollama-WebUI: ~100MB RAM

**Total:** ~3GB RAM con modelo activo, ~600MB en reposo

## 🔒 Seguridad

- Todos los servicios corren en red Docker local
- No se expone nada a internet (usa VPN o proxy reverso si necesitas acceso remoto)
- Los modelos LLM corren 100% local, tus datos no salen de tu red
- Considera añadir autenticación a n8n en producción (variables de entorno en docker-compose)

## 🌐 Acceso Remoto (Opcional)

Si quieres acceder desde fuera de casa:

1. Usa [Nginx Proxy Manager](https://nginxproxymanager.com/) o [Traefik](https://traefik.io/)
2. Configura Let's Encrypt para HTTPS
3. Protege con autenticación (Authelia, HTTP Basic Auth, etc.)
4. **NUNCA expongas Ollama directamente a internet**

## 📈 Mejoras Futuras

Ideas para extender este proyecto:

- [ ] Workflow de resumen diario generado por IA
- [ ] Integración con cámaras para análisis de imágenes (detección objetos, personas)
- [ ] Asistente conversacional completo (contexto multi-turno)
- [ ] Predicción de consumo energético con series temporales
- [ ] Recomendaciones proactivas ("Llueve, cierra las ventanas")

## 🤝 Contribuciones

Pull requests bienvenidas. Para cambios grandes, abre primero un issue.

## 📄 Licencia

MIT

## 🔗 Enlaces Útiles

- [Documentación Home Assistant](https://www.home-assistant.io/docs/)
- [Documentación n8n](https://docs.n8n.io/)
- [Modelos Ollama](https://ollama.com/library)
- [Artículo completo en eldiarioia.es](https://www.eldiarioia.es/?p=2355)

---

**¿Preguntas?** Abre un issue en este repositorio.

**¿Te fue útil?** Dale una ⭐ al repo!
