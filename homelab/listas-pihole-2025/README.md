# 📋 Mejores Listas de Bloqueo para Pi-hole 2025

Este repositorio contiene una recopilación completa de las mejores listas de bloqueo (blocklists) para Pi-hole en 2025, clasificadas por categorías y nivel de agresividad.

## 🚀 Inicio Rápido

### Configuración Recomendada para Principiantes

**Lista única todo-en-uno (recomendada):**
- **OISD Blocklist**: `https://big.oisd.nl/`
  - ✅ Excelente balance entre bloqueo y compatibilidad
  - ✅ ~2.5 millones de dominios
  - ✅ Muy pocos falsos positivos
  - ✅ Actualización diaria

### Configuración Avanzada

**Máxima protección (3 listas):**
1. **Hagezi Pro**: `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/pro.txt`
2. **Phishing Army Extended**: `https://phishing.army/download/phishing_army_blocklist_extended.txt`
3. **WindowsSpyBlocker**: `https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt`

---

## 📚 Categorías de Listas

### 1. 🎯 Publicidad y Rastreo (AdBlock)

#### ⭐ OISD Blocklist (RECOMENDADA #1)
- **URL**: `https://big.oisd.nl/`
- **Descripción**: Lista unificada de alta calidad que combina múltiples fuentes. Muy bien mantenida y con pocos falsos positivos.
- **Tamaño**: ~2.5 millones de dominios
- **Nivel**: Moderado
- **Actualización**: Diaria
- **Ventajas**: Excelente balance entre bloqueo y compatibilidad
- **Recomendado para**: La mayoría de usuarios

#### Hagezi Pro
- **URL**: `https://raw.githubusercontent.com/hagezi/dns-blocklists/main/domains/pro.txt`
- **Descripción**: Lista muy completa que abarca una amplia gama de dominios publicitarios y de rastreo.
- **Tamaño**: ~3.5 millones de dominios
- **Nivel**: Agresivo
- **Actualización**: Diaria
- **Ventajas**: Máxima protección, puede requerir whitelist
- **Recomendado para**: Usuarios avanzados

#### 1Hosts Lite
- **URL**: `https://o0.pages.dev/Lite/domains.txt`
- **Descripción**: Lista equilibrada que ofrece buena protección sin afectar la funcionalidad de sitios web.
- **Tamaño**: ~1.8 millones de dominios
- **Nivel**: Conservador
- **Actualización**: Diaria
- **Ventajas**: Ideal para usuarios que quieren bloqueo sin complicaciones
- **Recomendado para**: Usuarios casuales

#### StevenBlack's Unified Hosts
- **URL**: `https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts`
- **Descripción**: Combina múltiples listas populares (AdAway, Malware Domain List, etc.)
- **Tamaño**: ~150k dominios
- **Nivel**: Conservador
- **Actualización**: Semanal
- **Ventajas**: Muy estable, pocos falsos positivos
- **Recomendado para**: Usuarios que prefieren listas probadas

#### AdAway Default Blocklist
- **URL**: `https://adaway.org/hosts.txt`
- **Descripción**: Lista enfocada en bloquear anuncios en dispositivos móviles.
- **Tamaño**: ~50k dominios
- **Nivel**: Conservador
- **Actualización**: Semanal
- **Ventajas**: Ligera y rápida
- **Recomendado para**: Dispositivos con recursos limitados

#### EasyList
- **URL**: `https://easylist.to/easylist/easylist.txt`
- **Descripción**: Una de las listas más populares para bloquear anuncios en la web.
- **Tamaño**: ~70k dominios
- **Nivel**: Conservador
- **Actualización**: Diaria
- **Ventajas**: Muy probada, compatible con la mayoría de sitios
- **Recomendado para**: Usuarios que buscan compatibilidad máxima

#### EasyPrivacy
- **URL**: `https://easylist.to/easylist/easyprivacy.txt`
- **Descripción**: Complemento de EasyList que se centra en la privacidad y el rastreo.
- **Tamaño**: ~30k dominios
- **Nivel**: Conservador
- **Actualización**: Diaria
- **Ventajas**: Especializada en trackers y analytics
- **Recomendado para**: Complementar EasyList

