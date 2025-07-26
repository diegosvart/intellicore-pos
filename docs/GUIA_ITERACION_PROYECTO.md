# GUÍA DE ITERACIÓN DE PROYECTO - IntelliCore POS Multi-Vertical Platform

## PROPÓSITO
Este documento sirve como guía de referencia para iniciar cada sesión de desarrollo y mantener un flujo de trabajo consistente en el proyecto **IntelliCore POS**, una **plataforma POS multi-vertical empresarial** que soporta Restaurant, Hotel, Retail, Services y Healthcare, **implementando la metodología "Auto-Evolutionary Documentation Development" (AEDD) con modelos de lenguaje locales especializados**.

## VISIÓN GENERAL DEL PROYECTO

### **IntelliCore POS - Plataforma Multi-Vertical**
IntelliCore POS es una plataforma empresarial que trasciende el concepto tradicional de POS, ofreciendo:

- **Arquitectura Universal:** Core + Verticales modulares para diferentes industrias
- **Inteligencia Nativa:** ML engine integrado con analytics en tiempo real
- **QR Self-Service:** Sistema nativo sin dependencias externas
- **Split Billing Inteligente:** Gestión avanzada de pagos compartidos
- **Customer Journey Tracking:** Seguimiento completo del cliente a través de todos los puntos de contacto
- **Multi-Tenancy:** Soporte para múltiples negocios y configuraciones

### **Stack Tecnológico Enterprise:**
- **Backend:** FastAPI + PostgreSQL + Redis + SQLAlchemy
- **Frontend:** Angular 17 + TypeScript + TailwindCSS
- **ML/Analytics:** Python ML Engine + Real-time Analytics
- **Infraestructura:** Docker + Kubernetes + AWS/Azure/GCP
- **CI/CD:** GitHub Actions + Infrastructure as Code

## METODOLOGÍA: AUTO-EVOLUTIONARY DOCUMENTATION DEVELOPMENT (AEDD)

### **Definición:**
AEDD es una metodología de desarrollo de software empresarial que integra modelos de lenguaje especializados para crear un ecosistema auto-evolutivo donde la documentación, arquitectura y código evolucionan sincrónicamente, generando un contexto de proyecto cada vez más inteligente y adaptado a las necesidades multi-verticales.

### **Principios Fundamentales AEDD para Plataformas Enterprise:**
1. **Auto-Evolución Multi-Vertical:** El sistema se adapta automáticamente a diferentes industrias y casos de uso
2. **Documentación Viva Enterprise:** La documentación se actualiza automáticamente reflejando cambios en core y verticales
3. **Contexto Inteligente Universal:** Un orquestador maestro gestiona información de múltiples verticales de negocio
4. **Especialización por Dominio:** Modelos específicos para aspectos técnicos, de negocio, seguridad y arquitectura
5. **Optimización de Tokens:** Máxima eficiencia en el uso de recursos computacionales a escala empresarial
6. **Trazabilidad Multi-Tenancy:** Seguimiento de cambios y decisiones a través de múltiples verticales y clientes

### **Arquitectura AEDD para Plataforma Multi-Vertical:**
```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    INTELLICORE POS - METODOLOGÍA AEDD                      │
├─────────────────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌─────────────────── │
│  │    CORE      │◄─┤   CONTEXTO   │─►│  VERTICALES  │  │   DOCUMENTACIÓN   │
│  │  UNIVERSAL   │  │   MAESTRO    │  │ (Restaurant, │  │   AUTO-EVOLUTIVA  │
│  │              │  │(Orquestador) │  │ Hotel, Retail,│  │                   │
│  │ • Auth       │  │              │  │ Services,    │  │ • Casos Uso       │
│  │ • Payments   │  │              │  │ Healthcare)  │  │ • APIs            │
│  │ • ML Engine  │  │              │  │              │  │ • Arquitectura    │
│  │ • Analytics  │  │              │  │              │  │ • BD Schemas      │
│  └──────────────┘  └──────────────┘  └──────────────┘  └─────────────────── │
│           ▲                ▲                ▲                        ▲      │
│           │                │                │                        │      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌─────────────────── │
│  │   MODELOS    │  │   COMANDOS   │  │ MICRO-FRONT  │  │   TRACKING         │
│  │ESPECIALIZADOS│  │ EVOLUTIVOS   │  │   ENDS       │  │  EVOLUCIÓN         │
│  │              │  │              │  │              │  │                    │
│  │ • Arquitecto │  │ • /vertical  │  │ • Restaurant │  │ • Métricas         │
│  │ • Desarrolla │  │ • /core      │  │ • Hotel      │  │ • Multi-Tenancy    │
│  │ • Analista   │  │ • /ml-engine │  │ • Retail     │  │ • Performance      │
│  │ • Seguridad  │  │ • /analytics │  │ • Services   │  │ • Adoption         │
│  │ • DevOps     │  │ • /deploy    │  │ • Healthcare │  │ • ROI              │
│  └──────────────┘  └──────────────┘  └──────────────┘  └─────────────────── │
└─────────────────────────────────────────────────────────────────────────────┘
```

### **Componentes del Sistema AEDD Enterprise:**

#### **1. CONTEXTO MAESTRO MULTI-VERTICAL (Universal Orchestrator)**
- **Archivo:** `docs/llm-integration/CONTEXTO_MAESTRO.md`
- **Función:** Orquestador universal que contiene información esencial de todos los verticales
- **Beneficio:** Reduce tokens de 25-40K a 3-5K (optimización 85-90%) para plataformas enterprise
- **Contenido:** Casos de uso universales, reglas de negocio por vertical, stack tecnológico, patrones arquitecturales, configuraciones multi-tenancy

#### **2. MODELOS ESPECIALIZADOS ENTERPRISE (Domain-Specific LLMs)**
- **Arquitecto Principal (DeepSeek):** Clean Architecture, microservicios, escalabilidad enterprise, multi-tenancy
- **Desarrollador Senior (Qwen3):** FastAPI, Angular, PostgreSQL, Redis, testing, CI/CD
- **Analista de Negocio (Llama3.1):** Casos de uso multi-verticales, reglas de negocio específicas por industria
- **Especialista Seguridad (Gemma3-ES):** PCI DSS, OWASP, seguridad financiera, compliance multi-tenancy
- **DevOps Engineer (Claude-3.5):** Infrastructure as Code, Kubernetes, AWS/Azure/GCP, monitoring
#### **3. COMANDOS EVOLUTIVOS ENTERPRISE (Auto-Development Commands)**
- **`/implementar-vertical`:** Desarrollo completo de nuevo vertical + documentación automática
- **`/implementar-core-feature`:** Desarrollo de características universales del core
- **`/implementar-microfront`:** Desarrollo de micro-frontend específico
- **`/actualizar-documentacion`:** Sincronización inteligente código-docs multi-vertical
- **`/analizar-arquitectura`:** Evaluación arquitectural enterprise y multi-tenancy
- **`/validar-caso-uso`:** Verificación contra reglas de negocio por vertical
- **`/revisar-seguridad`:** Análisis de seguridad enterprise y compliance
- **`/deploy-vertical`:** Despliegue automatizado de vertical específico
- **`/optimizar-performance`:** Análisis y optimización de rendimiento enterprise

