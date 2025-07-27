# NAVIGATOR ONBOARDING - Flujos para Nuevos Usuarios

## DETECCIÓN AUTOMÁTICA DE USUARIO NUEVO

### 🔍 TRIGGERS DE ONBOARDING
```javascript
const ONBOARDING_TRIGGERS = {
  general_questions: ['¿qué es?', 'de qué trata', 'explica', 'overview'],
  exploration: ['dame información', 'no conozco', 'primera vez'],
  architecture_inquiry: ['arquitectura general', 'tecnologías', 'stack'],
  project_inquiry: ['cómo funciona', 'para qué sirve', 'objetivo']
}
```

### 📋 RESPUESTA AUTOMÁTICA
```
ESCENARIO: Usuario nuevo detectado
→ CARGAR: PROJECT_OVERVIEW.md (información fundamental)
→ RESPUESTA: "Detectado nuevo usuario. Cargando información fundamental..."
→ CLASIFICAR: Rol del usuario (Desarrollador/Analista/DevOps)
→ GUIAR: Hacia objetivos específicos de iteración
```

## FLUJOS POR ROL

### 👨‍💻 DESARROLLADOR
```
CONTEXTO INICIAL:
- PROJECT_OVERVIEW.md → Información del proyecto
- DEPENDENCIAS.md → Stack tecnológico  
- CASOS_USO_DETALLADOS.md → Funcionalidades implementadas

PRÓXIMOS PASOS:
- /start-session architecture "review stack técnico"
- /start-session core "explorar patrones de código"
- /verify-environment "preparar entorno desarrollo"
```

### 📊 ANALISTA/PRODUCT MANAGER
```
CONTEXTO INICIAL:
- PROJECT_OVERVIEW.md → Información del proyecto
- ESPECIALIZACIONES.md → Verticales y casos de uso
- CONTEXTO_MAESTRO.md → Arquitectura de negocio

PRÓXIMOS PASOS:
- /start-session vertical "review casos de uso restaurant"
- /start-session onboarding "explorar reglas de negocio"
```

### 🛠️ DEVOPS/INFRASTRUCTURE
```
CONTEXTO INICIAL:
- PROJECT_OVERVIEW.md → Información del proyecto
- DEPENDENCIAS.md → Stack tecnológico e infraestructura
- Documentación de deployment

PRÓXIMOS PASOS:
- /start-session deployment "review infraestructura"
- /start-session architecture "review arquitectura técnica"
```

## EJEMPLO COMPLETO DE ONBOARDING

### 📝 FLUJO PASO A PASO
```
Usuario: "No conozco el proyecto, ¿de qué trata este repositorio?"

1. DETECCIÓN AUTOMÁTICA:
   ├── Trigger: "no conozco" + "de qué trata" → ONBOARDING_NEEDED
   ├── Carga automática: PROJECT_OVERVIEW.md
   └── Modo: EDUCATIVO (no implementación)

2. RESPUESTA ESTRUCTURADA:
   📋 INTELLICORE POS - INFORMACIÓN FUNDAMENTAL
   
   IntelliCore POS es una plataforma empresarial multi-vertical...
   
   VERTICALES SOPORTADOS:
   ✅ Restaurant: Operativo (Q4 2024)
   🔄 Hotel: En desarrollo (Q2 2025)  
   📋 Retail: Roadmap (Q3 2025)
   📋 Services: Roadmap (Q4 2025)
   📋 Healthcare: Roadmap (Q1 2026)

3. CLASIFICACIÓN DE ROL:
   ¿Cuál es tu rol en el proyecto?
   - 👨‍💻 Desarrollador → Revisar stack técnico
   - 📊 Analista/Product → Revisar casos de uso
   - 🛠️ DevOps → Revisar infraestructura
   - 🎯 Otro → Especificar interés

4. GUÍA DE CONTINUACIÓN:
   Rutas recomendadas según tu rol...
   ¿Qué te gustaría hacer específicamente?
```

## TEMPLATES DE RESPUESTA

### 🎯 TEMPLATE GENERAL
```markdown
👋 BIENVENIDO A INTELLICORE POS

Detectado nuevo usuario. Cargando información fundamental...

📋 INFORMACIÓN DEL PROYECTO:
{PROJECT_OVERVIEW_CONTENT}

🎯 ESTADO ACTUAL:
{CURRENT_PROJECT_STATUS}

🔍 PRÓXIMOS PASOS:
Elige tu camino según tu rol e interés:
{ROLE_SPECIFIC_PATHS}

¿Qué te gustaría explorar primero?
```

### 🔧 TEMPLATE TÉCNICO (Desarrolladores)
```markdown
👨‍💻 ONBOARDING TÉCNICO - INTELLICORE POS

📚 STACK TECNOLÓGICO:
{TECH_STACK_SUMMARY}

🏗️ ARQUITECTURA:
{ARCHITECTURE_OVERVIEW}

🧪 CASOS DE USO IMPLEMENTADOS:
{IMPLEMENTED_USE_CASES}

🔗 RECURSOS TÉCNICOS:
- Patrones de código: PATRONES_CODIGO.md
- Dependencias: DEPENDENCIAS.md  
- Testing: TESTING_PROTOCOLS.md

🚀 EMPEZAR A DESARROLLAR:
/verify-environment "explorar codebase"
```

### 📊 TEMPLATE NEGOCIO (Analistas)
```markdown
📊 ONBOARDING NEGOCIO - INTELLICORE POS

🎯 PROPÓSITO:
{BUSINESS_PURPOSE}

🏢 VERTICALES:
{VERTICAL_BREAKDOWN}

📋 CASOS DE USO:
{BUSINESS_USE_CASES}

📈 ROADMAP:
{PROJECT_ROADMAP}

🔗 RECURSOS DE NEGOCIO:
- Especializaciones: ESPECIALIZACIONES.md
- Casos de uso: CASOS_USO_DETALLADOS.md

📝 EXPLORAR FUNCIONALIDADES:
/start-session vertical "review casos de uso [vertical]"
```

## MÉTRICAS DE ONBOARDING

### 📊 KPIs OBJETIVO
- **Tiempo de comprensión:** < 2 minutos
- **Satisfacción inicial:** > 85%
- **Continuación a desarrollo:** > 70%
- **Precisión de clasificación de rol:** > 90%

### 📈 SEGUIMIENTO
- **Usuarios nuevos detectados:** Automático
- **Rutas elegidas por rol:** Tracking
- **Tiempo hasta primera iteración:** Medición
- **Feedback de onboarding:** Opcional
