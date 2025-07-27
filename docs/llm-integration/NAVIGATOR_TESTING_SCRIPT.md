# NAVIGATOR AUTO-ROUTING - Script de Testing Automatizado

## 🎯 PROPÓSITO
Script interactivo para probar el sistema de auto-routing del Navigator optimizado. Ejecuta casos de prueba sistemáticos y valida la detección automática, routing y carga contextual.

## 🚀 INSTRUCCIONES DE USO

### **MÉTODO 1: Testing Manual Interactivo**
```bash
# Copiar y pegar cada caso en una nueva sesión de chat
# Verificar outputs contra especificaciones esperadas
```

### **MÉTODO 2: Testing Sistemático con Checklist**
```bash
# Usar este documento como checklist de validación
# Marcar ✅/❌ cada resultado
```

---

## 📋 CASOS DE PRUEBA EJECUTABLES

### **🆕 GRUPO 1: ONBOARDING (Nuevos Usuarios)**

#### **TEST ON-001: Información del proyecto**
```
COMANDO A EJECUTAR:
"¿De qué trata este repositorio?"

RESULTADOS ESPERADOS:
✅ Detecta: ONBOARDING_NEEDED
✅ Trigger: "de qué trata"  
✅ Carga: NAVIGATOR_ONBOARDING.md
✅ Especialistas: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
✅ Contexto: PROJECT_OVERVIEW.md + CONTEXTO_MAESTRO.md
✅ Tokens: ~4,200
✅ Salida: Información fundamental + clasificación de rol

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST ON-002: Consulta arquitectural**
```
COMANDO A EJECUTAR:
"Explícame la arquitectura del sistema"

RESULTADOS ESPERADOS:
✅ Detecta: ONBOARDING_NEEDED
✅ Trigger: "explícame" + "arquitectura"
✅ Carga: NAVIGATOR_ONBOARDING.md
✅ Especialistas: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
✅ Contexto: PROJECT_OVERVIEW.md + información arquitectural
✅ Salida: Arquitectura general + rutas de especialización

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST ON-003: Stack tecnológico**
```
COMANDO A EJECUTAR:
"¿Qué tecnologías usa este proyecto?"

RESULTADOS ESPERADOS:
✅ Detecta: ONBOARDING_NEEDED (enfoque técnico)
✅ Trigger: "qué tecnologías"
✅ Carga: NAVIGATOR_ONBOARDING.md
✅ Especialistas: DESARROLLADOR_SENIOR (prioridad)
✅ Contexto: PROJECT_OVERVIEW.md + DEPENDENCIAS.md
✅ Salida: Stack tecnológico + información para desarrolladores

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

---

### **🏗️ GRUPO 2: METODOLOGÍA DE DESARROLLO (Nuevo)**

#### **TEST DM-001: Inicio desarrollo estructurado**
```
COMANDO A EJECUTAR:
"Quiero trabajar en el core de autenticación"

RESULTADOS ESPERADOS:
✅ Detecta: DEVELOPMENT_METHODOLOGY
✅ Trigger: "quiero trabajar en" + "core"
✅ Carga: NAVIGATOR_DEVELOPMENT_METHODOLOGY.md
✅ Comando sugerido: /start-development core "autenticación"
✅ Especialistas: DESARROLLADOR_SENIOR + ARQUITECTO + ANALISTA_NEGOCIO
✅ Contexto: Metodología 20 fases + estado actual componente
✅ Salida: Estado de fases + documentación existente + próximas acciones

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST DM-002: Consulta estado desarrollo**
```
COMANDO A EJECUTAR:
"¿En qué estado está el desarrollo del core?"

RESULTADOS ESPERADOS:
✅ Detecta: DEVELOPMENT_STATUS
✅ Trigger: "estado" + "desarrollo" + "core"
✅ Carga: NAVIGATOR_DEVELOPMENT_METHODOLOGY.md
✅ Comando sugerido: /check-development-status core
✅ Especialistas: DESARROLLADOR_SENIOR (lead)
✅ Contexto: Estado actual de características + ramas activas
✅ Salida: Resumen características + fases completadas + próximas acciones

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST DM-003: Continuación desarrollo específico**
```
COMANDO A EJECUTAR:
"Continuar con el modelo de datos del sistema de pagos"

RESULTADOS ESPERADOS:
✅ Detecta: DEVELOPMENT_CONTINUATION
✅ Trigger: "continuar" + "modelo de datos" + "pagos"
✅ Carga: NAVIGATOR_DEVELOPMENT_METHODOLOGY.md
✅ Comando sugerido: /continue-development "modelo-datos" core pagos
✅ Especialistas: DESARROLLADOR_SENIOR + ARQUITECTO
✅ Contexto: Fase actual + archivos en progreso + criterios completitud
✅ Salida: Tareas específicas + archivos para editar + criterios validación

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

