# CONTEXTO MAESTRO - IntelliCore POS | Sistema AEDD Enterprise

## 🎯 OBJETIVO PRIMARIO DEL REPOSITORIO
**ITERACIÓN CONTINUA SOBRE EL PROYECTO INTELLICORE POS**

### **MARCO DE CONTENCIÓN CONTEXTUAL**
```
USUARIO EN REPOSITORIO → DETECTAR INTENCIÓN → CANALIZAR A ITERACIÓN → COMPLETAR CICLO
```

**Todo en este repositorio está diseñado para:**
1. **Identificar necesidades de mejora** del sistema IntelliCore POS
2. **Implementar iteraciones** específicas y documentadas  
3. **Evolucionar el proyecto** de forma controlada y medible
4. **Mantener coherencia** arquitectural y de negocio

### **INDICADORES DE DESVIACIÓN CONTEXTUAL**
🚨 **El sistema debe redirigir si detecta:**
- Preguntas teóricas sin intención implementativa
- Solicitudes fuera del dominio POS multi-vertical
- Discusiones arquitecturales sin propósito de iteración
- Exploraciones tecnológicas no relacionadas al stack actual

### **RESPUESTA AUTOMÁTICA A DESVÍOS**
```
"Detectado contexto fuera del objetivo de iteración. 
¿Tu solicitud busca mejorar/implementar algo específico en IntelliCore POS?
Usa: /start-session [tipo] [descripción específica de mejora]"
```

## SISTEMA DE NAVEGACIÓN MODULAR

### **PUNTO DE ENTRADA ÚNICO**
```
/start-session <tipo> <descripción>
/project-overview                    # Información fundamental para nuevos usuarios
/last-session                       # Estado de la última iteración
/session-history                    # Historial de iteraciones recientes
```

**Preparación automática de entorno incluida:**
- **Detección automática de usuarios nuevos** con onboarding inteligente
- Detección automática de nueva iteración
- Verificación y preparación de entorno Git
- Creación inteligente de ramas feature
- Carga optimizada de contexto específico
- **Tracking de sesiones anteriores** para continuidad

**Para uso eficiente, carga solo:**
1. Este contexto maestro (base) 
2. AEDD_NAVIGATOR.md (routing inteligente optimizado + sistema modular + onboarding)
3. PROJECT_OVERVIEW.md (si usuario nuevo detectado)
4. Módulos específicos según sesión (auto-cargados por navigator)

**Módulos disponibles:** `PROJECT_OVERVIEW.md` | `ESPECIALIZACIONES.md` | `PATRONES_CODIGO.md` | `DEPENDENCIAS.md` | `ESTRATEGIAS_IMPLEMENTACION.md` | `TESTING_PROTOCOLS.md` | `DOCUMENTACION_AUTOMATICA.md` | `CONTAINMENT_SYSTEM.md`

---

## INFORMACIÓN ESENCIAL DEL PROYECTO

### **Identidad del Proyecto**
- **Nombre:** IntelliCore POS
- **Tipo:** Plataforma Multi-Vertical Enterprise (Restaurant, Hotel, Retail, Services, Healthcare)
- **Stack Principal:** FastAPI (Backend) + Angular (Frontend) + PostgreSQL
- **Metodología:** AEDD (Auto-Evolutionary Documentation Development)

### **Arquitectura Multi-Vertical**
```
Backend (FastAPI) ←→ Frontend (Angular) ←→ PostgreSQL
     ↓                    ↓                   ↓
Core Services         UI Components      Multi-Tenancy
Vertical APIs         Vertical Modules   Tenant Schemas  
Shared Services       Analytics UI       Cross-Vertical Data
```

**Verticales Soportados:**
- **Restaurant:** Órdenes, mesas, menús, cocina
- **Hotel:** Reservas, habitaciones, check-in/out, housekeeping  
- **Retail:** Inventario, ventas, productos, promociones
- **Services:** Citas, profesionales, calendarios, facturación
- **Healthcare:** Pacientes, consultas, historial médico

### **Casos de Uso Críticos Multi-Vertical**
1. **CU-001: Procesamiento de Transacciones** - Core universal para todos los verticales
2. **CU-002: Gestión de Inventario/Stock** - Adaptado por vertical (productos/habitaciones/servicios)  
3. **CU-003: Analytics Cross-Vertical** - Dashboard unificado con métricas específicas
4. **CU-004: Gestión de Usuarios/Clientes** - Multi-tenancy con roles por vertical
5. **CU-005: Configuración Enterprise** - Admin centralizada multi-vertical

