# CASOS DE USO - CORE UNIVERSAL
## IntelliCore POS | Análisis de Funcionalidades Core

**Fecha:** 27 de Julio, 2025  
**Fase:** 1.1 - Casos de Uso (Use Cases)  
**Rama:** analysis/20250727-casos-uso-core-universal  
**Especialistas:** ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR + ARQUITECTO_PRINCIPAL

---

## 🎯 **PROPÓSITO DEL CORE UNIVERSAL**

El Core Universal de IntelliCore POS contiene toda la funcionalidad común que debe estar disponible para **todos los verticales** (Restaurant, Hotel, Retail, Services, Healthcare). Estas funcionalidades deben ser:

- **Multi-tenant**: Aislamiento completo entre tenants
- **Cross-vertical**: Funciona igual para todos los verticales
- **Escalable**: Soporte para miles de usuarios concurrentes
- **Segura**: PCI DSS compliant desde diseño

---

## 📋 **CASOS DE USO POR MÓDULO CORE**

### **1. MÓDULO: AUTH (Autenticación y Autorización)**

#### **CU-AUTH-001: Autenticación Multi-Tenant**
**Actor Principal:** Usuario (Cliente, Administrador, Empleado)  
**Objetivo:** Autenticar usuario en su tenant específico con roles apropiados

**Precondiciones:**
- Usuario tiene credenciales válidas
- Tenant está activo
- Sistema está disponible

**Flujo Principal:**
1. Usuario ingresa email/username y contraseña
2. Sistema valida credenciales contra tenant específico
3. Sistema verifica estado del tenant (activo/suspendido)
4. Sistema genera JWT token con claims de tenant y roles
5. Sistema retorna token de acceso y refresh token
6. Usuario queda autenticado para su tenant

**Flujos Alternativos:**
- **A1:** Credenciales incorrectas → Error 401 con mensaje específico
- **A2:** Tenant suspendido → Error 403 con mensaje de contacto
- **A3:** Múltiples intentos fallidos → Bloqueo temporal de cuenta
- **A4:** Primera vez login → Forzar cambio de contraseña

**Postcondiciones:**
- Token JWT válido generado
- Sesión iniciada en Redis
- Audit log registrado

---

#### **CU-AUTH-002: Autorización Granular por Roles**
**Actor Principal:** Usuario autenticado  
**Objetivo:** Verificar permisos para acciones específicas según rol

**Precondiciones:**
- Usuario autenticado
- Acción requiere permisos específicos
- Roles definidos en el sistema

**Flujo Principal:**
1. Usuario intenta realizar acción (ej: ver reportes)
2. Sistema extrae roles del JWT token
3. Sistema consulta permisos asociados al rol
4. Sistema verifica si el permiso específico está asignado
5. Sistema permite o deniega la acción
6. Sistema registra evento en audit log

**Flujos Alternativos:**
- **A1:** Token expirado → Redirigir a login
- **A2:** Permisos insuficientes → Error 403
- **A3:** Rol no existe → Error 500 + notificación admin

---

#### **CU-AUTH-003: Gestión de Sesiones**
**Actor Principal:** Sistema  
**Objetivo:** Manejar sesiones activas y limpiar sesiones expiradas

**Flujo Principal:**
1. Sistema mantiene registro de sesiones activas en Redis
2. Cada request valida token y actualiza timestamp
3. Sesiones inactivas > 30 min se marcan para limpieza
4. Proceso batch limpia sesiones expiradas cada hora
5. Logout manual invalida token inmediatamente

---

### **2. MÓDULO: PAYMENTS (Motor de Pagos)**

#### **CU-PAY-001: Procesamiento de Pago Universal**
**Actor Principal:** Cliente  
**Objetivo:** Procesar pago independiente del método y vertical

**Precondiciones:**
- Orden/transacción creada
- Método de pago configurado
- Monto válido > 0

**Flujo Principal:**
1. Cliente selecciona método de pago (efectivo, tarjeta, QR, wallet)
2. Sistema valida monto y disponibilidad de método
3. Sistema rutea a procesador específico (Stripe, PayPal, etc.)
4. Procesador retorna resultado (aprobado/rechazado)
5. Sistema actualiza estado de transacción
6. Sistema notifica a vertical específico
7. Sistema registra en audit trail