---

### **🔄 GRUPO 3: NUEVA ITERACIÓN (Desarrollo)**

#### **TEST IT-001: Funcionalidad core universal**
```
COMANDO A EJECUTAR:
"Implementar sistema de autenticación biométrica"

RESULTADOS ESPERADOS:
✅ Detecta: NEW_ITERATION + CORE
✅ Trigger: "implementar" + "autenticación"
✅ Carga: NAVIGATOR_GIT_FLOW.md + validaciones Git
✅ Especialistas: DESARROLLADOR_SENIOR + ESPECIALISTA_SEGURIDAD
✅ Contexto: DEPENDENCIAS.md + TESTING_PROTOCOLS.md + PATRONES_CODIGO.md
✅ Git Flow: Validaciones automáticas
✅ Rama sugerida: feature/20250727-autenticacion-biometrica
✅ Salida: Preparación entorno + /start-session core

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST IT-002: Funcionalidad vertical específica**
```
COMANDO A EJECUTAR:
"Crear sistema de reservas con overbooking para hoteles"

RESULTADOS ESPERADOS:
✅ Detecta: NEW_ITERATION + VERTICAL
✅ Trigger: "crear" + "hoteles"
✅ Vertical detectado: HOTEL
✅ Carga: NAVIGATOR_GIT_FLOW.md + especialización vertical
✅ Especialistas: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
✅ Contexto: ESPECIALIZACIONES.md + PATRONES_CODIGO.md + casos hotel
✅ Rama sugerida: feature/20250727-reservas-overbooking-hotel
✅ Salida: Preparación entorno + /start-session vertical

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST IT-003: Funcionalidad cross-vertical**
```
COMANDO A EJECUTAR:
"Desarrollar dashboard de analytics para todos los verticales"

RESULTADOS ESPERADOS:
✅ Detecta: NEW_ITERATION + CROSS_VERTICAL
✅ Trigger: "desarrollar" + "dashboard" + "todos los verticales"
✅ Carga: NAVIGATOR_GIT_FLOW.md + arquitectura cross-vertical
✅ Especialistas: ARQUITECTO + DESARROLLADOR_SENIOR
✅ Contexto: ESTRATEGIAS_IMPLEMENTACION.md + TESTING_PROTOCOLS.md
✅ Rama sugerida: feature/20250727-dashboard-analytics-cross-vertical
✅ Salida: Preparación entorno + /start-session cross-vertical

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST IT-004: Corrección de bug**
```
COMANDO A EJECUTAR:
"Corregir error en validación de emails del sistema de usuarios"

RESULTADOS ESPERADOS:
✅ Detecta: NEW_ITERATION + BUGFIX
✅ Trigger: "corregir" + "error"
✅ Tipo rama: bugfix (no feature)
✅ Carga: NAVIGATOR_GIT_FLOW.md + tipo bugfix
✅ Especialistas: DESARROLLADOR_SENIOR
✅ Contexto: PATRONES_CODIGO.md + TESTING_PROTOCOLS.md
✅ Rama sugerida: bugfix/20250727-validacion-emails
✅ Salida: Preparación entorno + enfoque resolución rápida

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST IT-005: Parche crítico (hotfix)**
```
COMANDO A EJECUTAR:
"Arreglo urgente: vulnerabilidad crítica en autenticación"

RESULTADOS ESPERADOS:
✅ Detecta: NEW_ITERATION + HOTFIX
✅ Trigger: "urgente" + "crítica" + "vulnerabilidad"
✅ Tipo rama: hotfix (desde main)
✅ Carga: NAVIGATOR_GIT_FLOW.md + tipo hotfix
✅ Especialistas: ESPECIALISTA_SEGURIDAD + DESARROLLADOR_SENIOR
✅ Contexto: DEPENDENCIAS.md + TESTING_PROTOCOLS.md + seguridad
✅ Rama sugerida: hotfix/20250727-vulnerabilidad-autenticacion
✅ Salida: Preparación urgente + protocolos críticos

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

---

### **📊 GRUPO 4: CONSULTA DE HISTORIAL**

#### **TEST HI-001: Última iteración**
```
COMANDO A EJECUTAR:
"¿Qué se implementó en la última iteración?"