### **Casos de Uso por Vertical**
- **Restaurant:** Gestión de mesas, órdenes en tiempo real, integración cocina
- **Hotel:** Sistema de reservas con overbooking, gestión de habitaciones
- **Retail:** Control de inventario, promociones, ventas multi-canal
- **Services:** Calendario de citas, gestión de profesionales
- **Healthcare:** Expedientes médicos, consultas, compliance HIPAA

### **Reglas de Negocio Enterprise**
- **Multi-Tenancy:** Aislamiento completo entre tenants con shared infrastructure
- **Atomicidad:** Transacciones ACID cross-vertical con rollback automático
- **Auditoría:** Trazabilidad completa con compliance por vertical (PCI-DSS, HIPAA, SOX)
- **Performance:** < 300ms para operaciones críticas, < 1s para analytics cross-vertical
- **Escalabilidad:** Horizontal scaling con load balancing por vertical
- **Seguridad:** Roles granulares, encryption at rest/transit, audit trails

### **Stack Tecnológico Enterprise**
- **Backend:** Clean Architecture + SOLID + Repository Pattern + Multi-Tenancy
- **Frontend:** Micro-frontends + Component-based + Reactive Programming (RxJS)
- **Base de Datos:** PostgreSQL + Row-Level Security + Partitioning by Tenant
- **Infraestructura:** Kubernetes + Docker + Helm + CI/CD + Observability Stack
- **Metodología:** AEDD con 5 especialistas LLM (DeepSeek, Qwen3, Llama3.1, Gemma3-ES, Claude-3.5)

---

## ESPECIALISTAS LLM DISPONIBLES

### **Auto-Routing por Tipo de Sesión**
- **CORE/CROSS-VERTICAL:** ARQUITECTO (DeepSeek) + DESARROLLADOR_SENIOR (Qwen3)
- **VERTICAL-SPECIFIC:** ANALISTA_NEGOCIO (Llama3.1) + DESARROLLADOR_SENIOR (Qwen3)  
- **ARCHITECTURE:** ARQUITECTO (DeepSeek) + DEVOPS_ENGINEER (Claude-3.5)
- **SECURITY:** ESPECIALISTA_SEGURIDAD (Gemma3-ES) + DESARROLLADOR_SENIOR (Qwen3)
- **DEPLOYMENT:** DEVOPS_ENGINEER (Claude-3.5) + ARQUITECTO (DeepSeek)

**Detalles completos:** Ver `ESPECIALIZACIONES.md` (auto-cargado por navigator según sesión)

---

## SISTEMA DE DOCUMENTACIÓN MODULAR

### **Estructura Optimizada (Token-Efficient)**
```
CONTEXTO_MAESTRO.md (este archivo) ← Base esencial + contención (3,200 tokens)
├── AEDD_NAVIGATOR.md ← Router optimizado + sistema modular (500 tokens)
│   ├── NAVIGATOR_ONBOARDING.md ← Flujos nuevos usuarios (800 tokens)
│   ├── NAVIGATOR_GIT_FLOW.md ← Scripts Git Flow completos (1,200 tokens)  
│   ├── NAVIGATOR_SESSION_HISTORY.md ← Historial sesiones (600 tokens)
│   ├── NAVIGATOR_EXAMPLES.md ← Ejemplos detallados (1,000 tokens)
│   ├── NAVIGATOR_SCRIPTS.md ← Scripts PowerShell/Bash (1,500 tokens)
│   └── NAVIGATOR_METRICS.md ← KPIs y métricas (400 tokens)
├── CONTAINMENT_SYSTEM.md ← Sistema de contención contextual (2,400 tokens)
├── ESPECIALIZACIONES.md ← Roles LLM (1,800 tokens)  
├── PATRONES_CODIGO.md ← Templates código (2,500 tokens)
├── DEPENDENCIAS.md ← Tech stack (2,200 tokens)
├── ESTRATEGIAS_IMPLEMENTACION.md ← Metodología AEDD (3,000 tokens)
├── TESTING_PROTOCOLS.md ← Testing cross-vertical (2,400 tokens)
├── DOCUMENTACION_AUTOMATICA.md ← Auto-docs (1,900 tokens)
└── CROSS_MODULE_VALIDATOR.md ← Validación automática (2,100 tokens)
```

**Eficiencia:** 87% reducción en Navigator principal (de ~4,000 a ~500 tokens) + carga contextual inteligente
**Sistema Modular Navigator:** Carga solo módulos necesarios según detección automática de intención
**Nuevo:** Sistema de contención contextual que mantiene foco en iteración del proyecto

