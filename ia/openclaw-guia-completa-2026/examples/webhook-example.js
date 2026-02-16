/**
 * OpenClaw Webhook Example
 * Ejemplo de integración de OpenClaw con webhook personalizado
 * 
 * Uso:
 *   1. npm install express openclaw
 *   2. Configura las variables de entorno
 *   3. node webhook-example.js
 */

const express = require('express');
const { OpenClaw } = require('openclaw');
require('dotenv').config();

const app = express();
app.use(express.json());

// Inicializar OpenClaw
const openclaw = new OpenClaw({
  apiKey: process.env.ANTHROPIC_API_KEY || process.env.OPENAI_API_KEY,
  model: process.env.OPENCLAW_MODEL || 'claude-3-5-sonnet-20241022',
  temperature: 0.7,
  maxTokens: 4096
});

// Middleware de autenticación básica
const authenticate = (req, res, next) => {
  const apiKey = req.headers['x-api-key'];
  const expectedKey = process.env.WEBHOOK_API_KEY;
  
  if (!expectedKey) {
    console.warn('⚠️  WEBHOOK_API_KEY no configurada. Webhook sin autenticación.');
    return next();
  }
  
  if (apiKey !== expectedKey) {
    return res.status(401).json({
      success: false,
      error: 'Unauthorized'
    });
  }
  
  next();
};

// Endpoint principal del webhook
app.post('/webhook/openclaw', authenticate, async (req, res) => {
  const { message, context, tools } = req.body;
  
  if (!message) {
    return res.status(400).json({
      success: false,
      error: 'Message is required'
    });
  }
  
  try {
    console.log(`📨 Procesando mensaje: ${message.substring(0, 50)}...`);
    
    // Procesar con OpenClaw
    const response = await openclaw.process({
      message,
      context: context || {},
      tools: tools || ['web_search', 'api_call', 'file_operation'],
      stream: false
    });
    
    console.log(`✅ Respuesta generada: ${response.content.substring(0, 50)}...`);
    
    res.json({
      success: true,
      response: response.content,
      actions: response.actions || [],
      usage: response.usage || {},
      timestamp: new Date().toISOString()
    });
    
  } catch (error) {
    console.error('❌ Error procesando webhook:', error);
    
    res.status(500).json({
      success: false,
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

// Endpoint de health check
app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    service: 'openclaw-webhook',
    timestamp: new Date().toISOString()
  });
});

// Endpoint de información
app.get('/info', (req, res) => {
  res.json({
    service: 'OpenClaw Webhook',
    version: '1.0.0',
    endpoints: {
      webhook: 'POST /webhook/openclaw',
      health: 'GET /health',
      info: 'GET /info'
    },
    documentation: 'https://openclawapi.org/es'
  });
});

// Iniciar servidor
const PORT = process.env.PORT || 3000;
const HOST = process.env.HOST || '0.0.0.0';

app.listen(PORT, HOST, () => {
  console.log(`🚀 OpenClaw Webhook Server running on http://${HOST}:${PORT}`);
  console.log(`📡 Webhook endpoint: http://${HOST}:${PORT}/webhook/openclaw`);
  console.log(`❤️  Health check: http://${HOST}:${PORT}/health`);
});

// Manejo de errores no capturados
process.on('unhandledRejection', (error) => {
  console.error('❌ Unhandled rejection:', error);
});

process.on('uncaughtException', (error) => {
  console.error('❌ Uncaught exception:', error);
  process.exit(1);
});