#### **4. DOCUMENTACIÓN AUTO-EVOLUTIVA ENTERPRISE (Living Documentation)**
```
docs/
├── llm-integration/           # Motor AEDD Enterprise
│   ├── CONTEXTO_MAESTRO.md   # Orquestador multi-vertical
│   ├── FLUJO_ITERACION_EVOLUTIVA.md  # Metodología enterprise
│   ├── TRACKING_EVOLUCION.md # Métricas y evolución multi-vertical
│   ├── CONTINUE_CONFIG_OPTIMIZADA.md # Configuración LLMs especializados
│   └── VERTICAL_MANAGEMENT.md # Gestión de verticales y plugins
├── llm-documentation/         # Documentación expandida por vertical
│   ├── CASOS_USO_CORE.md     # Casos de uso universales
│   ├── CASOS_USO_RESTAURANT.md # Casos de uso específicos restaurant
│   ├── CASOS_USO_HOTEL.md    # Casos de uso específicos hotel
│   ├── CASOS_USO_RETAIL.md   # Casos de uso específicos retail
│   ├── QUERIES_CASOS_USO.sql # Biblioteca de queries por vertical
│   ├── API_DOCUMENTATION.md  # Documentación OpenAPI completa
│   ├── ARCHITECTURE_PATTERNS.md # Patrones arquitecturales enterprise
│   └── DICCIONARIO_COMPLETO.json # Estructura BD multi-vertical
├── architecture/              # Documentación arquitectural
│   ├── CORE_ARCHITECTURE.md  # Arquitectura del core universal
│   ├── VERTICAL_ARCHITECTURE.md # Arquitectura de verticales
│   ├── MICROSERVICES_PATTERNS.md # Patrones de microservicios
│   └── DEPLOYMENT_STRATEGIES.md # Estrategias de despliegue
└── iteraciones/              # Tracking de sesiones por vertical
    ├── ITERACION_CORE_YYYY_MM_DD.md
    ├── ITERACION_RESTAURANT_YYYY_MM_DD.md
    └── ITERACION_[VERTICAL]_YYYY_MM_DD.md
```

#### **5. SISTEMA DE TRACKING ENTERPRISE (Multi-Vertical Evolution Metrics)**
- **Archivo:** `docs/llm-integration/TRACKING_EVOLUCION.md`
- **Métricas Multi-Vertical:** Casos de uso por vertical, APIs por dominio, performance, adopción
- **Dashboard Enterprise:** Estado en tiempo real de todos los verticales y core
- **Multi-Tenancy Tracking:** Métricas por cliente y configuración
- **ROI y Adoption:** Métricas de negocio y adopción por vertical
- **Versionado:** Control de evolución del contexto maestro y verticales

### **Flujo de Trabajo AEDD Enterprise:**
1. **Input:** Desarrollador solicita funcionalidad mediante comando evolutivo específico (core/vertical)
2. **Análisis Multi-Vertical:** Modelo especializado evalúa impacto en core y verticales afectados
3. **Implementación Inteligente:** Código generado siguiendo patrones enterprise y multi-tenancy
4. **Documentación Sincronizada:** Actualización automática por vertical y core afectado
5. **Evolución Universal:** Contexto maestro se enriquece manteniendo coherencia multi-vertical
6. **Testing Automatizado:** Tests generados para core, vertical específico e integración
7. **Deployment Ready:** Artifacts listos para despliegue en múltiples entornos
8. **Métricas Actualizadas:** Tracking automático de evolución y performance
6. **Tracking:** Métricas actualizadas automáticamente
7. **Output:** Funcionalidad completa + documentación sincronizada + contexto evolucionado

### **REGLAS DE OPTIMIZACIÓN PARA LLMs:**
- **NO usar íconos/emojis:** Desperdician tokens sin aportar valor técnico
- **Definiciones acotadas y precisas:** Maximizar información útil por token
- **Priorizar contenido técnico esencial:** Evitar redundancias y decoraciones
- **Referencias inteligentes:** Cargar documentación específica solo bajo demanda
- **Contexto curado:** Un archivo maestro vs múltiples archivos dispersos

### **ESTRUCTURA DEL PROYECTO AEDD ENTERPRISE:**