RESULTADOS ESPERADOS:
✅ Detecta: SESSION_HISTORY
✅ Trigger: "última iteración"
✅ Carga: NAVIGATOR_SESSION_HISTORY.md
✅ Especialistas: DESARROLLADOR_SENIOR
✅ Contexto: Git log + docs/iteraciones/ + rama actual
✅ Análisis: Commits recientes + archivos de iteración
✅ Salida: Resumen progreso + próximos pasos

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST HI-002: Estado general del proyecto**
```
COMANDO A EJECUTAR:
"¿En qué estado está el proyecto actualmente?"

RESULTADOS ESPERADOS:
✅ Detecta: SESSION_HISTORY + PROJECT_STATUS
✅ Trigger: "estado" + "proyecto" + "actualmente"
✅ Carga: NAVIGATOR_SESSION_HISTORY.md
✅ Especialistas: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
✅ Contexto: PROJECT_OVERVIEW.md + Git status + métricas
✅ Salida: Estado general + métricas + verticales

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST HI-003: Continuación de trabajo específico**
```
COMANDO A EJECUTAR:
"Quiero continuar con el trabajo de la rama feature/payment-gateway"

RESULTADOS ESPERADOS:
✅ Detecta: SESSION_HISTORY + CONTINUATION
✅ Trigger: "continuar" + "feature/"
✅ Rama específica: feature/payment-gateway
✅ Carga: NAVIGATOR_SESSION_HISTORY.md + análisis rama específica
✅ Especialistas: DESARROLLADOR_SENIOR
✅ Contexto: Git log rama + archivos modificados + testing
✅ Salida: Estado rama + próximos pasos lógicos

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

---

### **🔍 GRUPO 5: CONSULTAS ESPECÍFICAS**

#### **TEST SP-001: Análisis arquitectural**
```
COMANDO A EJECUTAR:
"Necesito revisar la arquitectura del sistema de pagos"

RESULTADOS ESPERADOS:
✅ Detecta: ARCHITECTURE_SESSION
✅ Trigger: "revisar" + "arquitectura"
✅ Componente específico: pagos
✅ Especialistas: ARQUITECTO + DESARROLLADOR_SENIOR
✅ Contexto: ESTRATEGIAS_IMPLEMENTACION.md + DEPENDENCIAS.md + pagos
✅ Salida: Análisis arquitectural específico + recomendaciones

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST SP-002: Auditoría de seguridad**
```
COMANDO A EJECUTAR:
"Hacer auditoría de seguridad del módulo de usuarios"

RESULTADOS ESPERADOS:
✅ Detecta: SECURITY_SESSION
✅ Trigger: "auditoría" + "seguridad"
✅ Módulo específico: usuarios
✅ Especialistas: ESPECIALISTA_SEGURIDAD + DESARROLLADOR_SENIOR
✅ Contexto: DEPENDENCIAS.md + TESTING_PROTOCOLS.md + compliance
✅ Salida: Análisis seguridad + checklist + recomendaciones

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST SP-003: Estrategia de deployment**
```
COMANDO A EJECUTAR:
"Planificar el deployment del vertical de healthcare"

RESULTADOS ESPERADOS:
✅ Detecta: DEPLOYMENT_SESSION
✅ Trigger: "deployment" + "healthcare"
✅ Vertical específico: healthcare
✅ Especialistas: DEVOPS_ENGINEER + ARQUITECTO
✅ Contexto: DEPENDENCIAS.md + DOCUMENTACION_AUTOMATICA.md + healthcare
✅ Compliance: Consideraciones HIPAA
✅ Salida: Plan deployment + infraestructura + compliance

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

---

### **❌ GRUPO 6: CASOS EDGE Y MANEJO DE ERRORES**

#### **TEST ED-001: Consulta ambigua**
```
COMANDO A EJECUTAR:
"Quiero hacer algo con el sistema"

RESULTADOS ESPERADOS:
✅ Detecta: AMBIGUOUS → CLARIFICATION_NEEDED
✅ Trigger: Ningún trigger específico detectado
✅ Respuesta: Solicita clarificación
✅ Ejemplos: Proporciona comandos válidos
✅ No asume: No hace suposiciones incorrectas
✅ Salida: Mensaje clarificación + ejemplos útiles

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST ED-002: Consulta fuera de dominio**
```
COMANDO A EJECUTAR:
"¿Cómo funciona React en general?"

RESULTADOS ESPERADOS:
✅ Detecta: OUT_OF_SCOPE → REDIRECT
✅ Trigger: Consulta teórica sin contexto de proyecto
✅ Contención: Aplica sistema de contención contextual
✅ Redirección: Hacia objetivos específicos del proyecto
✅ Salida: "Detectado contexto fuera del objetivo de iteración"

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

#### **TEST ED-003: Múltiples intenciones**
```
COMANDO A EJECUTAR:
"Implementar autenticación y también revisar la arquitectura general"

