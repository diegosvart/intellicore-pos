# AEDD NAVIGATOR - Router Inteligente IntelliCore POS

## PROPÓSITO
Sistema de routing inteligente que actúa como punto de entrada único para la metodología AEDD Enterprise, proporcionando auto-routing de comandos, selección automática de especialistas, carga inteligente de contexto modular y **onboarding automático para nuevos usuarios**.

## PRE-ITERACIÓN WORKFLOW

### FASE 0A: DETECCIÓN DE USUARIO NUEVO (ONBOARDING)
```
TRIGGER DETECTION → USER CLASSIFICATION → ONBOARDING OR ITERATION → CONTEXT LOADING
```

#### DETECCIÓN AUTOMÁTICA DE ONBOARDING NECESARIO
El Navigator detecta automáticamente nuevos usuarios mediante:

**Triggers de detección de nuevo usuario:**
- Preguntas genéricas: "¿qué es esto?", "de qué trata", "cómo funciona"
- Exploración sin dirección: "explica el proyecto", "dame un overview"
- Ausencia de intención específica: Sin mencionar implementación o mejora
- Consultas de arquitectura general sin contexto específico

#### RESPUESTA AUTOMÁTICA DE ONBOARDING
```
ESCENARIO: Usuario nuevo detectado
→ CARGAR: PROJECT_OVERVIEW.md (información fundamental)
→ RESPUESTA: "Detectado nuevo usuario. Cargando información fundamental del proyecto..."
→ OFRECER: Rutas de onboarding específicas por rol
→ GUIAR: Hacia objetivos específicos de iteración
```

### FASE 0B: PREPARACIÓN AUTOMÁTICA DE ENTORNO (USUARIOS EXISTENTES)
```
DETECCIÓN DE INTENCIÓN → VERIFICACIÓN GIT → PREPARACIÓN CONTEXTO → INICIO SESIÓN
```

#### DETECCIÓN AUTOMÁTICA DE NUEVA ITERACIÓN
El Navigator detecta automáticamente cuando el usuario solicita una nueva funcionalidad mediante:

**Triggers de detección:**
- Palabras clave: "implementar", "crear", "agregar", "desarrollar", "nuevo"
- Frases: "nueva funcionalidad", "feature", "caso de uso", "sistema"
- Contexto técnico: Descripción de desarrollo específico

**IMPORTANTE:** Si no detecta estos triggers, el sistema asume usuario nuevo y activa onboarding.

#### VERIFICACIÓN AUTOMÁTICA DEL ENTORNO GIT
```bash
# COMANDO INTERNO EJECUTADO AUTOMÁTICAMENTE
git status --porcelain && git branch --show-current && git branch --no-merged develop
```

**Análisis automático:**
- Estado actual del repositorio
- Rama activa vs develop
- Cambios sin commit
- Ramas pendientes de merge

#### PREPARACIÓN INTELIGENTE DE RAMA
```
ESCENARIO A: Rama feature activa y limpia
→ Continuar en rama actual

ESCENARIO B: En develop o main
→ Sugerir: git checkout -b feature/YYYYMMDD-[funcionalidad]

ESCENARIO C: Cambios sin commit
→ Sugerir: git add . && git commit -m "WIP: preparando nueva iteración"

ESCENARIO D: Ramas sin merge
→ Alertar: "Ramas pendientes: [lista] - ¿Hacer merge primero?"
```

### COMANDO DE VERIFICACIÓN DE ENTORNO
```
/verify-environment [descripción-funcionalidad]
```

**Output esperado:**
```
ANÁLISIS DE ENTORNO COMPLETADO:

GIT STATUS:
Rama: feature/20250727-qr-orders (creada automáticamente)
Estado: Limpio, sin cambios pendientes
Base: Sincronizado con develop

CONTEXTO:
Módulos cargados: 4 archivos (2,847 tokens)
Especialista sugerido: DESARROLLADOR_SENIOR + ANALISTA_NEGOCIO
Tipo de sesión: VERTICAL (restaurant)

LISTO PARA ITERACIÓN. ¿Proceder con /start-session? (y/n)
```

