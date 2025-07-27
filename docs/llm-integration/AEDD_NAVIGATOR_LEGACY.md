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

#### VERIFICACIÓN AUTOMÁTICA DEL ENTORNO GIT CON BUENAS PRÁCTICAS
```bash
# COMANDO INTERNO EJECUTADO AUTOMÁTICAMENTE (GIT FLOW COMPLIANT)
# Verificación completa del estado del repositorio siguiendo Git Flow
git status --porcelain
git branch --show-current
git fetch origin
git status --porcelain --untracked-files=no
git diff HEAD origin/$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') --name-only
git branch --no-merged $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
```

**Análisis automático siguiendo Git Flow:**
- **Estado del working directory:** Sin cambios pendientes (obligatorio)
- **Rama actual:** Debe ser develop, main, o feature/* válida
- **Sincronización:** Rama debe estar actualizada con origin
- **Branches pendientes:** Detectar feature branches sin merge
- **Convención de nombres:** Validar naming convention (feature/, bugfix/, hotfix/, release/)
- **Base branch:** Verificar que feature branches salgan de develop (o main si no hay develop)

#### PREPARACIÓN INTELIGENTE DE RAMA CON GIT FLOW
```
ESCENARIO A: En rama feature/* activa y limpia
→ Continuar en rama actual (validar que siga naming convention)

ESCENARIO B: En rama develop (ideal para Git Flow)
→ Crear feature branch: git checkout -b feature/YYYYMMDD-descripcion develop
→ Validar: Rama develop sincronizada con origin/develop

ESCENARIO C: En rama main (sin develop)
→ Crear feature branch: git checkout -b feature/YYYYMMDD-descripcion main
→ Validar: Rama main sincronizada con origin/main

ESCENARIO D: Cambios sin commit
→ BLOQUEAR: "⚠️ Cambios sin commit detectados. Hacer commit o stash antes de continuar"
→ Sugerir: git add . && git commit -m "WIP: preparando nueva funcionalidad" 
→ O: git stash push -m "Cambios temporales antes de nueva feature"

ESCENARIO E: Rama desactualizada
→ BLOQUEAR: "⚠️ Rama desactualizada con origin. Sincronizar primero"
→ Sugerir: git pull origin [rama-actual]

ESCENARIO F: En rama incorrecta (hotfix, release, etc.)
→ ADVERTIR: "⚠️ Estás en rama [tipo]. ¿Cambiar a develop/main para nueva feature?"
→ Sugerir: git checkout develop (o main si no hay develop)

ESCENARIO G: Feature branches sin merge pendientes
→ ADVERTIR: "Ramas feature pendientes: [lista] - ¿Completar merge primero?"
→ Mostrar: git branch --no-merged develop

ESCENARIO H: Naming convention incorrecta
→ CORREGIR: Sugerir renombre de rama si no sigue feature/YYYYMMDD-descripcion
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
Base: Sincronizado con main

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
├── Estado actual: En main, sin cambios pendientes
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

## GIT FLOW INTEGRATION Y BUENAS PRÁCTICAS

### CONVENCIONES DE BRANCHING IMPLEMENTADAS
```
ESTRUCTURA DE BRANCHES SOPORTADA:

📁 main (o master)
├── Rama estable y lista para producción
├── Solo recibe merges desde develop (o directamente features si no hay develop)
├── Tags de versiones: v1.0.0, v1.1.0, etc.
└── Protegida: No commits directos

📁 develop (opcional - auto-detectada)
├── Rama para integración de nuevas funcionalidades  
├── Recibe merges desde feature branches
├── Base para crear nuevas features
└── Se sincroniza periódicamente con main

📁 feature/YYYYMMDD-descripcion
├── Nuevas funcionalidades y mejoras
├── Creadas desde develop (o main si no hay develop)
├── Naming: feature/20250727-sistema-notificaciones
└── Se eliminan después del merge

📁 bugfix/YYYYMMDD-descripcion
├── Corrección de errores menores
├── Creadas desde develop (o main)
├── Naming: bugfix/20250727-corregir-validacion-email
└── Se eliminan después del merge

📁 hotfix/YYYYMMDD-descripcion
├── Corrección de errores críticos en producción
├── Creadas desde main
├── Naming: hotfix/20250727-parche-seguridad-critico
└── Se mergen a main Y develop

📁 release/vX.Y.Z
├── Preparación de nuevas versiones
├── Creadas desde develop
├── Naming: release/v1.2.0
└── Se mergen a main y develop con tag
```

### VALIDACIONES AUTOMÁTICAS IMPLEMENTADAS

#### ✅ PRE-VALIDACIONES (Antes de crear rama)
```bash
1. Working Directory Limpio
   - git status --porcelain debe estar vacío
   - No archivos modificados, añadidos o eliminados
   - Acción: Commit o stash cambios

2. Rama Base Válida
   - Detectar si existe develop o usar main
   - Verificar que estemos en rama correcta
   - Acción: Checkout a rama base apropiada

3. Sincronización con Origin
   - git fetch origin para actualizar referencias
   - Verificar que no estemos atrás de origin
   - Acción: git pull origin [base-branch]

4. Naming Convention
   - Validar formato: tipo/YYYYMMDD-descripcion
   - Verificar que rama no exista ya
   - Acción: Sugerir nombre alternativo
```

#### ✅ VALIDACIONES DURANTE CREACIÓN
```bash
5. Rama Única
   - git branch --list para verificar que no exista
   - Prevenir duplicados o conflictos
   - Acción: Sugerir descripción más específica

6. Permisos y Acceso
   - Verificar permisos de escritura
   - Validar conectividad con origin
   - Acción: Notificar errores de acceso

7. Base Branch Correcta
   - feature/bugfix: desde develop o main
   - hotfix: solo desde main
   - release: solo desde develop
```

#### ✅ POST-VALIDACIONES (Después de crear rama)
```bash
8. Rama Creada Exitosamente
   - Verificar git checkout exitoso
   - Confirmar rama activa correcta
   - Acción: Rollback si hay errores

9. Contexto de Trabajo
   - Preparar especialistas apropiados
   - Cargar módulos relevantes según tipo
   - Configurar entorno de desarrollo
```

### DETECCIÓN AUTOMÁTICA DE TIPO DE RAMA

#### 🔍 ANÁLISIS SEMÁNTICO DE DESCRIPCIÓN
```javascript
// Lógica implementada en Navigator
const BRANCH_TYPE_DETECTION = {
  // FEATURES (funcionalidad nueva)
  feature: [
    'implementar', 'crear', 'agregar', 'desarrollar', 'nuevo',
    'sistema', 'funcionalidad', 'feature', 'módulo',
    'dashboard', 'api', 'interfaz', 'integración'
  ],
  
  // BUGFIX (corrección menor)
  bugfix: [
    'corregir', 'arreglar', 'solucionar', 'reparar',
    'bug', 'error', 'problema', 'fallo', 'issue',
    'validación', 'formato', 'comportamiento'
  ],
  
  // HOTFIX (crítico en producción)
  hotfix: [
    'crítico', 'urgente', 'producción', 'security',
    'vulnerabilidad', 'parche', 'emergencia',
    'hotfix', 'critical', 'bloqueante'
  ],
  
  // RELEASE (preparación versión)
  release: [
    'release', 'versión', 'deploy', 'lanzamiento',
    'v1.', 'v2.', 'preparar release', 'candidate'
  ]
}
```

#### 🎯 EJEMPLOS DE DETECCIÓN AUTOMÁTICA
```
INPUT: "Implementar sistema de notificaciones push"
ANÁLISIS: 'implementar' + 'sistema' → FEATURE
RESULTADO: feature/20250727-sistema-notificaciones-push

INPUT: "Corregir bug en validación de email"
ANÁLISIS: 'corregir' + 'bug' + 'validación' → BUGFIX  
RESULTADO: bugfix/20250727-validacion-email

INPUT: "Parche crítico de seguridad"
ANÁLISIS: 'parche' + 'crítico' + 'seguridad' → HOTFIX
RESULTADO: hotfix/20250727-parche-seguridad

INPUT: "Preparar release v1.2.0"
ANÁLISIS: 'preparar' + 'release' + 'v1.2.0' → RELEASE
RESULTADO: release/v1.2.0
```

### INTEGRACIÓN CON WORKFLOW AEDD

#### 🔄 FLUJO AUTOMÁTICO COMPLETO
```
1. DETECCIÓN DE INTENCIÓN
   Usuario: "Quiero implementar autenticación biométrica"
   ↓
   Navigator detecta: "implementar" → NEW_ITERATION

2. ANÁLISIS DE TIPO
   Palabras clave: "implementar", "autenticación" → FEATURE
   Complejidad: "biométrica" → ALTA
   ↓
   Tipo determinado: feature/security

3. VALIDACIÓN GIT FLOW
   ✅ Working directory limpio
   ✅ Rama base: develop (detectada)
   ✅ Sincronizado con origin/develop
   ✅ Naming convention válida
   ↓
   Preparación: feature/20250727-autenticacion-biometrica

4. PREPARACIÓN DE CONTEXTO
   Especialistas: ESPECIALISTA_SEGURIDAD + DESARROLLADOR_SENIOR
   Módulos: DEPENDENCIAS.md, TESTING_PROTOCOLS.md
   ↓
   Contexto: SECURITY+CORE (3,456 tokens estimados)

5. INICIO AUTOMÁTICO
   Comando generado: /start-session core "autenticación biométrica"
   Estado: LISTO PARA DESARROLLO
```

### COMANDOS EXTENDIDOS PARA GIT FLOW

#### 📋 COMANDOS DE ESTADO Y VERIFICACIÓN
```bash
# Verificación completa de Git Flow
/git-flow-status
# Muestra: ramas, sincronización, naming convention, branches pendientes

# Verificación específica para nueva feature
/verify-environment "descripción funcionalidad"
# Ejecuta todas las validaciones y prepara entorno

# Análisis de branches pendientes
/pending-branches
# Lista: feature branches sin merge, estado de cada una

# Validación de naming convention
/validate-branch-naming
# Verifica: rama actual sigue convenciones establecidas
```

#### 🛠️ COMANDOS DE PREPARACIÓN AUTOMÁTICA
```bash
# Preparación estándar (auto-detecta tipo)
/prepare-iteration "descripción"
# Ejecuta: análisis semántico → tipo de rama → validaciones → creación

# Preparación con tipo específico
/prepare-feature "nueva funcionalidad"
/prepare-bugfix "corrección de error"  
/prepare-hotfix "parche crítico"
/prepare-release "v1.2.0"

# Preparación con validación exhaustiva
/prepare-iteration "descripción" --strict
# Incluye: validación de commits, branches remotas, permisos
```

## ENVIRONMENTAL PREPARATION COMMANDS

### COMANDO DE VERIFICACIÓN DE ENTORNO CON GIT FLOW
```bash
/verify-environment [descripción-funcionalidad]
```

**Ejemplo de uso:**
```
Usuario: /verify-environment "sistema de notificaciones push"

Navigator ejecuta verificación completa de Git Flow:
1. git status --porcelain (verificar working directory limpio)
2. git branch --show-current (identificar rama actual)
3. git fetch origin (actualizar referencias remotas)
4. git status --ahead-behind (verificar sincronización)
5. git branch --no-merged develop/main (detectar branches pendientes)
6. Validar naming convention de rama actual
7. Verificar que rama base sea develop o main
8. Análisis de palabras clave para tipo de branch
9. Preparación de contexto optimizado

Output:
ANÁLISIS DE ENTORNO GIT FLOW COMPLETO:

GIT FLOW STATUS:
├── Rama actual: feature/20250727-notificaciones-push 
├── Base branch: develop (sincronizado)
├── Working directory: Limpio
├── Naming convention: Válida (feature/YYYYMMDD-descripcion)
├── Rama actualizada: Sin commits pendientes
└── Branches pendientes: Ninguna

PREPARACIÓN:
├── Contexto: CORE session (3,124 tokens estimados)
├── Especialista: DESARROLLADOR_SENIOR + ARQUITECTO
├── Tipo branch: feature (nueva funcionalidad)
└── Listo para /start-session core

VALIDACIONES GIT FLOW: TODAS PASADAS
```

**Output con errores:**
```
ANÁLISIS DE ENTORNO - ERRORES DETECTADOS:

GIT FLOW STATUS:
├── Rama actual: main
├── Cambios sin commit: 3 archivos modificados
├── Rama desactualizada: 2 commits atrás de origin/main
└── Branches pendientes: feature/20250725-payment-gateway

ACCIONES REQUERIDAS:
1. Commit cambios: git add . && git commit -m "mensaje"
2. Actualizar rama: git pull origin main
3. Resolver branch pendiente antes de nueva feature
4. Cambiar a develop o crear feature branch

ESTADO: NO LISTO PARA NUEVA ITERACIÓN
Resolver errores antes de continuar.
```

### SCRIPTS DE PREPARACIÓN AUTOMÁTICA

#### PowerShell Script (Windows) - Git Flow Compliant
```powershell
# PREPARACIÓN AUTOMÁTICA DE ITERACIÓN CON GIT FLOW
function Prepare-AEDDIteration {
    param(
        [Parameter(Mandatory=$true)]
        [string]$FunctionalityDescription,
        [string]$BranchType = "feature"
    )
    
    Write-Host "🔍 VERIFICANDO ENTORNO GIT FLOW..." -ForegroundColor Cyan
    
    # 1. VERIFICAR ESTADO WORKING DIRECTORY
    $gitStatus = git status --porcelain
    if ($gitStatus) {
        Write-Host "Cambios sin commit detectados:" -ForegroundColor Red
        git status --short
        Write-Host "Opciones:" -ForegroundColor Yellow
        Write-Host "  1. Hacer commit: git add . && git commit -m 'WIP: preparando nueva feature'"
        Write-Host "  2. Hacer stash: git stash push -m 'Cambios temporales'"
        Write-Host "  3. Descartar cambios: git checkout . (¡CUIDADO!)"
        return
    }
    
    # 2. OBTENER RAMA ACTUAL Y VERIFICAR ESTADO
    $currentBranch = git branch --show-current
    Write-Host "Rama actual: $currentBranch" -ForegroundColor Blue
    
    # 3. DETECTAR RAMA BASE (develop > main)
    git fetch origin | Out-Null
    $developExists = git branch -r | Select-String "origin/develop"
    $baseBranch = if ($developExists) { "develop" } else { "main" }
    Write-Host "Rama base detectada: $baseBranch" -ForegroundColor Green
    
    # 4. VERIFICAR SI ESTAMOS EN RAMA CORRECTA PARA CREAR FEATURE
    $validBaseBranches = @("develop", "main")
    $isValidBase = $validBaseBranches -contains $currentBranch
    
    if (-not $isValidBase -and -not $currentBranch.StartsWith("feature/")) {
        Write-Host "Estás en rama '$currentBranch' que no es válida para crear features" -ForegroundColor Yellow
        Write-Host "Cambiando a rama base '$baseBranch'..." -ForegroundColor Cyan
        git checkout $baseBranch
        $currentBranch = $baseBranch
    }
    
    # 5. VERIFICAR SINCRONIZACIÓN CON ORIGIN
    if ($currentBranch -eq $baseBranch) {
        Write-Host "Verificando sincronización con origin/$baseBranch..." -ForegroundColor Cyan
        $behindCount = git rev-list --count HEAD..origin/$baseBranch
        if ([int]$behindCount -gt 0) {
            Write-Host "Rama desactualizada ($behindCount commits atrás)" -ForegroundColor Red
            Write-Host "Actualizando rama..." -ForegroundColor Cyan
            git pull origin $baseBranch
            if ($LASTEXITCODE -ne 0) {
                Write-Host "Error al actualizar rama. Resolver conflictos manualmente." -ForegroundColor Red
                return
            }
        }
    }
    
    # 6. VERIFICAR BRANCHES PENDIENTES
    $unmergedBranches = git branch --no-merged $baseBranch | Where-Object { $_ -notmatch "^\*" -and $_ -match "feature/" }
    if ($unmergedBranches) {
        Write-Host "Feature branches sin merge detectadas:" -ForegroundColor Yellow
        $unmergedBranches | ForEach-Object { Write-Host "   $($_.Trim())" -ForegroundColor Yellow }
        Write-Host "Considera completar el merge antes de crear nueva feature" -ForegroundColor Yellow
    }
    
    # 7. GENERAR NOMBRE DE RAMA CON NAMING CONVENTION
    $date = Get-Date -Format "yyyyMMdd"
    $cleanDescription = ($FunctionalityDescription -replace '[^a-zA-Z0-9\s]', '').Trim()
    $branchName = ($cleanDescription -replace '\s+', '-').ToLower()
    $featureBranch = "$BranchType/$date-$branchName"
    
    # 8. VALIDAR QUE LA RAMA NO EXISTA
    $branchExists = git branch --list $featureBranch
    if ($branchExists) {
        Write-Host "La rama '$featureBranch' ya existe" -ForegroundColor Red
        Write-Host "Sugerencias:" -ForegroundColor Yellow
        Write-Host "  1. Usar descripción más específica"
        Write-Host "  2. Cambiar a rama existente: git checkout $featureBranch"
        return
    }
    
    # 9. CREAR NUEVA RAMA FEATURE DESDE BASE BRANCH
    Write-Host "Creando rama '$featureBranch' desde '$baseBranch'..." -ForegroundColor Green
    git checkout -b $featureBranch $baseBranch
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "ENTORNO PREPARADO EXITOSAMENTE:" -ForegroundColor Green
        Write-Host "   Rama: $featureBranch" -ForegroundColor Cyan
        Write-Host "  Base: $baseBranch" -ForegroundColor Cyan
        Write-Host "  Descripción: $FunctionalityDescription" -ForegroundColor Cyan
        Write-Host "  Tipo: $BranchType" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "📋 PRÓXIMOS PASOS:" -ForegroundColor Blue
        Write-Host "   Usar: /start-session [tipo] '$FunctionalityDescription'" -ForegroundColor White
        Write-Host ""
        Write-Host "🔧 GIT FLOW STATUS: TODAS LAS VALIDACIONES PASADAS" -ForegroundColor Green
    } else {
        Write-Host "Error al crear rama" -ForegroundColor Red
    }
}

# FUNCIÓN AUXILIAR PARA VALIDAR NAMING CONVENTION
function Test-BranchNamingConvention {
    param([string]$BranchName)
    
    $patterns = @{
        "feature" = "^feature/\d{8}-[a-z0-9-]+$"
        "bugfix" = "^bugfix/\d{8}-[a-z0-9-]+$"
        "hotfix" = "^hotfix/\d{8}-[a-z0-9-]+$"
        "release" = "^release/v\d+\.\d+\.\d+$"
    }
    
    foreach ($type in $patterns.Keys) {
        if ($BranchName -match $patterns[$type]) {
            return @{ Valid = $true; Type = $type }
        }
    }
    
    return @{ Valid = $false; Type = "unknown" }
}

# EJEMPLOS DE USO:
# Prepare-AEDDIteration "sistema QR para pedidos"
# Prepare-AEDDIteration "corregir bug en pagos" -BranchType "bugfix"
# Prepare-AEDDIteration "arreglo crítico autenticación" -BranchType "hotfix"
```

#### Bash Script (Linux/Mac) - Git Flow Compliant
```bash
#!/bin/bash
# PREPARACIÓN AUTOMÁTICA DE ITERACIÓN CON GIT FLOW

prepare_aedd_iteration() {
    local functionality_description="$1"
    local branch_type="${2:-feature}"
    
    if [ -z "$functionality_description" ]; then
        echo "Error: Descripción de funcionalidad requerida"
        echo "Uso: prepare_aedd_iteration 'descripción' [tipo]"
        echo "   Tipos: feature (default), bugfix, hotfix"
        return 1
    fi
    
    echo "VERIFICANDO ENTORNO GIT FLOW..."
    
    # 1. VERIFICAR ESTADO WORKING DIRECTORY
    if [ -n "$(git status --porcelain)" ]; then
        echo "Cambios sin commit detectados:"
        git status --short
        echo "Opciones:"
        echo "  1. Hacer commit: git add . && git commit -m 'WIP: preparando nueva feature'"
        echo "  2. Hacer stash: git stash push -m 'Cambios temporales'"
        echo "  3. Descartar cambios: git checkout . (¡CUIDADO!)"
        return 1
    fi
    
    # 2. OBTENER RAMA ACTUAL
    local current_branch=$(git branch --show-current)
    echo "Rama actual: $current_branch"
    
    # 3. DETECTAR RAMA BASE (develop > main)
    git fetch origin >/dev/null 2>&1
    local base_branch
    if git branch -r | grep -q "origin/develop"; then
        base_branch="develop"
    else
        base_branch="main"
    fi
    echo "Rama base detectada: $base_branch"
    
    # 4. VERIFICAR SI ESTAMOS EN RAMA CORRECTA PARA CREAR FEATURE
    case "$current_branch" in
        develop|main)
            # Estamos en rama base, perfecto
            ;;
        feature/*|bugfix/*|hotfix/*)
            echo "Ya estás en una rama de trabajo: $current_branch"
            echo "¿Continuar en esta rama o crear nueva? (c/n): "
            read -r continue_choice
            if [ "$continue_choice" = "c" ]; then
                echo "Continuando en rama actual: $current_branch"
                return 0
            fi
            echo "Cambiando a rama base para crear nueva rama..."
            git checkout "$base_branch"
            current_branch="$base_branch"
            ;;
        *)
            echo "Estás en rama '$current_branch' que no es válida para crear features"
            echo "Cambiando a rama base '$base_branch'..."
            git checkout "$base_branch"
            current_branch="$base_branch"
            ;;
    esac
    
    # 5. VERIFICAR SINCRONIZACIÓN CON ORIGIN (solo si estamos en rama base)
    if [ "$current_branch" = "$base_branch" ]; then
        echo "Verificando sincronización con origin/$base_branch..."
        local behind_count=$(git rev-list --count HEAD..origin/"$base_branch" 2>/dev/null || echo "0")
        if [ "$behind_count" -gt 0 ]; then
            echo "Rama desactualizada ($behind_count commits atrás)"
            echo "Actualizando rama..."
            if ! git pull origin "$base_branch"; then
                echo "Error al actualizar rama. Resolver conflictos manualmente."
                return 1
            fi
        fi
    fi
    
    # 6. VERIFICAR BRANCHES PENDIENTES
    local unmerged_branches=$(git branch --no-merged "$base_branch" | grep -E "^\s*(feature|bugfix)/" | head -5)
    if [ -n "$unmerged_branches" ]; then
        echo "Feature/bugfix branches sin merge detectadas:"
        echo "$unmerged_branches" | sed 's/^/   /'
        echo "Considera completar el merge antes de crear nueva feature"
    fi
    
    # 7. GENERAR NOMBRE DE RAMA CON NAMING CONVENTION
    local date=$(date +%Y%m%d)
    local clean_description=$(echo "$functionality_description" | sed 's/[^a-zA-Z0-9 ]//g' | tr '[:upper:]' '[:lower:]')
    local branch_name=$(echo "$clean_description" | sed 's/[[:space:]]\+/-/g' | sed 's/^-\|-$//g')
    local feature_branch="$branch_type/$date-$branch_name"
    
    # 8. VALIDAR QUE LA RAMA NO EXISTA
    if git branch --list "$feature_branch" | grep -q "$feature_branch"; then
        echo "La rama '$feature_branch' ya existe"
        echo "Sugerencias:"
        echo "  1. Usar descripción más específica"
        echo "  2. Cambiar a rama existente: git checkout $feature_branch"
        return 1
    fi
    
    # 9. VALIDAR NAMING CONVENTION
    validate_branch_naming "$feature_branch"
    
    # 10. CREAR NUEVA RAMA FEATURE DESDE BASE BRANCH
    echo "Creando rama '$feature_branch' desde '$base_branch'..."
    if git checkout -b "$feature_branch" "$base_branch"; then
        echo ""
        echo "ENTORNO PREPARADO EXITOSAMENTE:"
        echo "    Rama: $feature_branch"
        echo "   Base: $base_branch"
        echo "   Descripción: $functionality_description"
        echo "   Tipo: $branch_type"
        echo ""
        echo "PRÓXIMOS PASOS:"
        echo "   Usar: /start-session [tipo] '$functionality_description'"
        echo ""
        echo "🔧 GIT FLOW STATUS: TODAS LAS VALIDACIONES PASADAS"
    else
        echo "Error al crear rama"
        return 1
    fi
}

# FUNCIÓN AUXILIAR PARA VALIDAR NAMING CONVENTION
validate_branch_naming() {
    local branch_name="$1"
    local valid=false
    local type="unknown"
    
    case "$branch_name" in
        feature/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*)
            valid=true
            type="feature"
            ;;
        bugfix/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*)
            valid=true
            type="bugfix"
            ;;
        hotfix/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*)
            valid=true
            type="hotfix"
            ;;
        release/v[0-9]*.[0-9]*.[0-9]*)
            valid=true
            type="release"
            ;;
    esac
    
    if [ "$valid" = true ]; then
        echo "Naming convention válida: $type branch"
    else
        echo "Naming convention no estándar: $branch_name"
        echo "Convención recomendada: $type/YYYYMMDD-descripcion"
    fi
}

# FUNCIÓN PARA VERIFICAR ESTADO COMPLETO
check_git_flow_status() {
    echo " ANÁLISIS COMPLETO DE GIT FLOW:"
    echo ""
    
    local current_branch=$(git branch --show-current)
    local git_status=$(git status --porcelain)
    
    # Estado working directory
    if [ -z "$git_status" ]; then
        echo " Working directory: Limpio"
    else
        echo " Working directory: Cambios pendientes"
    fi
    
    # Rama actual y validación
    echo " Rama actual: $current_branch"
    validate_branch_naming "$current_branch"
    
    # Sincronización
    git fetch origin >/dev/null 2>&1
    local base_branch
    if git branch -r | grep -q "origin/develop"; then
        base_branch="develop"
    else
        base_branch="main"
    fi
    
    if [ "$current_branch" = "$base_branch" ]; then
        local behind_count=$(git rev-list --count HEAD..origin/"$base_branch" 2>/dev/null || echo "0")
        if [ "$behind_count" -eq 0 ]; then
            echo " Sincronización: Actualizada con origin/$base_branch"
        else
            echo " Sincronización: $behind_count commits atrás de origin/$base_branch"
        fi
    fi
    
    # Branches pendientes
    local unmerged_count=$(git branch --no-merged "$base_branch" | grep -cE "^\s*(feature|bugfix)/" || echo "0")
    if [ "$unmerged_count" -eq 0 ]; then
        echo " Branches pendientes: Ninguna"
    else
        echo " Branches pendientes: $unmerged_count feature/bugfix branches sin merge"
    fi
    
    echo ""
    if [ -z "$git_status" ] && [ "$behind_count" -eq 0 ]; then
        echo " ESTADO:  LISTO PARA NUEVA ITERACIÓN"
    else
        echo " ESTADO:  REQUIERE ACCIÓN ANTES DE CONTINUAR"
    fi
}

# EJEMPLOS DE USO:
# prepare_aedd_iteration "sistema QR para pedidos"
# prepare_aedd_iteration "corregir bug en pagos" "bugfix"
# prepare_aedd_iteration "arreglo crítico autenticación" "hotfix"
# check_git_flow_status
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

### KPIs DEL SISTEMA NAVIGATOR CON GIT FLOW
```
EFFICIENCY METRICS:
- Tiempo promedio de routing: < 5 segundos
- Tiempo preparación entorno Git Flow: < 15 segundos
- Tiempo de onboarding usuario nuevo: < 30 segundos
- Precisión de detección de tipo: > 95%
- Precisión detección nueva iteración: > 98%
- Precisión detección nuevo usuario: > 92%
- Reducción de pasos manuales Git: 90% (incluye validaciones completas)
- Token efficiency: 85-90% vs método manual
- Detección automática tipo de rama: > 93%

GIT FLOW COMPLIANCE METRICS:
- Validaciones pre-creación exitosas: > 98%
- Naming convention compliance: > 99%
- Working directory limpio enforcement: 100%
- Sincronización automática con origin: > 97%
- Detección de rama base correcta: > 99%
- Prevención de ramas duplicadas: 100%
- Branches pendientes identificadas: > 95%

QUALITY METRICS:
- Consistencia cross-modular: > 98%
- Validación automática pass rate: > 95%
- Documentación auto-sync accuracy: > 99%
- Git workflow accuracy: > 99.5%
- Specialist selection accuracy: > 97%
- Onboarding satisfaction: > 90%
- Errores de Git Flow: < 0.5%

USER EXPERIENCE METRICS:
- Comandos simplificados vs complejos: 90% reducción
- Tiempo de setup de sesión completo: < 20 segundos (incluye Git Flow)
- Tiempo manual Git setup: < 15 segundos automático
- Tiempo comprensión proyecto nuevo usuario: < 2 minutos
- Errores de configuración Git: < 0.5%
- Errores de routing: < 2%
- Satisfacción con auto-routing: Target > 95%
- Adopción de preparación automática: Target > 90%
- Efectividad onboarding: > 85% usuarios entienden proyecto
- Satisfacción con Git Flow automation: Target > 95%

DEVELOPMENT WORKFLOW METRICS:
- Reducción de errores de merge: > 80%
- Tiempo de resolución de conflictos: -60%
- Adherencia a convenciones: > 95%
- Branches creadas correctamente: > 99%
- Rollbacks por errores de setup: < 1%
```

## USAGE EXAMPLES

### EJEMPLO COMPLETO: Nueva Iteración con Preparación Automática
```
Usuario: "Quiero implementar sistema de notificaciones push en tiempo real"

Navigator (automático):
 Nueva iteración detectada: Sistema notificaciones push tiempo real
 Verificando entorno Git...
   ├── Estado actual: main, limpio
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
INTELLICORE POS - INFORMACIÓN FUNDAMENTAL

IntelliCore POS es una plataforma empresarial multi-vertical de punto de venta...
[Información completa del PROJECT_OVERVIEW.md]

ESTADO ACTUAL:
Restaurant vertical: Operativo
Hotel vertical: En desarrollo Q2 2025
Retail vertical: Roadmap Q3 2025

¿Cuál es tu rol?
-  Desarrollador → /start-session architecture "review stack técnico"
- Analista → /start-session vertical "review casos de uso restaurant"
- DevOps → /start-session deployment "review infraestructura"

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