### **Navegación Inteligente del Navigator**
El sistema Navigator optimizado detecta automáticamente:
- **Usuarios nuevos** → Carga NAVIGATOR_ONBOARDING.md + PROJECT_OVERVIEW.md
- **Nueva iteración** → Carga NAVIGATOR_GIT_FLOW.md + validaciones automáticas
- **Consulta historial** → Carga NAVIGATOR_SESSION_HISTORY.md + análisis Git
- **Desarrollo específico** → Carga módulos especializados según contexto

**Beneficios de la modularización:**
- Precisión contextual: Solo carga lo necesario para cada tipo de sesión
- Eficiencia de tokens: 85-90% reducción vs carga completa
- Mantenibilidad: Cada módulo especializado evoluciona independientemente
- Escalabilidad: Fácil agregar nuevos módulos especializados

### **Referencias Legacy (Solo si Necesarias)**
- `docs/llm-documentation/CASOS_USO_DETALLADOS.md` - 10 casos de uso completos
- `docs/llm-documentation/QUERIES_CASOS_USO.sql` - 50+ queries por vertical
- `docs/llm-documentation/DICCIONARIO_COMPLETO.json` - Estructura BD completa
- `docs/llm-documentation/MODELO_BD_COMPLETO_LLM.md` - Documentación técnica BD

---

## METODOLOGÍA AEDD ENTERPRISE

### **Principios del Sistema Modular:**
1. **Preparación Automática:** Detección de nueva iteración + setup Git automático
2. **Contexto Optimizado:** Solo carga información relevante a la sesión específica
3. **Auto-Routing:** Navigator detecta automáticamente especialista y módulos necesarios
4. **Coherencia Multi-Vertical:** Validaciones automáticas de consistencia cross-vertical
5. **Especialización Inteligente:** Cada LLM tiene rol específico con contexto curado
6. **Git Workflow Integration:** Preparación automática de ramas feature con naming convention
7. **Documentación Auto-Evolutiva:** Actualización automática de contexto tras implementaciones

### **Flujo de Trabajo AEDD:**
```
0. ENVIRONMENTAL PREPARATION → Detección automática + preparación Git
1. COMMAND PARSING → Navigator analiza solicitud
2. CONTEXT LOADING → Carga módulos específicos (token-optimized)
3. SPECIALIST ROUTING → Activa LLM especializado correcto
4. EXECUTION → Implementación con metodología específica
5. DOCUMENTATION → Auto-actualización de contexto y documentación
```

### **Comandos Principales:**
```
/start-session <tipo> <descripción>  ← Comando principal
/verify-environment <descripción>    ← Preparación manual de entorno
```

**Detección automática:** Navigator detecta triggers como "implementar", "crear", "desarrollar" y prepara el entorno automáticamente.

**Tipos disponibles:** `core` | `vertical` | `cross-vertical` | `architecture` | `security` | `deployment`

**Ejemplos de uso:** Ver `NAVIGATOR_EXAMPLES.md` para casos detallados

---

## VALIDACIONES Y CONTROL DE CALIDAD

### **Validaciones Automáticas del Sistema:**
- **Git Environment Check:** Verificación automática de estado del repositorio
- **Branch Management:** Creación automática de ramas feature con naming convention
- **Consistency Check:** Coherencia entre módulos cargados
- **Completeness Check:** Contexto incluye toda información necesaria  
- **Cross-Vertical Impact:** Análisis de impacto en otros verticales
- **Compliance Validation:** Verificación de reglas de negocio por vertical
- **Performance Impact:** Evaluación de rendimiento de cambios propuestos

### **Red Flags del Sistema:**
- No inventar casos de uso no documentados en módulos
- No asumir tecnologías fuera del stack enterprise definido
- No ignorar reglas de negocio multi-vertical
- No proponer cambios sin análisis de impacto cross-vertical
- No usar emoticonos/elementos decorativos (waste tokens)
- No generar documentación monolítica (usar sistema modular)
- **CONTENCIÓN CONTEXTUAL:** No responder preguntas sin intención iterativa
- **CANALIZACIÓN OBLIGATORIA:** Redirigir toda consulta hacia iteración específica
- **OBJETIVO ÚNICO:** Todo debe resultar en mejora medible del proyecto