## COMMAND ROUTER SYSTEM

### COMANDO PRINCIPAL DE ENTRADA
```
/start-session <tipo> <descripción>
/project-overview                    # Información fundamental para nuevos usuarios
/last-session                       # Estado de la última iteración
/session-history                    # Historial de iteraciones recientes
```

**Tipos de sesión disponibles:**
- `onboarding` - Para nuevos usuarios que necesitan información del proyecto
- `core` - Funcionalidad universal que afecta todos los verticales
- `vertical` - Funcionalidad específica de un vertical
- `cross-vertical` - Funcionalidad que afecta múltiples verticales
- `architecture` - Decisiones arquitecturales y patterns
- `security` - Análisis de seguridad y compliance
- `deployment` - Estrategias de despliegue y DevOps
- `review` - Revisar trabajo anterior o estado del proyecto

### AUTO-ROUTING INTELLIGENCE

#### PARA SESIÓN ONBOARDING (NUEVO)
```
INPUT: /start-session onboarding "Necesito entender el proyecto"

AUTO-ROUTING:
Especialista: ANALISTA_NEGOCIO (Llama3.1) + DESARROLLADOR_SENIOR (Qwen3)
Contexto cargado:
   - PROJECT_OVERVIEW.md → Información fundamental del proyecto
   - CONTEXTO_MAESTRO.md → Arquitectura y casos de uso principales
   - DEPENDENCIAS.md → Stack tecnológico para desarrolladores
   - CASOS_USO_DETALLADOS.md → Funcionalidades implementadas
Modo: EDUCATIVO (no implementación)
Output: Información estructurada + rutas de continuación específicas
```

#### PARA SESIÓN REVIEW/HISTORY (NUEVO)
```
INPUT: /start-session review "¿Qué se implementó en la última sesión?"

AUTO-ROUTING:
Especialista: DESARROLLADOR_SENIOR (Qwen3)
Contexto cargado:
   - Git log reciente (últimos commits)
   - docs/iteraciones/ → Archivos de iteración recientes
   - Estado actual de ramas feature
   - CONTEXTO_MAESTRO.md → Para contextualizar cambios
Modo: INFORMATIVO (resumen + próximos pasos)
Output: Resumen de progreso + recomendaciones de continuación
```

#### PARA SESIÓN CORE
```
INPUT: /start-session core "Sistema de loyalty points universal"

AUTO-ROUTING:
Especialista: DESARROLLADOR SENIOR (Qwen3) + ARQUITECTO (DeepSeek)
Contexto cargado:
   - DEPENDENCIAS.md → Stack tecnológico
   - PATRONES_CODIGO.md → Templates core universal
   - ESTRATEGIAS_IMPLEMENTACION.md → Metodología AEDD fase 2-3
   - TESTING_PROTOCOLS.md → Testing cross-vertical
Validaciones automáticas:
   - Multi-tenancy compliance
   - Cross-vertical impact assessment
   - Performance impact analysis
```
```
INPUT: /start-session vertical "Sistema de reservas hotel con overbooking"

AUTO-ROUTING:
Especialista: ANALISTA NEGOCIO (Llama3.1) + DESARROLLADOR SENIOR (Qwen3)
Contexto cargado:
   - ESPECIALIZACIONES.md → Roles específicos
   - PATRONES_CODIGO.md → Templates vertical
   - DEPENDENCIAS.md → Dependencies por vertical
Vertical detectado: HOTEL
Archivos específicos:
   - CASOS_USO_HOTEL.md (si existe)
   - Hotel business rules y compliance
```

#### PARA SESIÓN CROSS-VERTICAL
```
INPUT: /start-session cross-vertical "Analytics dashboard para todos los verticales"

AUTO-ROUTING:
Especialista: ARQUITECTO (DeepSeek) + DESARROLLADOR SENIOR (Qwen3)
Contexto cargado:
   - ESTRATEGIAS_IMPLEMENTACION.md → Cross-vertical patterns
   - TESTING_PROTOCOLS.md → Integration testing
   - DOCUMENTACION_AUTOMATICA.md → Multi-vertical docs
Verticales afectados: ALL
Análisis de impacto: REQUIRED
```