#### **Arquitectura Multi-Vertical IntelliCore:**
```
intellicore-pos/
├── core/                     # NÚCLEO UNIVERSAL
│   ├── auth/                 # Autenticación y autorización multi-tenancy
│   ├── payments/             # Motor de pagos universal con split billing
│   ├── customers/            # Gestión universal de clientes y CRM
│   ├── qr_selfservice/       # QR Self-Service nativo
│   ├── ml_engine/            # Motor de ML integrado
│   ├── inventory/            # Inventario base universal
│   ├── analytics/            # Dashboard y KPIs en tiempo real
│   ├── event_bus/            # Sistema de eventos enterprise
│   ├── registry/             # Registro de verticales y plugins
│   ├── database/             # Configuración BD multi-tenancy
│   ├── config/               # Configuración central
│   └── main.py               # Aplicación principal FastAPI
├── verticales/               # VERTICALES DE NEGOCIO
│   ├── restaurant/           # Vertical Restaurante
│   │   ├── models/           # Modelos específicos restaurant
│   │   ├── api/              # Endpoints específicos
│   │   ├── services/         # Lógica de negocio restaurant
│   │   └── frontend/         # Micro-frontend restaurant
│   ├── hotel/                # Vertical Hotel/Hospedaje
│   │   ├── models/           # Habitaciones, reservas, huéspedes
│   │   ├── api/              # Check-in/out, housekeeping
│   │   ├── services/         # Gestión hotelera
│   │   └── frontend/         # Micro-frontend hotel
│   ├── retail/               # Vertical Retail/Comercio
│   │   ├── models/           # Productos, categorías, promociones
│   │   ├── api/              # E-commerce, inventario retail
│   │   ├── services/         # Gestión retail
│   │   └── frontend/         # Micro-frontend retail
│   ├── services/             # Vertical Servicios Profesionales
│   │   ├── models/           # Citas, recursos, profesionales
│   │   ├── api/              # Agendamiento, billing por tiempo
│   │   ├── services/         # Gestión de servicios
│   │   └── frontend/         # Micro-frontend servicios
│   └── healthcare/           # Vertical Salud/Clínicas
│       ├── models/           # Pacientes, citas médicas, historiales
│       ├── api/              # EMR básico, facturación médica
│       ├── services/         # Gestión sanitaria
│       └── frontend/         # Micro-frontend healthcare
├── frontend/                 # FRONTEND UNIVERSAL
│   ├── core-app/             # Aplicación Angular base
│   ├── shared-components/    # Biblioteca de componentes universal
│   ├── micro-frontends/      # Micro-frontends por vertical
│   └── deployment/           # Configuración deploy frontend
├── infrastructure/           # INFRAESTRUCTURA ENTERPRISE
│   ├── docker/               # Contenedores por servicio
│   ├── kubernetes/           # Manifiestos K8s enterprise
│   ├── terraform/            # Infrastructure as Code multi-cloud
│   ├── monitoring/           # Observabilidad (Prometheus, Grafana, ELK)
│   └── ci-cd/                # Pipelines CI/CD por vertical
├── docs/
│   ├── llm-integration/      # MOTOR AEDD ENTERPRISE
│   │   ├── CONTEXTO_MAESTRO.md           # [CORE] Orquestador multi-vertical
│   │   ├── FLUJO_ITERACION_EVOLUTIVA.md  # [CORE] Metodología AEDD enterprise
│   │   ├── TRACKING_EVOLUCION.md         # [CORE] Métricas evolutivas multi-vertical
│   │   ├── CONTINUE_CONFIG_OPTIMIZADA.md # [CORE] Config LLMs especializados
│   │   ├── VERTICAL_MANAGEMENT.md        # [CORE] Gestión de verticales
│   │   ├── ENTERPRISE_PATTERNS.md        # [REF] Patrones enterprise
│   │   └── DEPLOYMENT_AUTOMATION.md     # [UTIL] Automatización despliegue
│   ├── llm-documentation/    # DOCUMENTACIÓN EXPANDIDA POR VERTICAL
│   │   ├── CASOS_USO_CORE.md             # [AUTO] Casos de uso universales
│   │   ├── CASOS_USO_RESTAURANT.md       # [AUTO] Casos específicos restaurant
│   │   ├── CASOS_USO_HOTEL.md            # [AUTO] Casos específicos hotel
│   │   ├── CASOS_USO_RETAIL.md           # [AUTO] Casos específicos retail
│   │   ├── CASOS_USO_SERVICES.md         # [AUTO] Casos específicos services
│   │   ├── CASOS_USO_HEALTHCARE.md       # [AUTO] Casos específicos healthcare
│   │   ├── QUERIES_CASOS_USO.sql         # [AUTO] Biblioteca queries por vertical
│   │   ├── API_DOCUMENTATION.md          # [AUTO] Documentación OpenAPI completa
│   │   ├── ARCHITECTURE_PATTERNS.md      # [AUTO] Patrones arquitecturales
│   │   └── DICCIONARIO_COMPLETO.json     # [AUTO] Estructura BD multi-vertical
│   ├── architecture/         # DOCUMENTACIÓN ARQUITECTURAL ENTERPRISE
│   │   ├── CORE_ARCHITECTURE.md          # [REF] Arquitectura del core
│   │   ├── VERTICAL_ARCHITECTURE.md      # [REF] Arquitectura de verticales
│   │   ├── MICROSERVICES_PATTERNS.md     # [REF] Patrones microservicios
│   │   ├── MULTI_TENANCY_DESIGN.md       # [REF] Diseño multi-tenancy
│   │   └── DEPLOYMENT_STRATEGIES.md      # [REF] Estrategias despliegue
│   ├── api/                  # DOCUMENTACIÓN DE APIs
│   │   ├── CORE_APIS.md                  # [AUTO] APIs del core universal
│   │   ├── RESTAURANT_APIS.md            # [AUTO] APIs vertical restaurant
│   │   ├── HOTEL_APIS.md                 # [AUTO] APIs vertical hotel
│   │   └── [VERTICAL]_APIS.md            # [AUTO] APIs por vertical
│   ├── deployment/           # GUÍAS DE DESPLIEGUE
│   │   ├── AWS_DEPLOYMENT.md             # [REF] Despliegue en AWS
│   │   ├── AZURE_DEPLOYMENT.md           # [REF] Despliegue en Azure
│   │   ├── GCP_DEPLOYMENT.md             # [REF] Despliegue en GCP
│   │   └── ON_PREMISE_DEPLOYMENT.md      # [REF] Despliegue on-premise
│   ├── iteraciones/          # TRACKING DE SESIONES POR VERTICAL
│   │   ├── ITERACION_CORE_2025_07_26.md      # [AUTO] Log sesión core
│   │   ├── ITERACION_RESTAURANT_YYYY_MM_DD.md # [AUTO] Log restaurant
│   │   ├── ITERACION_HOTEL_YYYY_MM_DD.md      # [AUTO] Log hotel
│   │   └── ITERACION_[VERTICAL]_YYYY_MM_DD.md # [AUTO] Logs por vertical
│   └── GUIA_ITERACION_PROYECTO.md        # [MASTER] Esta guía
├── tests/                    # TESTS INTEGRALES ENTERPRISE
│   ├── core/                 # Tests del core universal
│   ├── verticales/           # Tests por vertical
│   ├── integration/          # Tests de integración cross-vertical
│   ├── e2e/                  # Tests end-to-end por caso de uso
│   ├── performance/          # Tests de performance y carga
│   └── security/             # Tests de seguridad y compliance
├── scripts/                  # AUTOMATIZACIÓN ENTERPRISE
│   ├── development/          # Scripts desarrollo multi-vertical
│   ├── deployment/           # Scripts despliegue por entorno
│   ├── maintenance/          # Scripts mantenimiento enterprise
│   └── vertical-management/  # Scripts gestión de verticales
└── .github/                  # CI/CD ENTERPRISE
    ├── workflows/            # Workflows por vertical y core
    └── templates/            # Templates issues y PRs
```

#### **Leyenda de Archivos Enterprise:**
- **[CORE]** - Archivos fundamentales del motor AEDD enterprise
- **[AUTO]** - Archivos que se actualizan automáticamente por vertical
- **[REF]** - Archivos de referencia y documentación arquitectural expandida
- **[UTIL]** - Utilidades y herramientas de apoyo multi-vertical
- **[MASTER]** - Archivo principal de entrada y coordinación
- **[BACKUP]** - Respaldos y configuraciones alternativas por entorno

### **CARACTERÍSTICAS ÚNICAS DE AEDD ENTERPRISE:**

#### **1. Auto-Crecimiento Multi-Vertical:**
- **Contexto Evolutivo Universal:** El sistema aprende y mejora con cada iteración en cualquier vertical
- **Documentación Viva Cross-Vertical:** Se actualiza automáticamente manteniendo coherencia entre verticales
- **Especialización Creciente:** Los modelos se vuelven más expertos en cada vertical específico
- **Inteligencia Compartida:** Aprendizajes de un vertical benefician a otros verticales aplicables

#### **2. Optimización Extrema Enterprise:**
- **Reducción de Tokens:** 85-90% menos consumo vs métodos tradicionales para plataformas enterprise
- **Referencias Inteligentes:** Carga bajo demanda de documentación específica por vertical
- **Contexto Curado Multi-Vertical:** Solo información esencial por dominio en el orquestador
- **Caché Inteligente:** Reutilización de contexto entre verticales similares

#### **3. Especialización por Dominio Enterprise:**
- **5 Modelos Especializados:** Cada uno experto en múltiples dominios enterprise
- **Comandos Multi-Verticales:** Herramientas diseñadas para desarrollo enterprise complejo
- **Patrones Cross-Vertical:** Reutilización de patrones entre diferentes industrias
- **Gestión de Complejidad:** Manejo inteligente de dependencias entre verticales
- **Flujo Integrado:** Desde análisis hasta implementación y documentación

#### **4. Trazabilidad Completa:**
- **Tracking Automático:** Métricas de evolución del proyecto
- **Versionado de Contexto:** Control de cambios en el conocimiento del sistema
- **Auditoría de Decisiones:** Log de todas las decisiones técnicas tomadas

---

## PREPARACIÓN DE SESIÓN DE DESARROLLO ENTERPRISE

### 1. REVISIÓN INICIAL DEL ESTADO MULTI-VERTICAL

#### Verificar estado del repositorio enterprise:
```bash
git status
git branch
git log --oneline -10  # Ver más commits para plataforma compleja
```

#### **ENTERPRISE: Verificar configuración de modelos especializados:**
- Validar que Continue esté configurado con los 5 modelos especializados enterprise
- Revisar `docs/llm-integration/CONTEXTO_MAESTRO.md` - Contexto multi-vertical actualizado
- Verificar última iteración por vertical en `docs/iteraciones/ITERACION_[VERTICAL]_YYYY_MM_DD.md`
- Validar estado de tracking en `docs/llm-integration/TRACKING_EVOLUCION.md`

#### Revisar documentación enterprise actualizada:
- `docs/llm-integration/CONTEXTO_MAESTRO.md` - **CRÍTICO:** Contexto multi-vertical esencial
- `docs/llm-documentation/CASOS_USO_CORE.md` - Casos de uso universales del core
- `docs/llm-documentation/CASOS_USO_[VERTICAL].md` - Casos específicos por vertical
- `docs/architecture/CORE_ARCHITECTURE.md` - Arquitectura del núcleo universal
- `docs/architecture/VERTICAL_ARCHITECTURE.md` - Arquitectura de verticales
- `README.md` - Estado general de la plataforma multi-vertical

