# 📚 DOCUMENTACIÓN LLM - IntelliCore POS

## 🎯 PROPÓSITO

Esta documentación está **específicamente optimizada para LLMs** para permitir desarrollo iterativo inteligente del sistema IntelliCore POS. Cada archivo está diseñado para proporcionar contexto completo y generar código funcional sin necesidad de información adicional.

---

## 📂 ESTRUCTURA DE ARCHIVOS

### 🏗 **ARQUITECTURA Y CONTEXTO**

#### [`MODELO_BD_COMPLETO_LLM.md`](./MODELO_BD_COMPLETO_LLM.md)
**🎯 Cuándo usar**: Primera consulta para entender el dominio completo
- **Contenido**: Arquitectura de 5 capas, casos de uso principales, diferenciadores
- **Para LLMs**: Contexto completo del negocio y arquitectura técnica
- **Ejemplo uso**: *"Explica la arquitectura de IntelliCore POS"*

#### [`DICCIONARIO_COMPLETO.json`](./DICCIONARIO_COMPLETO.json)
**🎯 Cuándo usar**: Necesitas nombres exactos de tablas, campos, tipos de datos
- **Contenido**: Metadatos estructurados de todas las entidades
- **Para LLMs**: Referencia técnica precisa para generación de código
- **Ejemplo uso**: *"Crear endpoint que use las tablas exactas del sistema"*

---

### 💼 **CASOS DE USO Y BUSINESS LOGIC**

#### [`CASOS_USO_DETALLADOS.md`](./CASOS_USO_DETALLADOS.md)
**🎯 Cuándo usar**: Implementar funcionalidades específicas del negocio
- **Contenido**: 10 casos de uso completos con flujos step-by-step
- **Para LLMs**: Lógica de negocio y requirements funcionales
- **Ejemplo uso**: *"Implementar el flujo de split billing para grupos"*

---

### 🔧 **CÓDIGO Y QUERIES**

#### [`QUERIES_CASOS_USO.sql`](./QUERIES_CASOS_USO.sql)
**🎯 Cuándo usar**: Necesitas queries SQL específicos y optimizados
- **Contenido**: 50+ queries organizados por módulo funcional
- **Para LLMs**: Biblioteca copy-paste ready para desarrollo rápido
- **Ejemplo uso**: *"Usar el query de dashboard tiempo real"*

---

### 🤖 **GUÍAS PARA LLMs**

#### [`GUIA_DESARROLLO_LLM.md`](./GUIA_DESARROLLO_LLM.md)
**🎯 Cuándo usar**: Protocolo para LLMs sobre cómo usar esta documentación
- **Contenido**: Metodología, patrones, ejemplos de uso efectivo
- **Para LLMs**: Instrucciones sobre cómo procesar solicitudes de desarrollo
- **Ejemplo uso**: *Consulta obligatoria para entender cómo usar el resto de archivos*

---

## � GUÍA DE INICIO TÉCNICA

### CONFIGURACIÓN DEL ENTORNO DE DESARROLLO

#### 1. **REQUISITOS PREVIOS**

##### Software necesario:
- **VS Code** (Visual Studio Code)
- **Continue Extension** para VS Code
- **Ollama** instalado y configurado
- **Git** para control de versiones
- **Node.js** (para frontend) y **Python** (para backend)

#### 2. **CONFIGURACIÓN DE OLLAMA**

##### Instalar y configurar modelos LLM:
```bash
# Instalar DeepSeek Coder
ollama pull deepseek-coder:6.7b

# Instalar Gemma 3 (modelo en español)
ollama pull gemma2:9b

# Verificar modelos instalados
ollama list
```

##### Iniciar servicio Ollama:
```bash
# Windows
ollama serve

# Verificar que esté corriendo en localhost:11434
curl http://localhost:11434/api/version
```

#### 3. **CONFIGURACIÓN DE VS CODE + CONTINUE**

##### Instalar Continue Extension:
1. Abrir VS Code
2. Ir a Extensions (Ctrl+Shift+X)
3. Buscar "Continue" e instalar
4. Reiniciar VS Code

##### Configurar Continue para usar Ollama:
Crear/editar archivo `.continue/config.json`:
```json
{
  "models": [
    {
      "title": "DeepSeek Coder",
      "provider": "ollama",
      "model": "deepseek-coder:6.7b",
      "apiBase": "http://localhost:11434"
    },
    {
      "title": "Gemma 3 Español",
      "provider": "ollama", 
      "model": "gemma2:9b",
      "apiBase": "http://localhost:11434"
    }
  ],
  "tabAutocompleteModel": {
    "title": "DeepSeek Coder Autocomplete",
    "provider": "ollama",
    "model": "deepseek-coder:6.7b",
    "apiBase": "http://localhost:11434"
  },
  "allowAnonymousTelemetry": false
}
```

#### 4. **CONFIGURACIÓN DEL PROYECTO INTELLICORE POS**

##### Clonar y configurar repositorio:
```bash
# Clonar proyecto
git clone <url-del-repositorio> intellicore-pos
cd intellicore-pos

# Verificar estructura
ls -la docs/llm-documentation/

# Abrir en VS Code
code .
```