## SYNTAX PARSER INTELIGENTE

### DETECCIÓN AUTOMÁTICA DE PALABRAS CLAVE
```javascript
// Parser lógico para comando processing
const KEYWORD_MAPPING = {
  // ONBOARDING TRIGGERS (NUEVOS)
  '¿qué es', 'de qué trata', 'explica', 'overview', 'información': 'ONBOARDING_NEEDED',
  'cómo funciona', 'arquitectura general', 'tecnologías', 'stack': 'ONBOARDING_NEEDED',
  'nuevo en el proyecto', 'primera vez', 'no entiendo': 'ONBOARDING_NEEDED',
  
  // SESSION HISTORY TRIGGERS (NUEVOS)
  'última sesión', 'última iteración', 'qué se hizo', 'progreso': 'SESSION_HISTORY',
  'estado actual', 'en qué vamos', 'resumen de trabajo': 'SESSION_HISTORY',
  'historial', 'cambios recientes', 'últimos commits': 'SESSION_HISTORY',
  
  // ITERATION TRIGGERS
  'implementar', 'crear', 'agregar', 'desarrollar', 'nuevo': 'NEW_ITERATION',
  'nueva funcionalidad', 'feature', 'caso de uso', 'sistema': 'NEW_ITERATION',
  
  // CORE INDICATORS
  'universal', 'core', 'central', 'shared', 'common': 'CORE_SESSION',
  'authentication', 'payment', 'user management': 'CORE_SESSION',
  
  // VERTICAL INDICATORS  
  'restaurant', 'menu', 'order', 'table': 'RESTAURANT_VERTICAL',
  'hotel', 'room', 'reservation', 'check-in': 'HOTEL_VERTICAL',
  'retail', 'product', 'inventory', 'sale': 'RETAIL_VERTICAL',
  'service', 'appointment', 'booking': 'SERVICES_VERTICAL',
  'healthcare', 'patient', 'medical', 'clinic': 'HEALTHCARE_VERTICAL',
  
  // CROSS-VERTICAL INDICATORS
  'analytics', 'dashboard', 'reporting': 'CROSS_VERTICAL_SESSION',
  'integration', 'sync', 'multi-vertical': 'CROSS_VERTICAL_SESSION',
  
  // ARCHITECTURE INDICATORS
  'architecture', 'design', 'pattern', 'scalability': 'ARCHITECTURE_SESSION',
  
  // SECURITY INDICATORS
  'security', 'compliance', 'audit', 'encryption': 'SECURITY_SESSION',
  
  // DEPLOYMENT INDICATORS
  'deploy', 'infrastructure', 'kubernetes', 'docker': 'DEPLOYMENT_SESSION'
}
```

### COMANDO SIMPLIFICADO CON AUTO-COMPLETION

#### **ESCENARIO A: Usuario Nuevo (Onboarding Automático)**
```
Usuario escribe: "¿De qué trata este repositorio?"

NAVIGATOR ANALIZA:
1. Detecta trigger: "de qué trata" → ONBOARDING_NEEDED
2. Carga automáticamente: PROJECT_OVERVIEW.md
3. Proporciona: Información fundamental del proyecto
4. Evalúa rol: ¿Desarrollador? ¿Analista? ¿DevOps?
5. Ofrece rutas específicas de continuación
6. Guía hacia objetivos de iteración específicos

RESPUESTA AL USUARIO:
📋 INTELLICORE POS - INFORMACIÓN FUNDAMENTAL

IntelliCore POS es una plataforma empresarial multi-vertical de punto de venta...
[Información del PROJECT_OVERVIEW.md]

¿Cuál es tu rol en el proyecto?
- 👨‍💻 Desarrollador → Revisar stack técnico y casos de uso
- 📊 Analista/Product → Revisar casos de uso y reglas de negocio  
- 🛠️ DevOps/Infrastructure → Revisar arquitectura y deployment

¿Qué te gustaría hacer específicamente?
```

