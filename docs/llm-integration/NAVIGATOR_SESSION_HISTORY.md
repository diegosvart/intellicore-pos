# NAVIGATOR SESSION HISTORY - Manejo de Historial y Estado

## TRIGGERS DE CONSULTA DE HISTORIAL

### 🔍 DETECCIÓN AUTOMÁTICA
```javascript
const SESSION_HISTORY_TRIGGERS = {
  last_session: ['última sesión', 'última iteración', 'último trabajo'],
  progress: ['progreso', 'avance', 'estado actual', 'en qué vamos'],
  recent_work: ['qué se hizo', 'trabajo reciente', 'cambios recientes'],
  git_history: ['últimos commits', 'historial', 'log']
}
```

### 📋 FUENTES DE INFORMACIÓN
1. **Git Log:** Últimos commits en branches activas
2. **docs/iteraciones/:** Archivos de iteración documentados
3. **Rama Actual:** Estado de la rama de trabajo
4. **CONTEXTO_MAESTRO.md:** Para contextualizar cambios

## COMANDOS DE HISTORIAL

### 📊 /last-session
```bash
# Búsqueda automática de última iteración
git log --oneline -10 --grep="feat\|fix\|feature"
ls docs/iteraciones/ | tail -5
git branch --show-current
git status --short
```

**Output esperado:**
```
📋 ÚLTIMA SESIÓN: 2025-07-27

RAMA ACTIVA: feature/20250727-qr-pedidos
ESPECIALISTAS: DESARROLLADOR_SENIOR + ANALISTA_NEGOCIO
OBJETIVO: Sistema QR para pedidos mejorado

IMPLEMENTADO:
├── ✅ API endpoint /qr/generate con validación mesa
├── ✅ Frontend component QrDisplay con error handling  
├── ✅ Base de datos: tabla qr_sessions con TTL
└── ✅ Tests unitarios: 95% coverage

EN PROGRESO:
├── 🔄 Integración con sistema de pagos
└── 🔄 Dashboard analytics para QR usage

PRÓXIMOS PASOS:
├── 📋 Completar testing de integración
├── 🚀 Deploy a staging environment
└── 🧪 Validación UAT con restaurant pilot

¿Continuar en esta rama o iniciar nueva iteración?
```

### 📈 /session-history
```bash
# Historial de múltiples sesiones
git log --oneline --since="1 week ago" --grep="feat\|fix"
find docs/iteraciones/ -name "*.md" -newer docs/iteraciones/ITERACION_2025_07_20.md
git branch -a | grep feature | head -5
```

**Output esperado:**
```
📚 HISTORIAL DE SESIONES (Última semana)

🗓️ 2025-07-27: Sistema QR para pedidos
   ├── Rama: feature/20250727-qr-pedidos
   ├── Estado: En progreso
   └── Progreso: 75% completado

🗓️ 2025-07-26: Integración pagos Stripe
   ├── Rama: feature/20250726-stripe-integration
   ├── Estado: Completado ✅
   └── Merged to: develop

🗓️ 2025-07-25: Dashboard analytics v2
   ├── Rama: feature/20250725-analytics-dashboard
   ├── Estado: En review
   └── Progreso: 90% completado

MÉTRICAS:
├── Sesiones activas: 3
├── Features completadas: 5
└── Tiempo promedio por feature: 2.3 días
```

## ANÁLISIS DE RAMA ACTUAL

### 🔍 INFORMACIÓN DETALLADA
```bash
get_current_branch_info() {
    local current_branch=$(git branch --show-current)
    local base_branch="develop"  # o main
    
    echo "ANÁLISIS DE RAMA ACTUAL:"
    echo "├── Rama: $current_branch"
    echo "├── Tipo: $(get_branch_type $current_branch)"
    echo "├── Creada: $(git log --format="%cr" -1 $current_branch --not $base_branch)"
    echo "├── Commits: $(git rev-list --count $base_branch..$current_branch)"
    echo "├── Archivos modificados: $(git diff --name-only $base_branch..$current_branch | wc -l)"
    echo "└── Última actividad: $(git log -1 --format="%cr")"
}
```

### 📊 MÉTRICAS DE PROGRESO
```bash
calculate_progress() {
    local todo_comments=$(grep -r "TODO\|FIXME\|XXX" . --include="*.js" --include="*.ts" | wc -l)
    local test_files=$(find . -name "*.test.*" -o -name "*.spec.*" | wc -l)
    local coverage=$(npm test -- --coverage 2>/dev/null | grep "All files" | awk '{print $4}')
    
    echo "MÉTRICAS DE PROGRESO:"
    echo "├── TODOs pendientes: $todo_comments"
    echo "├── Archivos de test: $test_files"
    echo "├── Coverage: $coverage"
    echo "└── Estado: $(estimate_completion_status)"
}
```

## TEMPLATES DE RESPUESTA

