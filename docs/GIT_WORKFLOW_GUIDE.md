# PROCEDIMIENTO ESTÁNDAR PARA COMMITS Y PUSH

## COMANDOS BÁSICOS DE GIT WORKFLOW

### 1. VERIFICAR ESTADO DEL REPOSITORIO
```bash
git status
```
**Propósito:** Revisar archivos modificados, añadidos o eliminados antes de hacer commit

### 2. AÑADIR ARCHIVOS AL STAGING AREA
```bash
git add .
```
**Propósito:** Preparar todos los archivos modificados para el commit
**Alternativa específica:** `git add nombre_archivo.ext` para archivos individuales

### 3. HACER COMMIT CON MENSAJE DESCRIPTIVO
```bash
git commit -m "Descripción clara del cambio realizado"
```
**Propósito:** Crear snapshot del código con descripción de los cambios
**Formato recomendado:** Verbo en presente + descripción concisa

### 4. VERIFICAR BRANCH ACTUAL
```bash
git branch
```
**Propósito:** Confirmar en qué rama estás trabajando antes de hacer push

### 5. SUBIR CAMBIOS AL REPOSITORIO REMOTO
```bash
git push origin nombre-del-branch
```
**Propósito:** Enviar commits locales al repositorio remoto
**Ejemplo:** `git push origin main` o `git push origin develop`

## PROCEDIMIENTO COMPLETO PASO A PASO

### Para cambios en rama de desarrollo:
```bash
git status
git add .
git commit -m "Descripcion del cambio"
git push origin develop
```

### Para cambios en rama principal:
```bash
git status
git add .
git commit -m "Descripcion del cambio"
git push origin main
```

### Para crear nueva rama de feature:
```bash
git checkout -b feature/nombre-funcionalidad
git add .
git commit -m "Implementar nueva funcionalidad"
git push origin feature/nombre-funcionalidad
```

## COMANDOS DE VERIFICACIÓN ADICIONALES

### Ver historial de commits:
```bash
git log --oneline -5
```

### Ver diferencias antes de commit:
```bash
git diff
```

### Ver ramas disponibles:
```bash
git branch -a
```

### Cambiar de rama:
```bash
git checkout nombre-rama
```

## WORKFLOW COMPLETO RECOMENDADO

```bash
# 1. Verificar estado
git status

# 2. Ver cambios realizados
git diff

# 3. Añadir archivos
git add .

# 4. Verificar archivos en staging
git status

# 5. Hacer commit
git commit -m "Mensaje descriptivo del cambio"

# 6. Verificar rama actual
git branch

# 7. Subir cambios
git push origin nombre-rama

# 8. Verificar que se subió correctamente
git log --oneline -3
```

## JUSTIFICACIÓN DEL ALGORITMO Y BUENAS PRÁCTICAS

### 1. **VERIFICACIÓN ANTES DE ACCIÓN (git status)**
- **Propósito:** Evitar commits accidentales de archivos no deseados
- **Buena práctica:** Siempre saber qué archivos van a ser incluidos

### 2. **STAGING SELECTIVO (git add)**
- **Propósito:** Control granular sobre qué cambios incluir en cada commit
- **Buena práctica:** `git add .` para todos los archivos o archivos específicos

### 3. **COMMITS ATÓMICOS Y DESCRIPTIVOS**
- **Propósito:** Historial claro y reversible de cambios
- **Buena práctica:** Un commit = una funcionalidad o fix específico
- **Formato:** "Verbo en presente + descripción concisa"

### 4. **VERIFICACIÓN DE RAMA (git branch)**
- **Propósito:** Evitar commits en rama incorrecta
- **Buena práctica:** Confirmar destino antes de push

### 5. **PUSH EXPLÍCITO CON RAMA**
- **Propósito:** Claridad sobre destino del código
- **Buena práctica:** Siempre especificar `origin nombre-rama`

### 6. **VALIDACIÓN POST-PUSH**
- **Propósito:** Confirmar que cambios se subieron correctamente
- **Buena práctica:** Verificar con `git log` o plataforma web

## BENEFICIOS DE ESTE WORKFLOW

1. **TRAZABILIDAD:** Historial claro de todos los cambios
2. **REVERSIBILIDAD:** Posibilidad de volver a estados anteriores
3. **COLABORACIÓN:** Otros desarrolladores entienden los cambios
4. **INTEGRACIÓN:** Compatible con CI/CD y code review
5. **SEGURIDAD:** Verificaciones múltiples antes de subir código

## COMANDOS DE EMERGENCIA

### Deshacer último commit (manteniendo cambios):
```bash
git reset --soft HEAD~1
```

### Deshacer cambios en archivo específico:
```bash
git checkout -- nombre_archivo.ext
```

### Ver estado del repositorio remoto:
```bash
git remote -v
```

## COMANDOS PARA MERGE ENTRE RAMAS

### Merge de feature branch a develop:
```bash
git checkout develop
git merge feature/nombre-funcionalidad
git push origin develop
```

### Merge de develop a main:
```bash
git checkout main
git merge develop
git push origin main
```

### Eliminar rama de feature después del merge:
```bash
git branch -d feature/nombre-funcionalidad
git push origin --delete feature/nombre-funcionalidad
```

## COMANDOS PARA SINCRONIZACIÓN

### Obtener últimos cambios del repositorio remoto:
```bash
git fetch origin
```

### Actualizar rama actual con cambios remotos:
```bash
git pull origin nombre-rama
```

### Sincronizar todas las ramas:
```bash
git fetch --all
```

## RESUMEN RÁPIDO - COMANDOS ESENCIALES

```bash
# Workflow básico diario
git status
git add .
git commit -m "Mensaje descriptivo"
git push origin nombre-rama

# Cambio de rama
git checkout nombre-rama

# Crear nueva rama
git checkout -b nueva-rama

# Ver historial
git log --oneline -5

# Ver diferencias
git diff
```

Este procedimiento garantiza un flujo de trabajo limpio, trazable y colaborativo siguiendo las mejores prácticas de control de versiones.