#### **ESCENARIO B: Usuario Existente (Iteración Directa)**
```
Usuario escribe: "Implementar sistema de notificaciones push"

NAVIGATOR ANALIZA:
1. Detecta trigger: "Implementar" → NEW_ITERATION
2. Ejecuta verificación Git automática
3. Detecta palabras clave: "notificaciones push"
4. Evalúa contexto: Universal/Core (afecta todos los verticales)
5. Prepara entorno: feature/20250727-notificaciones-push
6. Auto-completa: /start-session core "Sistema de notificaciones push"
7. Ejecuta routing automático
```

### FLUJO AUTOMÁTICO DE PREPARACIÓN

#### **ESCENARIO A: Onboarding de Usuario Nuevo**
```
DETECCIÓN: "¿Qué hace este proyecto?"

ANÁLISIS AUTOMÁTICO:
├── Trigger detectado: "qué hace" → ONBOARDING_NEEDED
├── Carga automática: PROJECT_OVERVIEW.md
├── Estado actual: Información fundamental disponible
├── Contexto: ONBOARDING (4,200 tokens aproximados)
└── Listo para clasificación de rol

RESPUESTA AL USUARIO:
Nuevo usuario detectado. Cargando información fundamental...
📋 INTELLICORE POS - Información del Proyecto Cargada
Contexto: ONBOARDING (4,200 tokens)
¿Cuál es tu rol? ¿Qué te gustaría hacer específicamente?
```

#### **ESCENARIO B: Iteración para Usuario Existente**
```
DETECCIÓN: "Quiero implementar sistema QR para pedidos"

ANÁLISIS AUTOMÁTICO:
├── Trigger detectado: "implementar" → NEW_ITERATION
├── Verificación Git: git status + git branch --show-current
├── Estado actual: En develop, sin cambios pendientes
├── Acción: Crear feature/20250727-qr-pedidos
├── Contexto: VERTICAL (restaurant) → 2,847 tokens
└── Listo para /start-session vertical

RESPUESTA AL USUARIO:
Nueva iteración detectada: Sistema QR para pedidos
Preparando entorno automáticamente...
Rama creada: feature/20250727-qr-pedidos  
Contexto cargado: VERTICAL restaurant (2,847 tokens)
¿Proceder con implementación? (y/n)
```

#### **ESCENARIO C: Información de Última Sesión**
```
DETECCIÓN: "¿Qué se hizo en la última iteración?"

ANÁLISIS AUTOMÁTICO:
├── Trigger detectado: "última iteración" → SESSION_HISTORY
├── Búsqueda automática: docs/iteraciones/ + Git history
├── Rama actual: feature/20250727-qr-pedidos
├── Última iteración: ITERACION_2025_07_27.md
└── Contexto: HISTORIAL (información de progreso)

RESPUESTA AL USUARIO:
Consultando última iteración...
📋 ÚLTIMA SESIÓN: 2025-07-27
Rama: feature/20250727-qr-pedidos
Implementado: [Resumen de la iteración]
Estado: [En progreso/Completado/Pendiente]
Próximos pasos: [Lista de acciones pendientes]
```

## WORKFLOW EXECUTION ENGINE

### PIPELINE AUTOMÁTICO
```
FASE 0: ENVIRONMENTAL PREPARATION (NUEVA)
├── Detectar intención de nueva iteración
├── Verificar estado Git automáticamente
├── Crear/sugerir rama feature apropiada
└── Validar entorno listo para desarrollo

FASE 1: COMMAND PARSING
├── Analizar input del usuario
├── Detectar tipo de sesión
├── Identificar verticales afectados
└── Seleccionar especialista principal

FASE 2: CONTEXT LOADING
├── Cargar módulos relevantes automáticamente
├── Aplicar filtros por especialización
├── Validar coherencia cross-modular
└── Preparar contexto optimizado

FASE 3: SPECIALIST ROUTING
├── Activar modelo especializado
├── Proveer contexto curado
├── Establecer objetivos de sesión
└── Iniciar workflow específico

FASE 4: EXECUTION MONITORING
├── Monitorear progreso de implementación
├── Validar consistencia en tiempo real
├── Aplicar auto-correcciones
└── Documentar decisiones tomadas

FASE 5: OUTPUT GENERATION
├── Generar código + tests + documentación
├── Actualizar contexto maestro
├── Crear archivo de iteración
└── Preparar artifacts de deployment
```

