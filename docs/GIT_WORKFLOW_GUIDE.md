# GUÍA DE ITERACIÓN DE PROYECTO - IntelliCore POS

## PROPÓSITO
Este documento sirve como guía de referencia para iniciar cada sesión de desarrollo y mantener un flujo de trabajo consistente en el proyecto IntelliCore POS.

---

## PREPARACIÓN DE SESIÓN DE DESARROLLO

### 1. REVISIÓN INICIAL DEL ESTADO DEL PROYECTO

#### Verificar estado del repositorio:
```bash
git status
git branch
git log --oneline -5
```

#### Verificar sincronización con remoto:
```bash
# Ver último merge realizado en la rama actual
git log --merges --oneline -5

# Comparar rama local con remota
git fetch origin
git status

# Ver diferencias específicas entre local y remoto
git diff HEAD origin/develop

# Ver commits que están en local pero no en remoto
git log origin/develop..HEAD --oneline

# Ver commits que están en remoto pero no en local
git log HEAD..origin/develop --oneline

# Ver estado detallado de tracking de ramas
git remote show origin
```

#### Revisar documentación actualizada:
- `docs/llm-documentation/README.md` - Punto de entrada LLM
- `docs/llm-documentation/CASOS_USO_DETALLADOS.md` - Funcionalidades pendientes
- `README.md` - Estado general del proyecto

#### Identificar rama de trabajo:
- **develop** - Para desarrollo general
- **feature/nombre-funcionalidad** - Para nuevas características específicas
- **hotfix/nombre-fix** - Para correcciones urgentes

### 2. PLANIFICACIÓN DE LA SESIÓN

#### Definir objetivo de la sesión:
- [ ] Implementar nueva funcionalidad
- [ ] Corregir bugs existentes
- [ ] Mejorar documentación
- [ ] Optimizar rendimiento
- [ ] Refactorizar código

#### Estimar tiempo y alcance:
- **Sesión corta (1-2 horas):** Un caso de uso específico
- **Sesión media (3-4 horas):** Módulo completo o múltiples casos de uso
- **Sesión larga (día completo):** Integración entre módulos o arquitectura

---

## FLUJO DE TRABAJO PARA NUEVA FUNCIONALIDAD

### FASE 1: ANÁLISIS Y DISEÑO

#### 1. Consultar documentación LLM:
```bash
# Abrir archivos de referencia
code docs/llm-documentation/CASOS_USO_DETALLADOS.md
code docs/llm-documentation/QUERIES_CASOS_USO.sql
code docs/llm-documentation/DICCIONARIO_COMPLETO.json
```

#### 2. Identificar caso de uso relacionado:
- Buscar en `CASOS_USO_DETALLADOS.md` el CU más similar
- Revisar queries existentes en `QUERIES_CASOS_USO.sql`
- Verificar estructura de datos en `DICCIONARIO_COMPLETO.json`

#### 3. Definir arquitectura de la solución:
- **Backend:** APIs necesarias (FastAPI endpoints)
- **Frontend:** Componentes UI requeridos
- **Base de Datos:** Tablas y queries involucradas
- **Integración:** Cómo conecta con funcionalidades existentes

### FASE 2: IMPLEMENTACIÓN

#### 1. Crear rama de trabajo:
```bash
git checkout develop
git pull origin develop
git checkout -b feature/nombre-descriptivo-funcionalidad
```

#### 2. Implementar siguiendo orden recomendado:
1. **Base de Datos:** Crear/modificar esquemas y queries
2. **Backend:** Implementar lógica de negocio y APIs
3. **Frontend:** Crear componentes e interfaces
4. **Integración:** Conectar todas las capas
5. **Testing:** Probar funcionalidad completa

#### 3. Commits incrementales:
```bash
# Por cada componente completado
git add .
git commit -m "Implementar [componente]: descripción específica"
git push origin feature/nombre-descriptivo-funcionalidad
```

### FASE 3: INTEGRACIÓN Y DOCUMENTACIÓN

#### 1. Actualizar documentación LLM:
- Añadir nuevos casos de uso a `CASOS_USO_DETALLADOS.md`
- Incluir queries nuevos en `QUERIES_CASOS_USO.sql`
- Actualizar `DICCIONARIO_COMPLETO.json` si hay cambios de BD

#### 2. Hacer merge a develop:
```bash
git checkout develop
git merge feature/nombre-descriptivo-funcionalidad
git push origin develop
```

#### 3. Limpiar rama de feature:
```bash
git branch -d feature/nombre-descriptivo-funcionalidad
git push origin --delete feature/nombre-descriptivo-funcionalidad
```

---

## DOCUMENTACIÓN DE ITERACIONES

### FORMATO ESTÁNDAR DE DOCUMENTACIÓN POR ITERACIÓN

#### Crear archivo de iteración:
```
docs/iteraciones/ITERACION_YYYY_MM_DD.md
```

#### Estructura del documento de iteración:

