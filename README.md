# IntelliCore POS - Plataforma de Punto de Venta Inteligente y Adaptable

## Descripción del Proyecto

IntelliCore POS es una **plataforma de punto de venta modular e inteligente** que se adapta a cualquier vertical de negocio. Utiliza una arquitectura de "Core + Verticales" donde un núcleo inteligente (IntelliCore) orquesta funcionalidades específicas por industria.

**Diferenciadores clave:**
- **Multi-vertical:** Restaurantes, hoteles, retail, servicios, clínicas
- **QR Self-Service nativo:** No solo menú digital, experiencia completa
- **Split Billing inteligente:** Múltiples pagadores automático
- **ML integrado:** Recomendaciones y analytics predictivos
- **Customer Journey tracking:** Trazabilidad completa del cliente

----------------------------------------------------------

## Arquitectura: Core + Verticales

### IntelliCore (Núcleo Inteligente)
- **Gestión universal:** Clientes, usuarios, pagos, inventario base
- **ML Engine:** Recomendaciones, predicciones, analytics
- **QR Self-Service:** Sistema universal de auto-atención
- **Split Billing:** División inteligente de pagos
- **Event Bus:** Comunicación entre verticales
- **Dashboard Analytics:** KPIs en tiempo real

### Verticales de Negocio (Plugins Especializados)
- **Restaurant Vertical:** Mesas, cocina, meseros, menú gastronómico
- **Hotel Vertical:** Habitaciones, huéspedes, servicios, check-in/out
- **Retail Vertical:** Productos, inventario, puntos de venta físicos
- **Services Vertical:** Citas, profesionales, tiempo de servicio
- **Healthcare Vertical:** Pacientes, consultas, tratamientos

----------------------------------------------------------

## Stack Tecnológico

### Backend (IntelliCore + Verticales)
- **Framework:** FastAPI (Python 3.11+) con arquitectura modular
- **ORM:** SQLAlchemy + Alembic para migraciones
- **Validación:** Pydantic models con validación automática
- **ML:** Scikit-learn + TensorFlow para recomendaciones
- **Cache:** Redis para sesiones y performance
- **Testing:** pytest + pytest-asyncio

### Frontend Universal
- **Framework:** Angular 17+ con micro-frontends
- **Estado:** NgRx para gestión de estado complejo
- **UI:** Angular Material + CSS Grid responsivo
- **PWA:** Service Workers para offline-first

### Base de Datos Inteligente
- **Principal:** PostgreSQL 15+ con extensiones analytics
- **Estructura:** Schema por vertical + core compartido
- **Analytics:** Triggers automáticos para ML features

----------------------------------------------------------

## Guía de Desarrollo por Módulo (Plugin)

Cada módulo representa un flujo funcional. La siguiente es la guía de desarrollo para agregar/modificar un plugin:

### Paso 1: Definición del Plugin

Ejemplo:
- Nombre: `flujo-pedidos`
- Descripción: Permite al mesero registrar pedidos y enviarlos a cocina.
- Responsable: `equipo-pedidos`


### Paso 2: Especificación de Casos de Uso

## Casos de Uso por Vertical

### Restaurant Vertical (Implementación Actual)
- CU-R01: QR Self-Service con recomendaciones ML
- CU-R02: Split billing automático en mesa de múltiples personas
- CU-R03: Kitchen display system con tiempos optimizados
- CU-R04: Customer journey desde QR hasta entrega

### Hotel Vertical (Roadmap)
- CU-H01: Check-in/out vía QR con upselling inteligente
- CU-H02: Room service con pedidos multi-huésped
- CU-H03: Gestión de amenities y servicios adicionales
- CU-H04: Analytics de ocupación y revenue management

### Retail Vertical (Roadmap)
- CU-RT01: POS tradicional con recomendaciones ML
- CU-RT02: Inventory management multi-tienda
- CU-RT03: Customer loyalty con analytics predictivos
- CU-RT04: Self-checkout con QR y anti-fraud