## MÓDULOS DISPONIBLES Y ROUTING

### MAPEO ESPECIALISTA → MÓDULOS
```yaml
DESARROLLADOR_SENIOR:
  primary_modules:
    - PATRONES_CODIGO.md
    - DEPENDENCIAS.md
    - TESTING_PROTOCOLS.md
  secondary_modules:
    - ESTRATEGIAS_IMPLEMENTACION.md
  auto_load_for:
    - core_features
    - vertical_features
    - api_development

ARQUITECTO_PRINCIPAL:
  primary_modules:
    - ESTRATEGIAS_IMPLEMENTACION.md
    - DEPENDENCIAS.md
  secondary_modules:
    - PATRONES_CODIGO.md
    - TESTING_PROTOCOLS.md
  auto_load_for:
    - architecture_decisions
    - cross_vertical_design
    - scalability_analysis

ANALISTA_NEGOCIO:
  primary_modules:
    - ESPECIALIZACIONES.md
    - ESTRATEGIAS_IMPLEMENTACION.md
  secondary_modules:
    - PATRONES_CODIGO.md
  auto_load_for:
    - business_rules
    - use_case_validation
    - vertical_requirements

ESPECIALISTA_SEGURIDAD:
  primary_modules:
    - DEPENDENCIAS.md
    - TESTING_PROTOCOLS.md
  secondary_modules:
    - ESTRATEGIAS_IMPLEMENTACION.md
  auto_load_for:
    - security_analysis
    - compliance_validation
    - vulnerability_assessment

DEVOPS_ENGINEER:
  primary_modules:
    - DEPENDENCIAS.md
    - DOCUMENTACION_AUTOMATICA.md
  secondary_modules:
    - TESTING_PROTOCOLS.md
  auto_load_for:
    - deployment_strategies
    - infrastructure_setup
    - ci_cd_configuration
```

## ENVIRONMENTAL PREPARATION COMMANDS

### COMANDO DE VERIFICACIÓN DE ENTORNO
```bash
/verify-environment [descripción-funcionalidad]
```

**Ejemplo de uso:**
```
Usuario: /verify-environment "sistema de notificaciones push"

Navigator ejecuta automáticamente:
1. git status --porcelain
2. git branch --show-current  
3. git branch --no-merged develop
4. Análisis de palabras clave
5. Preparación de contexto optimizado

Output:
ANÁLISIS DE ENTORNO:
Git: feature/20250727-notificaciones-push (creada)
Contexto: CORE session (3,124 tokens estimados)
Especialista: DESARROLLADOR_SENIOR + ARQUITECTO
Listo para /start-session core
```

### SCRIPTS DE PREPARACIÓN AUTOMÁTICA

#### PowerShell Script (Windows)
```powershell
# PREPARACIÓN AUTOMÁTICA DE ITERACIÓN
function Prepare-AEDDIteration {
    param(
        [Parameter(Mandatory=$true)]
        [string]$FunctionalityDescription
    )
    
    # Generar nombre de rama
    $date = Get-Date -Format "yyyyMMdd"
    $branchName = ($FunctionalityDescription -replace '[^a-zA-Z0-9]', '-').ToLower()
    $featureBranch = "feature/$date-$branchName"
    
    # Verificar estado Git
    $gitStatus = git status --porcelain
    $currentBranch = git branch --show-current
    
    if ($gitStatus) {
        Write-Host "⚠️ Cambios sin commit detectados. ¿Hacer commit? (y/n): " -NoNewline
        $commit = Read-Host
        if ($commit -eq 'y') {
            git add .
            git commit -m "WIP: preparando iteración $FunctionalityDescription"
        }
    }
    
    # Sincronizar con develop
    git checkout develop
    git pull origin develop
    
    # Crear nueva rama feature
    git checkout -b $featureBranch
    
    Write-Host "Entorno preparado:"
    Write-Host " Rama: $featureBranch"
    Write-Host " Listo para: $FunctionalityDescription"
    Write-Host " Usar: /start-session [tipo] '$FunctionalityDescription'"
}

# Uso: Prepare-AEDDIteration "sistema QR para pedidos"
```

