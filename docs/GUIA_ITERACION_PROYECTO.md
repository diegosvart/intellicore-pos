# GUÍA DE ITERACIÓN DE PROYECTO - IntelliCore POS

## PROPÓSITO
Este documento sirve como guía de referencia para iniciar cada sesión de desarrollo y mantener un flujo de trabajo consistente en el proyecto IntelliCore POS, **implementando la metodología "Auto-Evolutionary Documentation Development" (AEDD) con modelos de lenguaje locales especializados**.

## METODOLOGÍA: AUTO-EVOLUTIONARY DOCUMENTATION DEVELOPMENT (AEDD)

### **Definición:**
AEDD es una metodología de desarrollo de software que integra modelos de lenguaje especializados para crear un ecosistema auto-evolutivo donde la documentación y el código evolucionan sincrónicamente, generando un contexto de proyecto cada vez más inteligente y preciso.

### **Principios Fundamentales:**
1. **Auto-Evolución:** El sistema mejora automáticamente con cada iteración
2. **Documentación Viva:** La documentación se actualiza automáticamente con cada cambio de código
3. **Contexto Inteligente:** Un archivo maestro orquesta toda la información del proyecto
4. **Especialización por Roles:** Modelos específicos para diferentes aspectos del desarrollo
5. **Optimización de Tokens:** Máxima eficiencia en el uso de recursos computacionales

### **Arquitectura AEDD:**
```
┌─────────────────────────────────────────────────────────────┐
│                    METODOLOGÍA AEDD                         │
├─────────────────────────────────────────────────────────────┤
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────── │
│  │   CÓDIGO        │◄─┤  CONTEXTO       │─►│ DOCUMENTACIÓN  │
│  │   FUENTE        │  │   MAESTRO       │  │   AUTO-        │
│  │                 │  │  (Orquestador)  │  │  EVOLUTIVA     │
│  └─────────────────┘  └─────────────────┘  └─────────────── │
│           ▲                     ▲                     ▲     │
│           │                     │                     │     │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────── │
│  │   MODELOS       │  │   COMANDOS      │  │   TRACKING     │
│  │ ESPECIALIZADOS  │  │  EVOLUTIVOS     │  │  EVOLUCIÓN     │
│  │                 │  │                 │  │                │
│  │ • Arquitecto    │  │ • /implementar  │  │ • Métricas     │
│  │ • Desarrollador │  │ • /actualizar   │  │ • Dashboards   │
│  │ • Analista      │  │ • /validar      │  │ • Versiones    │
│  │ • Seguridad     │  │ • /evolucionar  │  │ • Estados      │
│  └─────────────────┘  └─────────────────┘  └─────────────── │
└─────────────────────────────────────────────────────────────┘
```

### **Componentes del Sistema AEDD:**

#### **1. CONTEXTO MAESTRO (Core Orchestrator)**
- **Archivo:** `docs/llm-integration/CONTEXTO_MAESTRO.md`
- **Función:** Orquestador único que contiene información esencial del proyecto
- **Beneficio:** Reduce tokens de 15-25K a 2-3K (optimización 75-85%)
- **Contenido:** Casos de uso críticos, reglas de negocio, stack tecnológico, referencias inteligentes

#### **2. MODELOS ESPECIALIZADOS (Role-Based LLMs)**
- **Arquitecto Principal (DeepSeek):** Clean Architecture, SOLID, escalabilidad
- **Desarrollador Senior (Qwen3):** FastAPI, Angular, PostgreSQL, testing
- **Analista de Negocio (Llama3.1):** Casos de uso POS, reglas de negocio
- **Especialista Seguridad (Gemma3-ES):** PCI DSS, OWASP, seguridad financiera

#### **3. COMANDOS EVOLUTIVOS (Auto-Development Commands)**
- **`/implementar-funcionalidad`:** Desarrollo completo + documentación automática
- **`/actualizar-documentacion`:** Sincronización inteligente código-docs
- **`/analizar-arquitectura`:** Evaluación arquitectural especializada
- **`/validar-caso-uso`:** Verificación contra reglas de negocio
- **`/revisar-seguridad`:** Análisis de seguridad POS-específico

