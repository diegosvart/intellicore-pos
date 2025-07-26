# CONTEXTO MAESTRO - IntelliCore POS | Sistema AEDD Enterprise

## SISTEMA DE NAVEGACIÓN MODULAR

### **PUNTO DE ENTRADA ÚNICO**
```
/start-session <tipo> <descripción>
```

**Para uso eficiente, carga solo:**
1. Este contexto maestro (base) 
2. AEDD_NAVIGATOR.md (routing inteligente)
3. Módulos específicos según sesión (auto-cargados por navigator)

**Módulos disponibles:** `ESPECIALIZACIONES.md` | `PATRONES_CODIGO.md` | `DEPENDENCIAS.md` | `ESTRATEGIAS_IMPLEMENTACION.md` | `TESTING_PROTOCOLS.md` | `DOCUMENTACION_AUTOMATICA.md` | `PLANTILLAS.md`

---

## INFORMACIÓN ESENCIAL DEL PROYECTO

### **Identidad del Proyecto**
- **Nombre:** IntelliCore POS
- **Tipo:** Plataforma Multi-Vertical Enterprise (Restaurant, Hotel, Retail, Services, Healthcare)
- **Stack Principal:** FastAPI (Backend) + Angular (Frontend) + PostgreSQL
- **Metodología:** AEDD (Auto-Evolutionary Documentation Development)

### **Arquitectura Multi-Vertical**
```
Backend (FastAPI) ←→ Frontend (Angular) ←→ PostgreSQL
     ↓                    ↓                   ↓
Core Services         UI Components      Multi-Tenancy
Vertical APIs         Vertical Modules   Tenant Schemas  
Shared Services       Analytics UI       Cross-Vertical Data
```

**Verticales Soportados:**
- **Restaurant:** Órdenes, mesas, menús, cocina
- **Hotel:** Reservas, habitaciones, check-in/out, housekeeping  
- **Retail:** Inventario, ventas, productos, promociones
- **Services:** Citas, profesionales, calendarios, facturación
- **Healthcare:** Pacientes, consultas, historial médico

### **Casos de Uso Críticos Multi-Vertical**
1. **CU-001: Procesamiento de Transacciones** - Core universal para todos los verticales
2. **CU-002: Gestión de Inventario/Stock** - Adaptado por vertical (productos/habitaciones/servicios)  
3. **CU-003: Analytics Cross-Vertical** - Dashboard unificado con métricas específicas
4. **CU-004: Gestión de Usuarios/Clientes** - Multi-tenancy con roles por vertical
5. **CU-005: Configuración Enterprise** - Admin centralizada multi-vertical

### **Casos de Uso por Vertical**
- **Restaurant:** Gestión de mesas, órdenes en tiempo real, integración cocina
- **Hotel:** Sistema de reservas con overbooking, gestión de habitaciones
- **Retail:** Control de inventario, promociones, ventas multi-canal
- **Services:** Calendario de citas, gestión de profesionales
- **Healthcare:** Expedientes médicos, consultas, compliance HIPAA

### **Reglas de Negocio Enterprise**
- **Multi-Tenancy:** Aislamiento completo entre tenants con shared infrastructure
- **Atomicidad:** Transacciones ACID cross-vertical con rollback automático
- **Auditoría:** Trazabilidad completa con compliance por vertical (PCI-DSS, HIPAA, SOX)
- **Performance:** < 300ms para operaciones críticas, < 1s para analytics cross-vertical
- **Escalabilidad:** Horizontal scaling con load balancing por vertical
- **Seguridad:** Roles granulares, encryption at rest/transit, audit trails

### **Stack Tecnológico Enterprise**
- **Backend:** Clean Architecture + SOLID + Repository Pattern + Multi-Tenancy
- **Frontend:** Micro-frontends + Component-based + Reactive Programming (RxJS)
- **Base de Datos:** PostgreSQL + Row-Level Security + Partitioning by Tenant
- **Infraestructura:** Kubernetes + Docker + Helm + CI/CD + Observability Stack
- **Metodología:** AEDD con 5 especialistas LLM (DeepSeek, Qwen3, Llama3.1, Gemma3-ES, Claude-3.5)

---

## ESPECIALISTAS LLM DISPONIBLES

### **Auto-Routing por Tipo de Sesión**
- **CORE/CROSS-VERTICAL:** ARQUITECTO (DeepSeek) + DESARROLLADOR_SENIOR (Qwen3)
- **VERTICAL-SPECIFIC:** ANALISTA_NEGOCIO (Llama3.1) + DESARROLLADOR_SENIOR (Qwen3)  
- **ARCHITECTURE:** ARQUITECTO (DeepSeek) + DEVOPS_ENGINEER (Claude-3.5)
- **SECURITY:** ESPECIALISTA_SEGURIDAD (Gemma3-ES) + DESARROLLADOR_SENIOR (Qwen3)
- **DEPLOYMENT:** DEVOPS_ENGINEER (Claude-3.5) + ARQUITECTO (DeepSeek)