#### Bash Script (Linux/Mac)
```bash
#!/bin/bash
# PREPARACIÓN AUTOMÁTICA DE ITERACIÓN

prepare_aedd_iteration() {
    local functionality_description="$1"
    
    if [ -z "$functionality_description" ]; then
        echo "Error: Descripción de funcionalidad requerida"
        echo "Uso: prepare_aedd_iteration 'descripción de la funcionalidad'"
        return 1
    fi
    
    # Generar nombre de rama
    local date=$(date +%Y%m%d)
    local branch_name=$(echo "$functionality_description" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
    local feature_branch="feature/$date-$branch_name"
    
    # Verificar estado Git
    if [ -n "$(git status --porcelain)" ]; then
        echo "Cambios sin commit detectados. ¿Hacer commit? (y/n): "
        read -r commit_choice
        if [ "$commit_choice" = "y" ]; then
            git add .
            git commit -m "WIP: preparando iteración $functionality_description"
        fi
    fi
    
    # Sincronizar con develop
    git checkout develop
    git pull origin develop
    
    # Crear nueva rama feature
    git checkout -b "$feature_branch"
    
    echo "Entorno preparado:"
    echo " Rama: $feature_branch"
    echo " Listo para: $functionality_description"
    echo " Usar: /start-session [tipo] '$functionality_description'"
}

# Uso: prepare_aedd_iteration "sistema QR para pedidos"
```

### COMANDOS INTEGRADOS EN NAVIGATOR

#### Auto-detección con preparación
```
Usuario escribe: "Necesito implementar autenticación biométrica"

Navigator detecta automáticamente:
1. Trigger: "implementar" → NEW_ITERATION
2. Ejecuta verificación Git
3. Sugiere: feature/20250727-autenticacion-biometrica
4. Analiza contexto: SECURITY + CORE
5. Prepara especialistas: ESPECIALISTA_SEGURIDAD + DESARROLLADOR_SENIOR

Respuesta automática:
Nueva iteración detectada: Autenticación biométrica
Preparando entorno...
Rama: feature/20250727-autenticacion-biometrica
Contexto: SECURITY+CORE (3,456 tokens)
Especialistas: ESPECIALISTA_SEGURIDAD + DESARROLLADOR_SENIOR
¿Proceder? (y/n)
```

## COMANDOS LEGACY MAPPING

### MIGRACIÓN AUTOMÁTICA DE COMANDOS
```
COMANDO LEGACY → NUEVO ROUTING

/implementar-core-feature "desc" 
→ /verify-environment "desc" → /start-session core "desc"

/implementar-vertical "desc" --vertical=restaurant
→ /verify-environment "desc" → /start-session vertical "desc para restaurant"

/implementar-cross-vertical "desc"
→ /verify-environment "desc" → /start-session cross-vertical "desc"

/analizar-arquitectura
→ /verify-environment "análisis arquitectural" → /start-session architecture "Análisis arquitectural completo"

/revisar-enterprise-security
→ /verify-environment "revisión seguridad" → /start-session security "Revisión de seguridad enterprise"

/deploy-vertical --vertical=hotel
→ /verify-environment "deploy hotel" → /start-session deployment "Deploy vertical hotel"
```

## VALIDATION MATRIX INTEGRATION