```markdown
# ITERACIÓN - [FECHA] - [OBJETIVO PRINCIPAL]

## CONTEXTO DE LA SESIÓN
- **Duración:** X horas
- **Objetivo:** Descripción del objetivo principal
- **Rama de trabajo:** feature/nombre-funcionalidad

## CAMBIOS IMPLEMENTADOS

### Backend
- [ ] API endpoint: descripción
- [ ] Lógica de negocio: descripción
- [ ] Queries SQL: descripción

### Frontend
- [ ] Componente: descripción
- [ ] Página/Vista: descripción
- [ ] Integración: descripción

### Base de Datos
- [ ] Nuevas tablas: descripción
- [ ] Modificaciones: descripción
- [ ] Índices: descripción

### Documentación
- [ ] Casos de uso actualizados
- [ ] Queries documentados
- [ ] README actualizado

## DECISIONES TÉCNICAS IMPORTANTES
1. **Decisión:** Descripción de la decisión tomada
   **Justificación:** Por qué se tomó esta decisión
   **Alternativas consideradas:** Qué otras opciones se evaluaron

## PROBLEMAS ENCONTRADOS Y SOLUCIONES
1. **Problema:** Descripción del problema
   **Solución:** Cómo se resolvió
   **Aprendizaje:** Qué se aprendió para futuras iteraciones

## PENDIENTES PARA PRÓXIMA ITERACIÓN
- [ ] Tarea pendiente 1
- [ ] Tarea pendiente 2
- [ ] Mejora identificada 1

## MÉTRICAS DE LA ITERACIÓN
- **Commits realizados:** X
- **Archivos modificados:** X
- **Líneas de código añadidas:** X
- **Tests creados:** X

## VALIDACIONES REALIZADAS
- [ ] Funcionalidad probada manualmente
- [ ] Tests unitarios ejecutados
- [ ] Documentación actualizada
- [ ] Code review realizado (si aplica)
```

### PLANTILLA RÁPIDA PARA ITERACIONES MENORES:

```markdown
# ITERACIÓN RÁPIDA - [FECHA] - [CAMBIO]

## QUÉ SE HIZO
- Descripción concisa del cambio

## ARCHIVOS MODIFICADOS
- archivo1.ext
- archivo2.ext

## COMMIT
```bash
git commit -m "Mensaje del commit"
```

## PRÓXIMO PASO
- Descripción del siguiente paso lógico
```

---

## CHECKLIST DE INICIO DE SESIÓN

### ANTES DE EMPEZAR:
- [ ] Verificar estado del repositorio (`git status`)
- [ ] Actualizar rama develop (`git pull origin develop`)
- [ ] Revisar últimas iteraciones documentadas
- [ ] Leer pendientes de iteración anterior
- [ ] Definir objetivo claro de la sesión

### DURANTE LA SESIÓN:
- [ ] Hacer commits incrementales frecuentes
- [ ] Documentar decisiones técnicas importantes
- [ ] Probar funcionalidad conforme se desarrolla
- [ ] Actualizar documentación LLM cuando corresponda

### AL FINALIZAR LA SESIÓN:
- [ ] Hacer commit final con mensaje descriptivo
- [ ] Hacer push de la rama de trabajo
- [ ] Crear/actualizar documento de iteración
- [ ] Hacer merge a develop si la funcionalidad está completa
- [ ] Definir pendientes para próxima sesión

---

## CHECKLIST DE FINALIZACIÓN DE FUNCIONALIDAD

### ANTES DEL MERGE A DEVELOP:
- [ ] Funcionalidad probada completamente
- [ ] Documentación LLM actualizada
- [ ] Casos de uso documentados
- [ ] Queries añadidos a biblioteca
- [ ] README actualizado si es necesario
- [ ] Commits organizados y con mensajes claros

### DESPUÉS DEL MERGE:
- [ ] Documento de iteración creado
- [ ] Rama de feature eliminada
- [ ] Próximos pasos definidos
- [ ] Aprendizajes documentados

---

## PATRONES DE TRABAJO RECOMENDADOS

### PARA SESIONES CORTAS (1-2 horas):
1. **Foco:** Un caso de uso específico o una mejora puntual
2. **Estrategia:** Usar queries y patrones existentes de la documentación LLM
3. **Output:** Funcionalidad completa y documentada

### PARA SESIONES MEDIAS (3-4 horas):
1. **Foco:** Módulo completo o integración entre componentes
2. **Estrategia:** Implementación end-to-end siguiendo casos de uso documentados
3. **Output:** Funcionalidad integrada y casos de uso actualizados

### PARA SESIONES LARGAS (día completo):
1. **Foco:** Arquitectura, refactoring o múltiples módulos relacionados
2. **Estrategia:** Planificación detallada y implementación por fases
3. **Output:** Mejoras significativas de arquitectura y documentación expandida

---

## MÉTRICAS DE ÉXITO POR ITERACIÓN

### MÉTRICAS DE PRODUCTIVIDAD:
- **Velocidad:** Funcionalidades completadas por sesión
- **Calidad:** Bugs introducidos vs funcionalidades añadidas
- **Reutilización:** % de código reutilizado de documentación LLM

### MÉTRICAS DE DOCUMENTACIÓN:
- **Cobertura:** % de funcionalidades documentadas
- **Actualización:** Frecuencia de actualización de docs LLM
- **Utilidad:** Frecuencia de consulta de documentación

### MÉTRICAS DE ARQUITECTURA:
- **Consistencia:** Adherencia a patrones establecidos
- **Escalabilidad:** Facilidad para añadir nuevas funcionalidades
- **Mantenibilidad:** Facilidad para modificar funcionalidades existentes

---

## HERRAMIENTAS Y COMANDOS ESENCIALES

### Comandos Git fundamentales:
```bash
# Estado y navegación
git status
git branch
git log --oneline -5

# Trabajo con ramas
git checkout develop
git checkout -b feature/nueva-funcionalidad
git merge feature/nueva-funcionalidad

# Sincronización
git pull origin develop
git push origin feature/nueva-funcionalidad

# Limpieza
git branch -d feature/funcionalidad-completada
```

### Comandos de proyecto:
```bash
# Abrir documentación LLM
code docs/llm-documentation/

# Ver estructura del proyecto
tree -I node_modules

# Ejecutar proyecto (cuando esté configurado)
npm run dev
# o
python -m uvicorn main:app --reload
```

---

Esta guía debe ser consultada al inicio de cada sesión de desarrollo para mantener consistencia y productividad en el proyecto IntelliCore POS.