#### **4. DOCUMENTACIÓN AUTO-EVOLUTIVA (Living Documentation)**
```
docs/
├── llm-integration/           # Motor AEDD
│   ├── CONTEXTO_MAESTRO.md   # Orquestador principal
│   ├── FLUJO_ITERACION_EVOLUTIVA.md  # Metodología
│   ├── TRACKING_EVOLUCION.md # Métricas y evolución
│   └── CONTINUE_CONFIG_OPTIMIZADA.md # Configuración LLMs
├── llm-documentation/         # Documentación expandida
│   ├── CASOS_USO_DETALLADOS.md
│   ├── QUERIES_CASOS_USO.sql
│   └── DICCIONARIO_COMPLETO.json
└── iteraciones/              # Tracking de sesiones
    └── ITERACION_YYYY_MM_DD.md
```

#### **5. SISTEMA DE TRACKING (Evolution Metrics)**
- **Archivo:** `docs/llm-integration/TRACKING_EVOLUCION.md`
- **Métricas:** Casos de uso, queries, APIs, consistencia, evolución de contexto
- **Dashboard:** Estado en tiempo real del proyecto
- **Versionado:** Control de evolución del contexto maestro

### **Flujo de Trabajo AEDD:**
1. **Input:** Desarrollador solicita funcionalidad mediante comando evolutivo
2. **Análisis:** Modelo especializado evalúa impacto usando contexto maestro
3. **Implementación:** Código generado siguiendo patrones del proyecto
4. **Documentación:** Actualización automática de archivos relevantes
5. **Evolución:** Contexto maestro se enriquece con nueva información esencial
6. **Tracking:** Métricas actualizadas automáticamente
7. **Output:** Funcionalidad completa + documentación sincronizada + contexto evolucionado

### **REGLAS DE OPTIMIZACIÓN PARA LLMs:**
- **NO usar íconos/emojis:** Desperdician tokens sin aportar valor técnico
- **Definiciones acotadas y precisas:** Maximizar información útil por token
- **Priorizar contenido técnico esencial:** Evitar redundancias y decoraciones
- **Referencias inteligentes:** Cargar documentación específica solo bajo demanda
- **Contexto curado:** Un archivo maestro vs múltiples archivos dispersos

### **ESTRUCTURA DEL PROYECTO AEDD:**

#### **Directorio Base:**
```
intellicore-pos/
├── backend/                  # Aplicación FastAPI
├── frontend/                 # Aplicación Angular  
├── database/                 # Esquemas y migraciones PostgreSQL
├── docs/
│   ├── llm-integration/      # ** MOTOR AEDD **
│   │   ├── CONTEXTO_MAESTRO.md           # [CORE] Orquestador único
│   │   ├── FLUJO_ITERACION_EVOLUTIVA.md  # [CORE] Metodología AEDD
│   │   ├── TRACKING_EVOLUCION.md         # [CORE] Métricas evolutivas
│   │   ├── CONTINUE_CONFIG_OPTIMIZADA.md # [CORE] Config LLMs especializados
│   │   ├── PROMPTS_ITERATIVOS.md         # [UTIL] Templates prompts
│   │   ├── CONTEXTO_PROYECTO.md          # [REF] Contexto expandido
│   │   └── CONTINUE_CONFIG.md            # [BACKUP] Config base
│   ├── llm-documentation/    # ** DOCUMENTACIÓN EXPANDIDA **
│   │   ├── CASOS_USO_DETALLADOS.md       # [AUTO] Casos de uso evolutivos
│   │   ├── QUERIES_CASOS_USO.sql         # [AUTO] Biblioteca de queries
│   │   ├── DICCIONARIO_COMPLETO.json     # [AUTO] Estructura BD
│   │   └── GUIA_DESARROLLO_LLM.md        # [REF] Metodología detallada
│   ├── iteraciones/          # ** TRACKING DE SESIONES **
│   │   ├── ITERACION_2025_07_24.md       # [AUTO] Log sesión principal
│   │   └── ITERACION_YYYY_MM_DD.md       # [AUTO] Logs por fecha
│   └── GUIA_ITERACION_PROYECTO.md        # [MASTER] Esta guía
├── infrastructure/           # Docker, K8s, CI/CD
└── scripts/                  # Automatización y utilidades
```

#### **Leyenda de Archivos:**
- **[CORE]** - Archivos fundamentales del motor AEDD
- **[AUTO]** - Archivos que se actualizan automáticamente
- **[REF]** - Archivos de referencia y documentación expandida
- **[UTIL]** - Utilidades y herramientas de apoyo
- **[MASTER]** - Archivo principal de entrada
- **[BACKUP]** - Respaldos y configuraciones alternativas

### **CARACTERÍSTICAS ÚNICAS DE AEDD:**