##### Configurar variables de entorno:
Crear archivo `.env` en la raíz del proyecto:
```env
# Base de datos
DATABASE_URL=postgresql://usuario:password@localhost:5432/intellicore_pos

# API Configuration
API_HOST=localhost
API_PORT=8000

# Ollama Configuration
OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_MODEL_CODE=deepseek-coder:6.7b
OLLAMA_MODEL_CHAT=gemma2:9b
```

#### 5. **VERIFICACIÓN DE LA CONFIGURACIÓN**

##### Test de Ollama + Continue:
1. Abrir cualquier archivo `.py` o `.js` en VS Code
2. Presionar `Ctrl+I` para abrir Continue chat
3. Escribir: "Explica la arquitectura de IntelliCore POS usando la documentación LLM"
4. Continue debería responder usando los archivos de `docs/llm-documentation/`

##### Test de autocompletado:
1. Crear nuevo archivo `test.py`
2. Escribir: `# Crear endpoint para dashboard de métricas`
3. Presionar Enter y esperar sugerencias de DeepSeek Coder
4. El autocompletado debería sugerir código relacionado con FastAPI

#### 6. **CONFIGURACIÓN AVANZADA PARA INTELLICORE POS**

##### Personalizar prompts de Continue:
Crear archivo `.continue/custom_prompts.md`:
```markdown
# CONTEXTO INTELLICORE POS
Eres un asistente especializado en el desarrollo del sistema IntelliCore POS.

## DOCUMENTACIÓN DISPONIBLE
- docs/llm-documentation/MODELO_BD_COMPLETO_LLM.md: Arquitectura completa
- docs/llm-documentation/CASOS_USO_DETALLADOS.md: Casos de uso del negocio  
- docs/llm-documentation/QUERIES_CASOS_USO.sql: Queries SQL listos para usar
- docs/llm-documentation/DICCIONARIO_COMPLETO.json: Estructura de datos

## INSTRUCCIONES
1. SIEMPRE consulta la documentación LLM antes de responder
2. Usa nomenclatura exacta de las tablas del DICCIONARIO_COMPLETO.json
3. Reutiliza queries existentes de QUERIES_CASOS_USO.sql cuando sea posible
4. Sigue los patrones establecidos en los casos de uso documentados

## TECNOLOGÍAS DEL PROYECTO
- Backend: FastAPI + PostgreSQL
- Frontend: Angular/React
- Base de datos: PostgreSQL con arquitectura de 5 capas
- Analytics: Sistema QR con ML para predicción de demanda
```

##### Atajos de teclado recomendados para VS Code:
```json
// En settings.json de VS Code
{
  "keyboard.shortcuts": [
    {
      "key": "ctrl+shift+i",
      "command": "continue.continueGUIView.focus",
      "when": "editorTextFocus"
    },
    {
      "key": "ctrl+shift+m", 
      "command": "continue.acceptVerticalDiffBlock",
      "when": "editorTextFocus"
    }
  ]
}
```

### WORKFLOW RECOMENDADO CON CONTINUE

#### Para nuevas funcionalidades:
1. **Abrir Continue Chat** (`Ctrl+I`)
2. **Solicitar contexto**: "Explica el CU-XXX de CASOS_USO_DETALLADOS.md"
3. **Pedir implementación**: "Implementa este caso de uso usando los queries de QUERIES_CASOS_USO.sql"
4. **Revisar y ajustar**: Hacer ajustes específicos según necesidades

#### Para debugging:
1. **Seleccionar código problemático**
2. **Continue Chat**: "Analiza este código considerando la arquitectura de IntelliCore POS"
3. **Solicitar solución**: "Propón una solución usando los patrones documentados"

#### Para optimización:
1. **Continue Chat**: "Optimiza este query basándote en QUERIES_CASOS_USO.sql"
2. **Pedir alternativas**: "Sugiere mejoras de rendimiento siguiendo las buenas prácticas documentadas"

---

## �🚀 QUICK START PARA LLMs

### Protocolo de Consulta Recomendado

```mermaid
graph TD
    A[Solicitud de Desarrollador] --> B{Tipo de Solicitud}
    B -->|Arquitectura/Contexto| C[MODELO_BD_COMPLETO_LLM.md]
    B -->|Datos Técnicos| D[DICCIONARIO_COMPLETO.json]
    B -->|Funcionalidad Específica| E[CASOS_USO_DETALLADOS.md]
    B -->|Query SQL| F[QUERIES_CASOS_USO.sql]
    
    C --> G[Generar Respuesta]
    D --> G
    E --> G
    F --> G
    
    G --> H{¿Necesita Validación?}
    H -->|Sí| I[GUIA_DESARROLLO_LLM.md]
    H -->|No| J[Respuesta Final]
    I --> J
```

---

## 📋 CASOS DE USO FRECUENTES

### 🔥 **Desarrollo Backend**

#### "Crear endpoint para métricas de dashboard"
1. **Consultar**: `CASOS_USO_DETALLADOS.md` → CU-005: Dashboard Ejecutivo
2. **Usar**: `QUERIES_CASOS_USO.sql` → Query ANA-001
3. **Aplicar**: Patrón de endpoint FastAPI de `GUIA_DESARROLLO_LLM.md`