#### Identificar contexto de trabajo enterprise:
- **develop** - Para desarrollo general del core
- **feature/core-[funcionalidad]** - Para nuevas características del core universal
- **feature/restaurant-[funcionalidad]** - Para características específicas del vertical restaurant
- **feature/hotel-[funcionalidad]** - Para características específicas del vertical hotel
- **feature/retail-[funcionalidad]** - Para características específicas del vertical retail
- **feature/cross-vertical-[funcionalidad]** - Para funcionalidades que afectan múltiples verticales
- **hotfix/[vertical]-[fix]** - Para correcciones específicas por vertical

### 2. PLANIFICACIÓN DE LA SESIÓN ENTERPRISE

#### Definir objetivo y alcance multi-vertical:
- [ ] **Implementar funcionalidad core** (**RECOMENDADO:** Usar `/implementar-core-feature`)
- [ ] **Implementar nuevo vertical** (**RECOMENDADO:** Usar `/implementar-vertical`)
- [ ] **Implementar funcionalidad específica de vertical** (Usar `/implementar-vertical-feature`)
- [ ] **Desarrollar micro-frontend** (Usar `/implementar-microfront`)
- [ ] **Evolucionar arquitectura enterprise** (Usar `/analizar-arquitectura`)
- [ ] **Optimizar performance multi-vertical** (Usar `/optimizar-performance`)
- [ ] **Mejorar documentación cross-vertical** (Usar `/actualizar-documentacion`)
- [ ] **Revisar seguridad y compliance** (Usar `/revisar-seguridad`)
- [ ] **Desplegar vertical en entorno** (Usar `/deploy-vertical`)

#### **ENTERPRISE: Seleccionar modelo y contexto especializado:**
- **Arquitecto Principal (DeepSeek)** - Para decisiones arquitecturales enterprise, microservicios, multi-tenancy
- **Desarrollador Senior (Qwen3)** - Para implementación core, APIs, integración entre verticales
- **Analista de Negocio (Llama3.1)** - Para validación de casos de uso específicos por vertical
- **Especialista Seguridad (Gemma3-ES)** - Para análisis de seguridad enterprise, PCI DSS, compliance
- **DevOps Engineer (Claude-3.5)** - Para automatización, CI/CD, infraestructura, monitoring

**Principio AEDD Enterprise:** Cada modelo tiene contexto automático de toda la plataforma multi-vertical y especialización específica, con capacidad de análisis cross-vertical e impacto en múltiples dominios.

#### Estimar tiempo y alcance enterprise:
- **Sesión micro (30min-1hora):** Ajuste específico en un vertical con `/fix-vertical-issue`
- **Sesión corta (1-2 horas):** Una característica específica de vertical con `/implementar-vertical-feature`
- **Sesión media (3-4 horas):** Funcionalidad core que afecta múltiples verticales
- **Sesión larga (día completo):** Nuevo vertical completo o evolución arquitectural mayor
- **Sesión sprint (2-3 días):** Múltiples verticales + core + infraestructura + documentación

---

## METODOLOGÍA AEDD ENTERPRISE EN PRÁCTICA: FLUJO DE TRABAJO MULTI-VERTICAL

### **Filosofía AEDD Enterprise:**
La metodología Auto-Evolutionary Documentation Development (AEDD) para plataformas enterprise se basa en el principio de que **el core universal, los verticales específicos y la documentación deben evolucionar juntos**, creando un ecosistema inteligente multi-vertical que se auto-mejora y auto-adapta con cada iteración.

### OPCIÓN A: FLUJO AEDD ENTERPRISE COMPLETO (Recomendado)

#### Comando único para implementación evolutiva multi-vertical:
```bash
/implementar-core-feature "Descripción de nueva funcionalidad del core"
/implementar-vertical "Nuevo vertical completo" --vertical=healthcare
/implementar-vertical-feature "Funcionalidad específica" --vertical=restaurant
/implementar-microfront "Micro-frontend específico" --vertical=hotel
```

**Ejemplos prácticos enterprise:**
```bash
# Funcionalidad core que afecta todos los verticales
/implementar-core-feature "Sistema de loyalty points universal para todos los verticales"

# Nuevo vertical completo
/implementar-vertical "Vertical Healthcare completo con EMR básico y facturación médica" --vertical=healthcare

# Funcionalidad específica de vertical
/implementar-vertical-feature "Sistema de reservas con overbooking para hotel" --vertical=hotel

# Micro-frontend específico
/implementar-microfront "Dashboard analytics específico para retail" --vertical=retail
```

**El motor AEDD Enterprise ejecuta automáticamente:**
1. **Análisis de impacto cross-vertical** - Evalúa impacto en core y otros verticales
2. **Implementación multi-capa especializada** - Core + Vertical + Frontend + BD + Tests
3. **Evolución automática de documentación multi-vertical:**
   - Nuevos casos de uso en `CASOS_USO_[VERTICAL].md` correspondiente
   - Casos de uso core actualizados si aplica
   - Queries SQL específicas por vertical en `QUERIES_CASOS_USO.sql`
   - APIs documentadas en `[VERTICAL]_APIS.md`
   - Arquitectura actualizada en documentos correspondientes
   - Contexto maestro evolucionado con información cross-vertical
4. **Generación de tests multi-capa** - Unit, integration, e2e por vertical y core
5. **Validación de consistencia AEDD Enterprise** - Coherencia cross-vertical y core
6. **Propuesta de deployment** - Estrategia de despliegue por vertical y entorno
7. **Tracking de evolución enterprise** - Métricas actualizadas por vertical y globales

**Resultado:** Funcionalidad enterprise completa + documentación sincronizada multi-vertical + contexto evolucionado + sistema más inteligente + deployment ready

### OPCIÓN B: FLUJO ENTERPRISE GRANULAR

Si prefieres control granular del proceso enterprise:

#### FASE 1: ANÁLISIS Y DISEÑO ENTERPRISE CON IA

##### 1. Consultar contexto multi-vertical del proyecto:
```bash
# El contexto maestro multi-vertical ya está disponible automáticamente
/intellicore-contexto     # Para ver resumen completo de la plataforma
/vertical-status          # Para ver estado de todos los verticales
/core-architecture        # Para ver arquitectura del core universal
```

##### 2. Análisis especializado enterprise según necesidad:
- **Arquitectura Core:** `/analizar-core-architecture` con 🏗️ Arquitecto Principal
- **Arquitectura Vertical:** `/analizar-vertical-architecture --vertical=restaurant` con 🏗️ Arquitecto Principal  
- **Casos de uso Cross-Vertical:** `/validar-cross-vertical-usecase` con 📊 Analista de Negocio
- **Seguridad Enterprise:** `/revisar-enterprise-security` con 🔒 Especialista Seguridad
- **Performance Multi-Tenancy:** `/analizar-performance` con 🚀 DevOps Engineer

##### 3. **ENTERPRISE:** Diseño con contexto automático multi-vertical:
El modelo tiene acceso automático a:
- Casos de uso core universales (CU-CORE-001 a CU-CORE-010)
- Casos de uso específicos por vertical (CU-REST-001, CU-HOTEL-001, etc.)
- Reglas de negocio universales y específicas por industria  
- Stack tecnológico enterprise y patrones establecidos
- Arquitectura multi-vertical actual y dependencias entre componentes
- Configuraciones multi-tenancy y deployment por entorno

