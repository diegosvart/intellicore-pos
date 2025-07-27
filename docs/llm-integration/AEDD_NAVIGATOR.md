# AEDD NAVIGATOR - Router Inteligente IntelliCore POS

## PROPÓSITO
Sistema de routing inteligente que actúa como punto de entrada único para la metodología AEDD Enterprise, proporcionando auto-routing de comandos, selección automática de especialistas, carga inteligente de contexto modular y onboarding automático para nuevos usuarios.

## COMANDO PRINCIPAL DE ENTRADA
```bash
/start-session <tipo> <descripción>
/project-overview                    # Para nuevos usuarios
/verify-environment <descripción>     # Validación Git Flow
/git-flow-status                    # Estado del repositorio

# COMANDOS DE METODOLOGÍA DE DESARROLLO
/start-development <componente> <característica>    # Inicia desarrollo estructurado
/check-development-status <componente>             # Estado de desarrollo por componente
/continue-development <fase> <componente>          # Continúa en fase específica
```

## DETECCIÓN AUTOMÁTICA Y ROUTING

### 🔍 TRIGGERS DE DETECCIÓN
| Tipo | Palabras Clave | Acción |
|------|----------------|--------|
| **Nuevo Usuario** | "¿qué es?", "explica", "overview", "información" | → [NAVIGATOR_ONBOARDING.md](NAVIGATOR_ONBOARDING.md) |
| **Nueva Iteración** | "implementar", "crear", "agregar", "desarrollar" | → [NAVIGATOR_GIT_FLOW.md](NAVIGATOR_GIT_FLOW.md) |
| **Desarrollo Metodológico** | "quiero trabajar en", "continuar desarrollo", "estado desarrollo" | → [NAVIGATOR_DEVELOPMENT_METHODOLOGY.md](NAVIGATOR_DEVELOPMENT_METHODOLOGY.md) |
| **Historial** | "última sesión", "progreso", "qué se hizo" | → [NAVIGATOR_SESSION_HISTORY.md](NAVIGATOR_SESSION_HISTORY.md) |
| **Core** | "universal", "shared", "authentication", "payment" | → Especialista: DESARROLLADOR_SENIOR + ARQUITECTO |
| **Vertical** | "restaurant", "hotel", "retail", "healthcare" | → Especialista: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR |
| **Cross-Vertical** | "analytics", "dashboard", "integration" | → Especialista: ARQUITECTO + DESARROLLADOR_SENIOR |

### 🎯 AUTO-ROUTING POR TIPO DE SESIÓN

#### SESIÓN ONBOARDING
```
INPUT: Usuario nuevo detectado
AUTO-ROUTING: → [NAVIGATOR_ONBOARDING.md](NAVIGATOR_ONBOARDING.md)
ESPECIALISTAS: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
CONTEXTO: PROJECT_OVERVIEW.md + CONTEXTO_MAESTRO.md
```

#### SESIÓN CORE
```
INPUT: /start-session core "descripción"
AUTO-ROUTING: Automático basado en palabras clave
ESPECIALISTAS: DESARROLLADOR_SENIOR + ARQUITECTO
CONTEXTO: DEPENDENCIAS.md + PATRONES_CODIGO.md + TESTING_PROTOCOLS.md
```

#### SESIÓN VERTICAL
```
INPUT: /start-session vertical "descripción [vertical]"
AUTO-ROUTING: Detecta vertical automáticamente
ESPECIALISTAS: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
CONTEXTO: ESPECIALIZACIONES.md + PATRONES_CODIGO.md + vertical específico
```

#### SESIÓN DESARROLLO METODOLÓGICO
```
INPUT: /start-development core "autenticación biométrica"
AUTO-ROUTING: → [NAVIGATOR_DEVELOPMENT_METHODOLOGY.md](NAVIGATOR_DEVELOPMENT_METHODOLOGY.md)
ESPECIALISTAS: DESARROLLADOR_SENIOR + ARQUITECTO + ANALISTA_NEGOCIO
CONTEXTO: Metodología 20 fases + estado actual + documentación existente
OUTPUT: Estado de fases + próximas acciones + documentación faltante
```

#### SESIÓN CONTINUACIÓN DESARROLLO
```
INPUT: /continue-development "modelo-datos" core
AUTO-ROUTING: → Fase específica en [NAVIGATOR_DEVELOPMENT_METHODOLOGY.md](NAVIGATOR_DEVELOPMENT_METHODOLOGY.md)
ESPECIALISTAS: Especialistas de la fase actual
CONTEXTO: Documentación de fase + archivos en progreso + criterios completitud
OUTPUT: Tareas específicas + archivos para editar + criterios validación
```

## PREPARACIÓN AUTOMÁTICA DE ENTORNO

### 🔧 VALIDACIONES GIT FLOW
```bash
# Verificación automática antes de crear nueva rama
1. Working Directory Limpio → git status --porcelain
2. Rama Base Válida → Auto-detecta develop/main
3. Sincronización → git fetch + verificación
4. Naming Convention → feature/YYYYMMDD-descripcion
```
**Detalles completos:** [NAVIGATOR_GIT_FLOW.md](NAVIGATOR_GIT_FLOW.md)

