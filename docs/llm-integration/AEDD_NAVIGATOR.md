# AEDD NAVIGATOR - Router Inteligente IntelliCore POS

## PROPÓSITO
Sistema de routing inteligente que actúa como punto de entrada único para la metodología AEDD Enterprise, proporcionando auto-routing de comandos, selección automática de especialistas y carga inteligente de contexto modular.

## COMMAND ROUTER SYSTEM

### COMANDO PRINCIPAL DE ENTRADA
```
/start-session <tipo> <descripción>
```

**Tipos de sesión disponibles:**
- `core` - Funcionalidad universal que afecta todos los verticales
- `vertical` - Funcionalidad específica de un vertical
- `cross-vertical` - Funcionalidad que afecta múltiples verticales
- `architecture` - Decisiones arquitecturales y patterns
- `security` - Análisis de seguridad y compliance
- `deployment` - Estrategias de despliegue y DevOps

### AUTO-ROUTING INTELLIGENCE

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

#### PARA SESIÓN VERTICAL
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
```
Usuario escribe: "Implementar loyalty points"

NAVIGATOR ANALIZA:
1. Detecta palabras clave: "loyalty points"
2. Evalúa contexto: Universal/Core (afecta todos los verticales)
3. Auto-completa: /start-session core "Sistema de loyalty points universal"
4. Ejecuta routing automático
```

## WORKFLOW EXECUTION ENGINE

### PIPELINE AUTOMÁTICO
```
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

## COMANDOS LEGACY MAPPING

### MIGRACIÓN AUTOMÁTICA DE COMANDOS
```
COMANDO LEGACY → NUEVO ROUTING

/implementar-core-feature "desc" 
→ /start-session core "desc"

/implementar-vertical "desc" --vertical=restaurant
→ /start-session vertical "desc para restaurant"

/implementar-cross-vertical "desc"
→ /start-session cross-vertical "desc"

/analizar-arquitectura
→ /start-session architecture "Análisis arquitectural completo"

/revisar-enterprise-security
→ /start-session security "Revisión de seguridad enterprise"

/deploy-vertical --vertical=hotel
→ /start-session deployment "Deploy vertical hotel"
```

## VALIDATION MATRIX INTEGRATION

### AUTO-VALIDACIÓN CROSS-MODULAR
```
PRE-EXECUTION VALIDATION:
Consistency Check: Validar que módulos cargados no conflictúen
Completeness Check: Verificar que contexto incluya toda info necesaria
Freshness Check: Confirmar que documentación esté actualizada
Access Check: Validar permisos para vertical/scope solicitado

POST-EXECUTION VALIDATION:
Output Consistency: Código generado sigue patrones establecidos
Documentation Sync: Docs actualizadas reflejan cambios implementados
Cross-Module References: Referencias entre módulos son válidas
Evolution Tracking: Métricas actualizadas correctamente
```

## SUCCESS METRICS

### KPIs DEL SISTEMA NAVIGATOR
```
EFFICIENCY METRICS:
- Tiempo promedio de routing: < 5 segundos
- Precisión de detección de tipo: > 95%
- Reducción de pasos manuales: 80%
- Token efficiency: 85-90% vs método manual

QUALITY METRICS:
- Consistencia cross-modular: > 98%
- Validación automática pass rate: > 95%
- Documentación auto-sync accuracy: > 99%
- Specialist selection accuracy: > 97%

USER EXPERIENCE METRICS:
- Comandos simplificados vs complejos: 90% reducción
- Tiempo de setup de sesión: < 30 segundos
- Errores de configuración: < 2%
- Satisfacción con auto-routing: Target > 95%
```

## USAGE EXAMPLES

---

## INSTALACIÓN Y CONFIGURACIÓN

### ACTIVAR NAVIGATOR
```bash
# El navigator se activa automáticamente al cargar cualquier sesión AEDD
# Para usar directamente:
/start-session <tipo> <descripción>

# Para migrar comandos legacy:
# Los comandos antiguos se redirigen automáticamente al navigator
```

### VERIFICAR FUNCIONAMIENTO
```bash
# Comando de diagnóstico
/navigator-status
# Retorna: Estado de módulos, especialistas disponibles, métricas de routing
```

## CAPACIDADES DEL SISTEMA

**El AEDD Navigator proporciona:**

1. Auto-detección del tipo de sesión necesaria
2. Selección automática del especialista correcto  
3. Carga inteligente de solo los módulos relevantes
4. Validación de consistencia cross-modular antes de ejecutar
5. Optimización de tokens cargando solo contexto necesario
6. Routing transparente para el usuario

**Ejemplos detallados de uso:** Ver archivo [NAVIGATOR_EXAMPLES.md](NAVIGATOR_EXAMPLES.md)

**Próximo paso crítico:** Actualizar el CONTEXTO_MAESTRO.md para reflejar este sistema modular con navigator.