**Detalles completos:** Ver `ESPECIALIZACIONES.md` (auto-cargado por navigator según sesión)

---

## SISTEMA DE DOCUMENTACIÓN MODULAR

### **Estructura Optimizada (Token-Efficient)**
```
CONTEXTO_MAESTRO.md (este archivo) ← Base esencial (2,800 tokens)
├── AEDD_NAVIGATOR.md ← Router inteligente (2,215 tokens)
├── ESPECIALIZACIONES.md ← Roles LLM (1,800 tokens)  
├── PATRONES_CODIGO.md ← Templates código (2,500 tokens)
├── DEPENDENCIAS.md ← Tech stack (2,200 tokens)
├── ESTRATEGIAS_IMPLEMENTACION.md ← Metodología AEDD (3,000 tokens)
├── TESTING_PROTOCOLS.md ← Testing cross-vertical (2,400 tokens)
├── DOCUMENTACION_AUTOMATICA.md ← Auto-docs (1,900 tokens)
└── PLANTILLAS.md ← Templates output (2,100 tokens)
```

**Eficiencia:** 80% reducción vs documentación monolítica (de ~20,000 a ~4,000 tokens por sesión)

### **Referencias Legacy (Solo si Necesarias)**
- `docs/llm-documentation/CASOS_USO_DETALLADOS.md` - 10 casos de uso completos
- `docs/llm-documentation/QUERIES_CASOS_USO.sql` - 50+ queries por vertical
- `docs/llm-documentation/DICCIONARIO_COMPLETO.json` - Estructura BD completa
- `docs/llm-documentation/MODELO_BD_COMPLETO_LLM.md` - Documentación técnica BD

---

## METODOLOGÍA AEDD ENTERPRISE

### **Principios del Sistema Modular:**
1. **Contexto Optimizado:** Solo carga información relevante a la sesión específica
2. **Auto-Routing:** Navigator detecta automáticamente especialista y módulos necesarios
3. **Coherencia Multi-Vertical:** Validaciones automáticas de consistencia cross-vertical
4. **Especialización Inteligente:** Cada LLM tiene rol específico con contexto curado
5. **Documentación Auto-Evolutiva:** Actualización automática de contexto tras implementaciones

### **Flujo de Trabajo AEDD:**
```
1. COMMAND PARSING → Navigator analiza solicitud
2. CONTEXT LOADING → Carga módulos específicos (token-optimized)
3. SPECIALIST ROUTING → Activa LLM especializado correcto
4. EXECUTION → Implementación con metodología específica
5. DOCUMENTATION → Auto-actualización de contexto y documentación
```

### **Comando Principal de Entrada:**
```
/start-session <tipo> <descripción>
```

**Tipos disponibles:** `core` | `vertical` | `cross-vertical` | `architecture` | `security` | `deployment`

**Ejemplos de uso:** Ver `NAVIGATOR_EXAMPLES.md` para casos detallados

---

## VALIDACIONES Y CONTROL DE CALIDAD

### **Validaciones Automáticas del Sistema:**
- **Consistency Check:** Coherencia entre módulos cargados
- **Completeness Check:** Contexto incluye toda información necesaria  
- **Cross-Vertical Impact:** Análisis de impacto en otros verticales
- **Compliance Validation:** Verificación de reglas de negocio por vertical
- **Performance Impact:** Evaluación de rendimiento de cambios propuestos

### **Red Flags del Sistema:**
- No inventar casos de uso no documentados en módulos
- No asumir tecnologías fuera del stack enterprise definido
- No ignorar reglas de negocio multi-vertical
- No proponer cambios sin análisis de impacto cross-vertical
- No usar emoticonos/elementos decorativos (waste tokens)
- No generar documentación monolítica (usar sistema modular)

### **Métricas de Success:**
- **Token Efficiency:** 80-90% reducción vs método manual
- **Routing Accuracy:** >95% precisión en selección de especialista
- **Context Relevance:** >98% de información cargada es relevante a la sesión
- **Implementation Quality:** Código generado pasa validaciones automáticas

---

## COMANDOS LEGACY Y MIGRACIÓN

### **Sistema de Comandos Actualizado:**
```
COMANDO LEGACY → NUEVO SISTEMA AEDD

/implementar-funcionalidad [desc] → /start-session core [desc]
/implementar-vertical [desc] --vertical=X → /start-session vertical [desc para X]
/analizar-arquitectura → /start-session architecture "Análisis arquitectural"
/revisar-seguridad → /start-session security "Revisión de seguridad"
/validar-caso-uso → /start-session vertical "Validación caso uso específico"
/optimizar-pos → /start-session cross-vertical "Optimización performance"
```

**Migración automática:** Navigator detecta comandos legacy y los redirige al sistema modular

---

**Última actualización:** 2025-07-26 | **Versión:** 2.0-AEDD-Enterprise | **Sistema:** Modular Navigator Activo