### Services Vertical (Roadmap)
- CU-S01: Gestión de citas con optimización de tiempo
- CU-S02: Payment splitting para servicios grupales
- CU-S03: Professional scheduling con analytics
- CU-S04: Customer feedback loop automatizado

### Paso 3: Diseño de Base de Datos

Cada módulo puede usar un esquema separado o compartir tablas.

### Paso 4: Diseño de API REST

POST /pedidos
GET /pedidos/{id}
PUT /pedidos/{id}/estado

Documentadas automáticamente con Swagger/OpenAPI via FastAPI
Seguridad con Depends(auth_guard)

### Paso 5: Contenedor del Plugin
dockerfile
Copiar
Editar
# plugins/flujo-pedidos/Dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
Asegúrate de que cada plugin sea autónomo y contenedorizable.

### Paso 6: Integración con el Core
Registro en core/registry.py
Suscripción a eventos en core/event_bus.py
Enrutamiento API en core/router.py

### Despliegue en AWS (Free Tier)
Componente	Tecnología	Costo
Backend API	EC2 (t2.micro) o ECS Fargate	Gratis 750 hrs/mes
Frontend Angular	S3 + CloudFront	Gratis 5GB
Base de datos	RDS PostgreSQL t3.micro	750 hrs/mes
Almacenamiento	S3	5GB gratuitos
Logs	CloudWatch	Gratis 5GB logs
Mensajería	ElastiCache Redis (si usas caché)	solo en pago (alternativa: usar Redis local o PubSub en backend)

Recomendación: usa nginx en EC2 para servir Angular en /, y FastAPI bajo /api.

----------------------------------------------------------

## Listado de Plugins a Desarrollar

1. `flujo-ventas` – Registro y procesamiento de pagos
2. `flujo-pedidos` – Registro de pedidos y asignación a mesa
3. `flujo-cocina` – Visualización y gestión de preparación en cocina
4. `flujo-retroalimentacion` – Encuestas post-consumo
5. `flujo-administracion` – Dashboard, analítica, promociones

----------------------------------------------------------

## Definición necesaria para cada plugin

**Aspectos funcionales:**
- Casos de uso
- Roles de usuario involucrados
- Flujo de interacción

**Aspectos conceptuales:**
- Objetivo del módulo
- Relación con otros módulos
- Comportamiento esperado (sincrónico/asíncrono)

**Aspectos técnicos:**
- Modelo de datos
- Endpoints de API
- Esquema de autenticación/autorización
- Subscripción a eventos
- Contenedor Docker
- Pruebas unitarias y de integración
- Esquema de base de datos y migraciones

----------------------------------------------------------

### Estructura del Repositorio

