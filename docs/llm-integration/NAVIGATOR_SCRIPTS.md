# NAVIGATOR SCRIPTS - Scripts PowerShell y Bash Completos

## SCRIPTS POWERSHELL (WINDOWS)

### 🖥️ SCRIPT PRINCIPAL DE PREPARACIÓN
```powershell
# AEDD_NAVIGATOR_SETUP.ps1
function Prepare-AEDDIteration {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$FunctionalityDescription,
        [ValidateSet("feature", "bugfix", "hotfix", "release")]
        [string]$BranchType = "feature",
        [switch]$Strict,
        [switch]$DryRun
    )
    
    Write-Host "🔍 AEDD NAVIGATOR - PREPARACIÓN DE ITERACIÓN" -ForegroundColor Cyan
    Write-Host "Descripción: $FunctionalityDescription" -ForegroundColor White
    Write-Host "Tipo: $BranchType" -ForegroundColor White
    Write-Host ""
    
    if ($DryRun) {
        Write-Host "🧪 MODO DRY RUN - Solo simulación" -ForegroundColor Yellow
    }
    
    # 1. VERIFICAR HERRAMIENTAS NECESARIAS
    Write-Host "🔧 Verificando herramientas..." -ForegroundColor Cyan
    
    try {
        $gitVersion = git --version 2>$null
        if (-not $gitVersion) {
            throw "Git no encontrado"
        }
        Write-Host "✅ Git: $($gitVersion)" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Git no está instalado o no está en PATH" -ForegroundColor Red
        return
    }
    
    # 2. VERIFICAR ESTADO DEL REPOSITORIO
    Write-Host "📂 Verificando repositorio..." -ForegroundColor Cyan
    
    if (-not (Test-Path ".git")) {
        Write-Host "❌ No es un repositorio Git" -ForegroundColor Red
        return
    }
    
    # 3. VERIFICAR WORKING DIRECTORY LIMPIO
    Write-Host "🧹 Verificando working directory..." -ForegroundColor Cyan
    
    $gitStatus = git status --porcelain 2>$null
    if ($gitStatus) {
        Write-Host "❌ Working directory no está limpio:" -ForegroundColor Red
        git status --short
        Write-Host ""
        Write-Host "💡 Opciones para continuar:" -ForegroundColor Yellow
        Write-Host "  1. git add . && git commit -m 'WIP: preparando nueva feature'" -ForegroundColor White
        Write-Host "  2. git stash push -m 'Cambios temporales antes de nueva feature'" -ForegroundColor White
        Write-Host "  3. git checkout . # ⚠️ CUIDADO: Pierde cambios no commitados" -ForegroundColor White
        return
    }
    Write-Host "✅ Working directory limpio" -ForegroundColor Green
    
    # 4. OBTENER INFORMACIÓN ACTUAL
    $currentBranch = git branch --show-current 2>$null
    Write-Host "📍 Rama actual: $currentBranch" -ForegroundColor Blue
    
    # 5. DETECTAR RAMA BASE (develop > main > master)
    Write-Host "🔍 Detectando rama base..." -ForegroundColor Cyan
    
    if (-not $DryRun) {
        git fetch origin 2>&1 | Out-Null
    }
    
    $baseBranch = $null
    $remoteBranches = git branch -r 2>$null
    
    if ($remoteBranches | Select-String "origin/develop") {
        $baseBranch = "develop"
    } elseif ($remoteBranches | Select-String "origin/main") {
        $baseBranch = "main"
    } elseif ($remoteBranches | Select-String "origin/master") {
        $baseBranch = "master"
    } else {
        Write-Host "❌ No se pudo detectar rama base (develop/main/master)" -ForegroundColor Red
        return
    }
    
    Write-Host "🎯 Rama base detectada: $baseBranch" -ForegroundColor Green
    
    # 6. VALIDAR TIPO DE RAMA VS RAMA ACTUAL
    $currentBranchType = Get-BranchType $currentBranch
    $isValidForNewBranch = $false
    
    switch ($BranchType) {
        "feature" { $isValidForNewBranch = ($currentBranch -eq $baseBranch) -or ($currentBranch -eq "develop") }
        "bugfix"  { $isValidForNewBranch = ($currentBranch -eq $baseBranch) -or ($currentBranch -eq "develop") }
        "hotfix"  { $isValidForNewBranch = ($currentBranch -eq "main") -or ($currentBranch -eq "master") }
        "release" { $isValidForNewBranch = ($currentBranch -eq "develop") }
    }
    
    if (-not $isValidForNewBranch) {
        $targetBranch = switch ($BranchType) {
            "hotfix" { if ($baseBranch -eq "main") { "main" } else { "master" } }
            "release" { "develop" }
            default { $baseBranch }
        }
        
        Write-Host "⚠️ Rama actual '$currentBranch' no es válida para crear $BranchType" -ForegroundColor Yellow
        Write-Host "🔄 Cambiando a rama '$targetBranch'..." -ForegroundColor Cyan
        
        if (-not $DryRun) {
            git checkout $targetBranch 2>&1 | Out-Null
            if ($LASTEXITCODE -ne 0) {
                Write-Host "❌ Error al cambiar a rama $targetBranch" -ForegroundColor Red
                return
            }
        }
        $currentBranch = $targetBranch
    }
    
    # 7. VERIFICAR SINCRONIZACIÓN CON ORIGIN
    if ($currentBranch -eq $baseBranch -or $currentBranch -eq "develop") {
        Write-Host "🔄 Verificando sincronización con origin/$currentBranch..." -ForegroundColor Cyan
        
        $behindCount = git rev-list --count HEAD..origin/$currentBranch 2>$null
        if ([int]$behindCount -gt 0) {
            Write-Host "⚠️ Rama desactualizada ($behindCount commits atrás de origin)" -ForegroundColor Yellow
            Write-Host "🔄 Actualizando rama..." -ForegroundColor Cyan
            
            if (-not $DryRun) {
                git pull origin $currentBranch 2>&1 | Out-Null
                if ($LASTEXITCODE -ne 0) {
                    Write-Host "❌ Error al actualizar rama. Resolver conflictos manualmente." -ForegroundColor Red
                    return
                }
            }
            Write-Host "✅ Rama actualizada exitosamente" -ForegroundColor Green
        } else {
            Write-Host "✅ Rama sincronizada con origin" -ForegroundColor Green
        }
    }
    
    # 8. VERIFICAR BRANCHES PENDIENTES (solo en modo strict)
    if ($Strict) {
        Write-Host "🔍 Verificando branches pendientes..." -ForegroundColor Cyan
        
        $unmergedBranches = git branch --no-merged $baseBranch 2>$null | 
                           Where-Object { $_ -notmatch "^\*" -and $_ -match "(feature|bugfix)/" } |
                           ForEach-Object { $_.Trim() }
        
        if ($unmergedBranches) {
            Write-Host "⚠️ Feature/bugfix branches sin merge detectadas:" -ForegroundColor Yellow
            $unmergedBranches | ForEach-Object { 
                Write-Host "   📋 $_" -ForegroundColor Yellow 
            }
            Write-Host "💡 Considera completar merge antes de crear nueva feature" -ForegroundColor Yellow
            
            if ($BranchType -eq "feature") {
                $continue = Read-Host "¿Continuar de todas formas? (y/N)"
                if ($continue -ne "y" -and $continue -ne "Y") {
                    Write-Host "⏹️ Operación cancelada por el usuario" -ForegroundColor Yellow
                    return
                }
            }
        }
    }
    
    # 9. GENERAR NOMBRE DE RAMA CON NAMING CONVENTION
    $date = Get-Date -Format "yyyyMMdd"
    $cleanDescription = ($FunctionalityDescription -replace '[^a-zA-Z0-9\s]', '').Trim()
    $branchName = ($cleanDescription -replace '\s+', '-').ToLower()
    
    # Limitar longitud del nombre
    if ($branchName.Length -gt 50) {
        $branchName = $branchName.Substring(0, 50).TrimEnd('-')
        Write-Host "⚠️ Nombre truncado a 50 caracteres" -ForegroundColor Yellow
    }
    
    $newBranch = "$BranchType/$date-$branchName"
    
    # 10. VALIDAR QUE LA RAMA NO EXISTA
    $branchExists = git branch --list $newBranch 2>$null
    if ($branchExists) {
        Write-Host "❌ La rama '$newBranch' ya existe" -ForegroundColor Red
        Write-Host "💡 Sugerencias:" -ForegroundColor Yellow
        Write-Host "  1. Usar descripción más específica" -ForegroundColor White
        Write-Host "  2. Cambiar a rama existente: git checkout $newBranch" -ForegroundColor White
        Write-Host "  3. Eliminar rama existente: git branch -D $newBranch" -ForegroundColor White
        return
    }
    
    # 11. MOSTRAR RESUMEN ANTES DE CREAR
    Write-Host ""
    Write-Host "📋 RESUMEN DE OPERACIÓN:" -ForegroundColor Cyan
    Write-Host "├── Rama nueva: $newBranch" -ForegroundColor White
    Write-Host "├── Desde: $currentBranch" -ForegroundColor White
    Write-Host "├── Tipo: $BranchType" -ForegroundColor White
    Write-Host "├── Descripción: $FunctionalityDescription" -ForegroundColor White
    Write-Host "└── Modo: $(if ($DryRun) { 'DRY RUN' } else { 'REAL' })" -ForegroundColor White
    Write-Host ""
    
    if ($DryRun) {
        Write-Host "🧪 DRY RUN COMPLETADO - No se realizaron cambios" -ForegroundColor Yellow
        Write-Host "✅ Validaciones pasadas, rama lista para crear" -ForegroundColor Green
        return
    }
    
    # 12. CREAR NUEVA RAMA
    Write-Host "🚀 Creando rama '$newBranch'..." -ForegroundColor Green
    
    git checkout -b $newBranch $currentBranch 2>&1 | Out-Null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "🎉 ENTORNO PREPARADO EXITOSAMENTE!" -ForegroundColor Green
        Write-Host "┌─────────────────────────────────────────────┐" -ForegroundColor Green
        Write-Host "│                                             │" -ForegroundColor Green
        Write-Host "│  📁 Rama: $($newBranch.PadRight(30)) │" -ForegroundColor Green
        Write-Host "│  🌿 Base: $($currentBranch.PadRight(30)) │" -ForegroundColor Green
        Write-Host "│  📝 Descripción: $($FunctionalityDescription.Substring(0, [Math]::Min($FunctionalityDescription.Length, 23)).PadRight(23)) │" -ForegroundColor Green
        Write-Host "│  🎯 Tipo: $($BranchType.PadRight(30)) │" -ForegroundColor Green
        Write-Host "│                                             │" -ForegroundColor Green
        Write-Host "└─────────────────────────────────────────────┘" -ForegroundColor Green
        Write-Host ""
        Write-Host "📋 PRÓXIMOS PASOS:" -ForegroundColor Blue
        Write-Host "   /start-session [tipo] '$FunctionalityDescription'" -ForegroundColor White
        Write-Host ""
        Write-Host "🔧 GIT FLOW STATUS: ✅ TODAS LAS VALIDACIONES PASADAS" -ForegroundColor Green
        
        # Generar sugerencia de tipo de sesión
        $sessionType = Get-SuggestedSessionType $FunctionalityDescription
        if ($sessionType) {
            Write-Host ""
            Write-Host "💡 SUGERENCIA INTELIGENTE:" -ForegroundColor Magenta
            Write-Host "   /start-session $sessionType '$FunctionalityDescription'" -ForegroundColor Cyan
        }
        
    } else {
        Write-Host "❌ Error al crear rama" -ForegroundColor Red
        Write-Host "Comando ejecutado: git checkout -b $newBranch $currentBranch" -ForegroundColor Gray
    }
}

# FUNCIÓN AUXILIAR: Detectar tipo de rama actual
function Get-BranchType {
    param([string]$BranchName)
    
    if ($BranchName -match "^feature/") { return "feature" }
    if ($BranchName -match "^bugfix/") { return "bugfix" }
    if ($BranchName -match "^hotfix/") { return "hotfix" }
    if ($BranchName -match "^release/") { return "release" }
    if ($BranchName -in @("develop", "main", "master")) { return "base" }
    
    return "unknown"
}

# FUNCIÓN AUXILIAR: Sugerir tipo de sesión basado en descripción
function Get-SuggestedSessionType {
    param([string]$Description)
    
    $desc = $Description.ToLower()
    
    # Keywords para diferentes tipos de sesión
    $coreKeywords = @("authentication", "payment", "core", "shared", "universal", "api")
    $verticalKeywords = @("restaurant", "hotel", "retail", "service", "healthcare")
    $crossVerticalKeywords = @("analytics", "dashboard", "reporting", "integration")
    $securityKeywords = @("security", "encryption", "audit", "compliance", "vulnerability")
    $deploymentKeywords = @("deploy", "infrastructure", "docker", "kubernetes", "ci/cd")
    
    foreach ($keyword in $securityKeywords) {
        if ($desc -like "*$keyword*") { return "security" }
    }
    
    foreach ($keyword in $deploymentKeywords) {
        if ($desc -like "*$keyword*") { return "deployment" }
    }
    
    foreach ($keyword in $crossVerticalKeywords) {
        if ($desc -like "*$keyword*") { return "cross-vertical" }
    }
    
    foreach ($keyword in $coreKeywords) {
        if ($desc -like "*$keyword*") { return "core" }
    }
    
    foreach ($keyword in $verticalKeywords) {
        if ($desc -like "*$keyword*") { return "vertical" }
    }
    
    return $null
}

# FUNCIÓN AUXILIAR: Validar naming convention
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

# FUNCIÓN DE ESTADO COMPLETO
function Get-AEDDGitFlowStatus {
    Write-Host "🔍 ANÁLISIS COMPLETO DE GIT FLOW - AEDD NAVIGATOR" -ForegroundColor Cyan
    Write-Host ""
    
    # Información básica
    $currentBranch = git branch --show-current 2>$null
    $gitStatus = git status --porcelain 2>$null
    
    Write-Host "📍 ESTADO ACTUAL:" -ForegroundColor Blue
    Write-Host "├── Rama: $currentBranch" -ForegroundColor White
    
    # Validar naming convention
    $namingValidation = Test-BranchNamingConvention $currentBranch
    if ($namingValidation.Valid) {
        Write-Host "├── Naming convention: ✅ Válida ($($namingValidation.Type))" -ForegroundColor Green
    } else {
        Write-Host "├── Naming convention: ⚠️ No estándar" -ForegroundColor Yellow
    }
    
    # Estado working directory
    if (-not $gitStatus) {
        Write-Host "├── Working directory: ✅ Limpio" -ForegroundColor Green
    } else {
        Write-Host "├── Working directory: ❌ Cambios pendientes" -ForegroundColor Red
        Write-Host "│   $($gitStatus.Count) archivos modificados" -ForegroundColor Gray
    }
    
    # Detectar rama base
    git fetch origin 2>&1 | Out-Null
    $remoteBranches = git branch -r 2>$null
    $baseBranch = $null
    
    if ($remoteBranches | Select-String "origin/develop") {
        $baseBranch = "develop"
    } elseif ($remoteBranches | Select-String "origin/main") {
        $baseBranch = "main"
    }
    
    Write-Host "└── Rama base: $baseBranch" -ForegroundColor White
    
    # Sincronización
    if ($currentBranch -eq $baseBranch) {
        $behindCount = git rev-list --count HEAD..origin/$baseBranch 2>$null
        Write-Host ""
        Write-Host "🔄 SINCRONIZACIÓN:" -ForegroundColor Blue
        if ([int]$behindCount -eq 0) {
            Write-Host "└── ✅ Actualizada con origin/$baseBranch" -ForegroundColor Green
        } else {
            Write-Host "└── ⚠️ $behindCount commits atrás de origin/$baseBranch" -ForegroundColor Yellow
        }
    }
    
    # Branches pendientes
    $unmergedBranches = git branch --no-merged $baseBranch 2>$null | 
                       Where-Object { $_ -notmatch "^\*" -and $_ -match "(feature|bugfix)/" } |
                       ForEach-Object { $_.Trim() }
    
    Write-Host ""
    Write-Host "📋 BRANCHES PENDIENTES:" -ForegroundColor Blue
    if (-not $unmergedBranches) {
        Write-Host "└── ✅ Ninguna feature/bugfix branch sin merge" -ForegroundColor Green
    } else {
        Write-Host "├── ⚠️ $($unmergedBranches.Count) branches sin merge:" -ForegroundColor Yellow
        for ($i = 0; $i -lt $unmergedBranches.Count; $i++) {
            $prefix = if ($i -eq $unmergedBranches.Count - 1) { "└──" } else { "├──" }
            Write-Host "$prefix 📋 $($unmergedBranches[$i])" -ForegroundColor Yellow
        }
    }
    
    # Resumen final
    Write-Host ""
    Write-Host "🎯 ESTADO GENERAL:" -ForegroundColor Blue
    if (-not $gitStatus -and $behindCount -eq 0) {
        Write-Host "└── ✅ LISTO PARA NUEVA ITERACIÓN" -ForegroundColor Green
    } else {
        Write-Host "└── ⚠️ REQUIERE ACCIÓN ANTES DE CONTINUAR" -ForegroundColor Yellow
    }
}

# EXPORTAR FUNCIONES
Export-ModuleMember -Function Prepare-AEDDIteration, Get-AEDDGitFlowStatus, Test-BranchNamingConvention

# EJEMPLOS DE USO:
<#
Prepare-AEDDIteration "sistema QR para pedidos"
Prepare-AEDDIteration "corregir bug en validación email" -BranchType "bugfix"
Prepare-AEDDIteration "parche crítico seguridad" -BranchType "hotfix" -Strict
Prepare-AEDDIteration "nueva funcionalidad" -DryRun
Get-AEDDGitFlowStatus
#>
```

