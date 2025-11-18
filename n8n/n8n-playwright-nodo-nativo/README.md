# n8n Playwright - Nodo Nativo: Ejemplos y Workflows

Este repositorio contiene ejemplos prácticos de workflows de n8n usando el nodo Playwright nativo para automatización web.

## 📋 Contenido

### Workflows Incluidos

1. **scraping-basico.json** - Extracción básica de datos de una página web
2. **formulario.json** - Automatización de rellenado y envío de formularios
3. **screenshot.json** - Captura de pantalla de páginas web
4. **pdf.json** - Generación de PDFs desde páginas web
5. **login.json** - Automatización de inicio de sesión
6. **monitoreo.json** - Monitoreo de cambios en páginas web
7. **ecommerce.json** - Scraping de precios de productos

### Ejemplos de Selectores

- `examples/selectores-comunes.md` - Guía de selectores CSS y XPath más usados

## 🚀 Cómo Usar

1. **Importar workflow en n8n:**
   - Abre n8n
   - Ve a "Workflows" → "Import from File"
   - Selecciona el archivo JSON que quieras importar

2. **Configurar credenciales:**
   - Ajusta las URLs según tus necesidades
   - Configura variables de entorno si es necesario
   - Revisa los selectores CSS/XPath

3. **Ejecutar:**
   - Activa el workflow
   - Ejecuta manualmente o configura triggers

## 📚 Artículo Completo

Para la guía completa sobre el nodo Playwright nativo de n8n, visita:
**https://www.eldiarioia.es/2025/11/18/n8n-playwright-nodo-nativo-automatizacion-web/**

## ⚠️ Notas Importantes

- **Versión mínima de n8n:** Verifica que tu versión de n8n soporte el nodo Playwright nativo
- **Recursos:** El nodo Playwright consume RAM (200-400MB por instancia)
- **Selectores:** Los selectores CSS/XPath pueden cambiar según el sitio web
- **Legalidad:** Asegúrate de tener permiso para hacer scraping de los sitios web

## 🔗 Recursos Adicionales

- [Documentación oficial de n8n](https://docs.n8n.io/)
- [Documentación de Playwright](https://playwright.dev/)
- [Comunidad de n8n](https://community.n8n.io/)

## 📝 Licencia

Estos ejemplos son de código abierto y están disponibles para uso personal y comercial.