### 📋 TEMPLATE ÚLTIMA SESIÓN
```markdown
📋 ÚLTIMA SESIÓN: {DATE}

CONTEXTO:
├── Rama: {CURRENT_BRANCH}
├── Especialistas: {SPECIALISTS}
├── Objetivo: {SESSION_OBJECTIVE}
└── Tiempo transcurrido: {TIME_SINCE_START}

PROGRESO:
{COMPLETED_TASKS}

EN CURSO:
{IN_PROGRESS_TASKS}

PENDIENTE:
{PENDING_TASKS}

MÉTRICAS:
├── Commits: {COMMIT_COUNT}
├── Archivos modificados: {FILES_CHANGED}
├── Tests: {TEST_STATUS}
└── Progreso estimado: {COMPLETION_PERCENTAGE}%

🎯 PRÓXIMOS PASOS:
{RECOMMENDED_ACTIONS}

¿Continuar trabajo o iniciar nueva iteración?
```

### 📚 TEMPLATE HISTORIAL MÚLTIPLE
```markdown
📚 HISTORIAL DE SESIONES ({TIMEFRAME})

{SESSION_LIST}

📊 RESUMEN:
├── Total sesiones: {TOTAL_SESSIONS}
├── Features completadas: {COMPLETED_FEATURES}
├── En progreso: {ACTIVE_SESSIONS}
├── Tiempo promedio: {AVERAGE_TIME}
└── Productividad: {PRODUCTIVITY_METRIC}

🏆 LOGROS DESTACADOS:
{KEY_ACHIEVEMENTS}

⚠️ ITEMS PENDIENTES:
{PENDING_ITEMS}

🎯 RECOMENDACIONES:
{RECOMMENDATIONS}
```

## INTEGRACIÓN CON GIT

### 🔍 ANÁLISIS AUTOMÁTICO DE COMMITS
```bash
analyze_recent_commits() {
    echo "ANÁLISIS DE COMMITS RECIENTES:"
    
    # Últimos 10 commits con información detallada
    git log --oneline -10 --pretty=format:"├── %h %s (%cr)"
    
    echo ""
    echo "TIPOS DE CAMBIOS:"
    
    # Clasificar commits por tipo
    local feat_count=$(git log --oneline -20 --grep="feat" | wc -l)
    local fix_count=$(git log --oneline -20 --grep="fix" | wc -l)
    local docs_count=$(git log --oneline -20 --grep="docs" | wc -l)
    
    echo "├── Features: $feat_count"
    echo "├── Fixes: $fix_count"
    echo "└── Docs: $docs_count"
}
```

### 📈 ESTADÍSTICAS DE PRODUCTIVIDAD
```bash
productivity_stats() {
    local today=$(date +%Y-%m-%d)
    local week_ago=$(date -d '7 days ago' +%Y-%m-%d)
    
    echo "PRODUCTIVIDAD (Última semana):"
    
    local commits_today=$(git log --since="$today" --oneline | wc -l)
    local commits_week=$(git log --since="$week_ago" --oneline | wc -l)
    local files_changed=$(git diff --name-only HEAD~7 | wc -l)
    
    echo "├── Commits hoy: $commits_today"
    echo "├── Commits semana: $commits_week"
    echo "├── Archivos modificados: $files_changed"
    echo "└── Promedio diario: $((commits_week / 7))"
}
```

## DETECCIÓN DE ESTADO DE TRABAJO

### 🎯 ANÁLISIS INTELIGENTE
```javascript
const WORK_STATUS_DETECTION = {
  in_progress: {
    indicators: ['WIP:', 'TODO:', 'console.log', 'debugger'],
    branch_pattern: /^feature\/\d{8}-/,
    uncommitted_changes: true
  },
  
  ready_for_review: {
    indicators: ['feat:', 'fix:', 'complete'],
    test_coverage: '>= 80%',
    uncommitted_changes: false
  },
  
  completed: {
    branch_merged: true,
    tag_exists: true,
    documentation_updated: true
  }
}
```

### 🔧 RECOMENDACIONES AUTOMÁTICAS
```bash
generate_recommendations() {
    local status=$(detect_work_status)
    
    case $status in
        "in_progress")
            echo "🔄 CONTINUAR TRABAJO ACTUAL"
            echo "├── Completar TODOs pendientes"
            echo "├── Aumentar coverage de tests"
            echo "└── Preparar para review"
            ;;
        "ready_for_review")
            echo "👀 LISTO PARA REVIEW"
            echo "├── Crear Pull Request"
            echo "├── Solicitar revisión de código"
            echo "└── Preparar merge"
            ;;
        "completed")
            echo "✅ TRABAJO COMPLETADO"
            echo "├── Limpiar rama feature"
            echo "├── Actualizar documentación"
            echo "└── Iniciar nueva iteración"
            ;;
    esac
}
```

## INTEGRACIÓN CON NAVIGATOR

### 🔗 AUTO-CARGA EN SESIÓN
```bash
# Cuando se detecta trigger de historial
if detect_history_trigger "$user_input"; then
    load_session_history
    provide_context_continuation
    suggest_next_actions
fi
```

### 📊 MÉTRICAS DE SEGUIMIENTO
- **Consultas de historial:** Frecuencia y patrones
- **Continuidad de trabajo:** % de sesiones que continúan trabajo previo
- **Tiempo de retoma:** Tiempo entre abandono y continuación
- **Efectividad de recomendaciones:** Adopción de sugerencias