### AUTO-VALIDACIÓN CROSS-MODULAR
```
PRE-EXECUTION VALIDATION:
Git Environment Check: Verificar estado del repositorio y rama apropiada
Consistency Check: Validar que módulos cargados no conflictúen
Completeness Check: Verificar que contexto incluya toda info necesaria
Freshness Check: Confirmar que documentación esté actualizada
Access Check: Validar permisos para vertical/scope solicitado

POST-EXECUTION VALIDATION:
Output Consistency: Código generado sigue patrones establecidos
Documentation Sync: Docs actualizadas reflejan cambios implementados
Cross-Module References: Referencias entre módulos son válidas
Evolution Tracking: Métricas actualizadas correctamente
Git Integration: Cambios committed en rama feature apropiada
```

## SUCCESS METRICS

### KPIs DEL SISTEMA NAVIGATOR
```
EFFICIENCY METRICS:
- Tiempo promedio de routing: < 5 segundos
- Tiempo preparación entorno Git: < 10 segundos
- Tiempo de onboarding usuario nuevo: < 30 segundos
- Precisión de detección de tipo: > 95%
- Precisión detección nueva iteración: > 98%
- Precisión detección nuevo usuario: > 92%
- Reducción de pasos manuales: 85% (incluye Git setup)
- Token efficiency: 85-90% vs método manual

QUALITY METRICS:
- Consistencia cross-modular: > 98%
- Validación automática pass rate: > 95%
- Documentación auto-sync accuracy: > 99%
- Git workflow accuracy: > 99%
- Specialist selection accuracy: > 97%
- Onboarding satisfaction: > 90%

USER EXPERIENCE METRICS:
- Comandos simplificados vs complejos: 90% reducción
- Tiempo de setup de sesión completo: < 15 segundos (incluye Git)
- Tiempo manual Git setup: < 10 segundos automático
- Tiempo comprensión proyecto nuevo usuario: < 2 minutos
- Errores de configuración Git: < 1%
- Errores de routing: < 2%
- Satisfacción con auto-routing: Target > 95%
- Adopción de preparación automática: Target > 90%
- Efectividad onboarding: > 85% usuarios entienden proyecto
```

## USAGE EXAMPLES

### EJEMPLO COMPLETO: Nueva Iteración con Preparación Automática
```
Usuario: "Quiero implementar sistema de notificaciones push en tiempo real"

Navigator (automático):
 Nueva iteración detectada: Sistema notificaciones push tiempo real
 Verificando entorno Git...
   ├── Estado actual: develop, limpio
   ├── Última sincronización: hace 2 horas
   └── Creando: feature/20250727-notificaciones-push

 Analizando contexto...
   ├── Tipo detectado: CORE + CROSS_VERTICAL
   ├── Complejidad: ALTA (real-time + multi-platform)
   ├── Especialistas: ARQUITECTO + DESARROLLADOR_SENIOR
   └── Contexto: 3,892 tokens estimados

 Entorno preparado completamente
 ¿Proceder con /start-session core "Sistema notificaciones push tiempo real"? (y/n)

Usuario: y

Navigator:
Ejecutando /start-session core "Sistema notificaciones push tiempo real"
Especialistas activados: ARQUITECTO (DeepSeek) + DESARROLLADOR_SENIOR (Qwen3)
Contexto cargado: 3,892 tokens
Sesión iniciada en rama: feature/20250727-notificaciones-push
```

### EJEMPLO COMPLETO: Onboarding de Usuario Nuevo
```
Usuario: "No conozco el proyecto, ¿de qué trata este repositorio?"

Navigator (automático):
 Usuario nuevo detectado: Pregunta sobre información del proyecto
 Cargando información fundamental...
   ├── PROJECT_OVERVIEW.md: Información del proyecto
   ├── CONTEXTO_MAESTRO.md: Arquitectura y casos de uso
   ├── Estimado contexto: 4,200 tokens
   └── Modo: ONBOARDING

 Información del proyecto cargada
 ¿Proceder con /start-session onboarding "Información del proyecto"? (y/n)

Usuario: y

Navigator:
📋 INTELLICORE POS - INFORMACIÓN FUNDAMENTAL

IntelliCore POS es una plataforma empresarial multi-vertical de punto de venta...
[Información completa del PROJECT_OVERVIEW.md]

ESTADO ACTUAL:
✅ Restaurant vertical: Operativo
🔄 Hotel vertical: En desarrollo Q2 2025
🔄 Retail vertical: Roadmap Q3 2025

¿Cuál es tu rol?
- 👨‍💻 Desarrollador → /start-session architecture "review stack técnico"
- 📊 Analista → /start-session vertical "review casos de uso restaurant"
- 🛠️ DevOps → /start-session deployment "review infraestructura"

¿Qué te gustaría hacer específicamente en el proyecto?
```