## SCRIPTS BASH (LINUX/MAC)

### 🐧 SCRIPT PRINCIPAL DE PREPARACIÓN
```bash
#!/bin/bash
# aedd_navigator_setup.sh

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Función principal de preparación
prepare_aedd_iteration() {
    local functionality_description="$1"
    local branch_type="${2:-feature}"
    local strict_mode=false
    local dry_run=false
    
    # Procesar argumentos adicionales
    shift 2
    while [[ $# -gt 0 ]]; do
        case $1 in
            --strict)
                strict_mode=true
                shift
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            *)
                echo -e "${YELLOW}Argumento desconocido: $1${NC}"
                shift
                ;;
        esac
    done
    
    if [ -z "$functionality_description" ]; then
        echo -e "${RED}❌ Error: Descripción de funcionalidad requerida${NC}"
        echo -e "${CYAN}📋 Uso: prepare_aedd_iteration 'descripción' [tipo] [--strict] [--dry-run]${NC}"
        echo -e "${WHITE}   Tipos: feature (default), bugfix, hotfix, release${NC}"
        return 1
    fi
    
    echo -e "${CYAN}🔍 AEDD NAVIGATOR - PREPARACIÓN DE ITERACIÓN${NC}"
    echo -e "${WHITE}Descripción: $functionality_description${NC}"
    echo -e "${WHITE}Tipo: $branch_type${NC}"
    echo ""
    
    if [ "$dry_run" = true ]; then
        echo -e "${YELLOW}🧪 MODO DRY RUN - Solo simulación${NC}"
    fi
    
    # 1. VERIFICAR HERRAMIENTAS NECESARIAS
    echo -e "${CYAN}🔧 Verificando herramientas...${NC}"
    
    if ! command -v git &> /dev/null; then
        echo -e "${RED}❌ Git no está instalado${NC}"
        return 1
    fi
    
    local git_version=$(git --version)
    echo -e "${GREEN}✅ Git: $git_version${NC}"
    
    # 2. VERIFICAR ESTADO DEL REPOSITORIO
    echo -e "${CYAN}📂 Verificando repositorio...${NC}"
    
    if [ ! -d ".git" ]; then
        echo -e "${RED}❌ No es un repositorio Git${NC}"
        return 1
    fi
    
    # 3. VERIFICAR WORKING DIRECTORY LIMPIO
    echo -e "${CYAN}🧹 Verificando working directory...${NC}"
    
    if [ -n "$(git status --porcelain)" ]; then
        echo -e "${RED}❌ Working directory no está limpio:${NC}"
        git status --short
        echo ""
        echo -e "${YELLOW}💡 Opciones para continuar:${NC}"
        echo -e "${WHITE}  1. git add . && git commit -m 'WIP: preparando nueva feature'${NC}"
        echo -e "${WHITE}  2. git stash push -m 'Cambios temporales antes de nueva feature'${NC}"
        echo -e "${WHITE}  3. git checkout . # ⚠️ CUIDADO: Pierde cambios no commitados${NC}"
        return 1
    fi
    echo -e "${GREEN}✅ Working directory limpio${NC}"
    
    # 4. OBTENER INFORMACIÓN ACTUAL
    local current_branch=$(git branch --show-current)
    echo -e "${BLUE}📍 Rama actual: $current_branch${NC}"
    
    # 5. DETECTAR RAMA BASE
    echo -e "${CYAN}🔍 Detectando rama base...${NC}"
    
    if [ "$dry_run" != true ]; then
        git fetch origin >/dev/null 2>&1
    fi
    
    local base_branch=""
    if git branch -r | grep -q "origin/develop"; then
        base_branch="develop"
    elif git branch -r | grep -q "origin/main"; then
        base_branch="main"
    elif git branch -r | grep -q "origin/master"; then
        base_branch="master"
    else
        echo -e "${RED}❌ No se pudo detectar rama base (develop/main/master)${NC}"
        return 1
    fi
    
    echo -e "${GREEN}🎯 Rama base detectada: $base_branch${NC}"
    
    # 6. VALIDAR TIPO DE RAMA VS RAMA ACTUAL
    local is_valid_for_new_branch=false
    
    case "$branch_type" in
        "feature"|"bugfix")
            if [[ "$current_branch" == "$base_branch" || "$current_branch" == "develop" ]]; then
                is_valid_for_new_branch=true
            fi
            ;;
        "hotfix")
            if [[ "$current_branch" == "main" || "$current_branch" == "master" ]]; then
                is_valid_for_new_branch=true
            fi
            ;;
        "release")
            if [[ "$current_branch" == "develop" ]]; then
                is_valid_for_new_branch=true
            fi
            ;;
    esac
    
    if [ "$is_valid_for_new_branch" != true ]; then
        local target_branch
        case "$branch_type" in
            "hotfix")
                target_branch=$(if [[ "$base_branch" == "main" ]]; then echo "main"; else echo "master"; fi)
                ;;
            "release")
                target_branch="develop"
                ;;
            *)
                target_branch="$base_branch"
                ;;
        esac
        
        echo -e "${YELLOW}⚠️ Rama actual '$current_branch' no es válida para crear $branch_type${NC}"
        echo -e "${CYAN}🔄 Cambiando a rama '$target_branch'...${NC}"
        
        if [ "$dry_run" != true ]; then
            if ! git checkout "$target_branch" >/dev/null 2>&1; then
                echo -e "${RED}❌ Error al cambiar a rama $target_branch${NC}"
                return 1
            fi
        fi
        current_branch="$target_branch"
    fi
    
    # 7. VERIFICAR SINCRONIZACIÓN CON ORIGIN
    if [[ "$current_branch" == "$base_branch" || "$current_branch" == "develop" ]]; then
        echo -e "${CYAN}🔄 Verificando sincronización con origin/$current_branch...${NC}"
        
        local behind_count=$(git rev-list --count HEAD..origin/"$current_branch" 2>/dev/null || echo "0")
        if [ "$behind_count" -gt 0 ]; then
            echo -e "${YELLOW}⚠️ Rama desactualizada ($behind_count commits atrás de origin)${NC}"
            echo -e "${CYAN}🔄 Actualizando rama...${NC}"
            
            if [ "$dry_run" != true ]; then
                if ! git pull origin "$current_branch" >/dev/null 2>&1; then
                    echo -e "${RED}❌ Error al actualizar rama. Resolver conflictos manualmente.${NC}"
                    return 1
                fi
            fi
            echo -e "${GREEN}✅ Rama actualizada exitosamente${NC}"
        else
            echo -e "${GREEN}✅ Rama sincronizada con origin${NC}"
        fi
    fi
    
    # 8. VERIFICAR BRANCHES PENDIENTES (solo en modo strict)
    if [ "$strict_mode" = true ]; then
        echo -e "${CYAN}🔍 Verificando branches pendientes...${NC}"
        
        local unmerged_branches=$(git branch --no-merged "$base_branch" 2>/dev/null | grep -E "^\s*(feature|bugfix)/" | head -10)
        if [ -n "$unmerged_branches" ]; then
            echo -e "${YELLOW}⚠️ Feature/bugfix branches sin merge detectadas:${NC}"
            echo "$unmerged_branches" | sed 's/^/   📋 /' | while read line; do
                echo -e "${YELLOW}$line${NC}"
            done
            echo -e "${YELLOW}💡 Considera completar merge antes de crear nueva feature${NC}"
            
            if [ "$branch_type" = "feature" ]; then
                echo -n "¿Continuar de todas formas? (y/N): "
                read -r continue_choice
                if [[ "$continue_choice" != "y" && "$continue_choice" != "Y" ]]; then
                    echo -e "${YELLOW}⏹️ Operación cancelada por el usuario${NC}"
                    return 0
                fi
            fi
        fi
    fi
    
    # 9. GENERAR NOMBRE DE RAMA CON NAMING CONVENTION
    local date=$(date +%Y%m%d)
    local clean_description=$(echo "$functionality_description" | sed 's/[^a-zA-Z0-9 ]//g' | tr '[:upper:]' '[:lower:]')
    local branch_name=$(echo "$clean_description" | sed 's/[[:space:]]\+/-/g' | sed 's/^-\|-$//g')
    
    # Limitar longitud del nombre
    if [ ${#branch_name} -gt 50 ]; then
        branch_name="${branch_name:0:50}"
        branch_name="${branch_name%-}"  # Remover guión final si existe
        echo -e "${YELLOW}⚠️ Nombre truncado a 50 caracteres${NC}"
    fi
    
    local new_branch="$branch_type/$date-$branch_name"
    
    # 10. VALIDAR QUE LA RAMA NO EXISTA
    if git branch --list "$new_branch" | grep -q "$new_branch"; then
        echo -e "${RED}❌ La rama '$new_branch' ya existe${NC}"
        echo -e "${YELLOW}💡 Sugerencias:${NC}"
        echo -e "${WHITE}  1. Usar descripción más específica${NC}"
        echo -e "${WHITE}  2. Cambiar a rama existente: git checkout $new_branch${NC}"
        echo -e "${WHITE}  3. Eliminar rama existente: git branch -D $new_branch${NC}"
        return 1
    fi
    
    # 11. MOSTRAR RESUMEN ANTES DE CREAR
    echo ""
    echo -e "${CYAN}📋 RESUMEN DE OPERACIÓN:${NC}"
    echo -e "${WHITE}├── Rama nueva: $new_branch${NC}"
    echo -e "${WHITE}├── Desde: $current_branch${NC}"
    echo -e "${WHITE}├── Tipo: $branch_type${NC}"
    echo -e "${WHITE}├── Descripción: $functionality_description${NC}"
    echo -e "${WHITE}└── Modo: $(if [ "$dry_run" = true ]; then echo 'DRY RUN'; else echo 'REAL'; fi)${NC}"
    echo ""
    
    if [ "$dry_run" = true ]; then
        echo -e "${YELLOW}🧪 DRY RUN COMPLETADO - No se realizaron cambios${NC}"
        echo -e "${GREEN}✅ Validaciones pasadas, rama lista para crear${NC}"
        return 0
    fi
    
    # 12. CREAR NUEVA RAMA
    echo -e "${GREEN}🚀 Creando rama '$new_branch'...${NC}"
    
    if git checkout -b "$new_branch" "$current_branch" >/dev/null 2>&1; then
        echo ""
        echo -e "${GREEN}🎉 ENTORNO PREPARADO EXITOSAMENTE!${NC}"
        echo -e "${GREEN}┌─────────────────────────────────────────────┐${NC}"
        echo -e "${GREEN}│                                             │${NC}"
        printf "${GREEN}│  📁 Rama: %-30s │${NC}\n" "$new_branch"
        printf "${GREEN}│  🌿 Base: %-30s │${NC}\n" "$current_branch"
        printf "${GREEN}│  📝 Descripción: %-23s │${NC}\n" "${functionality_description:0:23}"
        printf "${GREEN}│  🎯 Tipo: %-30s │${NC}\n" "$branch_type"
        echo -e "${GREEN}│                                             │${NC}"
        echo -e "${GREEN}└─────────────────────────────────────────────┘${NC}"
        echo ""
        echo -e "${BLUE}📋 PRÓXIMOS PASOS:${NC}"
        echo -e "${WHITE}   /start-session [tipo] '$functionality_description'${NC}"
        echo ""
        echo -e "${GREEN}🔧 GIT FLOW STATUS: ✅ TODAS LAS VALIDACIONES PASADAS${NC}"
        
        # Generar sugerencia de tipo de sesión
        local session_type=$(get_suggested_session_type "$functionality_description")
        if [ -n "$session_type" ]; then
            echo ""
            echo -e "${MAGENTA}💡 SUGERENCIA INTELIGENTE:${NC}"
            echo -e "${CYAN}   /start-session $session_type '$functionality_description'${NC}"
        fi
        
    else
        echo -e "${RED}❌ Error al crear rama${NC}"
        echo -e "${GRAY}Comando ejecutado: git checkout -b $new_branch $current_branch${NC}"
        return 1
    fi
}

# FUNCIÓN AUXILIAR: Detectar tipo de rama actual
get_branch_type() {
    local branch_name="$1"
    
    case "$branch_name" in
        feature/*) echo "feature" ;;
        bugfix/*) echo "bugfix" ;;
        hotfix/*) echo "hotfix" ;;
        release/*) echo "release" ;;
        develop|main|master) echo "base" ;;
        *) echo "unknown" ;;
    esac
}

# FUNCIÓN AUXILIAR: Sugerir tipo de sesión basado en descripción
get_suggested_session_type() {
    local description="$1"
    local desc_lower=$(echo "$description" | tr '[:upper:]' '[:lower:]')
    
    # Keywords para diferentes tipos de sesión
    local security_keywords="security encryption audit compliance vulnerability"
    local deployment_keywords="deploy infrastructure docker kubernetes ci-cd"
    local cross_vertical_keywords="analytics dashboard reporting integration"
    local core_keywords="authentication payment core shared universal api"
    local vertical_keywords="restaurant hotel retail service healthcare"
    
    for keyword in $security_keywords; do
        if [[ "$desc_lower" == *"$keyword"* ]]; then
            echo "security"
            return
        fi
    done
    
    for keyword in $deployment_keywords; do
        if [[ "$desc_lower" == *"$keyword"* ]]; then
            echo "deployment"
            return
        fi
    done
    
    for keyword in $cross_vertical_keywords; do
        if [[ "$desc_lower" == *"$keyword"* ]]; then
            echo "cross-vertical"
            return
        fi
    done
    
    for keyword in $core_keywords; do
        if [[ "$desc_lower" == *"$keyword"* ]]; then
            echo "core"
            return
        fi
    done
    
    for keyword in $vertical_keywords; do
        if [[ "$desc_lower" == *"$keyword"* ]]; then
            echo "vertical"
            return
        fi
    done
}

# FUNCIÓN AUXILIAR: Validar naming convention
validate_branch_naming() {
    local branch_name="$1"
    
    case "$branch_name" in
        feature/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*)
            echo -e "${GREEN}✅ Naming convention válida: feature branch${NC}"
            return 0
            ;;
        bugfix/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*)
            echo -e "${GREEN}✅ Naming convention válida: bugfix branch${NC}"
            return 0
            ;;
        hotfix/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*)
            echo -e "${GREEN}✅ Naming convention válida: hotfix branch${NC}"
            return 0
            ;;
        release/v[0-9]*.[0-9]*.[0-9]*)
            echo -e "${GREEN}✅ Naming convention válida: release branch${NC}"
            return 0
            ;;
        *)
            echo -e "${YELLOW}⚠️ Naming convention no estándar: $branch_name${NC}"
            echo -e "${YELLOW}💡 Convención recomendada: tipo/YYYYMMDD-descripcion${NC}"
            return 1
            ;;
    esac
}

# FUNCIÓN DE ESTADO COMPLETO
get_aedd_git_flow_status() {
    echo -e "${CYAN}🔍 ANÁLISIS COMPLETO DE GIT FLOW - AEDD NAVIGATOR${NC}"
    echo ""
    
    # Información básica
    local current_branch=$(git branch --show-current)
    local git_status=$(git status --porcelain)
    
    echo -e "${BLUE}📍 ESTADO ACTUAL:${NC}"
    echo -e "${WHITE}├── Rama: $current_branch${NC}"
    
    # Validar naming convention
    if validate_branch_naming "$current_branch" >/dev/null 2>&1; then
        local branch_type=$(get_branch_type "$current_branch")
        echo -e "${GREEN}├── Naming convention: ✅ Válida ($branch_type)${NC}"
    else
        echo -e "${YELLOW}├── Naming convention: ⚠️ No estándar${NC}"
    fi
    
    # Estado working directory
    if [ -z "$git_status" ]; then
        echo -e "${GREEN}├── Working directory: ✅ Limpio${NC}"
    else
        local file_count=$(echo "$git_status" | wc -l)
        echo -e "${RED}├── Working directory: ❌ Cambios pendientes${NC}"
        echo -e "${GRAY}│   $file_count archivos modificados${NC}"
    fi
    
    # Detectar rama base
    git fetch origin >/dev/null 2>&1
    local base_branch=""
    if git branch -r | grep -q "origin/develop"; then
        base_branch="develop"
    elif git branch -r | grep -q "origin/main"; then
        base_branch="main"
    fi
    
    echo -e "${WHITE}└── Rama base: $base_branch${NC}"
    
    # Sincronización
    if [[ "$current_branch" == "$base_branch" ]]; then
        local behind_count=$(git rev-list --count HEAD..origin/"$base_branch" 2>/dev/null || echo "0")
        echo ""
        echo -e "${BLUE}🔄 SINCRONIZACIÓN:${NC}"
        if [ "$behind_count" -eq 0 ]; then
            echo -e "${GREEN}└── ✅ Actualizada con origin/$base_branch${NC}"
        else
            echo -e "${YELLOW}└── ⚠️ $behind_count commits atrás de origin/$base_branch${NC}"
        fi
    fi
    
    # Branches pendientes
    local unmerged_branches=$(git branch --no-merged "$base_branch" 2>/dev/null | grep -E "^\s*(feature|bugfix)/" | head -5)
    
    echo ""
    echo -e "${BLUE}📋 BRANCHES PENDIENTES:${NC}"
    if [ -z "$unmerged_branches" ]; then
        echo -e "${GREEN}└── ✅ Ninguna feature/bugfix branch sin merge${NC}"
    else
        local branch_count=$(echo "$unmerged_branches" | wc -l)
        echo -e "${YELLOW}├── ⚠️ $branch_count branches sin merge:${NC}"
        echo "$unmerged_branches" | sed 's/^/└── 📋 /' | while read line; do
            echo -e "${YELLOW}$line${NC}"
        done
    fi
    
    # Resumen final
    echo ""
    echo -e "${BLUE}🎯 ESTADO GENERAL:${NC}"
    if [ -z "$git_status" ] && [ "$behind_count" -eq 0 ]; then
        echo -e "${GREEN}└── ✅ LISTO PARA NUEVA ITERACIÓN${NC}"
    else
        echo -e "${YELLOW}└── ⚠️ REQUIERE ACCIÓN ANTES DE CONTINUAR${NC}"
    fi
}

# Hacer funciones disponibles globalmente
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    # Script ejecutado directamente
    prepare_aedd_iteration "$@"
else
    # Script importado (source)
    echo "AEDD Navigator scripts cargados."
    echo "Funciones disponibles:"
    echo "  - prepare_aedd_iteration"
    echo "  - get_aedd_git_flow_status"
    echo "  - validate_branch_naming"
fi

# EJEMPLOS DE USO:
# prepare_aedd_iteration "sistema QR para pedidos"
# prepare_aedd_iteration "corregir bug en validación email" "bugfix"
# prepare_aedd_iteration "parche crítico seguridad" "hotfix" --strict
# prepare_aedd_iteration "nueva funcionalidad" "feature" --dry-run
# get_aedd_git_flow_status
```

## INSTRUCCIONES DE INSTALACIÓN

### 🖥️ WINDOWS (PowerShell)
```powershell
# 1. Descargar script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/tu-repo/AEDD_NAVIGATOR_SETUP.ps1" -OutFile "AEDD_NAVIGATOR_SETUP.ps1"

# 2. Importar módulo
Import-Module .\AEDD_NAVIGATOR_SETUP.ps1

# 3. Uso
Prepare-AEDDIteration "nueva funcionalidad"
```

### 🐧 LINUX/MAC (Bash)
```bash
# 1. Descargar script
curl -O https://raw.githubusercontent.com/tu-repo/aedd_navigator_setup.sh

# 2. Hacer ejecutable
chmod +x aedd_navigator_setup.sh

# 3. Añadir a PATH (opcional)
sudo cp aedd_navigator_setup.sh /usr/local/bin/aedd-navigator

# 4. Uso
./aedd_navigator_setup.sh "nueva funcionalidad"
# o si está en PATH:
aedd-navigator "nueva funcionalidad"
```