#### **1. Auto-Crecimiento:**
- **Contexto Evolutivo:** El sistema aprende y mejora con cada iteración
- **Documentación Viva:** Se actualiza automáticamente sin intervención manual
- **Especialización Creciente:** Los modelos se vuelven más expertos en el proyecto específico

#### **2. Optimización Extrema:**
- **Reducción de Tokens:** 75-85% menos consumo vs métodos tradicionales
- **Referencias Inteligentes:** Carga bajo demanda de documentación específica
- **Contexto Curado:** Solo información esencial en el orquestador principal

#### **3. Especialización por Roles:**
- **4 Modelos Especializados:** Cada uno experto en su dominio
- **Comandos Específicos:** Herramientas diseñadas para desarrollo POS
- **Flujo Integrado:** Desde análisis hasta implementación y documentación

#### **4. Trazabilidad Completa:**
- **Tracking Automático:** Métricas de evolución del proyecto
- **Versionado de Contexto:** Control de cambios en el conocimiento del sistema
- **Auditoría de Decisiones:** Log de todas las decisiones técnicas tomadas

---

## PREPARACIÓN DE SESIÓN DE DESARROLLO

### 1. REVISIÓN INICIAL DEL ESTADO DEL PROYECTO

#### Verificar estado del repositorio:
```bash
git status
git branch
git log --oneline -5
```

#### **NUEVO: Verificar configuración de modelos locales:**
- Validar que Continue esté configurado con modelos especializados
- Revisar `docs/llm-integration/CONTEXTO_MAESTRO.md` - Contexto actualizado del proyecto
- Verificar última iteración en `docs/iteraciones/ITERACION_YYYY_MM_DD.md`

#### Revisar documentación actualizada:
- `docs/llm-integration/CONTEXTO_MAESTRO.md` - **PRIORITARIO:** Contexto esencial del proyecto
- `docs/llm-documentation/CASOS_USO_DETALLADOS.md` - Funcionalidades documentadas
- `docs/llm-documentation/TRACKING_EVOLUCION.md` - Estado de evolución del proyecto
- `README.md` - Estado general del proyecto

#### Identificar rama de trabajo:
- **develop** - Para desarrollo general
- **feature/nombre-funcionalidad** - Para nuevas características específicas
- **hotfix/nombre-fix** - Para correcciones urgentes

### 2. PLANIFICACIÓN DE LA SESIÓN

#### Definir objetivo de la sesión:
- [ ] Implementar nueva funcionalidad (**RECOMENDADO:** Usar `/implementar-funcionalidad`)
- [ ] Corregir bugs existentes (Usar modelos especializados según el área)
- [ ] Mejorar documentación (Usar `/actualizar-documentacion`)
- [ ] Optimizar rendimiento (Usar `/optimizar-pos`)
- [ ] Refactorizar código (Usar `/analizar-arquitectura`)
- [ ] **NUEVO:** Evolucionar arquitectura con documentación sincronizada

#### 🎯 **NUEVO: Seleccionar modelo especializado según metodología AEDD:**
- **Arquitecto Principal (DeepSeek)** - Para decisiones de diseño y arquitectura siguiendo Clean Architecture
- **Desarrollador Senior (Qwen3)** - Para implementación y optimización de código siguiendo patterns del proyecto
- **Analista de Negocio (Llama3.1)** - Para validación de casos de uso POS y reglas de negocio
- **Especialista Seguridad (Gemma3-ES)** - Para análisis de seguridad crítica PCI DSS

**Principio AEDD:** Cada modelo tiene contexto automático del proyecto y especialización específica, eliminando la necesidad de re-explicar el contexto en cada interacción.

#### Estimar tiempo y alcance:
- **Sesión corta (1-2 horas):** Un caso de uso específico con `/implementar-funcionalidad`
- **Sesión media (3-4 horas):** Módulo completo con documentación auto-actualizada
- **Sesión larga (día completo):** Evolución arquitectural + múltiples funcionalidades

---

## 🤖 METODOLOGÍA AEDD EN PRÁCTICA: FLUJO DE TRABAJO CON MODELOS ESPECIALIZADOS

### **Filosofía AEDD:**
La metodología Auto-Evolutionary Documentation Development (AEDD) se basa en el principio de que **el código y la documentación deben evolucionar juntos**, creando un ecosistema inteligente que se auto-mejora con cada iteración.

### OPCIÓN A: FLUJO AEDD COMPLETO (Recomendado)

#### Comando único para implementación evolutiva:
```bash
/implementar-funcionalidad "Descripción de la nueva funcionalidad"
```

