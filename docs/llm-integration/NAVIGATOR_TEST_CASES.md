# NAVIGATOR AUTO-ROUTING - Casos de Prueba

## 🎯 PROPÓSITO
Casos de prueba para validar el auto-routing del Navigator modular optimizado, verificando detección automática de intención, carga contextual inteligente y routing a módulos especializados.

## 📋 METODOLOGÍA DE TESTING
```
INPUT (consulta usuario) → DETECCIÓN ESPERADA → MÓDULO/ESPECIALISTA → VALIDACIÓN
```

---

## 🆕 CASOS ONBOARDING (Nuevos Usuarios)

### **CASO ON-001: Pregunta genérica sobre el proyecto**
```
INPUT: "¿De qué trata este repositorio?"
DETECCIÓN ESPERADA: ONBOARDING_NEEDED
TRIGGER: "de qué trata"
ROUTING: → NAVIGATOR_ONBOARDING.md
ESPECIALISTAS: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
CONTEXTO: PROJECT_OVERVIEW.md + CONTEXTO_MAESTRO.md
TOKENS ESTIMADOS: ~4,200

VALIDACIÓN:
✅ Detecta usuario nuevo automáticamente
✅ Carga información fundamental del proyecto
✅ Ofrece rutas de continuación por rol
✅ No intenta crear nueva iteración
```

### **CASO ON-002: Solicitud de información arquitectural**
```
INPUT: "Explícame la arquitectura del sistema"
DETECCIÓN ESPERADA: ONBOARDING_NEEDED
TRIGGER: "explícame" + "arquitectura"
ROUTING: → NAVIGATOR_ONBOARDING.md
ESPECIALISTAS: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
CONTEXTO: PROJECT_OVERVIEW.md + CONTEXTO_MAESTRO.md
TOKENS ESTIMADOS: ~4,200

VALIDACIÓN:
✅ Reconoce solicitud de información general
✅ Carga contexto arquitectural básico
✅ Guía hacia especialización (¿desarrollador/analista?)
```

### **CASO ON-003: Consulta sobre tecnologías**
```
INPUT: "¿Qué tecnologías usa este proyecto?"
DETECCIÓN ESPERADA: ONBOARDING_NEEDED
TRIGGER: "qué tecnologías"
ROUTING: → NAVIGATOR_ONBOARDING.md
ESPECIALISTAS: DESARROLLADOR_SENIOR (énfasis técnico)
CONTEXTO: PROJECT_OVERVIEW.md + DEPENDENCIAS.md
TOKENS ESTIMADOS: ~3,800

VALIDACIÓN:
✅ Identifica consulta de stack tecnológico
✅ Carga información técnica apropiada
✅ Enfoque en desarrollador como rol probable
```

---

## 🔄 CASOS NUEVA ITERACIÓN (Desarrollo)

### **CASO IT-001: Implementación de funcionalidad core**
```
INPUT: "Implementar sistema de autenticación biométrica"
DETECCIÓN ESPERADA: NEW_ITERATION + CORE
TRIGGER: "implementar" + "autenticación"
ROUTING: → NAVIGATOR_GIT_FLOW.md + validaciones
ESPECIALISTAS: DESARROLLADOR_SENIOR + ESPECIALISTA_SEGURIDAD
CONTEXTO: DEPENDENCIAS.md + TESTING_PROTOCOLS.md + PATRONES_CODIGO.md
RAMA SUGERIDA: feature/20250727-autenticacion-biometrica
TOKENS ESTIMADOS: ~3,500

VALIDACIÓN:
✅ Detecta nueva funcionalidad
✅ Identifica como funcionalidad core/universal
✅ Ejecuta validaciones Git Flow
✅ Prepara rama feature con naming convention
✅ Carga especialistas de seguridad + desarrollo
```