**Flujos Alternativos:**
- **A1:** Tarjeta rechazada → Permitir reintento con otro método
- **A2:** Error de conectividad → Reintento automático x3
- **A3:** Pago parcial → Manejar saldo pendiente

---

#### **CU-PAY-002: Split Billing Inteligente**
**Actor Principal:** Múltiples clientes  
**Objetivo:** Dividir automáticamente el pago entre múltiples personas

**Precondiciones:**
- Orden compartida existente
- Múltiples clientes identificados
- Items de orden rastreables por cliente

**Flujo Principal:**
1. Sistema identifica items por cliente (via QR tracking)
2. Sistema calcula subtotal por persona
3. Sistema aplica impuestos y propinas proporcionales
4. Sistema presenta división a cada cliente
5. Cada cliente confirma su parte y paga
6. Sistema consolida pagos y completa transacción

**Flujos Alternativos:**
- **A1:** División manual → Permitir ajuste de montos
- **A2:** Alguien se va sin pagar → Reasignar su parte
- **A3:** Propina compartida → Aplicar porcentaje total

---

### **3. MÓDULO: CUSTOMERS (Gestión de Clientes 360)**

#### **CU-CUST-001: Registro Unificado de Cliente**
**Actor Principal:** Cliente  
**Objetivo:** Crear perfil único del cliente cross-vertical

**Flujo Principal:**
1. Cliente proporciona información básica
2. Sistema valida email/teléfono únicos en tenant
3. Sistema crea perfil con ID universal
4. Sistema vincula cliente a vertical inicial
5. Sistema inicializa preferencias y historial

**Flujos Alternativos:**
- **A1:** Cliente ya existe → Vincular a nuevo vertical
- **A2:** Información incompleta → Perfil temporal

---

#### **CU-CUST-002: Customer Journey Tracking**
**Actor Principal:** Sistema  
**Objetivo:** Rastrear interacciones del cliente cross-vertical

**Flujo Principal:**
1. Cliente interactúa con cualquier punto de contacto
2. Sistema registra evento con timestamp y contexto
3. Sistema actualiza perfil de comportamiento
4. Sistema alimenta ML engine para recomendaciones
5. Sistema actualiza métricas de engagement

---

### **4. MÓDULO: QR_SELFSERVICE (Sistema QR Nativo)**

#### **CU-QR-001: Generación de QR Dinámico**
**Actor Principal:** Sistema  
**Objetivo:** Generar códigos QR únicos por sesión/contexto

**Flujo Principal:**
1. Sistema recibe request de QR (mesa, habitación, producto)
2. Sistema genera token único con expiración
3. Sistema crea QR code con URL + token
4. Sistema almacena mapeo token → contexto en Redis
5. Sistema retorna QR para display

---

#### **CU-QR-002: Experiencia Self-Service**
**Actor Principal:** Cliente  
**Objetivo:** Completar flujo end-to-end via QR

**Flujo Principal:**
1. Cliente escanea QR
2. Sistema valida token y redirige a experiencia
3. Cliente navega catálogo/servicios
4. Cliente agrega items a carrito personal
5. Cliente procede a checkout
6. Sistema procesa pago via módulo payments
7. Sistema notifica a vertical para fulfillment

---

### **5. MÓDULO: ML_ENGINE (Motor de Machine Learning)**

#### **CU-ML-001: Recomendaciones Personalizadas**
**Actor Principal:** Sistema  
**Objetivo:** Generar recomendaciones basadas en historial y contexto

**Flujo Principal:**
1. Sistema recibe request de recomendaciones + contexto cliente
2. ML Engine analiza historial de compras
3. Engine considera contexto actual (tiempo, ubicación, vertical)
4. Engine aplica algoritmos de collaborative filtering
5. Engine retorna lista rankeada de recomendaciones
6. Sistema presenta recomendaciones al cliente

---

#### **CU-ML-002: Analytics Predictivos**
**Actor Principal:** Administrador  
**Objetivo:** Predecir tendencias y comportamientos

**Flujo Principal:**
1. Sistema ejecuta modelos predictivos scheduled
2. Analiza patrones de ventas, inventario, demanda
3. Genera predicciones para próximos períodos
4. Crea alertas automáticas para anomalías
5. Actualiza dashboards con insights