```
intellicore-pos/
├── docs/                                    # DOCUMENTACIÓN AEDD
│   ├── llm-integration/                     # Motor AEDD
│   │   ├── CONTEXTO_MAESTRO.md             # [CORE] Orquestador principal
│   │   ├── CONTINUE_CONFIG_OPTIMIZADA.md   # [CORE] Config modelos LLM
│   │   ├── FLUJO_ITERACION_EVOLUTIVA.md    # [CORE] Metodología auto-evolutiva
│   │   ├── TRACKING_EVOLUCION.md           # [CORE] Métricas y dashboard
│   │   ├── CONTEXTO_PROYECTO.md            # [AUTO] Información base del proyecto
│   │   └── PROMPTS_ITERATIVOS.md           # [AUTO] Biblioteca de prompts
│   ├── llm-documentation/                  # Documentación Expandida
│   │   ├── CASOS_USO_DETALLADOS.md         # [AUTO] Casos de uso evolutivos
│   │   ├── QUERIES_CASOS_USO.sql           # [AUTO] Biblioteca de queries
│   │   ├── DICCIONARIO_COMPLETO.json       # [AUTO] Estructura BD completa
│   │   ├── MODELO_BD_COMPLETO_LLM.md       # [CORE] Modelo optimizado para LLM
│   │   └── GUIA_DESARROLLO_LLM.md          # [CORE] Metodología desarrollo
│   ├── iteraciones/                        # Tracking de Sesiones
│   │   └── ITERACION_YYYY_MM_DD.md         # [AUTO] Logs evolutivos por sesión
│   ├── GUIA_ITERACION_PROYECTO.md          # Puerta de entrada AEDD
│   └── GIT_WORKFLOW_GUIDE.md               # Flujos de trabajo Git
├── core/                                    # INTELLICORE (Núcleo Inteligente)
│   ├── auth/                               # Sistema de autenticación universal
│   │   ├── models.py                       # Modelos de usuario, roles, permisos
│   │   ├── services.py                     # JWT, OAuth2, RBAC
│   │   └── api.py                          # Endpoints de autenticación
│   ├── payments/                           # Motor de pagos universal
│   │   ├── models.py                       # Transacciones, métodos de pago
│   │   ├── split_billing.py               # Split billing inteligente
│   │   └── api.py                          # Endpoints de pagos
│   ├── customers/                          # Gestión universal de clientes
│   │   ├── models.py                       # Cliente, contacto, preferencias
│   │   ├── journey_tracking.py            # Customer journey analytics
│   │   └── api.py                          # CRM endpoints
│   ├── qr_selfservice/                     # QR Self-Service nativo
│   │   ├── models.py                       # Sesiones QR, carritos temporales
│   │   ├── services.py                     # Lógica de auto-atención
│   │   └── api.py                          # Endpoints QR
│   ├── ml_engine/                          # Motor de ML integrado
│   │   ├── recommendations.py              # Sistema de recomendaciones
│   │   ├── analytics.py                    # Predicciones y insights
│   │   └── features.py                     # Feature engineering
│   ├── inventory/                          # Inventario base universal
│   │   ├── models.py                       # Productos, categorías, stock
│   │   ├── services.py                     # Gestión de inventario
│   │   └── api.py                          # Endpoints de inventario
│   ├── analytics/                          # Dashboard y KPIs en tiempo real
│   │   ├── models.py                       # Métricas, reportes, aggregaciones
│   │   ├── real_time.py                    # Streaming analytics
│   │   └── api.py                          # Endpoints de analytics
│   ├── event_bus/                          # Sistema de eventos
│   │   ├── events.py                       # Definición de eventos
│   │   ├── handlers.py                     # Manejadores de eventos
│   │   └── publisher.py                    # Publisher/Subscriber
│   ├── registry/                           # Registro de verticales
│   │   ├── vertical_manager.py             # Gestión de plugins
│   │   └── discovery.py                    # Auto-discovery de verticales
│   ├── database/                           # Configuración BD
│   │   ├── base.py                         # Base models SQLAlchemy
│   │   ├── migrations/                     # Alembic migrations
│   │   └── schemas/                        # Schema por vertical
│   ├── config/                             # Configuración central
│   │   ├── settings.py                     # Variables de entorno
│   │   └── logging.py                      # Configuración de logs
│   └── main.py                             # Aplicación principal FastAPI
├── verticales/                             # VERTICALES DE NEGOCIO (Plugins)
│   ├── restaurant/                         # Vertical Restaurante (Actual)
│   │   ├── models/                         # Modelos específicos restaurant
│   │   │   ├── mesa.py                     # Mesas, sectores, estados
│   │   │   ├── menu.py                     # Menú, platos, ingredientes
│   │   │   ├── cocina.py                   # Kitchen display, preparación
│   │   │   └── servicio.py                 # Eventos de servicio, meseros
│   │   ├── api/                            # Endpoints específicos
│   │   │   ├── mesas.py                    # API gestión de mesas
│   │   │   ├── pedidos.py                  # API pedidos y órdenes
│   │   │   ├── cocina.py                   # API kitchen display
│   │   │   └── menu.py                     # API gestión de menú
│   │   ├── services/                       # Lógica de negocio restaurant
│   │   │   ├── pedidos_service.py          # Flujo de pedidos
│   │   │   ├── cocina_service.py           # Gestión de cocina
│   │   │   └── mesa_service.py             # Control de mesas
│   │   ├── ml/                             # ML específico restaurant
│   │   │   ├── menu_recommendations.py     # Recomendaciones de platos
│   │   │   └── demand_prediction.py        # Predicción de demanda
│   │   ├── frontend/                       # Micro-frontend restaurant
│   │   │   ├── components/                 # Componentes Angular
│   │   │   ├── services/                   # Services específicos
│   │   │   └── pages/                      # Páginas del vertical
│   │   ├── tests/                          # Tests del vertical
│   │   ├── migrations/                     # Migraciones específicas
│   │   ├── config.py                       # Configuración del vertical
│   │   └── main.py                         # Entry point del vertical
│   ├── hotel/                              # Vertical Hotel (Roadmap Q2 2025)
│   │   ├── models/                         # Habitaciones, huéspedes, servicios
│   │   ├── api/                            # Check-in/out, room service
│   │   ├── services/                       # Gestión hotelera
│   │   └── config.py                       # Config hotel vertical
│   ├── retail/                             # Vertical Retail (Roadmap Q3 2025)
│   │   ├── models/                         # Productos, tiendas, ventas
│   │   ├── api/                            # POS tradicional, inventario
│   │   ├── services/                       # Gestión retail
│   │   └── config.py                       # Config retail vertical
│   ├── services/                           # Vertical Servicios (Roadmap Q4 2025)
│   │   ├── models/                         # Citas, profesionales, servicios
│   │   ├── api/                            # Scheduling, appointments
│   │   ├── services/                       # Gestión de servicios
│   │   └── config.py                       # Config services vertical
│   └── healthcare/                         # 🏥 Vertical Healthcare (Roadmap Q4 2025)
│       ├── models/                         # Pacientes, consultas, tratamientos
│       ├── api/                            # Medical records, appointments
│       ├── services/                       # Healthcare workflows
│       └── config.py                       # Config healthcare vertical
├── frontend/                               # FRONTEND UNIVERSAL
│   ├── core-app/                           # Aplicación base Angular
│   │   ├── src/
│   │   │   ├── app/
│   │   │   │   ├── core/                   # Servicios compartidos
│   │   │   │   ├── shared/                 # Componentes compartidos
│   │   │   │   ├── auth/                   # Módulo de autenticación
│   │   │   │   ├── dashboard/              # Dashboard universal
│   │   │   │   └── vertical-loader/        # Cargador de micro-frontends
│   │   │   ├── assets/                     # Recursos estáticos
│   │   │   └── environments/               # Configuraciones por ambiente
│   │   ├── angular.json                    # Configuración Angular
│   │   ├── package.json                    # Dependencias
│   │   └── tsconfig.json                   # TypeScript config
│   ├── micro-frontends/                    # Micro-frontends por vertical
│   │   ├── restaurant-frontend/            # Frontend restaurant
│   │   ├── hotel-frontend/                 # Frontend hotel
│   │   └── retail-frontend/                # Frontend retail
│   └── shared-components/                  # Biblioteca de componentes
│       ├── qr-selfservice/                 # Componentes QR universales
│       ├── split-billing/                  # Componentes de split billing
│       └── analytics-widgets/              # Widgets de analytics
├── infrastructure/                         # INFRAESTRUCTURA Y DESPLIEGUE
│   ├── docker/                             # Contenedores Docker
│   │   ├── docker-compose.yml              # Orquestación local
│   │   ├── docker-compose.prod.yml         # Producción
│   │   ├── Dockerfile.core                 # Container IntelliCore
│   │   ├── Dockerfile.restaurant           # Container restaurant vertical
│   │   └── Dockerfile.frontend             # Container frontend
│   ├── kubernetes/                         # Manifiestos K8s
│   │   ├── core/                           # Deploy IntelliCore
│   │   ├── verticales/                     # Deploy verticales
│   │   └── ingress/                        # Configuración ingress
│   ├── terraform/                          # Infrastructure as Code
│   │   ├── aws/                            # Deploy AWS
│   │   ├── azure/                          # Deploy Azure
│   │   └── gcp/                            # Deploy GCP
│   └── monitoring/                         # Observabilidad
│       ├── prometheus/                     # Métricas
│       ├── grafana/                        # Dashboards
│       └── elk/                            # Logging centralizado
├── scripts/                                # 🔧 SCRIPTS DE AUTOMATIZACIÓN
│   ├── development/                        # Scripts desarrollo
│   │   ├── setup.sh                        # Setup entorno local
│   │   ├── run-tests.sh                    # Ejecutar tests
│   │   └── generate-docs.sh                # Generar documentación
│   ├── deployment/                         # Scripts despliegue
│   │   ├── deploy-aws.sh                   # Deploy a AWS
│   │   ├── deploy-local.sh                 # Deploy local
│   │   └── backup-db.sh                    # Backup base de datos
│   └── maintenance/                        # Scripts mantenimiento
│       ├── cleanup.sh                      # Limpieza de recursos
│       └── health-check.sh                 # Health checks
├── tests/                                  # TESTS INTEGRALES
│   ├── integration/                        # Tests de integración
│   ├── e2e/                                # Tests end-to-end
│   ├── performance/                        # Tests de performance
│   └── security/                           # Tests de seguridad
├── .github/                                # CI/CD GITHUB ACTIONS
│   ├── workflows/                          # Workflows automáticos
│   │   ├── ci.yml                          # Continuous Integration
│   │   ├── cd.yml                          # Continuous Deployment
│   │   └── security-scan.yml               # Security scanning
│   └── ISSUE_TEMPLATE/                     # Templates de issues
├── .gitignore                              # Git ignore rules
├── .env.example                            # Variables de entorno ejemplo
├── requirements.txt                        # Dependencias Python core
├── pyproject.toml                          # Configuración proyecto Python
├── docker-compose.yml                      # Orquestación desarrollo
├── README.md                               # Documentación principal
└── LICENSE                                 # Licencia del proyecto
```

