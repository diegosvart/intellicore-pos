# IntelliCore POS - Modelo de Datos v3.0
## Documentación Optimizada para LLM

---

## 🎯 **METADATOS DEL MODELO**

- **Versión:** 3.0
- **Tablas:** 25 (base) + 5 (pago distribuido) = 30 total
- **Casos de uso principales:** 4 (Dashboard, Mesero, Cocina, QR Self-Service)
- **Nivel de complejidad:** Enterprise
- **Dominio:** Restaurantes/Bar con QR Self-Service + Analytics
- **Base de datos:** PostgreSQL 15+
- **Fecha creación:** 2025-07-24

---

## 🏗️ **ARQUITECTURA EN CAPAS**

### **CAPA 1: Core Business (Operaciones básicas)**
```
✅ cliente - Gestión de clientes registrados
✅ mesa - Control de mesas y estados  
✅ sector - Organización espacial del establecimiento
✅ usuario - Sistema de roles y permisos
✅ cuenta - Facturación central del negocio
✅ metodo_pago - Formas de pago disponibles
```

### **CAPA 2: Catálogo y Operaciones**
```
✅ comida - Platos del menú con costos
✅ trago - Bebidas con graduación y volumen
✅ receta - Preparaciones con materias primas
✅ materia_prima - Inventario de ingredientes
✅ unidad_medida - Sistema de medidas
✅ cuenta_producto - Detalle de facturación
```

### **CAPA 3: Operaciones Avanzadas**
```
✅ cuenta_cliente - Multi-cliente por mesa
✅ pedido - Flujo hacia cocina
✅ pedido_detalle - Items individuales del pedido
✅ movimiento_inventario - Control de stock
✅ alerta_stock - Notificaciones automáticas
✅ cuenta_corriente - Crédito de clientes
```

### **CAPA 4: QR Self-Service**
```
✅ sesion_qr - Sesiones de autoservicio
✅ evento_servicio - Customer journey tracking
✅ carrito_temporal - Análisis de abandono
✅ metricas_servicio_tiempo_real - Performance en vivo
```

### **CAPA 5: Analytics & ML**
```
✅ agregaciones_analytics - Dashboard metrics
✅ features_ml - Variables para machine learning
✅ metricas_diarias - Consolidación histórica
✅ parametro - Configuraciones del sistema
✅ motivo - Catálogo de razones operativas
```

---

## 🎯 **CASOS DE USO PRINCIPALES**

### **1. Dashboard Gerencial**
**Propósito:** Monitoreo en tiempo real del negocio
**Tablas core:** `cuenta`, `mesa`, `metricas_diarias`, `agregaciones_analytics`
**Features clave:**
- Ventas del día por canal (mesero vs QR)
- Ocupación de mesas en tiempo real
- KPIs de performance (ticket promedio, tiempo servicio)
- Alertas operativas (stock bajo, mesas sin atender)

### **2. Flujo Mesero Tradicional**
**Propósito:** Gestión tradicional de servicio de mesa
**Tablas core:** `mesa`, `cuenta`, `pedido`, `cuenta_cliente`, `cuenta_producto`
**Features clave:**
- Asignación de mesero a mesa
- Toma de pedido multi-cliente
- Envío a cocina con prioridades
- Facturación y pago tradicional

### **3. Flujo Cocina**
**Propósito:** Gestión de preparación y entrega
**Tablas core:** `pedido`, `pedido_detalle`, `receta`, `materia_prima`
**Features clave:**
- Cola de pedidos priorizados
- Control de tiempos de preparación
- Gestión de stock automático
- Notificaciones de platos listos

### **4. QR Self-Service (DIFERENCIADOR)**
**Propósito:** Autoservicio completo con analytics
**Tablas core:** `sesion_qr`, `carrito_temporal`, `evento_servicio`, `features_ml`
**Features clave:**
- Escaneo QR → identificación de mesa
- Navegación de menú con recomendaciones ML
- Carrito con split billing automático
- Pago individual desde móvil
- Tracking completo del customer journey

---

## 💳 **FLUJO DE PAGO DISTRIBUIDO**

### **Problema Resuelto:**
El modelo tradicional permite solo **un pago por cuenta**. El v3.0 soporta **múltiples pagadores** en la misma mesa.

### **Arquitectura de Pago:**
```sql
cuenta (1) → (N) pago_transaccion → (N) pago_detalle_items
         ↓
cuenta_estado_pago (control de completitud)
```

### **Escenarios Soportados:**
1. **Pago Individual:** Cada persona paga sus items
2. **Pago Grupal:** Una persona paga por varias
3. **Pago Mixto:** Combinación de individual + grupal
4. **Split Automático:** División equitativa
5. **Múltiples Métodos:** Efectivo + tarjeta en mismo pago

---

## 📊 **ANALYTICS Y ML INTEGRADO**

### **Real-time Analytics:**
- **evento_servicio:** Cada acción del cliente timestampeada
- **metricas_servicio_tiempo_real:** KPIs calculados en vivo
- **agregaciones_analytics:** Métricas diarias consolidadas