### 📝 CONVENCIONES DE BRANCHES
| Tipo | Formato | Origen | Destino |
|------|---------|--------|---------|
| **feature** | `feature/YYYYMMDD-descripcion` | develop/main | develop/main |
| **bugfix** | `bugfix/YYYYMMDD-descripcion` | develop/main | develop/main |
| **hotfix** | `hotfix/YYYYMMDD-descripcion` | main | main + develop |
| **release** | `release/vX.Y.Z` | develop | main + develop |

## MAPEO ESPECIALISTA → MÓDULOS

### 👨‍💻 DESARROLLADOR_SENIOR
- **Primarios:** PATRONES_CODIGO.md, DEPENDENCIAS.md, TESTING_PROTOCOLS.md
- **Auto-carga:** core_features, vertical_features, api_development

### 🏗️ ARQUITECTO_PRINCIPAL  
- **Primarios:** ESTRATEGIAS_IMPLEMENTACION.md, DEPENDENCIAS.md
- **Auto-carga:** architecture_decisions, cross_vertical_design, scalability_analysis

### 📊 ANALISTA_NEGOCIO
- **Primarios:** ESPECIALIZACIONES.md, ESTRATEGIAS_IMPLEMENTACION.md
- **Auto-carga:** business_rules, use_case_validation, vertical_requirements

### 🔒 ESPECIALISTA_SEGURIDAD
- **Primarios:** DEPENDENCIAS.md, TESTING_PROTOCOLS.md
- **Auto-carga:** security_analysis, compliance_validation

### 🛠️ DEVOPS_ENGINEER
- **Primarios:** DEPENDENCIAS.md, DOCUMENTACION_AUTOMATICA.md
- **Auto-carga:** deployment_strategies, infrastructure_setup

## COMANDOS EXTENDIDOS

### 🔍 VERIFICACIÓN Y ESTADO
```bash
/verify-environment "descripción"     # Validación completa pre-iteración
/git-flow-status                     # Estado Git Flow actual
/pending-branches                    # Branches sin merge
/navigator-status                    # Diagnóstico completo del sistema
```

### 🚀 PREPARACIÓN AUTOMÁTICA
```bash
/prepare-iteration "descripción"      # Auto-detecta tipo de rama
/prepare-feature "nueva funcionalidad" # Específico para features
/prepare-bugfix "corrección error"    # Específico para bugfix
/prepare-hotfix "parche crítico"      # Específico para hotfix
```

## FLUJO AUTOMÁTICO COMPLETO

### 📋 EJEMPLO: Nueva Funcionalidad
```
Usuario: "Implementar sistema de notificaciones push"
         ↓
🔍 Detección: "implementar" → NEW_ITERATION → FEATURE
🔧 Git Flow: Validaciones automáticas → feature/20250727-notificaciones-push
🎯 Routing: CORE session → DESARROLLADOR_SENIOR + ARQUITECTO
📚 Contexto: 3,124 tokens estimados
         ↓
✅ LISTO: /start-session core "Sistema notificaciones push"
```

## ARCHIVOS DE REFERENCIA DETALLADA

| Archivo | Propósito | Tokens Aprox. |
|---------|-----------|---------------|
| [NAVIGATOR_ONBOARDING.md](NAVIGATOR_ONBOARDING.md) | Flujos de onboarding para nuevos usuarios | ~800 |
| [NAVIGATOR_GIT_FLOW.md](NAVIGATOR_GIT_FLOW.md) | Scripts y validaciones Git Flow completas | ~1,200 |
| [NAVIGATOR_DEVELOPMENT_METHODOLOGY.md](NAVIGATOR_DEVELOPMENT_METHODOLOGY.md) | Metodología estructurada 20 fases desarrollo | ~1,800 |
| [NAVIGATOR_SESSION_HISTORY.md](NAVIGATOR_SESSION_HISTORY.md) | Manejo de historial y última sesión | ~600 |
| [NAVIGATOR_EXAMPLES.md](NAVIGATOR_EXAMPLES.md) | Ejemplos detallados de uso | ~1,000 |
| [NAVIGATOR_SCRIPTS.md](NAVIGATOR_SCRIPTS.md) | Scripts PowerShell y Bash completos | ~1,500 |
| [NAVIGATOR_METRICS.md](NAVIGATOR_METRICS.md) | KPIs y métricas de éxito | ~400 |

## MÉTRICAS CLAVE
- **Tiempo routing:** < 5 segundos
- **Preparación entorno:** < 15 segundos  
- **Precisión detección:** > 95%
- **Git Flow compliance:** > 99%
- **Token efficiency:** 85-90% vs método manual

---

**💡 OPTIMIZACIÓN DE TOKENS:**
- Navigator principal: ~500 tokens (vs 4,000+ anterior)
- Carga contextual: Solo archivos necesarios según detección
- Referencias cruzadas: Links a documentación específica cuando se necesite

**🔗 NAVEGACIÓN INTELIGENTE:**
El sistema carga automáticamente solo los módulos necesarios basándose en la detección de intención, manteniendo el contexto optimizado y la funcionalidad completa.