#### "Implementar split billing"
1. **Entender**: `MODELO_BD_COMPLETO_LLM.md` → Diferenciadores clave
2. **Flujo**: `CASOS_USO_DETALLADOS.md` → CU-002 y CU-004
3. **Código**: `QUERIES_CASOS_USO.sql` → Queries FACT-001, FACT-002

#### "Sistema de alertas de inventario"
1. **Contexto**: `CASOS_USO_DETALLADOS.md` → CU-008: Reabastecimiento Predictivo
2. **Query**: `QUERIES_CASOS_USO.sql` → INV-003: Alertas de stock bajo
3. **Implementar**: Siguiendo patrones de `GUIA_DESARROLLO_LLM.md`

---

### 🎨 **Desarrollo Frontend**

#### "Componente de sesión QR"
1. **Flujo UX**: `CASOS_USO_DETALLADOS.md` → CU-001: Cliente Escanea QR
2. **APIs**: `QUERIES_CASOS_USO.sql` → Queries QR-001 a QR-004
3. **Estructura**: `DICCIONARIO_COMPLETO.json` → Tabla qr_sessions_analytics

#### "Dashboard de analytics"
1. **KPIs**: `CASOS_USO_DETALLADOS.md` → CU-005 y CU-006
2. **Datos**: `QUERIES_CASOS_USO.sql` → Queries ANA-001 a ANA-004
3. **Métricas**: `MODELO_BD_COMPLETO_LLM.md` → Sección Analytics

---

### 🗄 **Desarrollo Database**

#### "Optimizar queries de reportes"
1. **Queries base**: `QUERIES_CASOS_USO.sql` → Sección reportes ejecutivos
2. **Índices**: `GUIA_DESARROLLO_LLM.md` → Sección optimizaciones
3. **Estructura**: `DICCIONARIO_COMPLETO.json` → Relaciones entre tablas

#### "Crear nuevas métricas ML"
1. **Casos uso**: `CASOS_USO_DETALLADOS.md` → CU-006: Predicción de Demanda
2. **Patterns**: `QUERIES_CASOS_USO.sql` → Query ANA-004
3. **Features**: `DICCIONARIO_COMPLETO.json` → ml_features por tabla

---

## 🎯 OBJETIVOS DE EFECTIVIDAD

### Para el LLM:
- **Tiempo de contexto**: < 30 segundos para entender cualquier solicitud
- **Precisión técnica**: 95%+ uso correcto de nomenclatura y patrones
- **Completitud**: Respuestas que no requieren información adicional

### Para el Desarrollador:
- **Velocidad desarrollo**: 60-80% reducción en tiempo de implementación
- **Consistencia**: 100% alineación con arquitectura documentada
- **Calidad**: Código funcional desde la primera iteración

---

## 📊 MÉTRICAS DE USO DOCUMENTACIÓN

### Indicadores de Efectividad LLM:
- **Reutilización Queries**: % de queries de biblioteca utilizados
- **Consistencia Nomenclatura**: % uso correcto de nombres de BD
- **Alineación Casos Uso**: % implementaciones que siguen flujos documentados
- **Tiempo Primera Implementación**: Minutos desde solicitud hasta código funcional

---

## ⚡ TIPS PARA MÁXIMA EFECTIVIDAD

### Para Desarrolladores:

```markdown
✅ **ESPECÍFICO**: "Implementar CU-002 split billing con endpoint FastAPI"
❌ **VAGO**: "Necesito hacer facturación"

✅ **REFERENCIAR**: "Usar query ANA-001 para dashboard tiempo real"
❌ **GENÉRICO**: "Mostrar métricas del restaurante"

✅ **CONTEXTO**: "Siguiendo arquitectura de 5 capas de IntelliCore POS"
❌ **SIN CONTEXTO**: "Crear sistema POS general"
```

### Para LLMs:

```markdown
✅ **CONSULTAR SIEMPRE**: Leer documentación antes de responder
✅ **REFERENCIAR**: Mencionar qué archivos y secciones usaste
✅ **EXPLICAR**: Por qué esa implementación específica
✅ **VALIDAR**: Contra casos de uso documentados
```

---

## 🔄 ITERACIONES Y MEJORAS

Esta documentación LLM evoluciona con el proyecto:

1. **Feedback Loops**: Incorporar patrones de solicitudes frecuentes
2. **Nuevos Casos Uso**: Documentar funcionalidades emergentes
3. **Optimizaciones**: Refinar queries basado en performance real
4. **Patterns**: Documentar patrones de código que funcionan bien

---

## 📞 SOPORTE Y CONTRIBUCIONES

Para mejoras a esta documentación LLM:

1. **Issues**: Reportar casos donde LLM no puede generar código funcional
2. **PRs**: Añadir nuevos casos de uso o queries optimizados
3. **Feedback**: Métricas de efectividad y tiempo de desarrollo

---

*🤖 Esta documentación transforma el desarrollo de IntelliCore POS en un proceso de colaboración inteligente entre humanos y LLMs.*