----------------------------------------------------------

🔐 Seguridad
JWT + OAuth2 con FastAPI
Guardias en Angular por módulo
Autorización RBAC a nivel de endpoint y componentes

----------------------------------------------------------

### 🧪 Pruebas
bash
Copiar
Editar
# backend
pytest plugins/flujo-pedidos/tests/

# frontend
ng test

----------------------------------------------------------

📦 Extensiones futuras (en backlog)
📲 App móvil con Ionic (Angular) para meseros
🔄 WebSockets para pedidos en tiempo real
📈 Panel BI con Metabase (free)
📤 Exportación de reportes a PDF

----------------------------------------------------------

🧭 ¿Cómo contribuir?
Clona el repositorio
Crea un nuevo módulo en plugins/
Sigue la plantilla del módulo
Ejecuta docker-compose up para levantar entorno de test
Crea un PR y documenta tu feature

----------------------------------------------------------

## Diferenciadores vs Competencia

### Capacidades Únicas
- **QR Self-Service nativo:** No solo menú digital, experiencia completa
- **Split Billing automático:** Sin intervención manual
- **ML integrado:** Recomendaciones desde día 1
- **Multi-vertical:** Un solo sistema para múltiples negocios
- **Customer Journey:** Trazabilidad completa del cliente
- **Real-time Analytics:** KPIs actualizados en tiempo real