### **CASO IT-002: Desarrollo específico de vertical**
```
INPUT: "Crear sistema de reservas con overbooking para hoteles"
DETECCIÓN ESPERADA: NEW_ITERATION + VERTICAL
TRIGGER: "crear" + "hoteles"
ROUTING: → NAVIGATOR_GIT_FLOW.md + especialización vertical
ESPECIALISTAS: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
CONTEXTO: ESPECIALIZACIONES.md + PATRONES_CODIGO.md + casos hotel
RAMA SUGERIDA: feature/20250727-reservas-overbooking-hotel
TOKENS ESTIMADOS: ~3,200

VALIDACIÓN:
✅ Detecta nueva funcionalidad vertical
✅ Identifica vertical hotel automáticamente
✅ Carga especialistas de negocio + desarrollo
✅ Incluye contexto específico de hotel
```

### **CASO IT-003: Funcionalidad cross-vertical**
```
INPUT: "Desarrollar dashboard de analytics para todos los verticales"
DETECCIÓN ESPERADA: NEW_ITERATION + CROSS_VERTICAL
TRIGGER: "desarrollar" + "dashboard" + "todos los verticales"
ROUTING: → NAVIGATOR_GIT_FLOW.md + arquitectura cross-vertical
ESPECIALISTAS: ARQUITECTO + DESARROLLADOR_SENIOR
CONTEXTO: ESTRATEGIAS_IMPLEMENTACION.md + TESTING_PROTOCOLS.md
RAMA SUGERIDA: feature/20250727-dashboard-analytics-cross-vertical
TOKENS ESTIMADOS: ~3,800

VALIDACIÓN:
✅ Detecta funcionalidad cross-vertical
✅ Carga especialistas arquitecturales
✅ Incluye contexto de integración multi-vertical
✅ Considera impacto en todos los verticales
```

### **CASO IT-004: Corrección de bug**
```
INPUT: "Corregir error en validación de emails del sistema de usuarios"
DETECCIÓN ESPERADA: NEW_ITERATION + BUGFIX
TRIGGER: "corregir" + "error"
ROUTING: → NAVIGATOR_GIT_FLOW.md + tipo bugfix
ESPECIALISTAS: DESARROLLADOR_SENIOR
CONTEXTO: PATRONES_CODIGO.md + TESTING_PROTOCOLS.md
RAMA SUGERIDA: bugfix/20250727-validacion-emails
TOKENS ESTIMADOS: ~2,800

VALIDACIÓN:
✅ Detecta corrección de error
✅ Sugiere tipo de rama bugfix
✅ Carga contexto de desarrollo + testing
✅ Enfoque en resolución rápida
```

### **CASO IT-005: Parche crítico de seguridad**
```
INPUT: "Arreglo urgente: vulnerabilidad crítica en autenticación"
DETECCIÓN ESPERADA: NEW_ITERATION + HOTFIX
TRIGGER: "urgente" + "crítica" + "vulnerabilidad"
ROUTING: → NAVIGATOR_GIT_FLOW.md + tipo hotfix
ESPECIALISTAS: ESPECIALISTA_SEGURIDAD + DESARROLLADOR_SENIOR
CONTEXTO: DEPENDENCIAS.md + TESTING_PROTOCOLS.md + seguridad
RAMA SUGERIDA: hotfix/20250727-vulnerabilidad-autenticacion
TOKENS ESTIMADOS: ~3,400

VALIDACIÓN:
✅ Detecta criticidad y urgencia
✅ Sugiere hotfix (desde main)
✅ Prioriza especialista de seguridad
✅ Incluye protocolos de testing críticos
```

---

## 📊 CASOS CONSULTA DE HISTORIAL

### **CASO HI-001: Estado de última sesión**
```
INPUT: "¿Qué se implementó en la última iteración?"
DETECCIÓN ESPERADA: SESSION_HISTORY
TRIGGER: "última iteración"
ROUTING: → NAVIGATOR_SESSION_HISTORY.md
ESPECIALISTAS: DESARROLLADOR_SENIOR
CONTEXTO: Git log + docs/iteraciones/ + rama actual
TOKENS ESTIMADOS: ~2,500

VALIDACIÓN:
✅ Detecta consulta de historial
✅ Busca archivos de iteración recientes
✅ Analiza commits y estado de ramas
✅ Proporciona resumen de progreso
```