---

### 2. 🛡️ Malware y Phishing

#### ⭐ Phishing Army Blocklist Extended (RECOMENDADA)
- **URL**: `https://phishing.army/download/phishing_army_blocklist_extended.txt`
- **Descripción**: Lista actualizada de dominios utilizados para phishing.
- **Tamaño**: ~200k dominios
- **Nivel**: Agresivo
- **Actualización**: Diaria
- **Ventajas**: Muy efectiva contra phishing, actualizada constantemente
- **Recomendado para**: Todos los usuarios

#### Malware Domain List
- **URL**: `https://www.malwaredomainlist.com/hostslist/hosts.txt`
- **Descripción**: Lista de dominios conocidos por distribuir malware.
- **Tamaño**: ~15k dominios
- **Nivel**: Conservador
- **Actualización**: Semanal
- **Ventajas**: Lista confiable y estable
- **Recomendado para**: Protección básica contra malware

#### Prigent Malware
- **URL**: `https://v.firebog.net/hosts/Prigent-Malware.txt`
- **Descripción**: Lista de malware mantenida por Prigent.
- **Tamaño**: ~25k dominios
- **Nivel**: Conservador
- **Actualización**: Semanal
- **Ventajas**: Buena cobertura de malware conocido
- **Recomendado para**: Complementar otras listas de malware

#### Prigent Phishing
- **URL**: `https://v.firebog.net/hosts/Prigent-Phishing.txt`
- **Descripción**: Lista de phishing mantenida por Prigent.
- **Tamaño**: ~20k dominios
- **Nivel**: Conservador
- **Actualización**: Semanal
- **Ventajas**: Complementa otras listas de phishing
- **Recomendado para**: Protección adicional contra phishing

---

### 3. 📊 Trackers y Analytics

#### Fanboy's Enhanced Tracking List
- **URL**: `https://secure.fanboy.co.nz/enhancedstats.txt`
- **Descripción**: Lista que bloquea rastreadores adicionales no cubiertos por EasyPrivacy.
- **Tamaño**: ~40k dominios
- **Nivel**: Moderado
- **Actualización**: Semanal
- **Ventajas**: Especializada en trackers de analytics
- **Recomendado para**: Usuarios preocupados por la privacidad

#### WindowsSpyBlocker
- **URL**: `https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt`
- **Descripción**: Bloquea dominios utilizados por Windows para telemetría.
- **Tamaño**: ~5k dominios
- **Nivel**: Conservador
- **Actualización**: Semanal
- **Ventajas**: Específica para Windows, reduce telemetría
- **Recomendado para**: Usuarios de Windows

---

### 4. 📱 Redes Sociales

#### Nick Oppen's Unified Social Media Lists
- **URL**: `https://nickoppen.github.io/pihole-blocklists/unifiedSocialMediaLists.txt`
- **Descripción**: Bloquea dominios relacionados con redes sociales (Facebook, Twitter, Instagram, etc.)
- **Tamaño**: ~50k dominios
- **Nivel**: Agresivo
- **Actualización**: Semanal
- **Ventajas**: Bloqueo completo de redes sociales
- **Recomendado para**: Usuarios que quieren bloquear redes sociales

#### No Facebook
- **URL**: `https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/facebook/all`
- **Descripción**: Bloquea todos los dominios relacionados con Facebook.
- **Tamaño**: ~10k dominios
- **Nivel**: Agresivo
- **Actualización**: Mensual
- **Ventajas**: Específica para Facebook
- **Recomendado para**: Bloqueo selectivo de Facebook

#### No Twitter
- **URL**: `https://raw.githubusercontent.com/jmdugan/blocklists/master/corporations/twitter/all`
- **Descripción**: Bloquea todos los dominios relacionados con Twitter/X.
- **Tamaño**: ~5k dominios
- **Nivel**: Agresivo
- **Actualización**: Mensual
- **Ventajas**: Específica para Twitter/X
- **Recomendado para**: Bloqueo selectivo de Twitter

---

### 5. 🔞 Contenido para Adultos