#### FASE 2: IMPLEMENTACIÓN ENTERPRISE CON IA

##### 1. Crear rama de trabajo enterprise:
```bash
git checkout develop
git pull origin develop
# Para funcionalidades core
git checkout -b feature/core-nombre-descriptivo-funcionalidad
# Para funcionalidades de vertical específico
git checkout -b feature/restaurant-nombre-descriptivo-funcionalidad
# Para funcionalidades cross-vertical
git checkout -b feature/cross-vertical-nombre-descriptivo-funcionalidad
```

##### 2. **ENTERPRISE:** Implementación con modelo especializado multi-vertical:
- **Desarrollador Senior:** Para implementación core, APIs, integración entre verticales
- **Arquitecto Principal:** Para decisiones de diseño enterprise y multi-tenancy
- **Analista de Negocio:** Para validar lógica de negocio específica por vertical
- **Especialista Seguridad:** Para validar compliance y seguridad enterprise
- **DevOps Engineer:** Para automatización, CI/CD y deployment strategies

##### 3. **AUTOMÁTICO ENTERPRISE:** Orden de implementación inteligente multi-capa:
El modelo implementa automáticamente en el orden correcto enterprise:
1. **Schemas de Base de Datos:** Multi-tenancy, índices, particiones por vertical
2. **Core Universal:** APIs, servicios, event bus, authentication
3. **Vertical Específico:** Modelos, APIs, servicios, reglas de negocio
4. **Frontend Micro-Frontend:** Componentes, rutas, integración con core
5. **Testing Multi-Capa:** Unit (core + vertical), integration, e2e, performance
6. **CI/CD Pipeline:** Workflows específicos por vertical y core
7. **Deployment Manifests:** Kubernetes, Docker, Infrastructure as Code
8. **Monitoring & Observability:** Métricas específicas, alertas, dashboards

##### 4. **AUTOMÁTICO ENTERPRISE:** Commits incrementales inteligentes cross-vertical:
```bash
# El modelo propone commits estructurados enterprise
git add .
git commit -m "feat(core): implementar [funcionalidad universal] con impacto multi-vertical

Core Changes:
- Agregar caso de uso CU-CORE-XXX
- Implementar API endpoints universales
- Actualizar event bus para nuevos eventos

Vertical Impact:
- Restaurant: Nuevos endpoints CU-REST-XXX
- Hotel: Integración con sistema de reservas CU-HOTEL-XXX  
- Retail: Impacto en inventario CU-RETAIL-XXX

Documentation:
- Actualizar contexto maestro multi-vertical
- Generar tests comprehensivos cross-vertical
- Actualizar deployment strategies"
```
```

#### FASE 3: DOCUMENTACIÓN AUTO-ACTUALIZADA

##### **AUTOMÁTICO:** El modelo actualiza sin intervención:
- ✅ Nuevo caso de uso en `CASOS_USO_DETALLADOS.md`
- ✅ Queries SQL en `QUERIES_CASOS_USO.sql`  
#### FASE 3: DOCUMENTACIÓN AUTO-ACTUALIZADA ENTERPRISE

##### **AUTOMÁTICO ENTERPRISE:** El modelo actualiza sin intervención multi-vertical:
-  Nuevos casos de uso en `CASOS_USO_CORE.md` y/o `CASOS_USO_[VERTICAL].md` correspondiente
-  Queries SQL específicas por vertical en `QUERIES_CASOS_USO.sql`  
-  Estructura BD multi-vertical en `DICCIONARIO_COMPLETO.json`
-  APIs documentadas en `[VERTICAL]_APIS.md` y `CORE_APIS.md`
-  Patrones arquitecturales en `ARCHITECTURE_PATTERNS.md`
-  Contexto maestro multi-vertical con información esencial cross-vertical
-  Archivo de iteración específico por vertical y core con decisiones tomadas
-  Deployment strategies actualizadas por vertical y entorno

##### **VALIDACIÓN ENTERPRISE:** Consistencia automática cross-vertical:
-  Numeración secuencial de casos de uso por vertical y core
-  Referencias cross-vertical entre archivos correctas
-  Coherencia con reglas de negocio específicas por industria
-  Adherencia a patrones arquitecturales enterprise y multi-tenancy
-  Validación de dependencias entre verticales y core
-  Compliance con estándares de seguridad por vertical (PCI DSS, HIPAA, etc.)

#### FASE 4: MERGE Y DEPLOYMENT ENTERPRISE

##### 1. **AUTOMÁTICO ENTERPRISE:** Merge preparado con validación cross-vertical:
```bash
# El modelo propone el merge cuando todo está validado enterprise
git checkout develop
git merge feature/[core|vertical]-nombre-descriptivo-funcionalidad
git push origin develop

# Si es funcionalidad crítica, el modelo sugiere deployment strategy
# e.g., Blue-Green, Canary, Rolling por vertical afectado
```

##### 2. **AUTOMÁTICO ENTERPRISE:** Limpieza y preparación deployment:
```bash
git branch -d feature/[core|vertical]-nombre-descriptivo-funcionalidad
git push origin --delete feature/[core|vertical]-nombre-descriptivo-funcionalidad

# El modelo prepara artifacts de deployment por vertical
# e.g., Docker images, Kubernetes manifests, Terraform scripts
```

##### 3. **AUTOMÁTICO ENTERPRISE:** Archivos de iteración multi-vertical generados:
El modelo crea automáticamente archivos de tracking por contexto:
- `docs/iteraciones/ITERACION_CORE_YYYY_MM_DD.md` - Si afecta core universal
- `docs/iteraciones/ITERACION_RESTAURANT_YYYY_MM_DD.md` - Si afecta vertical restaurant
- `docs/iteraciones/ITERACION_CROSS_VERTICAL_YYYY_MM_DD.md` - Si afecta múltiples verticales

**Contenido de cada archivo de iteración:**
- Resumen de cambios implementados (core/vertical/cross-vertical)
- Decisiones técnicas y arquitecturales tomadas
- Archivos de documentación actualizados por contexto
- Métricas de la iteración (performance, coverage, complexity)
- Impacto en otros verticales y dependencias
- Estrategia de deployment y rollback
- Próximos pasos sugeridos y roadmap técnico

---

##  COMANDOS ESPECIALIZADOS ENTERPRISE DISPONIBLES

### **Comandos Principales Multi-Vertical:**
```bash
# CORE UNIVERSAL
/implementar-core-feature "descripción"   # Implementación core universal automatizada
/analizar-core-architecture               # Revisión arquitectural del core
/optimizar-core-performance               # Optimización integral del core

# VERTICALES ESPECÍFICOS  
/implementar-vertical "descripción" --vertical=restaurant|hotel|retail|services|healthcare
/implementar-vertical-feature "descripción" --vertical=[vertical]
/analizar-vertical-architecture --vertical=[vertical]
/validar-vertical-usecase --vertical=[vertical]

# MICRO-FRONTENDS
/implementar-microfront "descripción" --vertical=[vertical]
/optimizar-microfront-performance --vertical=[vertical]

# CROSS-VERTICAL
/implementar-cross-vertical "descripción" --affects=restaurant,hotel,retail
/analizar-cross-vertical-impact "descripción"
/validar-cross-vertical-consistency

# ENTERPRISE OPERATIONS
/deploy-vertical --vertical=[vertical] --environment=dev|staging|prod
/rollback-vertical --vertical=[vertical] --version=[version]
/health-check-vertical --vertical=[vertical]
```

### **Comandos de Análisis Enterprise:**
```bash
# ARQUITECTURA Y DISEÑO
/analizar-arquitectura                    # Revisión arquitectural enterprise completa
/validar-multi-tenancy                    # Validación de diseño multi-tenancy
/revisar-microservices-patterns          # Análisis de patrones de microservicios