**Ejemplo práctico:**
```bash
/implementar-funcionalidad "Sistema de descuentos por volumen para clientes VIP"
```

**El motor AEDD ejecuta automáticamente:**
1. ✅ **Análisis de impacto evolutivo** - Evalúa contra contexto maestro actual
2. ✅ **Implementación especializada** - Usa modelo apropiado (Backend/Frontend/BD)
3. ✅ **Evolución automática de documentación:**
   - Nuevo caso de uso CU-006 en `CASOS_USO_DETALLADOS.md`
   - Queries SQL específicas en `QUERIES_CASOS_USO.sql`
   - Estructura BD actualizada en `DICCIONARIO_COMPLETO.json`
   - Contexto maestro evolucionado con información esencial
4. ✅ **Generación de tests especializados** - Según patrones del proyecto
5. ✅ **Validación de consistencia AEDD** - Coherencia arquitectural y de negocio
6. ✅ **Propuesta de commit estructurado** - Siguiendo convenciones del proyecto
7. ✅ **Tracking de evolución** - Métricas actualizadas automáticamente

**Resultado:** Funcionalidad completa + documentación sincronizada + contexto evolucionado + sistema más inteligente

### OPCIÓN B: FLUJO TRADICIONAL MEJORADO

Si prefieres control granular del proceso:

#### FASE 1: ANÁLISIS Y DISEÑO CON IA

##### 1. Consultar contexto del proyecto:
```bash
# El contexto maestro ya está disponible automáticamente
/pos-contexto  # Para ver resumen completo
```

##### 2. Análisis especializado según necesidad:
- **Arquitectura:** `/analizar-arquitectura` con 🏗️ Arquitecto Principal
- **Casos de uso:** `/validar-caso-uso` con 📊 Analista de Negocio
- **Seguridad:** `/revisar-seguridad` con 🔒 Especialista Seguridad

##### 3. **NUEVO:** Diseño con contexto automático:
El modelo tiene acceso automático a:
- Casos de uso críticos (CU-001 a CU-005)
- Reglas de negocio esenciales
- Stack tecnológico y patrones establecidos
- Arquitectura actual del proyecto

#### FASE 2: IMPLEMENTACIÓN CON IA

##### 1. Crear rama de trabajo:
```bash
git checkout develop
git pull origin develop
git checkout -b feature/nombre-descriptivo-funcionalidad
```

##### 2. **NUEVO:** Implementación con modelo especializado:
- **💻 Desarrollador Senior:** Para implementación de código
- **🏗️ Arquitecto Principal:** Para decisiones de diseño
- **📊 Analista de Negocio:** Para validar lógica de negocio

##### 3. **AUTOMÁTICO:** Orden de implementación inteligente:
El modelo implementa automáticamente en el orden correcto:
1. **Base de Datos:** Esquemas y migraciones si es necesario
2. **Backend:** APIs FastAPI + lógica de negocio
3. **Frontend:** Componentes Angular + interfaces
4. **Testing:** Tests comprehensivos generados
5. **Integración:** Validación end-to-end

##### 4. **AUTOMÁTICO:** Commits incrementales inteligentes:
```bash
# El modelo propone commits estructurados
git add .
git commit -m "feat(pos): implementar [funcionalidad] con docs actualizadas

- Agregar caso de uso CU-XXX
- Implementar API endpoints necesarios
- Actualizar contexto maestro
- Generar tests comprehensivos"
```

#### FASE 3: DOCUMENTACIÓN AUTO-ACTUALIZADA

##### **AUTOMÁTICO:** El modelo actualiza sin intervención:
- ✅ Nuevo caso de uso en `CASOS_USO_DETALLADOS.md`
- ✅ Queries SQL en `QUERIES_CASOS_USO.sql`  
- ✅ Estructura BD en `DICCIONARIO_COMPLETO.json`
- ✅ Contexto maestro con información esencial
- ✅ Archivo de iteración con decisiones tomadas

##### **VALIDACIÓN:** Consistencia automática:
- ✅ Numeración secuencial de casos de uso
- ✅ Referencias entre archivos correctas
- ✅ Coherencia con reglas de negocio
- ✅ Adherencia a patrones arquitecturales

#### FASE 4: MERGE Y LIMPIEZA

##### 1. **AUTOMÁTICO:** Merge preparado:
```bash
# El modelo propone el merge cuando todo está validado
git checkout develop
git merge feature/nombre-descriptivo-funcionalidad
git push origin develop
```