#### StevenBlack's Adult Content Blocklist
- **URL**: `https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts`
- **Descripción**: Lista para bloquear sitios con contenido para adultos, fakenews y apuestas.
- **Tamaño**: ~100k dominios
- **Nivel**: Agresivo
- **Actualización**: Semanal
- **Ventajas**: Combina múltiples categorías
- **Recomendado para**: Protección familiar

#### HomeTinker Protection of Minors
- **URL**: `https://blocklists.hometinker.io/lists/protection-of-minors.txt`
- **Descripción**: Lista enfocada en bloquear sitios con contenido para adultos.
- **Tamaño**: ~80k dominios
- **Nivel**: Agresivo
- **Actualización**: Semanal
- **Ventajas**: Específica para protección de menores
- **Recomendado para**: Familias con niños

---

### 6. 📰 Fakenews

#### StevenBlack's Fakenews Blocklist
- **URL**: `https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts`
- **Descripción**: Bloquea sitios conocidos por distribuir noticias falsas.
- **Tamaño**: ~5k dominios
- **Nivel**: Moderado
- **Actualización**: Semanal
- **Ventajas**: Reduce exposición a fakenews
- **Recomendado para**: Usuarios preocupados por información falsa

---

## 🔧 Cómo Añadir Listas a Pi-hole

### Método 1: Interfaz Web (Recomendado)

1. Accede a la interfaz web de Pi-hole: `http://pi.hole/admin/`
2. Navega a **"Group Management"** > **"Adlists"**
3. En el campo **"Address"**, introduce la URL de la lista deseada
4. Proporciona una descripción en el campo **"Description"** (opcional)
5. Haz clic en **"Add"** para añadir la lista
6. Repite para cada lista que quieras añadir
7. Una vez añadidas todas, ve a **"Tools"** > **"Update Gravity"** y haz clic en **"Update"** para aplicar los cambios

### Método 2: Línea de Comandos

```bash
# Añadir una lista
pihole -a -w https://big.oisd.nl/

# Actualizar todas las listas
pihole -g
```

---

## ⚙️ RegEx Avanzadas

Si quieres bloquear patrones específicos, puedes usar expresiones regulares en Pi-hole:

### Patrones Recomendados

1. **Bloquear dominios de anuncios**: `(^|\.)ads?[0-9]*\.`
2. **Bloquear trackers**: `(^|\.)track(ing|er)?[0-9]*\.`
3. **Bloquear analytics**: `(^|\.)analytics?[0-9]*\.`
4. **Bloquear Google DoubleClick**: `(^|\.)doubleclick\.`
5. **Bloquear Google AdSense**: `(^|\.)googlesyndication\.`
6. **Bloquear Facebook tracking**: `(^|\.)facebook\.net$`
7. **Bloquear Amazon ads**: `(^|\.)amazon-adsystem\.`
8. **Bloquear ComScore**: `(^|\.)scorecardresearch\.`

### Cómo Añadir RegEx

1. Accede a Pi-hole Admin → **"Group Management"** > **"Regex"**
2. Introduce el patrón en el campo **"Regex"**
3. Haz clic en **"Add"**

---

## ✅ Whitelist Esencial

### Dominios que NO debes bloquear

#### Google Services (si usas Gmail, Google Drive, etc.)
```
google.com
gmail.com
googleapis.com
googleusercontent.com
gstatic.com
```

#### Microsoft Services (si usas Office 365, Outlook, etc.)
```
microsoft.com
office.com
live.com
outlook.com
microsoftonline.com
```

#### CDNs Esenciales
```
cloudflare.com
cloudfront.net
fastly.com
jsdelivr.net
```

#### Actualizaciones del Sistema
```
windowsupdate.com
update.microsoft.com
download.microsoft.com
```

#### Servicios de Pago
```
paypal.com
stripe.com
visa.com
mastercard.com
```

---

## 🐛 Troubleshooting

### Problema: Sitios web no cargan

**Causa**: Falso positivo - un dominio legítimo está en la lista de bloqueo.

**Solución**:
1. Accede a Pi-hole Admin → **Query Log**
2. Busca el dominio que está fallando
3. Si aparece como bloqueado, añádelo a la **Whitelist**
4. Ejecuta `pihole -g` para actualizar