### **CASO HI-002: Progreso general del proyecto**
```
INPUT: "¿En qué estado está el proyecto actualmente?"
DETECCIÓN ESPERADA: SESSION_HISTORY + PROJECT_STATUS
TRIGGER: "estado" + "proyecto" + "actualmente"
ROUTING: → NAVIGATOR_SESSION_HISTORY.md
ESPECIALISTAS: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
CONTEXTO: PROJECT_OVERVIEW.md + Git status + métricas
TOKENS ESTIMADOS: ~3,000

VALIDACIÓN:
✅ Identifica consulta de estado general
✅ Combina historial + información actual
✅ Incluye métricas de progreso
✅ Enfoque en vista de negocio + técnica
```

### **CASO HI-003: Continuación de trabajo previo**
```
INPUT: "Quiero continuar con el trabajo de la rama feature/payment-gateway"
DETECCIÓN ESPERADA: SESSION_HISTORY + CONTINUATION
TRIGGER: "continuar" + "feature/"
ROUTING: → NAVIGATOR_SESSION_HISTORY.md + análisis rama específica
ESPECIALISTAS: DESARROLLADOR_SENIOR
CONTEXTO: Git log rama + archivos modificados + testing
TOKENS ESTIMADOS: ~2,800

VALIDACIÓN:
✅ Detecta continuación de trabajo específico
✅ Analiza rama mencionada específicamente
✅ Carga contexto de trabajo previo
✅ Sugiere próximos pasos lógicos
```

---

## 🔍 CASOS CONSULTAS ESPECÍFICAS

### **CASO SP-001: Análisis de arquitectura**
```
INPUT: "Necesito revisar la arquitectura del sistema de pagos"
DETECCIÓN ESPERADA: ARCHITECTURE_SESSION
TRIGGER: "revisar" + "arquitectura"
ROUTING: → Especialista ARQUITECTO
ESPECIALISTAS: ARQUITECTO + DESARROLLADOR_SENIOR
CONTEXTO: ESTRATEGIAS_IMPLEMENTACION.md + DEPENDENCIAS.md + pagos
TOKENS ESTIMADOS: ~3,600

VALIDACIÓN:
✅ Detecta necesidad de análisis arquitectural
✅ Carga especialista arquitecto
✅ Incluye contexto de estrategias
✅ Enfoque en componente específico (pagos)
```

### **CASO SP-002: Revisión de seguridad**
```
INPUT: "Hacer auditoría de seguridad del módulo de usuarios"
DETECCIÓN ESPERADA: SECURITY_SESSION
TRIGGER: "auditoría" + "seguridad"
ROUTING: → Especialista SEGURIDAD
ESPECIALISTAS: ESPECIALISTA_SEGURIDAD + DESARROLLADOR_SENIOR
CONTEXTO: DEPENDENCIAS.md + TESTING_PROTOCOLS.md + compliance
TOKENS ESTIMADOS: ~3,400

VALIDACIÓN:
✅ Identifica necesidad de revisión de seguridad
✅ Prioriza especialista de seguridad
✅ Incluye protocolos de compliance
✅ Enfoque en auditoría específica
```

### **CASO SP-003: Estrategia de deployment**
```
INPUT: "Planificar el deployment del vertical de healthcare"
DETECCIÓN ESPERADA: DEPLOYMENT_SESSION
TRIGGER: "deployment" + "healthcare"
ROUTING: → Especialista DEVOPS
ESPECIALISTAS: DEVOPS_ENGINEER + ARQUITECTO
CONTEXTO: DEPENDENCIAS.md + DOCUMENTACION_AUTOMATICA.md + healthcare
TOKENS ESTIMADOS: ~3,200

VALIDACIÓN:
✅ Detecta necesidad de deployment
✅ Carga especialista DevOps
✅ Incluye contexto de infraestructura
✅ Considera compliance healthcare (HIPAA)
```

---

## ❌ CASOS EDGE Y DETECCIÓN DE ERRORES

### **CASO ED-001: Consulta ambigua**
```
INPUT: "Quiero hacer algo con el sistema"
DETECCIÓN ESPERADA: AMBIGUOUS → CLARIFICATION_NEEDED
TRIGGER: Ningún trigger específico detectado
ROUTING: → Solicitar clarificación
RESPUESTA: "Detectada intención poco específica. ¿Podrías ser más específico?"
SUGERENCIAS: Ejemplos de comandos válidos

VALIDACIÓN:
✅ Detecta ambigüedad
✅ Solicita clarificación apropiada
✅ Proporciona ejemplos útiles
✅ No hace suposiciones incorrectas
```

