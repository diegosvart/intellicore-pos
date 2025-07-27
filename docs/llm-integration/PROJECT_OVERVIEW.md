# PROJECT OVERVIEW - IntelliCore POS | Información Fundamental del Proyecto

## 🎯 ¿QUÉ ES INTELLICORE POS?

**IntelliCore POS** es una **plataforma empresarial multi-vertical** de punto de venta que trasciende el concepto tradicional de POS. No es solo software de facturación, sino una plataforma inteligente completa que se adapta a diferentes industrias.

### **DIFERENCIADORES ÚNICOS**
- **Multi-Vertical:** Un solo sistema que sirve a Restaurant, Hotel, Retail, Services y Healthcare
- **QR Self-Service Nativo:** Experiencia completa sin dependencias externas 
- **Split Billing Inteligente:** Pagos compartidos automáticos en mesa
- **ML Engine Integrado:** Recomendaciones y analytics predictivos desde día 1
- **Customer Journey Completo:** Trazabilidad total del cliente a través de todos los puntos de contacto

### **ARQUITECTURA CONCEPTUAL**
```
IntelliCore (NÚCLEO UNIVERSAL)
├── Autenticación & Multi-Tenancy
├── Motor de Pagos Universal
├── QR Self-Service
├── ML Engine & Analytics
├── Customer Management
└── Dashboard Ejecutivo

VERTICALES (MÓDULOS ESPECIALIZADOS)
├── Restaurant → Mesas, menús, cocina, meseros
├── Hotel → Habitaciones, reservas, check-in/out
├── Retail → Inventario, productos, POS tradicional  
├── Services → Citas, profesionales, calendarios
└── Healthcare → Pacientes, consultas, expedientes
```

## 📋 ESTADO ACTUAL DEL PROYECTO

### **IMPLEMENTACIÓN ACTUAL (Restaurant Vertical)**
✅ **Sistema Base Funcionando:**
- Core de autenticación y multi-tenancy
- QR Self-Service básico implementado  
- Split billing funcional
- Dashboard analytics operativo
- APIs REST completas para restaurant

✅ **Casos de Uso Operativos:**
- CU-R01: QR Self-Service con recomendaciones ML
- CU-R02: Split billing automático en mesa
- CU-R03: Kitchen display system 
- CU-R04: Customer journey tracking

### **EN DESARROLLO ACTIVO**
🔄 **Roadmap Inmediato:**
- Hotel Vertical (Q2 2025)
- Retail Vertical (Q3 2025) 
- Services Vertical (Q4 2025)
- Healthcare Vertical (Q1 2026)

🔄 **Features Core en Expansión:**
- Analytics predictivos avanzados
- Integration APIs para terceros
- Mobile apps nativas
- Multi-tenancy enterprise

## 🛠️ STACK TECNOLÓGICO

### **Backend Enterprise**
- **Framework:** FastAPI (Python 3.11+) con Clean Architecture
- **Base de Datos:** PostgreSQL 15+ con Row-Level Security
- **ORM:** SQLAlchemy + Alembic para migraciones
- **Cache:** Redis para performance y sesiones
- **ML:** Scikit-learn + TensorFlow integrados
- **Testing:** pytest + coverage completo

### **Frontend Universal**
- **Framework:** Angular 17+ con micro-frontends
- **Estado:** NgRx para gestión de estado complejo
- **UI:** Angular Material + responsive design
- **PWA:** Service Workers para experiencia offline
- **Testing:** Jasmine + Karma + E2E automatizado

### **Infraestructura**
- **Containerización:** Docker + Docker Compose
- **Orquestación:** Kubernetes (producción)
- **CI/CD:** GitHub Actions + automated deployment
- **Observabilidad:** Prometheus + Grafana + structured logging
- **Seguridad:** JWT + OAuth2 + PCI DSS compliance

## 🎯 CASOS DE USO PRINCIPALES

### **Restaurant Vertical (IMPLEMENTADO)**
```
FLUJO TÍPICO:
1. Cliente escanea QR en mesa
2. Accede a menú digital con recomendaciones ML
3. Agrega productos al carrito personal
4. Comparte mesa con otros comensales
5. Cada persona paga su parte (split billing)
6. Pedido va automáticamente a cocina
7. Analytics registra todo el customer journey
```

### **Hotel Vertical (EN DESARROLLO)**
```
FLUJO TÍPICO:
1. Huésped recibe QR en check-in
2. Accede a servicios del hotel
3. Ordena room service con menú dinámico
4. Reserva servicios adicionales (spa, tour)
5. Split billing entre huéspedes de la habitación
6. Analytics de ocupación y revenue management
```

### **Cross-Vertical Features**
- **Dashboard Ejecutivo:** KPIs en tiempo real por vertical
- **Customer 360:** Vista unificada del cliente across verticales
- **Inventory Management:** Control de stock universal
- **Financial Reporting:** Reportes consolidados multi-vertical

## 🏗️ ARQUITECTURA TÉCNICA

### **Patrón: Core + Verticales**
```
CORE UNIVERSAL (Shared Services)
├── authentication/     # JWT + OAuth2 + Multi-tenancy
├── payments/          # Payment processing universal
├── customers/         # Customer management 360
├── analytics/         # ML engine + dashboard
├── qr_selfservice/    # QR sistema nativo
└── shared/           # Utils, constants, types

VERTICAL MODULES (Business Logic)
├── restaurant/        # Mesas, menús, cocina
├── hotel/            # Habitaciones, reservas  
├── retail/           # Productos, inventario
├── services/         # Citas, profesionales
└── healthcare/       # Pacientes, consultas
```