### **Machine Learning Features:**
- **features_ml:** Variables extraídas para modelos predictivos
- **Predicciones habilitadas:**
  - Demanda por hora y día
  - Probabilidad de regreso del cliente  
  - Recomendaciones personalizadas
  - Detección de patrones de abandono

### **Customer Journey Tracking:**
```
QR Scan → Menu View → Category Browse → Item Select → 
Cart Review → Payment Method → Submit → Confirmation → 
Kitchen Preparation → Ready Notification → Delivered
```
*Cada paso trackeado con timestamp y metadata*

---

## 🔧 **CONFIGURACIÓN MODULAR**

### **Sistema de Parámetros:**
La tabla `parametro` permite habilitar/deshabilitar funcionalidades:

```sql
-- Ejemplos de configuración
QR_SELFSERVICE_ENABLED = true
SPLIT_BILLING_ENABLED = true  
ML_RECOMMENDATIONS_ENABLED = true
INVENTORY_AUTO_DEDUCTION = true
REAL_TIME_ANALYTICS = true
```

### **Adaptabilidad por Tipo de Negocio:**
- **Restaurante Básico:** Solo capas 1-2
- **Restaurante Avanzado:** Capas 1-3
- **Restaurante Digital:** Todas las capas (1-5)

---

## 🎯 **DIFERENCIADORES COMPETITIVOS**

### **vs Competencia Tradicional (Square, Toast):**
1. ✅ **QR Self-Service nativo** (no solo menú digital)
2. ✅ **Split billing automático** (pago individual desde móvil)
3. ✅ **Analytics predictivo** (ML integrado desde día 1)
4. ✅ **Customer journey completo** (trazabilidad total)

### **vs Soluciones QR Básicas:**
1. ✅ **Pago integrado** (no redirección externa)
2. ✅ **Multi-cliente por mesa** (no un QR = una persona)
3. ✅ **Analytics avanzado** (no solo pedidos básicos)
4. ✅ **Configurabilidad total** (módulos enable/disable)

---

## 📈 **MÉTRICAS DE COMPLEJIDAD**

| Aspecto | Métrica | Valor |
|---------|---------|-------|
| **Tablas Total** | Cantidad | 25-30 |
| **Relaciones** | Foreign Keys | 45+ |
| **Casos de Uso** | Principales | 4 |
| **Endpoints API** | Estimados | 80+ |
| **Queries Complejas** | JOINs 5+ tablas | 15+ |
| **Real-time Features** | WebSocket endpoints | 10+ |

---

## 🔄 **EVOLUCIÓN Y VERSIONADO**

### **Historial:**
- **v1.0:** Modelo básico (16 tablas) - POS tradicional
- **v2.0:** Operaciones avanzadas (22 tablas) - Inventario + cocina  
- **v3.0:** QR + Analytics (25-30 tablas) - Self-service + ML

### **Roadmap Futuro:**
- **v3.1:** Sistema de reservas online
- **v3.2:** Programa de fidelización
- **v3.3:** Integración delivery (Rappi, UberEats)
- **v4.0:** Multi-tenant SaaS

---

## 💡 **INSTRUCCIONES PARA LLM**

### **CUANDO UN USUARIO PREGUNTA SOBRE:**

**"Ventas/Revenue"** → Consultar: `cuenta`, `cuenta_producto`, `metricas_diarias`, `agregaciones_analytics`

**"QR/Self-service"** → Consultar: `sesion_qr`, `evento_servicio`, `carrito_temporal`, `features_ml`

**"Pagos/Split billing"** → Consultar: `pago_transaccion`, `cuenta_estado_pago`, `metodo_pago`

**"Cocina/Kitchen"** → Consultar: `pedido`, `pedido_detalle`, `receta`, `materia_prima`

**"Analytics/ML"** → Consultar: `agregaciones_analytics`, `features_ml`, `evento_servicio`

**"Inventario"** → Consultar: `materia_prima`, `movimiento_inventario`, `alerta_stock`

**"Clientes/Mesas"** → Consultar: `cuenta_cliente`, `mesa`, `sector`, `cliente`

### **PATRONES DE RESPUESTA:**
1. **Identificar caso de uso principal**
2. **Listar tablas relevantes con propósito**
3. **Proporcionar query ejemplo funcional**
4. **Explicar impacto de negocio**
5. **Sugerir optimizaciones si aplica**

### **CONTEXTO DE NEGOCIO CRÍTICO:**
- **Split billing es el diferenciador clave** vs competencia
- **Customer journey tracking** habilita analytics únicos
- **Modularidad** permite adaptar a diferentes tipos de negocio
- **Real-time capabilities** son requisito no negociable
- **ML/Data science** integrado desde diseño, no añadido después

---

## 🎯 **CONCLUSIÓN**

Este modelo de datos está diseñado para ser la base de una **plataforma inteligente de comercio**, no solo un POS tradicional. La complejidad adicional se justifica por:

1. **Diferenciación radical** en el mercado
2. **Pricing premium** justificado por valor único
3. **Escalabilidad** desde pequeño negocio a cadena enterprise
4. **Future-proof** con ML y analytics integrados

**El modelo v3.0 es la base técnica para construir el "Shopify de los restaurantes" con capacidades únicas de QR self-service y analytics predictivo.**
