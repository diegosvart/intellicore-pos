# CONTEXTO DEL PROYECTO - IntelliCore POS

## INFORMACIÓN AUTOMÁTICA PARA MODELOS LLM

### **Proyecto Base**
- **Nombre completo:** IntelliCore POS - Sistema de Punto de Venta Inteligente
- **Sector:** Retail PyMEs (Pequeñas y Medianas Empresas)
- **Alcance:** Multi-tienda con administración centralizada

### **Stack Tecnológico Completo**
```
BACKEND:
- Framework: FastAPI (Python 3.11+)
- ORM: SQLAlchemy con Alembic
- Validación: Pydantic models
- Testing: pytest + pytest-asyncio
- Autenticación: JWT + OAuth2

FRONTEND:
- Framework: Angular 17+
- Estado: NgRx para gestión de estado
- UI: Angular Material + CSS Grid
- Testing: Jasmine + Karma

BASE DE DATOS:
- Principal: PostgreSQL 15+
- Cache: Redis para sesiones
- Analytics: Extensiones PostgreSQL

INFRAESTRUCTURA:
- Contenedores: Docker + Docker Compose
- Orquestación: Kubernetes (producción)
- CI/CD: GitHub Actions
- Monitoreo: Prometheus + Grafana
```

### **Arquitectura Detallada**
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   FRONTEND      │    │    BACKEND      │    │  BASE DE DATOS  │
│   (Angular)     │◄──►│   (FastAPI)     │◄──►│  (PostgreSQL)   │
├─────────────────┤    ├─────────────────┤    ├─────────────────┤
│ • Componentes   │    │ • Controllers   │    │ • Esquemas      │
│ • Servicios     │    │ • Services      │    │ • Índices       │
│ • Guards        │    │ • Repositories  │    │ • Triggers      │
│ • Interceptors  │    │ • Models        │    │ • Vistas        │
│ • NgRx Store    │    │ • Middlewares   │    │ • Funciones     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### **Casos de Uso Implementados/Planificados**
1. **CU-001: Registro de Ventas** - Transacciones completas con múltiples métodos de pago
2. **CU-002: Gestión de Inventario** - Stock en tiempo real, alertas, reposición automática
3. **CU-003: Analytics de Ventas** - Reportes, métricas, dashboards para toma de decisiones
4. **CU-004: Gestión de Clientes** - Perfiles, historial, programas de fidelización
5. **CU-005: Configuración Multi-tienda** - Administración centralizada, sincronización

### **Reglas de Negocio Implementadas**
- **Transacciones atómicas:** Rollback automático en caso de error
- **Auditoría completa:** Log de todas las operaciones críticas
- **Performance objetivo:** <500ms para operaciones de venta
- **Seguridad PCI DSS:** Cifrado de datos financieros, tokenización
- **Escalabilidad horizontal:** Soporte para crecimiento multi-tienda

### **Estructura de Directorios del Proyecto**
```
intellicore-pos/
├── backend/
│   ├── src/
│   │   ├── api/          # Endpoints REST
│   │   ├── models/       # SQLAlchemy models
│   │   ├── services/     # Lógica de negocio
│   │   └── analytics/    # Módulos de análisis
│   └── tests/
├── frontend/
│   ├── src/
│   │   ├── app/         # Componentes Angular
│   │   ├── models/      # TypeScript interfaces
│   │   ├── services/    # Servicios HTTP
│   │   └── analytics/   # Componentes de reportes
│   └── tests/
├── database/
│   ├── schemas/         # DDL y estructura
│   ├── migrations/      # Alembic migrations
│   └── seeds/          # Datos iniciales
├── docs/
│   ├── llm-documentation/  # Documentación para LLMs
│   ├── api/               # Documentación OpenAPI
│   └── architecture/      # Diagramas y especificaciones
└── infrastructure/
    ├── docker/           # Dockerfiles y configs
    ├── kubernetes/       # Manifiestos K8s
    └── aws/             # Configuración cloud
```

### **APIs Principales Disponibles**
```
VENTAS:
POST /api/v1/ventas/           # Crear nueva venta
GET  /api/v1/ventas/{id}       # Obtener venta específica
GET  /api/v1/ventas/           # Listar ventas con filtros

PRODUCTOS:
GET  /api/v1/productos/        # Catálogo de productos
PUT  /api/v1/productos/{id}    # Actualizar producto
POST /api/v1/productos/stock   # Actualizar inventario

CLIENTES:
GET  /api/v1/clientes/         # Gestión de clientes
POST /api/v1/clientes/         # Registrar nuevo cliente

ANALYTICS:
GET  /api/v1/analytics/ventas  # Reportes de ventas
GET  /api/v1/analytics/stock   # Análisis de inventario
```

### **Base de Datos - Tablas Principales**
```sql
-- Estructura simplificada para contexto
TABLAS CRÍTICAS:
- ventas: transacciones principales
- items_venta: detalle de productos vendidos
- productos: catálogo y stock
- clientes: información de compradores
- tiendas: configuración multi-tienda
- usuarios: sistema de autenticación
- auditoria: log de todas las operaciones
```

### **Configuración de Desarrollo**
```bash
# Comandos principales del proyecto
npm run dev          # Desarrollo frontend
npm run api:dev      # Desarrollo backend
npm run db:migrate   # Aplicar migraciones
npm run test        # Ejecutar tests
npm run build       # Build de producción
```

---

## INSTRUCCIONES ESPECÍFICAS PARA LLMs

### **Al analizar código:**
1. **Considera siempre** el contexto POS y las reglas de negocio críticas
2. **Evalúa performance** con objetivo <500ms para operaciones críticas
3. **Verifica seguridad** especialmente en manejo de datos financieros
4. **Mantén consistencia** con la arquitectura Clean + SOLID establecida

### **Al proponer cambios:**
1. **Justifica arquitecturalmente** cualquier modificación significativa
2. **Considera impacto** en múltiples tiendas y escalabilidad
3. **Preserva** atomicidad de transacciones y auditoría
4. **Incluye tests** apropiados para cualquier nueva funcionalidad

### **Al documentar:**
1. **Actualiza** casos de uso si la funcionalidad es nueva
2. **Mantén sincronización** entre código y documentación
3. **Sigue convenciones** establecidas en el proyecto
4. **No uses íconos/emojis** para optimizar tokens

---

**Última actualización:** 2025-07-24 | **Propósito:** Contexto automático para modelos LLM | **Estado:** Activo