### Ventajas Técnicas
- **Auto-evolutionary documentation:** Documentación que evoluciona sola
- **LLM-assisted development:** Desarrollo asistido con IA
- **Token-optimized:** Arquitectura optimizada para eficiencia
- **Plugin-first:** Extensibilidad desde el diseño

----------------------------------------------------------

### DESPLIEGUE OPTIMIZADO PARA CAPA GRATUITA AWS
Arquitectura de Demo Optimizada:

## Despliegue en AWS (Capa Gratuita Optimizada)

### **Estrategia de Demo Multi-Vertical**
Para presentaciones y demos, IntelliCore POS está optimizado para usar **100% recursos gratuitos** de AWS durante el primer año.

### **Componentes de la Demo:**

| Componente | Servicio AWS | Límite Gratuito | Uso IntelliCore POS |
|------------|--------------|-----------------|---------------------|
| **Backend API** | EC2 t2.micro | 750 hrs/mes | IntelliCore + 1 Vertical activo |
| **Frontend** | S3 + CloudFront | 5GB + 50GB transferencia | Angular SPA multi-vertical |
| **Base de Datos** | RDS PostgreSQL t3.micro | 750 hrs/mes + 20GB | Schema core + vertical demo |
| **Caché/Redis** | ElastiCache t2.micro | N/A (no gratuito) | **ALTERNATIVA:** Redis en EC2 |
| **Archivos** | S3 | 5GB storage | Imágenes, documentos, logs |
| **CDN** | CloudFront | 50GB transferencia | Distribución global del frontend |
| **Logs** | CloudWatch | 5GB logs/mes | Monitoring y debugging |
| **Dominio** | Route 53 | $0.50/mes | demo.intellicore-pos.com |