### **Base de Datos Multi-Tenancy**
```sql
-- Cada tabla incluye tenant_id para aislamiento
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    tenant_id INTEGER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2),
    vertical VARCHAR(20) -- restaurant, hotel, retail
);

-- Row-Level Security automático
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;
CREATE POLICY tenant_isolation ON productos FOR ALL TO app_role 
    USING (tenant_id = current_setting('app.current_tenant')::INTEGER);
```

## 📊 DIFERENCIADORES COMPETITIVOS

### **vs POS Tradicionales (Square, Toast, etc.)**
- **QR Self-Service nativo** (no solo menú digital)
- **Split billing automático** (no manual)
- **ML engine integrado** (no analytics básicos)
- **Multi-vertical** (no single-industry)
- **Customer journey completo** (no solo transacciones)

### **vs Soluciones QR Básicas**
- **Pago integrado** (no redirección externa)
- **Multi-cliente por mesa** (no 1 QR = 1 persona)
- **Analytics avanzados** (no solo pedidos)
- **Enterprise features** (multi-tenancy, compliance)

## 🔄 METODOLOGÍA DE DESARROLLO

### **AEDD (Auto-Evolutionary Documentation Development)**
El proyecto utiliza una metodología única donde:

1. **Documentación viva:** Se actualiza automáticamente con cada cambio
2. **LLMs especializados:** 5 roles específicos (Arquitecto, Developer, Analista, Seguridad, DevOps)
3. **Iteración continua:** Cada cambio es una iteración documentada
4. **Git workflow integrado:** Preparación automática de entorno
5. **Contexto modular:** Solo se carga información relevante

### **ROLES LLM ESPECIALIZADOS**
- **ARQUITECTO (DeepSeek):** Decisiones arquitecturales, escalabilidad
- **DESARROLLADOR SENIOR (Qwen3):** Implementación, código, testing
- **ANALISTA NEGOCIO (Llama3.1):** Casos de uso, validación funcional
- **ESPECIALISTA SEGURIDAD (Gemma3):** PCI DSS, compliance, vulnerabilidades
- **DEVOPS (Claude-3.5):** Infraestructura, deployment, observabilidad

## 📈 MÉTRICAS Y OBJETIVOS

### **Objetivos Técnicos**
- **Performance:** < 300ms operaciones críticas
- **Uptime:** > 99.5% disponibilidad
- **Escalabilidad:** 10,000+ usuarios concurrentes
- **Seguridad:** PCI DSS Level 1 compliance

### **Objetivos de Negocio**
- **ROI Cliente:** < 6 meses recuperación inversión
- **Ticket Promedio:** +25% vs POS tradicional
- **Eficiencia Operativa:** -15% costos personal
- **Customer Experience:** NPS > 8.5/10

## 🚀 ROADMAP 2025-2026

### **Q2 2025: Hotel Vertical**
- Sistema de reservas con overbooking
- Room service QR + split billing
- Housekeeping management
- Revenue management analytics

### **Q3 2025: Retail Vertical**
- POS tradicional + QR self-checkout
- Inventory management multi-tienda
- Customer loyalty programs
- Promotion engine

### **Q4 2025: Services Vertical**
- Appointment scheduling
- Professional management
- Service delivery tracking
- Customer feedback loops

### **Q1 2026: Healthcare Vertical**
- Patient management system
- Medical records integration
- Appointment + billing
- HIPAA compliance

## 💡 PRÓXIMOS PASOS PARA NUEVOS USUARIOS

### **Si eres Desarrollador:**
1. Lee `DEPENDENCIAS.md` para entender el stack completo
2. Revisa `PATRONES_CODIGO.md` para templates obligatorios
3. Usa `/start-session vertical "descripción"` para implementar

### **Si eres Analista/Product:**
1. Lee `CASOS_USO_DETALLADOS.md` para entender funcionalidades
2. Revisa `ESPECIALIZACIONES.md` para roles y responsabilidades  
3. Usa `/start-session architecture "análisis específico"`

### **Si eres DevOps/Infraestructura:**
1. Revisa `DEPENDENCIAS.md` para stack de infraestructura
2. Consulta `TESTING_PROTOCOLS.md` para estrategias de deployment
3. Usa `/start-session deployment "configuración específica"`

---

## 🎯 RESUMEN EJECUTIVO

**IntelliCore POS** es una plataforma empresarial que redefine el concepto de POS tradicional. Con arquitectura multi-vertical, QR self-service nativo y ML integrado, ofrece una solución completa que se adapta a cualquier industria mientras mantiene un core universal robusto.

**Estado actual:** Restaurant vertical operativo, otros verticales en desarrollo activo.
**Metodología:** AEDD con LLMs especializados para desarrollo iterativo inteligente.
**Objetivo:** Convertirse en la plataforma de referencia para comercio inteligente multi-vertical.

**Para comenzar cualquier trabajo en este proyecto, usa el Navigator con `/start-session [tipo] [descripción]` que te guiará automáticamente al contexto correcto.**
