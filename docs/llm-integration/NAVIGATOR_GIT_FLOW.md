# NAVIGATOR GIT FLOW - Validaciones y Preparación Automática

## CONVENCIONES DE BRANCHING

### 📁 ESTRUCTURA SOPORTADA
```
main (o master)
├── Rama estable para producción
├── Tags: v1.0.0, v1.1.0, etc.
└── Protegida: No commits directos

develop (opcional - auto-detectada)
├── Integración de features
├── Base para nuevas features
└── Sincronización con main

feature/YYYYMMDD-descripcion
├── Nuevas funcionalidades
├── Desde: develop (o main)
└── Eliminada después del merge

bugfix/YYYYMMDD-descripcion
├── Correcciones menores
├── Desde: develop (o main)
└── Eliminada después del merge

hotfix/YYYYMMDD-descripcion
├── Parches críticos
├── Desde: main únicamente
└── Merge a: main + develop

release/vX.Y.Z
├── Preparación de versiones
├── Desde: develop
└── Merge a: main + develop
```

## VALIDACIONES AUTOMÁTICAS

### ✅ PRE-VALIDACIONES
```bash
1. WORKING DIRECTORY LIMPIO
   comando: git status --porcelain
   validación: Resultado vacío
   acción_error: Solicitar commit o stash

2. RAMA BASE VÁLIDA  
   comando: git branch --show-current
   validación: develop, main, o feature/* válida
   acción_error: Checkout a rama base

3. SINCRONIZACIÓN CON ORIGIN
   comando: git fetch origin && git status --ahead-behind
   validación: Sin commits pendientes
   acción_error: git pull origin [rama]

4. NAMING CONVENTION
   validación: Formato tipo/YYYYMMDD-descripcion
   acción_error: Sugerir nombre correcto
```

### 🔧 DETECCIÓN AUTOMÁTICA DE TIPO

```javascript
const BRANCH_TYPE_DETECTION = {
  feature: [
    'implementar', 'crear', 'agregar', 'desarrollar', 'nuevo',
    'sistema', 'funcionalidad', 'módulo', 'dashboard', 'api'
  ],
  bugfix: [
    'corregir', 'arreglar', 'solucionar', 'reparar', 'bug',
    'error', 'problema', 'fallo', 'validación', 'formato'
  ],
  hotfix: [
    'crítico', 'urgente', 'producción', 'security',
    'vulnerabilidad', 'parche', 'emergencia', 'bloqueante'
  ],
  release: [
    'release', 'versión', 'deploy', 'lanzamiento', 'v1.', 'v2.'
  ]
}
```

## SCRIPTS DE PREPARACIÓN

### 🖥️ POWERSHELL (Windows)
```powershell
function Prepare-AEDDIteration {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Description,
        [string]$Type = "feature"
    )
    
    # 1. Verificar working directory limpio
    $gitStatus = git status --porcelain
    if ($gitStatus) {
        Write-Host "❌ Cambios sin commit detectados" -ForegroundColor Red
        Write-Host "Acciones: commit, stash, o descartar" -ForegroundColor Yellow
        return
    }
    
    # 2. Detectar y cambiar a rama base
    git fetch origin | Out-Null
    $developExists = git branch -r | Select-String "origin/develop"
    $baseBranch = if ($developExists) { "develop" } else { "main" }
    
    $currentBranch = git branch --show-current
    if ($currentBranch -ne $baseBranch) {
        git checkout $baseBranch
    }
    
    # 3. Sincronizar con origin
    git pull origin $baseBranch
    
    # 4. Crear rama con naming convention
    $date = Get-Date -Format "yyyyMMdd"
    $cleanDesc = ($Description -replace '[^a-zA-Z0-9\s]', '').Trim()
    $branchName = ($cleanDesc -replace '\s+', '-').ToLower()
    $newBranch = "$Type/$date-$branchName"
    
    # 5. Crear y cambiar a nueva rama
    git checkout -b $newBranch $baseBranch
    
    Write-Host "✅ Rama creada: $newBranch" -ForegroundColor Green
    Write-Host "🚀 Listo para: /start-session [tipo] '$Description'" -ForegroundColor Cyan
}

# Uso: Prepare-AEDDIteration "sistema notificaciones push"
```