##### 2. **AUTOMÁTICO:** Limpieza de rama:
```bash
git branch -d feature/nombre-descriptivo-funcionalidad
git push origin --delete feature/nombre-descriptivo-funcionalidad
```

##### 3. **AUTOMÁTICO:** Archivo de iteración generado:
El modelo crea automáticamente `docs/iteraciones/ITERACION_YYYY_MM_DD.md` con:
- Resumen de cambios implementados
- Decisiones técnicas tomadas
- Archivos de documentación actualizados
- Métricas de la iteración
- Próximos pasos sugeridos

---

## 📊 COMANDOS ESPECIALIZADOS DISPONIBLES

### **Comandos Principales:**
```bash
/implementar-funcionalidad "descripción"  # Implementación completa automatizada
/actualizar-documentacion                 # Sincronizar docs con código
/analizar-arquitectura                    # Revisión arquitectural
/validar-caso-uso                         # Validación de lógica de negocio  
/revisar-seguridad                        # Análisis de seguridad
/optimizar-pos                            # Optimización integral
```

### **Comandos de Utilidad:**
```bash
/pos-contexto     # Ver contexto maestro del proyecto
/pos-docs         # Listar documentación disponible
/pos-validar      # Validar consistencia proyecto
/pos-evolucionar  # Evolucionar arquitectura + docs
```

## 🔄 DOCUMENTACIÓN AUTO-EVOLUTIVA

### **Archivos que se Actualizan Automáticamente:**

#### **Siempre:**
- ✅ `docs/llm-integration/CONTEXTO_MAESTRO.md` - Información esencial actualizada
- ✅ `docs/iteraciones/ITERACION_YYYY_MM_DD.md` - Log detallado de la sesión

#### **Según tipo de cambio:**
- **� Nueva funcionalidad:** `CASOS_USO_DETALLADOS.md`, `QUERIES_CASOS_USO.sql`
- **🗄️ Cambios de BD:** `DICCIONARIO_COMPLETO.json`  
- **🏗️ Cambios arquitecturales:** `GUIA_DESARROLLO_LLM.md`, `README.md`
- **🔌 Nuevas APIs:** Documentación OpenAPI, `CHANGELOG.md`

### **Tracking de Evolución:**
El sistema mantiene métricas automáticas en `docs/llm-integration/TRACKING_EVOLUCION.md`:
```
INTELLICORE POS - EVOLUTION DASHBOARD
=====================================
Casos de Uso:        5 → 7 (+2 nuevos)
Queries SQL:         50+ → 67 (+17 nuevas)  
Endpoints API:       24 → 28 (+4 nuevos)
Contexto Maestro:    v1.0 → v1.2
Última iteración:    2025-07-24
```

---

## FORMATO ESTÁNDAR DE DOCUMENTACIÓN POR ITERACIÓN

### **Creación Automática:**
El modelo genera automáticamente `docs/iteraciones/ITERACION_YYYY_MM_DD.md` con estructura estandarizada que incluye:

- ✅ **Contexto de la sesión:** Duración, objetivo, rama de trabajo
- ✅ **Cambios implementados:** Backend, Frontend, BD, Documentación
- ✅ **Decisiones técnicas:** Justificaciones y alternativas consideradas
- ✅ **Problemas y soluciones:** Aprendizajes para futuras iteraciones
- ✅ **Métricas:** Commits, archivos modificados, tests creados
- ✅ **Validaciones:** Funcionalidad probada, documentación actualizada

---

## CHECKLIST DE INICIO DE SESIÓN

### **ANTES DE EMPEZAR:**
- [ ] Verificar estado del repositorio (`git status`)
- [ ] Actualizar rama develop (`git pull origin develop`)
- [ ] **NUEVO:** Validar modelos locales activos en Continue
- [ ] **NUEVO:** Revisar contexto maestro actualizado
- [ ] Revisar últimas iteraciones documentadas
- [ ] Leer pendientes de iteración anterior
- [ ] Definir objetivo claro de la sesión

### **DURANTE LA SESIÓN:**
- [ ] **NUEVO:** Usar comandos especializados (`/implementar-funcionalidad`)
- [ ] **AUTOMÁTICO:** Validar documentación auto-actualizada
- [ ] Hacer commits incrementales frecuentes (o dejar que el modelo los proponga)
- [ ] Documentar decisiones técnicas importantes
- [ ] Probar funcionalidad conforme se desarrolla