### Problema: Pi-hole muy lento

**Causa**: Demasiadas listas o listas muy grandes.

**Solución**:
1. Reduce el número de listas activas (máximo 10-15 listas)
2. Usa listas unificadas (OISD, Hagezi) en lugar de múltiples pequeñas
3. Considera usar una Raspberry Pi 4 o superior
4. Aumenta la RAM si es posible

### Problema: Actualizaciones fallan

**Causa**: Lista temporalmente no disponible o URL incorrecta.

**Solución**:
1. Verifica que la URL de la lista sigue siendo válida
2. Revisa los logs: `pihole -t`
3. Elimina listas que fallan repetidamente
4. Usa listas de fuentes confiables (Firebog, GitHub)

---

## 📊 Comparativas

### Conservador vs Agresivo

| Aspecto | Conservador | Agresivo |
|---------|-------------|----------|
| Dominios bloqueados | 1-2 millones | 5-10+ millones |
| Falsos positivos | Muy pocos | Frecuentes |
| Rendimiento | Excelente | Puede ser lento |
| Protección | Básica | Máxima |
| Mantenimiento | Mínimo | Requiere whitelist activa |
| Recomendado para | Usuarios casuales | Usuarios avanzados |

### Listas Unificadas vs Múltiples Listas

| Aspecto | Unificadas (OISD, Hagezi) | Múltiples Listas |
|---------|---------------------------|------------------|
| Facilidad | Alta | Media |
| Rendimiento | Mejor | Puede ser peor |
| Control | Bajo | Alto |
| Mantenimiento | Fácil | Requiere más atención |
| Recomendado para | La mayoría de usuarios | Usuarios que quieren control fino |

---

## 🎯 Configuraciones Recomendadas

### Configuración 1: Usuario Casual
**Objetivo**: Bloquear anuncios sin complicaciones

**Listas**:
- OISD Blocklist (1 lista)

**Total**: ~2.5 millones de dominios

**Resultado**: Bloqueo efectivo con mínimos falsos positivos

---

### Configuración 2: Usuario Avanzado
**Objetivo**: Máxima protección y privacidad

**Listas**:
- Hagezi Pro
- Phishing Army Extended
- WindowsSpyBlocker

**Total**: ~3.7 millones de dominios

**Resultado**: Protección máxima, requiere whitelist activa

---

### Configuración 3: Protección Familiar
**Objetivo**: Bloquear contenido inapropiado y anuncios

**Listas**:
- OISD Blocklist
- HomeTinker Protection of Minors
- StevenBlack Fakenews

**Total**: ~2.6 millones de dominios

**Resultado**: Protección familiar completa

---

## 📝 Scripts de Automatización

### Script de Actualización Automática

Crea un script `actualizar_listas.sh`:

```bash
#!/bin/bash
# Actualizar listas de Pi-hole automáticamente

echo "🔄 Actualizando listas de Pi-hole..."
pihole -g

if [ $? -eq 0 ]; then
    echo "✅ Listas actualizadas correctamente"
else
    echo "❌ Error al actualizar listas"
    exit 1
fi
```

Hazlo ejecutable:
```bash
chmod +x actualizar_listas.sh
```

Añádelo a cron para actualización diaria:
```bash
# Editar crontab
crontab -e

# Añadir línea (actualiza a las 3 AM diariamente)
0 3 * * * /ruta/al/script/actualizar_listas.sh
```

---

## 🔗 Recursos Adicionales

- [Pi-hole Documentation](https://docs.pi-hole.net/)
- [Firebog - The Big Blocklist Collection](https://v.firebog.net/hosts/)
- [Pi-hole Community Forums](https://discourse.pi-hole.net/)
- [StevenBlack's Hosts Repository](https://github.com/StevenBlack/hosts)
- [OISD Blocklist](https://oisd.nl/)

---

## 📄 Licencia

Este repositorio es de código abierto y está disponible bajo la licencia MIT.

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Si encuentras una lista que debería estar incluida o tienes sugerencias, por favor abre un issue o pull request.

---

**Última actualización**: Diciembre 2025