RESULTADOS ESPERADOS:
✅ Detecta: MULTIPLE_INTENTIONS → PRIORITIZATION
✅ Trigger: "implementar" + "revisar"
✅ Respuesta: Detecta múltiples intenciones
✅ Sugerencia: Division en sesiones específicas
✅ Priorización: Ayuda a determinar orden lógico
✅ Salida: Sugerencia de separación + priorización

RESULTADO REAL: [ ] ✅ PASS / [ ] ❌ FAIL
NOTAS: ________________________________
```

---

## 📊 RESUMEN DE RESULTADOS

### **SCORECARD GENERAL**

#### **Onboarding (3 casos)**
- [ ] ON-001: Información proyecto ___/✅
- [ ] ON-002: Consulta arquitectural ___/✅
- [ ] ON-003: Stack tecnológico ___/✅

**Score Onboarding: ___/3 (Target: 3/3)**

#### **Metodología Desarrollo (3 casos)**
- [ ] DM-001: Inicio desarrollo estructurado ___/✅
- [ ] DM-002: Consulta estado desarrollo ___/✅
- [ ] DM-003: Continuación desarrollo específico ___/✅

**Score Metodología: ___/3 (Target: 3/3)**

#### **Nueva Iteración (5 casos)**
- [ ] IT-001: Funcionalidad core ___/✅
- [ ] IT-002: Vertical específica ___/✅
- [ ] IT-003: Cross-vertical ___/✅
- [ ] IT-004: Bug fix ___/✅
- [ ] IT-005: Hotfix crítico ___/✅

**Score Iteración: ___/5 (Target: 5/5)**

#### **Historial (3 casos)**
- [ ] HI-001: Última iteración ___/✅
- [ ] HI-002: Estado general ___/✅
- [ ] HI-003: Continuación trabajo ___/✅

**Score Historial: ___/3 (Target: 3/3)**

#### **Consultas Específicas (3 casos)**
- [ ] SP-001: Análisis arquitectural ___/✅
- [ ] SP-002: Auditoría seguridad ___/✅
- [ ] SP-003: Deployment strategy ___/✅

**Score Específicas: ___/3 (Target: 3/3)**

#### **Casos Edge (3 casos)**
- [ ] ED-001: Consulta ambigua ___/✅
- [ ] ED-002: Fuera de dominio ___/✅
- [ ] ED-003: Múltiples intenciones ___/✅

**Score Edge Cases: ___/3 (Target: 3/3)**

### **SCORE TOTAL: ___/20 (Target: 20/20 = 100%)**

---

## ⚡ TESTING RÁPIDO - COMANDOS ESENCIALES

### **QUICK TEST SET (6 comandos básicos)**
```bash
# 1. Onboarding
"¿De qué trata este repositorio?"

# 2. Metodología desarrollo
"Quiero trabajar en el core de autenticación"

# 3. Nueva iteración core
"Implementar sistema de autenticación biométrica"

# 4. Nueva iteración vertical  
"Crear sistema de reservas para hoteles"

# 5. Consulta historial
"¿Qué se implementó en la última iteración?"

# 6. Caso edge
"Quiero hacer algo con el sistema"
```

**Quick Score: ___/6**

---

## 📈 ANÁLISIS DE RENDIMIENTO

### **MÉTRICAS A MEDIR:**

#### **Precisión de Detección**
```
Casos detectados correctamente: ___/20
Porcentaje: ___% (Target: >95%)
```

#### **Eficiencia de Tokens**
```
Promedio tokens por sesión: ___
Máximo observado: ___
Target: <5,000 tokens por sesión típica
```

#### **Tiempo de Respuesta**
```
Promedio tiempo routing: ___ segundos
Máximo observado: ___ segundos  
Target: <5 segundos
```

#### **Calidad de Routing**
```
Especialistas correctos: ___/20
Módulos apropiados: ___/20
Contexto relevante: ___/20
```

---

## 🔄 ACCIONES POST-TESTING

### **SI SCORE < 90%:**
1. **Identificar patrones de fallo**
2. **Ajustar triggers en AEDD_NAVIGATOR.md**
3. **Refinar lógica de detección**
4. **Re-ejecutar tests fallidos**

### **SI SCORE ≥ 90%:**
1. **Documentar configuración exitosa**
2. **Expandir casos edge identificados**
3. **Optimizar tokens donde sea posible**
4. **Preparar para testing en producción**

### **OPTIMIZACIONES POTENCIALES:**
- [ ] Refinar triggers de detección
- [ ] Optimizar carga contextual
- [ ] Mejorar manejo de casos edge
- [ ] Expandir especialistas disponibles
- [ ] Ajustar estimaciones de tokens

---

**💡 NOTAS DE USO:**
- Ejecutar en orden para máxima efectividad
- Documentar cualquier comportamiento inesperado
- Usar como baseline para futuras mejoras
- Repetir después de cambios al Navigator
