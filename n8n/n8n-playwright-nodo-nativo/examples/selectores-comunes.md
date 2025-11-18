# Selectores Comunes para n8n Playwright

Guía rápida de selectores CSS y XPath más utilizados en automatización web con el nodo Playwright de n8n.

## Selectores CSS

### Por ID
```css
#username
#password
#submit-button
```

### Por Clase
```css
.button-primary
.form-input
.menu-item
```

### Por Atributo
```css
[type="submit"]
[data-testid="login-button"]
[name="email"]
```

### Por Tipo de Elemento
```css
input
button
a
div
```

### Combinaciones
```css
form input[type="text"]
.container .item
#main > .content
```

## Selectores XPath

### Por Texto
```xpath
//button[text()="Enviar"]
//a[contains(text(), "Descargar")]
```

### Por Atributo
```xpath
//input[@name="email"]
//button[@type="submit"]
//div[@data-id="123"]
```

### Por Posición
```xpath
//div[1]
//li[last()]
//tr[position()>1]
```

### Combinaciones
```xpath
//form//input[@type="text"]
//div[@class="container"]//a
```

## Mejores Prácticas

1. **Preferir IDs** cuando estén disponibles (más estables)
2. **Usar data attributes** si el sitio los proporciona
3. **Evitar selectores por posición** (nth-child) si es posible
4. **Probar selectores** en DevTools antes de usar en n8n
5. **Usar waitForSelector** antes de interactuar con elementos

## Ejemplos Reales

### Botón de Login
```css
button[type="submit"]
#login-button
.btn-primary
```

### Campo de Email
```css
input[type="email"]
input[name="email"]
#email
```

### Tabla de Datos
```css
table tbody tr
.data-row
#results-table tr
```

### Dropdown
```css
select[name="category"]
.dropdown-menu
#category-select
```