### **Configuración Optimizada para Demo:**

#### **1. EC2 Instance (t2.micro) - Backend Consolidado**
```yaml
# docker-compose.demo.yml
version: '3.8'
services:
  intellicore-demo:
    build: 
      dockerfile: infrastructure/docker/Dockerfile.demo
    ports:
      - "80:80"      # Nginx frontend
      - "8000:8000"  # FastAPI backend
    environment:
      - ENV=demo
      - VERTICAL_ACTIVE=restaurant  # Solo restaurant para demo
      - DB_URL=postgresql://user:pass@demo-db.region.rds.amazonaws.com:5432/intellicore
      - REDIS_URL=redis://localhost:6379  # Redis local en EC2
    volumes:
      - ./logs:/app/logs
```

#### **2. RDS PostgreSQL (t3.micro) - Schema Optimizado**
```sql
-- Schema optimizado para demo (reducir consumo)
CREATE DATABASE intellicore_demo;

-- Solo tablas esenciales del core
CREATE SCHEMA core;           -- Usuarios, clientes, pagos básicos
CREATE SCHEMA restaurant;     -- Mesas, menú, pedidos (demo principal)

-- Schemas futuros comentados para demo
-- CREATE SCHEMA hotel;      -- Para demo hotel (futuro)
-- CREATE SCHEMA retail;     -- Para demo retail (futuro)
```

#### **3. Frontend S3 + CloudFront - Multi-Vertical SPA**
```bash
# Compilación optimizada para demo
ng build --configuration=demo --output-path=dist/demo
aws s3 sync dist/demo s3://intellicore-pos-demo
aws cloudfront create-invalidation --distribution-id EDFDVBD6EXAMPLE --paths "/*"
```

### **Arquitectura de Demo:**
```
┌─────────────────────────────────────────────────────────────┐
│                    AWS FREE TIER DEMO                       │
├─────────────────────────────────────────────────────────────┤
│  CloudFront CDN (50GB/mes)                                  │
│  ├── intellicore-pos-demo.com                              │
│  └── Distribución global del frontend Angular              │
├─────────────────────────────────────────────────────────────┤
│  S3 Bucket (5GB)                                           │
│  ├── Frontend Angular compilado                            │
│  ├── Assets estáticos (imágenes, docs)                     │
│  └── Logs de aplicación                                    │
├─────────────────────────────────────────────────────────────┤
│  EC2 t2.micro (750 hrs/mes)                               │
│  ├── Docker: IntelliCore Core + Restaurant Vertical        │
│  ├── Nginx: Proxy reverso (frontend + API)                │
│  ├── Redis: Caché local (en lugar de ElastiCache)         │
│  └── PM2: Process manager para alta disponibilidad        │
├─────────────────────────────────────────────────────────────┤
│  RDS PostgreSQL t3.micro (750 hrs/mes, 20GB)              │
│  ├── Schema: core + restaurant                            │
│  ├── Data demo: 5 mesas, 20 platos, 100 transacciones    │
│  └── Backups automáticos (7 días retención)               │
└─────────────────────────────────────────────────────────────┘
```

### **Scripts de Despliegue Automatizado:**