---

### **6. MÓDULO: INVENTORY (Gestión de Inventario Universal)**

#### **CU-INV-001: Control de Stock Cross-Vertical**
**Actor Principal:** Sistema  
**Objetivo:** Mantener inventario consistente entre verticales

**Flujo Principal:**
1. Venta/uso actualiza stock automáticamente
2. Sistema verifica stock disponible vs mínimos
3. Sistema genera alertas de restock si necesario
4. Sistema sincroniza stock entre ubicaciones
5. Sistema actualiza costos promedio

**Flujos Alternativos:**
- **A1:** Stock insuficiente → Bloquear venta + notificar
- **A2:** Stock negativo → Alerta crítica + investigación

---

### **7. MÓDULO: ANALYTICS (Analytics y Reportes)**

#### **CU-ANA-001: Dashboard Ejecutivo Real-Time**
**Actor Principal:** Administrador/Gerente  
**Objetivo:** Monitorear KPIs críticos en tiempo real

**Flujo Principal:**
1. Sistema agrega métricas en tiempo real
2. Dashboard actualiza cada 30 segundos
3. Muestra ventas, transacciones, clientes activos
4. Permite drill-down por vertical/período
5. Genera alertas para métricas fuera de rango

---

#### **CU-ANA-002: Reportes Programados**
**Actor Principal:** Sistema  
**Objetivo:** Generar reportes automáticos

**Flujo Principal:**
1. Sistema ejecuta reportes según schedule
2. Extrae datos de múltiples fuentes
3. Aplica transformaciones y cálculos
4. Genera reporte en formato requerido (PDF/Excel)
5. Envía por email a destinatarios configurados

---

### **8. MÓDULO: EVENT_BUS (Bus de Eventos)**

#### **CU-EVT-001: Comunicación Cross-Vertical**
**Actor Principal:** Módulos del sistema  
**Objetivo:** Facilitar comunicación asíncrona entre módulos

**Flujo Principal:**
1. Módulo A publica evento (ej: "pago_completado")
2. Event Bus recibe evento y valida formato
3. Bus rutea evento a suscriptores registrados
4. Módulos suscritos procesan evento asíncronamente
5. Bus registra evento en audit log

**Flujos Alternativos:**
- **A1:** Suscriptor no disponible → Reintento + dead letter queue
- **A2:** Evento malformado → Rechazar + notificar origen

---

### **9. MÓDULO: REGISTRY (Registro de Servicios)**

#### **CU-REG-001: Registro de Servicios**
**Actor Principal:** Microservicio  
**Objetivo:** Registrar servicios disponibles para discovery

**Flujo Principal:**
1. Servicio se inicia y registra en registry
2. Registry valida health check del servicio
3. Registry actualiza tabla de servicios disponibles
4. Otros servicios pueden descubrir via registry
5. Registry monitorea health y actualiza estado

---

### **10. MÓDULO: DATABASE (Gestión de Base de Datos)**

#### **CU-DB-001: Multi-Tenancy Enforcement**
**Actor Principal:** Sistema  
**Objetivo:** Garantizar aislamiento de datos por tenant

**Flujo Principal:**
1. Cada query incluye tenant_id automáticamente
2. Row-Level Security valida acceso
3. Sistema rechaza queries sin tenant context
4. Audit log registra todos los accesos a datos
5. Backup/restore mantiene separación de tenants

---

## **CRITERIOS DE COMPLETITUD**

### **VALIDACIÓN DE CASOS DE USO:**
- Casos de uso principales documentados por módulo
- Actores identificados y roles definidos
- Precondiciones y postcondiciones especificadas
- Flujos alternativos considerados
- Multi-tenancy presente en todos los casos
- Cross-vertical compatibility verificada

### **PRÓXIMOS PASOS:**
1. **Fase 1.2:** Historias de Usuario detalladas
2. **Fase 1.3:** Requisitos Funcionales específicos
3. **Fase 1.4:** Requisitos No Funcionales (performance, seguridad)

---

**Estado:** COMPLETADO  
**Validado por:** ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR + ARQUITECTO_PRINCIPAL  
**Fecha:** 27 de Julio, 2025