# SEGURIDAD Y COMPLIANCE
/revisar-enterprise-security              # Análisis de seguridad enterprise
/validar-compliance --standard=pci-dss|hipaa|gdpr
/audit-security-vertical --vertical=[vertical]

# PERFORMANCE Y ESCALABILIDAD
/optimizar-performance                    # Optimización integral multi-vertical
/load-test-vertical --vertical=[vertical]
/analyze-bottlenecks --scope=core|vertical|cross-vertical

# DOCUMENTACIÓN
/actualizar-documentacion                 # Sincronizar docs cross-vertical
/generate-api-docs --vertical=[vertical]
/validate-docs-consistency
```

### **Comandos de Utilidad Enterprise:**
```bash
# CONTEXTO Y ESTADO
/intellicore-contexto                     # Ver contexto maestro completo
/vertical-status                          # Estado de todos los verticales
/core-status                              # Estado del core universal
/deployment-status                        # Estado de deployments por entorno
# MÉTRICAS Y MONITOREO
/metrics-dashboard                        # Dashboard de métricas enterprise
/generate-reports --type=performance|security|adoption
/analyze-roi --vertical=[vertical]

# DESARROLLO Y TESTING
/run-tests --scope=core|vertical|integration|e2e
/generate-test-data --vertical=[vertical]
/validate-quality --scope=code|architecture|documentation
```

## 🔄 DOCUMENTACIÓN AUTO-EVOLUTIVA ENTERPRISE

### **Archivos que se Actualizan Automáticamente Multi-Vertical:**

#### **Siempre (Actualizaciones Universales):**
-  `docs/llm-integration/CONTEXTO_MAESTRO.md` - Información esencial multi-vertical actualizada
-  `docs/iteraciones/ITERACION_[SCOPE]_YYYY_MM_DD.md` - Log detallado por contexto (core/vertical/cross-vertical)
-  `docs/llm-integration/TRACKING_EVOLUCION.md` - Métricas evolutivas enterprise

#### **Según tipo de cambio y alcance:**

** Funcionalidad CORE Universal:**
- `docs/llm-documentation/CASOS_USO_CORE.md` - Casos de uso universales
- `docs/api/CORE_APIS.md` - APIs del core universal
- `docs/architecture/CORE_ARCHITECTURE.md` - Arquitectura del core
- `QUERIES_CASOS_USO.sql` (sección CORE) - Queries universales

** Funcionalidad VERTICAL Específica:**
- `docs/llm-documentation/CASOS_USO_[VERTICAL].md` - Casos específicos del vertical
- `docs/api/[VERTICAL]_APIS.md` - APIs específicas del vertical
- `QUERIES_CASOS_USO.sql` (sección [VERTICAL]) - Queries específicas
- `docs/architecture/VERTICAL_ARCHITECTURE.md` - Arquitectura de verticales

** Funcionalidad CROSS-VERTICAL:**
- Múltiples archivos `CASOS_USO_[VERTICAL].md` según verticales afectados
- `docs/architecture/MICROSERVICES_PATTERNS.md` - Patrones de integración
- `docs/architecture/MULTI_TENANCY_DESIGN.md` - Diseño multi-tenancy
- Múltiples `[VERTICAL]_APIS.md` según impacto

** Cambios de Base de Datos:**
- `DICCIONARIO_COMPLETO.json` - Estructura BD multi-vertical completa
- `database/schemas/[vertical]_schema.sql` - Esquemas específicos
- `database/migrations/` - Migraciones por vertical y core

** Cambios Arquitecturales:**
- `docs/architecture/` - Documentación arquitectural completa
- `README.md` - Arquitectura general de la plataforma
- `docs/deployment/` - Estrategias de despliegue actualizadas

**🔌 Nuevas APIs:**
- Documentación OpenAPI por vertical y core
- `CHANGELOG.md` - Log de cambios enterprise
- `docs/api/` - Documentación completa de APIs

### **Tracking de Evolución Enterprise:**
El sistema mantiene métricas automáticas multi-vertical en `docs/llm-integration/TRACKING_EVOLUCION.md`:
```
INTELLICORE POS ENTERPRISE - EVOLUTION DASHBOARD
===============================================

CORE UNIVERSAL:
Casos de Uso Core:     10 → 12 (+2 nuevos)
APIs Core:             15 → 18 (+3 nuevas)
Servicios Core:        8 → 9 (+1 nuevo)

VERTICALES:
Restaurant:            CU: 25 | APIs: 35 | Status: ACTIVE
Hotel:                 CU: 20 | APIs: 28 | Status: ACTIVE  
Retail:                CU: 18 | APIs: 24 | Status: ACTIVE
Services:              CU: 15 | APIs: 20 | Status: BETA
Healthcare:            CU: 12 | APIs: 16 | Status: DEVELOPMENT

MÉTRICAS ENTERPRISE:
Total Queries SQL:     150+ → 178 (+28 nuevas)
Total Endpoints:       98 → 115 (+17 nuevos)
Test Coverage:         85% → 87% (+2%)
Performance Score:     92/100 → 94/100
Security Score:        96/100 → 97/100

DEPLOYMENT:
Entornos Activos:      DEV, STAGING, PROD
Verticales en PROD:    Restaurant, Hotel, Retail
Verticales en STAGING: Services
Verticales en DEV:     Healthcare