### **CASO ED-002: Consulta fuera de dominio**
```
INPUT: "¿Cómo funciona React en general?"
DETECCIÓN ESPERADA: OUT_OF_SCOPE → REDIRECT
TRIGGER: Consulta teórica sin contexto de proyecto
ROUTING: → Redirección a objetivo del proyecto
RESPUESTA: "Detectado contexto fuera del objetivo de iteración."
REDIRECCIÓN: Hacia mejoras específicas de IntelliCore POS

VALIDACIÓN:
✅ Identifica consulta fuera de scope
✅ Aplica contención contextual
✅ Redirige hacia objetivos del proyecto
✅ Mantiene foco en iteración
```

### **CASO ED-003: Múltiples intenciones**
```
INPUT: "Implementar autenticación y también revisar la arquitectura general"
DETECCIÓN ESPERADA: MULTIPLE_INTENTIONS → PRIORITIZATION
TRIGGER: "implementar" + "revisar"
ROUTING: → Priorización de tareas
RESPUESTA: Detectadas múltiples intenciones, sugerir división
SUGERENCIAS: Separar en sesiones específicas

VALIDACIÓN:
✅ Detecta múltiples intenciones
✅ Sugiere priorización
✅ Propone división de trabajo
✅ Mantiene foco en una tarea por sesión
```

---

## 🧪 PROTOCOLO DE TESTING

### **EJECUTAR CASOS DE PRUEBA:**

#### **1. Testing Individual**
Para cada caso:
```bash
# Ejecutar comando específico
INPUT: [consulta del caso]
# Verificar outputs esperados
- Detección correcta de triggers
- Routing al módulo apropiado
- Carga de especialistas correctos
- Estimación de tokens aproximada
```

#### **2. Testing Secuencial**
```bash
# Probar flujo completo usuario nuevo → iteración
1. Caso ON-001 → verificar onboarding
2. Caso IT-001 → verificar transición a desarrollo
3. Caso HI-001 → verificar tracking de progreso
```

#### **3. Testing de Carga Contextual**
```bash
# Verificar que solo carga módulos necesarios
- Onboarding: ¿Solo PROJECT_OVERVIEW + CONTEXTO_MAESTRO?
- Iteración: ¿Solo módulos específicos del tipo?
- Historial: ¿Solo información de sesiones?
```

#### **4. Testing de Eficiencia**
```bash
# Verificar optimización de tokens
- Navigator principal: ~500 tokens máximo
- Módulos específicos: Solo los necesarios
- Total por sesión: < 5,000 tokens típico
```

### **CRITERIOS DE ÉXITO:**

- ✅ **Precisión detección:** > 95% casos detectados correctamente
- ✅ **Routing apropiado:** 100% routing a módulo correcto
- ✅ **Especialistas:** Selección apropiada en 100% casos
- ✅ **Eficiencia tokens:** < 5,000 tokens por sesión típica
- ✅ **Tiempo respuesta:** < 5 segundos para routing
- ✅ **Manejo errores:** Gestión apropiada de casos edge

### **MÉTRICAS A MONITOREAR:**

| Métrica | Target | Medición |
|---------|--------|----------|
| **Precisión Auto-detección** | > 95% | Casos correctos / Total casos |
| **Eficiencia Contextual** | 85-90% | Reducción vs carga completa |
| **Tiempo Routing** | < 5 seg | Tiempo detección → respuesta |
| **Satisfacción Usuario** | > 90% | Feedback en casos reales |

---

**💡 USO DE ESTE DOCUMENTO:**
1. Ejecutar casos individualmente para validar funcionamiento
2. Usar como benchmark para mejoras futuras
3. Referencia para testing de regresión
4. Validación de nuevas funcionalidades del Navigator

**🔄 MANTENIMIENTO:**
- Actualizar casos cuando se agreguen nuevos triggers
- Expandir casos edge según experiencia real
- Refinar criterios de éxito basado en métricas