### 🐧 BASH (Linux/Mac)
```bash
prepare_aedd_iteration() {
    local description="$1"
    local type="${2:-feature}"
    
    # 1. Verificar working directory limpio
    if [ -n "$(git status --porcelain)" ]; then
        echo "❌ Cambios sin commit detectados"
        echo "Acciones: commit, stash, o descartar"
        return 1
    fi
    
    # 2. Detectar rama base
    git fetch origin >/dev/null 2>&1
    local base_branch
    if git branch -r | grep -q "origin/develop"; then
        base_branch="develop"
    else
        base_branch="main"
    fi
    
    # 3. Cambiar a rama base y sincronizar
    git checkout "$base_branch"
    git pull origin "$base_branch"
    
    # 4. Crear rama con naming convention
    local date=$(date +%Y%m%d)
    local clean_desc=$(echo "$description" | sed 's/[^a-zA-Z0-9 ]//g' | tr '[:upper:]' '[:lower:]')
    local branch_name=$(echo "$clean_desc" | sed 's/[[:space:]]\+/-/g')
    local new_branch="$type/$date-$branch_name"
    
    # 5. Crear nueva rama
    git checkout -b "$new_branch" "$base_branch"
    
    echo "✅ Rama creada: $new_branch"
    echo "🚀 Listo para: /start-session [tipo] '$description'"
}

# Uso: prepare_aedd_iteration "sistema notificaciones push"
```

## COMANDOS DE VERIFICACIÓN

### 🔍 /verify-environment
```bash
# Ejecución automática
git status --porcelain                    # Working directory
git branch --show-current                 # Rama actual  
git fetch origin                          # Actualizar refs
git status --ahead-behind                 # Sincronización
git branch --no-merged [base]             # Branches pendientes

# Output ejemplo
✅ ANÁLISIS GIT FLOW:
├── Working directory: Limpio
├── Rama: feature/20250727-notificaciones-push
├── Base: develop (sincronizado)
├── Naming: Válida
└── Branches pendientes: Ninguna

🎯 ESTADO: LISTO PARA DESARROLLO
```

### 📊 /git-flow-status
```bash
# Análisis completo del repositorio
echo "🔍 ANÁLISIS COMPLETO DE GIT FLOW"

# Estado general
git status --short
git branch --show-current

# Validar naming convention
validate_branch_naming $(git branch --show-current)

# Branches pendientes
git branch --no-merged develop 2>/dev/null | grep -E "feature|bugfix"

# Sincronización
git fetch origin >/dev/null 2>&1
git status --ahead-behind
```

## FLUJO AUTOMÁTICO COMPLETO

### 🔄 EJEMPLO: Nueva Feature
```
1. DETECCIÓN
   Usuario: "Implementar sistema de notificaciones push"
   ↓
   Análisis: "implementar" + "sistema" → FEATURE

2. VALIDACIÓN GIT FLOW
   ├── ✅ Working directory limpio
   ├── ✅ Rama base: develop detectada
   ├── ✅ Sincronizado con origin/develop
   └── ✅ Naming convention preparada

3. PREPARACIÓN AUTOMÁTICA
   ├── Rama: feature/20250727-notificaciones-push
   ├── Base: develop
   └── Status: Creada exitosamente

4. CONTEXTO Y ROUTING
   ├── Tipo detectado: CORE (multi-vertical)
   ├── Especialistas: DESARROLLADOR_SENIOR + ARQUITECTO
   └── Contexto: 3,124 tokens estimados

5. INICIO SESIÓN
   Comando: /start-session core "Sistema notificaciones push"
   Estado: ✅ LISTO PARA DESARROLLO
```

## CASOS DE ERROR COMUNES

### ❌ WORKING DIRECTORY SUCIO
```bash
Problema: Archivos modificados sin commit
Detección: git status --porcelain no vacío
Solución: 
  1. git add . && git commit -m "WIP: preparando nueva feature"
  2. git stash push -m "Cambios temporales"
  3. git checkout . (¡CUIDADO! - pierde cambios)
```

### ❌ RAMA DESACTUALIZADA
```bash
Problema: Commits atrás de origin
Detección: git rev-list --count HEAD..origin/[rama] > 0
Solución: git pull origin [rama]
```

### ❌ NAMING CONVENTION INCORRECTA
```bash
Problema: Rama no sigue convención
Detección: No match con patrón tipo/YYYYMMDD-descripcion
Solución: Sugerir renombre o nueva rama
```

### ❌ BRANCHES PENDIENTES
```bash
Problema: Feature branches sin merge
Detección: git branch --no-merged develop
Solución: Advertir y listar branches pendientes
```

## MÉTRICAS Y VALIDACIÓN

### 📊 KPIs OBJETIVO
- **Tiempo preparación:** < 15 segundos
- **Errores Git Flow:** < 0.5%
- **Naming compliance:** > 99%
- **Working directory enforcement:** 100%
- **Sincronización automática:** > 97%

### 🔧 TROUBLESHOOTING
```bash
# Diagnóstico completo
/git-flow-status

# Reset a estado limpio
git checkout develop && git pull origin develop

# Validar convenciones
/validate-branch-naming

# Estado de branches
/pending-branches
```