CONTEXTO MAESTRO:
Versión:               v2.0 → v2.3
Última Evolución:      2025-07-26
Próxima Review:        2025-08-02
```

---

## FORMATO ESTÁNDAR DE DOCUMENTACIÓN POR ITERACIÓN ENTERPRISE

### **Creación Automática Multi-Vertical:**
El modelo genera automáticamente archivos de iteración específicos por contexto con estructura estandarizada enterprise:

**Para desarrollo CORE:** `docs/iteraciones/ITERACION_CORE_YYYY_MM_DD.md`
**Para desarrollo VERTICAL:** `docs/iteraciones/ITERACION_[VERTICAL]_YYYY_MM_DD.md`
**Para desarrollo CROSS-VERTICAL:** `docs/iteraciones/ITERACION_CROSS_VERTICAL_YYYY_MM_DD.md`

### **Estructura Enterprise Estándar:**

###  **CONTEXTO DE LA SESIÓN ENTERPRISE:**
-  **Duración y alcance:** Tiempo invertido, scope (core/vertical/cross-vertical)
-  **Objetivo enterprise:** Funcionalidad implementada y impacto multi-vertical
-  **Rama de trabajo:** Estrategia de branching por contexto
-  **Modelos utilizados:** Especialistas involucrados y sus roles específicos
-  **Verticales afectados:** Lista de verticales impactados directa o indirectamente

#### **CAMBIOS IMPLEMENTADOS MULTI-VERTICAL:**
- **Core Universal:** APIs, servicios, modelos, event bus modificados
- **Vertical Específico:** Funcionalidades, APIs, frontend, reglas de negocio
- **Base de Datos:** Esquemas, migraciones, índices por vertical y core
- **Frontend/Micro-Frontends:** Componentes, rutas, integración desarrollados
- **Testing:** Unit, integration, e2e tests generados por capa
- **CI/CD:** Pipelines, workflows, deployment manifests actualizados
- **Documentación:** Archivos auto-actualizados por vertical y core

#### **DECISIONES TÉCNICAS ENTERPRISE:**
- **Arquitecturales:** Patrones aplicados, trade-offs considerados
- **Multi-Tenancy:** Decisiones de diseño para múltiples clientes
- **Performance:** Optimizaciones aplicadas, métricas mejoradas
- **Seguridad:** Medidas implementadas, compliance considerado
- **Escalabilidad:** Capacidad de crecimiento, recursos considerados
- **Integración:** Estrategias de comunicación entre verticales

#### **🔧 PROBLEMAS Y SOLUCIONES ENTERPRISE:**
- **Desafíos cross-vertical:** Conflictos entre verticales y resolución
- **Complejidad técnica:** Problemas de integración y soluciones aplicadas
- **Performance issues:** Bottlenecks identificados y optimizaciones
- **Aprendizajes:** Conocimiento adquirido para futuras iteraciones

#### **📊 MÉTRICAS ENTERPRISE:**
- **Desarrollo:** Commits, archivos modificados, LOC agregadas/eliminadas
- **Testing:** Coverage por capa, tests creados, tests automatizados
- **Performance:** Mejoras en latencia, throughput, resource usage
- **Calidad:** Code quality score, complexity metrics, technical debt
- **Deployment:** Success rate, rollback procedures, downtime

#### **VALIDACIONES ENTERPRISE:**
- **Funcionalidad:** Tests unitarios, integración, e2e por vertical
- **Cross-Vertical:** Validación de integración entre verticales
- **Performance:** Load testing, stress testing por vertical
- **Seguridad:** Security scans, compliance validation
- **Documentación:** Consistencia, completitud, actualización automática
- **Deployment:** Staging validation, rollback procedures tested

#### **PRÓXIMOS PASOS Y ROADMAP:**
- **Inmediatos:** Tareas pendientes para completar la funcionalidad
- **Corto plazo:** Optimizaciones y mejoras planificadas
- **Mediano plazo:** Nuevos verticales o características planificadas
- **Dependencias:** Bloqueos identificados y estrategias de resolución

---

## CHECKLISTS ENTERPRISE

### **CHECKLIST DE INICIO DE SESIÓN ENTERPRISE:**

#### **ANTES DE EMPEZAR (Preparación Multi-Vertical):**
- [ ] Verificar estado del repositorio enterprise (`git status`, revisar múltiples ramas)
- [ ] Actualizar rama develop (`git pull origin develop`)
- [ ] **ENTERPRISE:** Validar 5 modelos especializados activos en Continue
- [ ] **ENTERPRISE:** Revisar contexto maestro multi-vertical actualizado
- [ ] **ENTERPRISE:** Verificar estado de todos los verticales activos
- [ ] Revisar últimas iteraciones por vertical y core documentadas
- [ ] Leer pendientes de iteración anterior (core y verticales)
- [ ] Definir objetivo claro y alcance (core/vertical/cross-vertical)
- [ ] **ENTERPRISE:** Validar entornos de deployment disponibles
- [ ] **ENTERPRISE:** Revisar métricas de performance y salud del sistema

#### **DURANTE LA SESIÓN (Desarrollo Multi-Vertical):**
- [ ] **ENTERPRISE:** Usar comandos especializados por contexto (`/implementar-core-feature`, `/implementar-vertical`)
- [ ] **AUTOMÁTICO ENTERPRISE:** Validar documentación auto-actualizada multi-vertical
- [ ] Hacer commits incrementales frecuentes por contexto (o dejar que el modelo los proponga)
- [ ] Documentar decisiones técnicas enterprise importantes
- [ ] Probar funcionalidad conforme se desarrolla (unit, integration, e2e)
- [ ] **ENTERPRISE:** Validar impacto cross-vertical de cambios
- [ ] **ENTERPRISE:** Verificar compliance y seguridad según el vertical

#### **AL FINALIZAR LA SESIÓN (Cierre Enterprise):**
- [ ] **AUTOMÁTICO ENTERPRISE:** Archivo de iteración generado por contexto
- [ ] **AUTOMÁTICO ENTERPRISE:** Documentación actualizada y validada multi-vertical
- [ ] Hacer push de la rama de trabajo con naming convention enterprise
- [ ] Hacer merge a develop si la funcionalidad está completa y validada
- [ ] **ENTERPRISE:** Verificar evolución del contexto maestro multi-vertical
- [ ] **ENTERPRISE:** Actualizar métricas de tracking enterprise
- [ ] **ENTERPRISE:** Validar deployment readiness si aplica
- [ ] Definir pendientes para próxima sesión (core/vertical/cross-vertical)
### **CHECKLIST DE FINALIZACIÓN DE FUNCIONALIDAD ENTERPRISE:**

#### **AUTOMÁTICO CON MODELOS ESPECIALIZADOS ENTERPRISE:**
- **Funcionalidad implementada multi-vertical** - Por modelos especializados según contexto
- **Tests generados multi-capa** - Unit, integration, e2e por vertical y core automáticamente
- **Documentación actualizada cross-vertical** - Auto-sincronizada por todos los contextos afectados
- **Casos de uso documentados por vertical** - Agregados automáticamente en archivos correspondientes
- **Contexto maestro evolucionado enterprise** - Con información esencial cross-vertical
- **Commits estructurados enterprise** - Propuestos por el modelo con naming conventions
- **Deployment artifacts preparados** - Docker, K8s, Terraform por vertical y entorno
- **CI/CD pipelines actualizados** - Workflows por vertical y core según impacto

#### **VALIDACIÓN MANUAL ENTERPRISE:**
- [ ] Funcionalidad probada manualmente en vertical correspondiente
- [ ] Integración cross-vertical validada si aplica
- [ ] Performance testing ejecutado según SLA del vertical
- [ ] Security scanning completado según compliance requerido
- [ ] Revisión de código generado por arquitecto senior
- [ ] Validación de documentación actualizada multi-vertical
- [ ] Aprobación de cambios arquitecturales enterprise
- [ ] Deployment readiness validation por entorno

---

## PATRONES DE TRABAJO ENTERPRISE OPTIMIZADOS

### **SESIONES MICRO (30min-1hora):**
```bash
/fix-vertical-issue "Issue específico" --vertical=restaurant
```
- **Foco:** Corrección rápida específica de un vertical
- **Estrategia:** Comando específico con validación automática
- **Output:** Fix aplicado + documentación actualizada + tests validados

### **SESIONES CORTAS (1-2 horas):**
```bash
/implementar-vertical-feature "Funcionalidad específica" --vertical=hotel
```
- **Foco:** Una característica específica de un vertical
- **Estrategia:** Comando específico con documentación auto-actualizada
- **Output:** Funcionalidad completa + docs sincronizadas + deployment ready

### **SESIONES MEDIAS (3-4 horas):**
```bash
/implementar-core-feature "Funcionalidad core que afecta múltiples verticales"
/validate-cross-vertical-impact  # Validar impacto
```
- **Foco:** Funcionalidad core con impacto multi-vertical
- **Estrategia:** Implementación core + validación cross-vertical
- **Output:** Core evolucionado + documentación cross-vertical + verticales actualizados

### **SESIONES LARGAS (día completo):**
```bash
/implementar-vertical "Nuevo vertical completo" --vertical=healthcare
/analizar-cross-vertical-impact
/validate-enterprise-architecture
```
- **Foco:** Nuevo vertical completo o evolución arquitectural mayor
- **Estrategia:** Desarrollo completo + validación enterprise + documentación expandida
- **Output:** Vertical funcional + arquitectura evolucionada + documentación completa

### **SESIONES SPRINT (2-3 días):**
```bash
/enterprise-evolution-sprint "Evolución mayor de plataforma"
# Incluye: múltiples verticales + core + infraestructura + documentación
```
- **Foco:** Evolución enterprise mayor con múltiples componentes
- **Estrategia:** Planificación arquitectural + implementación por fases + validación integral
- **Output:** Plataforma evolucionada + documentación enterprise + deployment strategies

---

## MÉTRICAS AUTO-GESTIONADAS ENTERPRISE

### **El sistema rastrea automáticamente por contexto:**
- **Casos de uso por vertical:** Cantidad, complejidad, cobertura evolutiva
- **APIs por dominio:** Endpoints core vs vertical, documentación OpenAPI
- **Performance multi-vertical:** Latencia, throughput, resource usage por vertical
- **Consistencia cross-vertical:** Score de coherencia entre verticales y core
- **Evolución enterprise:** Versiones del contexto maestro, adoption rate
- **Deployment success rate:** Por vertical, entorno, y estrategia
- **Security compliance:** Score por vertical según estándares (PCI DSS, HIPAA, etc.)
- **Code quality:** Complexity, maintainability, technical debt por componente

### **Dashboards en tiempo real enterprise:**
- **Principal:** `docs/llm-integration/TRACKING_EVOLUCION.md`
- **Por vertical:** `docs/iteraciones/DASHBOARD_[VERTICAL].md`
- **Performance:** `docs/monitoring/PERFORMANCE_DASHBOARD.md`
- **Security:** `docs/monitoring/SECURITY_DASHBOARD.md`

---

## HERRAMIENTAS ESENCIALES ENTERPRISE

### **Comandos de Modelos Especializados Enterprise:**
```bash
# Desarrollo principal multi-vertical
/implementar-core-feature "descripción"
/implementar-vertical "descripción" --vertical=[vertical]
/implementar-cross-vertical "descripción"
/actualizar-documentacion
/validate-enterprise-consistency

