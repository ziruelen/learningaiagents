/**
 * Ejemplo de uso de LocalAI con Node.js
 * Compatible con OpenAI SDK
 */
const OpenAI = require('openai');

// Configurar cliente LocalAI (compatible con OpenAI)
const openai = new OpenAI({
  apiKey: 'not-needed',  // LocalAI no requiere API key
  baseURL: 'http://localhost:8080/v1'  // URL de tu instancia LocalAI
});

// Usar exactamente igual que OpenAI
async function main() {
  try {
    const completion = await openai.chat.completions.create({
      model: 'gpt-4',  // Nombre del modelo configurado en LocalAI
      messages: [
        { role: 'system', content: 'Eres un asistente útil.' },
        { role: 'user', content: 'Explica qué es LocalAI en una frase.' }
      ],
      temperature: 0.7,
      max_tokens: 150
    });

    // Imprimir respuesta
    console.log('Respuesta de LocalAI:');
    console.log(completion.choices[0].message.content);
    
    // Información adicional
    console.log(`\nModelo usado: ${completion.model}`);
    console.log(`Tokens usados: ${completion.usage.total_tokens}`);
  } catch (error) {
    console.error('Error:', error.message);
  }
}

main();