### **Protocolo de Contención Contextual:**
```
IF (consulta_sin_intención_implementativa AND usuario_nuevo) THEN
   RESPONSE: "Detectado nuevo usuario. Cargando información fundamental del proyecto..."
   REDIRECT: Activar onboarding con PROJECT_OVERVIEW.md + clasificación de rol

IF (consulta_historial_sesión) THEN
   RESPONSE: "Consultando última iteración y progreso del proyecto..."
   REDIRECT: Cargar información de Git + docs/iteraciones/ + estado actual

IF (consulta_sin_intención_implementativa AND usuario_existente) THEN
   RESPONSE: "¿Qué aspecto específico de IntelliCore POS buscas mejorar?"
   REDIRECT: Guiar hacia /start-session con objetivo claro

IF (pregunta_teórica_general) THEN  
   RESPONSE: "Contextualiza tu consulta al proyecto IntelliCore POS"
   REDIRECT: Proporcionar ejemplo de iteración relacionada

IF (exploración_sin_propósito) THEN
   RESPONSE: "Todo en este repositorio apunta a iteración. ¿Cuál es tu objetivo específico?"
   REDIRECT: Mostrar casos de uso disponibles para iteración
```

### **Métricas de Success:**
```
PRODUCTIVIDAD:
- Tiempo iteración completa: < 45 minutos (incluye onboarding si necesario)
- Tiempo comprensión proyecto (nuevo usuario): < 2 minutos
- Precisión routing automático: > 97%
- Reducción setup manual: 85%
- Token efficiency: 80-90% vs approach manual

CALIDAD:
- Coherencia cross-vertical: > 98%
- Precisión detección contexto: > 95%
- Satisfacción onboarding: > 90%
- Efectividad contención: > 92%
- Adopción metodología AEDD: > 85%

ADOPCIÓN:
- Nuevos usuarios comprenden proyecto: > 85%
- Usuarios prefieren navigator vs manual: > 90%
- Iteraciones completadas exitosamente: > 88%
- Tiempo hasta primera contribución: < 15 minutos
```
- **Token Efficiency:** 80-90% reducción vs método manual
- **Routing Accuracy:** >95% precisión en selección de especialista
- **Git Setup Automation:** >98% de iteraciones con preparación automática exitosa
- **Context Relevance:** >98% de información cargada es relevante a la sesión
- **Implementation Quality:** Código generado pasa validaciones automáticas
- **Environment Preparation:** Reducción de 5-10 minutos a 10-15 segundos
- **Contención Contextual:** >95% de consultas canalizadas hacia iteración específica
- **Objetivo Compliance:** >98% de sesiones resultan en mejora medible del proyecto

---

## COMANDOS LEGACY Y MIGRACIÓN

### **Sistema de Comandos Actualizado:**
```
COMANDO LEGACY → NUEVO SISTEMA AEDD

/implementar-funcionalidad [desc] → Auto-detección + /start-session core [desc]
/implementar-vertical [desc] --vertical=X → Auto-detección + /start-session vertical [desc para X]
/analizar-arquitectura → /verify-environment + /start-session architecture "Análisis arquitectural"
/revisar-seguridad → /verify-environment + /start-session security "Revisión de seguridad"
/validar-caso-uso → Auto-detección + /start-session vertical "Validación caso uso específico"
/optimizar-pos → Auto-detección + /start-session cross-vertical "Optimización performance"
```

**Migración automática:** Navigator detecta comandos legacy y los redirige al sistema modular
**Nuevo:** Preparación automática de entorno Git integrada en todos los comandos
**Contención:** Sistema de canalización automática hacia iteración específica

### **EJEMPLOS DE CONTENCIÓN CONTEXTUAL**

#### Usuario se desvía del objetivo:
```
Usuario: "¿Cuál es la diferencia entre MongoDB y PostgreSQL?"

Sistema: "Detectado contexto fuera del objetivo de iteración. IntelliCore POS usa PostgreSQL enterprise.
¿Buscas optimizar algún aspecto específico de la BD en el proyecto?
Usa: /start-session architecture 'optimización base de datos PostgreSQL'"
```

#### Usuario hace pregunta genérica:
```
Usuario: "¿Cómo funciona Clean Architecture?"

Sistema: "IntelliCore POS implementa Clean Architecture. ¿Qué componente específico buscas mejorar?
Opciones de iteración:
- /start-session architecture 'refactor módulo específico'
- /start-session core 'implementar nuevo caso de uso'
- /start-session vertical 'mejorar arquitectura vertical específico'"
```

#### Usuario explora sin propósito:
```
Usuario: "Cuéntame sobre el proyecto"

Sistema: "IntelliCore POS es un sistema POS multi-vertical. ¿Qué aspecto específico te interesa iterar?
Casos disponibles para mejora:
- CU-001: Procesamiento Transacciones → /start-session core 'optimizar transacciones'
- CU-002: Gestión Inventario → /start-session vertical 'mejorar inventario [vertical]'
- CU-003: Analytics → /start-session cross-vertical 'expandir analytics'"
```

---

**Última actualización:** 2025-07-27 | **Versión:** 2.1-AEDD-Enterprise-GitAutomation | **Sistema:** Modular Navigator + Git Automation Activo