# Análisis especializado enterprise
/analizar-core-architecture
/analizar-vertical-architecture --vertical=[vertical]
/revisar-enterprise-security  
/validar-cross-vertical-usecase
/optimizar-enterprise-performance
/audit-compliance --standard=pci-dss|hipaa|gdpr

# Deployment y operaciones
/deploy-vertical --vertical=[vertical] --environment=[env]
/health-check-enterprise
/rollback-vertical --vertical=[vertical] --version=[version]

# Utilidades enterprise
/intellicore-contexto
/vertical-status
/enterprise-docs
/enterprise-evolucionar
```

### **Comandos Git Enterprise (cuando sea necesario):**
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
```bash
# Para casos complejos enterprise donde necesites control manual
git status
git branch --all  # Ver todas las ramas por vertical
git checkout -b feature/core-nueva-funcionalidad          # Para core
git checkout -b feature/restaurant-nueva-funcionalidad    # Para restaurant
git checkout -b feature/cross-vertical-nueva-funcionalidad # Para cross-vertical
git merge feature/[contexto]-nueva-funcionalidad
```

### **Scripts del proyecto enterprise:**
```bash
# Cuando estén disponibles
npm run dev                           # Desarrollo local completo
npm run dev:core                      # Solo core universal
npm run dev:restaurant                # Solo vertical restaurant + core
npm run test                          # Tests automatizados completos
npm run test:core                     # Tests solo del core
npm run test:vertical -- --vertical=restaurant  # Tests de vertical específico
npm run docs:validate                 # Validar documentación enterprise
npm run evolution:status              # Estado de evolución multi-vertical
npm run deploy:staging -- --vertical=restaurant  # Deploy vertical a staging
npm run health-check                  # Health check enterprise completo
```

---

## INICIO RÁPIDO PARA NUEVA SESIÓN ENTERPRISE

### **Flujo mínimo recomendado enterprise:**
```bash
# 1. Verificar estado multi-vertical
git status
git pull origin develop
/vertical-status  # Estado de todos los verticales

# 2. Revisar contexto enterprise
/intellicore-contexto  # Contexto maestro multi-vertical

# 3. Seleccionar tipo de desarrollo
## Para funcionalidad CORE universal:
/implementar-core-feature "Tu nueva funcionalidad core aquí"

## Para funcionalidad VERTICAL específica:
/implementar-vertical-feature "Tu funcionalidad específica aquí" --vertical=restaurant

## Para NUEVO VERTICAL completo:
/implementar-vertical "Nuevo vertical completo" --vertical=healthcare

## Para funcionalidad CROSS-VERTICAL:
/implementar-cross-vertical "Funcionalidad que afecta múltiples verticales"

# 4. Validar resultado enterprise
/validate-enterprise-consistency

# 5. Merge si todo está bien
git merge feature/[core|vertical|cross-vertical]-[nombre-generado]
```

### **Flujo ultra-rápido para desarrollo específico:**
```bash
# Para desarrollo CORE:
/implementar-core-feature "Descripción" && /validate-enterprise-consistency

# Para desarrollo VERTICAL:
/implementar-vertical-feature "Descripción" --vertical=restaurant && /validate-enterprise-consistency

# Para nuevo VERTICAL:
/implementar-vertical "Descripción completa" --vertical=services && /enterprise-docs

# Para deployment:
/deploy-vertical --vertical=restaurant --environment=staging
```

**¡Listo!** Con este flujo enterprise tienes implementación multi-vertical + documentación cross-vertical + validación automática + deployment readiness.

---

## CONCLUSIÓN ENTERPRISE

**Esta guía actualizada debe ser consultada al inicio de cada sesión de desarrollo para mantener consistencia y productividad máxima en la plataforma IntelliCore POS multi-vertical con la potencia de modelos locales especializados enterprise.**

### **Beneficios Clave de la Metodología AEDD Enterprise:**

#### **Productividad Exponencial:**
- **Desarrollo 10x más rápido:** Comandos únicos que implementan funcionalidades completas
- **Documentación automática:** 0 tiempo invertido en documentación manual
- **Testing automático:** Tests comprehensivos generados automáticamente
- **Deployment readiness:** Artifacts de deployment preparados automáticamente

#### **Arquitectura Enterprise Robusta:**
- **Multi-vertical escalable:** Core + Verticales modulares
- **Multi-tenancy nativo:** Diseño para múltiples clientes desde el inicio
- **Microservicios inteligentes:** Comunicación optimizada entre servicios
- **Cloud-native:** Deployment automático en múltiples nubes

#### **Documentación Viva Enterprise:**
- **Auto-sincronización:** Documentación siempre actualizada
- **Cross-vertical consistency:** Coherencia entre todos los verticales
- **Knowledge evolution:** Sistema que aprende y mejora continuamente
- **Zero documentation debt:** Eliminación completa de deuda de documentación

#### **Seguridad y Compliance:**
- **Security by design:** Seguridad integrada desde el desarrollo
- **Compliance automático:** Validación automática por estándares
- **Audit ready:** Trazabilidad completa de cambios y decisiones
- **Multi-vertical security:** Seguridad específica por industria

#### **Métricas y Observabilidad:**
- **Real-time insights:** Métricas en tiempo real por vertical
- **Predictive analytics:** Análisis predictivo de performance
- **ROI tracking:** Seguimiento de retorno de inversión por vertical
- **Evolution metrics:** Métricas de evolución de la plataforma

### **Próximos Pasos Recomendados:**

1. **Implementar primer vertical completo** usando `/implementar-vertical`
2. **Configurar modelos especializados** según `CONTINUE_CONFIG_OPTIMIZADA.md`
3. **Establecer CI/CD enterprise** con deployment por vertical
4. **Configurar monitoring y observabilidad** por vertical y core
5. **Entrenar equipo** en comandos especializados AEDD

**¡Comienza tu próxima sesión enterprise y experimenta el poder de la metodología AEDD para plataformas multi-verticales!**
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