### EJEMPLO COMPLETO: Consulta de Última Sesión
```
Usuario: "¿Qué se implementó en la última iteración?"

Navigator (automático):
 Consulta de historial detectada: Última iteración
 Buscando información de sesiones...
   ├── Git log: Últimos commits en feature branches
   ├── docs/iteraciones/: Archivos de iteración
   ├── Rama actual: feature/20250727-qr-pedidos
   └── Modo: SESSION_HISTORY

Navigator:
ÚLTIMA ITERACIÓN: 2025-07-27

RAMA: feature/20250727-qr-pedidos
ESPECIALISTAS: DESARROLLADOR_SENIOR + ANALISTA_NEGOCIO  
OBJETIVO: Sistema QR para pedidos mejorado

IMPLEMENTADO:
API endpoint /qr/generate con validación mesa
Frontend component QrDisplay con error handling
Base de datos: tabla qr_sessions con TTL
Tests unitarios: 95% coverage

EN PROGRESO:
Integración con sistema de pagos
Dashboard analytics para QR usage

PRÓXIMOS PASOS:
- Completar testing de integración
- Deploy a staging environment
- Validación UAT con restaurant pilot

¿Continuar trabajo en esta rama o iniciar nueva iteración?
```

---

## INSTALACIÓN Y CONFIGURACIÓN

### ACTIVAR NAVIGATOR CON PREPARACIÓN AUTOMÁTICA
```bash
# El navigator se activa automáticamente al cargar cualquier sesión AEDD
# Para usar directamente con preparación automática:
Usuario: "Implementar [descripción]" → Auto-detección + preparación
/verify-environment "descripción" → Preparación manual
/start-session <tipo> <descripción> → Sesión tradicional

# Para usar scripts de preparación externos:
Prepare-AEDDIteration "descripción"  # PowerShell
prepare_aedd_iteration "descripción" # Bash
```

### VERIFICAR FUNCIONAMIENTO
```bash
# Comando de diagnóstico completo
/navigator-status
# Retorna: Estado de módulos, especialistas disponibles, métricas de routing, estado Git

# Comando de verificación de entorno
/verify-environment "descripción opcional"
# Retorna: Estado Git, preparación automática, contexto estimado
```

## CAPACIDADES DEL SISTEMA

**El AEDD Navigator proporciona:**

1. **Auto-detección de nueva iteración** mediante triggers de palabras clave
2. **Preparación automática de entorno Git** con verificación de estado
3. **Creación inteligente de ramas feature** con naming convention automático
4. Auto-detección del tipo de sesión necesaria
5. Selección automática del especialista correcto  
6. Carga inteligente de solo los módulos relevantes
7. Validación de consistencia cross-modular antes de ejecutar
8. **Verificación de estado Git** y resolución de conflictos
9. Optimización de tokens cargando solo contexto necesario
10. Routing transparente para el usuario
11. **Scripts de preparación multiplataforma** (PowerShell/Bash)

**Beneficios de la preparación automática:**
- Reduce setup manual de 5-10 minutos a 10-15 segundos
- Previene errores de Git workflow
- Mantiene naming convention consistente 
- Integra verificación de entorno en el flujo natural
- Optimiza tokens al cargar contexto específico anticipadamente

**Ejemplos detallados de uso:** Ver archivo [NAVIGATOR_EXAMPLES.md](NAVIGATOR_EXAMPLES.md)

**Próximo paso crítico:** Actualizar el CONTEXTO_MAESTRO.md para reflejar este sistema modular con navigator y preparación automática de entorno.