### **AL FINALIZAR LA SESIÓN:**
- [ ] **AUTOMÁTICO:** Archivo de iteración generado
- [ ] **AUTOMÁTICO:** Documentación actualizada y validada
- [ ] Hacer push de la rama de trabajo
- [ ] Hacer merge a develop si la funcionalidad está completa
- [ ] **NUEVO:** Verificar evolución del contexto maestro
- [ ] Definir pendientes para próxima sesión

---

## CHECKLIST DE FINALIZACIÓN DE FUNCIONALIDAD

### **AUTOMÁTICO CON MODELOS LOCALES:**
- ✅ **Funcionalidad implementada** - Por modelo especializado
- ✅ **Tests generados** - Automáticamente por el modelo
- ✅ **Documentación actualizada** - Auto-sincronizada
- ✅ **Casos de uso documentados** - Agregados automáticamente
- ✅ **Contexto maestro evolucionado** - Con información esencial
- ✅ **Commits estructurados** - Propuestos por el modelo

### **VALIDACIÓN MANUAL:**
- [ ] Funcionalidad probada manualmente
- [ ] Revisión de código generado
- [ ] Validación de documentación actualizada
- [ ] Aprobación de cambios arquitecturales

---

## 🎯 PATRONES DE TRABAJO OPTIMIZADOS

### **SESIONES CORTAS (1-2 horas):**
```bash
/implementar-funcionalidad "Funcionalidad específica y acotada"
```
- **Foco:** Un caso de uso específico
- **Estrategia:** Comando único con documentación auto-actualizada
- **Output:** Funcionalidad completa + docs sincronizadas

### **SESIONES MEDIAS (3-4 horas):**
```bash
/implementar-funcionalidad "Módulo completo"
/pos-validar  # Validar consistencia
```
- **Foco:** Módulo completo o múltiples casos de uso relacionados
- **Estrategia:** Implementación + validación arquitectural
- **Output:** Módulo integrado + evolución del contexto maestro

### **SESIONES LARGAS (día completo):**
```bash
/pos-evolucionar  # Evolución arquitectural
/implementar-funcionalidad "Funcionalidad 1"
/implementar-funcionalidad "Funcionalidad 2"
/pos-validar  # Validación final
```
- **Foco:** Evolución arquitectural + múltiples funcionalidades
- **Estrategia:** Planificación arquitectural + implementación iterativa
- **Output:** Arquitectura evolucionada + documentación expandida

---

## 📊 MÉTRICAS AUTO-GESTIONADAS

### **El sistema rastrea automáticamente:**
- 📈 **Casos de uso:** Cantidad y complejidad evolutiva
- 📈 **Queries documentadas:** Cobertura de funcionalidades
- 📈 **APIs documentadas:** Endpoints y documentación OpenAPI
- 📈 **Consistencia:** Score de coherencia entre código y docs
- 📈 **Evolución:** Versiones del contexto maestro

### **Dashboard en tiempo real:**
Disponible en `docs/llm-integration/TRACKING_EVOLUCION.md`

---

## 🛠️ HERRAMIENTAS ESENCIALES

### **Comandos de Modelos Locales:**
```bash
# Desarrollo principal
/implementar-funcionalidad "descripción"
/actualizar-documentacion
/pos-validar

# Análisis especializado
/analizar-arquitectura
/revisar-seguridad  
/validar-caso-uso
/optimizar-pos

# Utilidades
/pos-contexto
/pos-docs
/pos-evolucionar
```

### **Comandos Git (cuando sea necesario):**
```bash
# Para casos complejos donde necesites control manual
git status
git branch
git checkout -b feature/nueva-funcionalidad
git merge feature/nueva-funcionalidad
```

### **Scripts del proyecto:**
```bash
# Cuando estén disponibles
npm run dev                    # Desarrollo local
npm run test                   # Tests automatizados  
npm run docs:validate          # Validar documentación
npm run evolution:status       # Estado de evolución
```

---

## 🚀 INICIO RÁPIDO PARA NUEVA SESIÓN

### **Flujo mínimo recomendado:**
```bash
# 1. Verificar estado
git status
git pull origin develop

# 2. Revisar contexto
/pos-contexto

# 3. Implementar funcionalidad
/implementar-funcionalidad "Tu nueva funcionalidad aquí"

# 4. Validar resultado
/pos-validar

# 5. Merge si todo está bien
git merge feature/[nombre-generado]
```

**¡Listo!** Con este flujo tienes implementación + documentación + validación automática.

---

**Esta guía debe ser consultada al inicio de cada sesión de desarrollo para mantener consistencia y productividad en el proyecto IntelliCore POS con la potencia de modelos locales especializados.**
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