#### **setup-aws-demo.sh**
```bash
#!/bin/bash
# Script para configurar demo en AWS Free Tier

echo "🚀 Configurando IntelliCore POS Demo en AWS Free Tier..."

# 1. Crear S3 bucket para frontend
aws s3 mb s3://intellicore-pos-demo-$RANDOM
aws s3 website s3://intellicore-pos-demo-$RANDOM --index-document index.html

# 2. Configurar CloudFront distribution
aws cloudfront create-distribution --distribution-config file://aws-cloudfront-config.json

# 3. Lanzar EC2 instance con user-data
aws ec2 run-instances \
  --image-id ami-0abcdef1234567890 \
  --instance-type t2.micro \
  --key-name my-key-pair \
  --security-group-ids sg-903004f8 \
  --user-data file://ec2-user-data.sh

# 4. Crear RDS instance
aws rds create-db-instance \
  --db-instance-identifier intellicore-demo \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --allocated-storage 20 \
  --db-name intellicore_demo

echo "Demo configurado. Accede en 10 minutos a: https://intellicore-pos-demo.com"
```

#### **ec2-user-data.sh**
```bash
#!/bin/bash
# User data script para EC2 instance

# Instalar Docker y dependencias
yum update -y
yum install -y docker git
systemctl start docker
systemctl enable docker

# Instalar Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Clonar repositorio
git clone https://github.com/tu-usuario/intellicore-pos.git /app
cd /app

# Configurar variables de entorno para demo
cp .env.demo .env

# Levantar servicios
docker-compose -f docker-compose.demo.yml up -d

# Configurar Nginx como proxy
cp infrastructure/nginx/demo.conf /etc/nginx/conf.d/
systemctl restart nginx
```

### **Dockerfile.demo (Optimizado)**
```dockerfile
# Multi-stage build para reducir tamaño
FROM node:18-alpine AS frontend-build
WORKDIR /app/frontend
COPY frontend/core-app/package*.json ./
RUN npm ci --only=production
COPY frontend/core-app/ ./
RUN npm run build -- --configuration=demo

FROM python:3.11-slim AS backend
WORKDIR /app
COPY core/ ./core/
COPY verticales/restaurant/ ./verticales/restaurant/
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Nginx para servir frontend + proxy API
FROM nginx:alpine
COPY --from=frontend-build /app/frontend/dist /usr/share/nginx/html
COPY --from=backend /app /app
COPY infrastructure/nginx/demo.conf /etc/nginx/conf.d/default.conf

# Supervisor para manejar múltiples procesos
RUN apk add --no-cache supervisor python3 py3-pip
COPY infrastructure/supervisor/demo.conf /etc/supervisor/conf.d/

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
```

### **Estimación de Costos (Post Free Tier):**

| Componente | Costo Mensual | Observaciones |
|------------|---------------|---------------|
| **EC2 t2.micro** | $8.50/mes | Después de 750 hrs gratuitas |
| **RDS t3.micro** | $13.50/mes | Después de 750 hrs gratuitas |
| **S3 + CloudFront** | $1-3/mes | Dependiendo del tráfico |
| **Route 53** | $0.50/mes | Dominio |
| **TOTAL** | **~$23-25/mes** | Para demo permanente |

### **Estrategia de Demos Múltiples:**

```bash
# Demo Restaurant (Principal)
curl -X POST https://demo.intellicore-pos.com/api/switch-vertical -d '{"vertical": "restaurant"}'

# Demo Hotel (Futuro - mismo EC2)
curl -X POST https://demo.intellicore-pos.com/api/switch-vertical -d '{"vertical": "hotel"}'

# Demo Retail (Futuro - mismo EC2)
curl -X POST https://demo.intellicore-pos.com/api/switch-vertical -d '{"vertical": "retail"}'
```

### **Monitoring Gratuito:**
- **CloudWatch:** 5GB logs gratuitos
- **Uptime monitoring:** StatusCake (gratuito)
- **Error tracking:** Sentry (plan gratuito)
- **Analytics:** Google Analytics (gratuito)



🧑‍💻 Autor
Diego Morales – Arquitecto de Software