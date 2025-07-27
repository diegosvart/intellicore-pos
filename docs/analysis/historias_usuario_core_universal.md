# HISTORIAS DE USUARIO - CORE UNIVERSAL
## IntelliCore POS | User Stories Detalladas

**Fecha:** 27 de Julio, 2025  
**Fase:** 1.2 - Historias de Usuario (User Stories)  
**Rama:** analysis/20250727-historias-usuario-core  
**Especialistas:** ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR + UX_DESIGNER

---

## 🎯 **PROPÓSITO DE LAS HISTORIAS DE USUARIO**

Las historias de usuario transforman los casos de uso técnicos en narrativas centradas en el usuario, describiendo **QUÉ** quiere lograr cada actor, **POR QUÉ** lo necesita y **CUÁNDO** se considera exitoso.

**Formato estándar:**
```
Como [ACTOR], quiero [ACCIÓN] para [BENEFICIO]

Criterios de Aceptación:
- Dado que [CONTEXTO]
- Cuando [ACCIÓN]
- Entonces [RESULTADO ESPERADO]
```

---

## 📋 **HISTORIAS DE USUARIO POR MÓDULO CORE**

### **1. MÓDULO: AUTH (Autenticación y Autorización)**

#### **US-AUTH-001: Login Multi-Tenant Seguro**
```
Como EMPLEADO de un restaurante/hotel/retail,
Quiero iniciar sesión con mis credenciales específicas de mi empresa
Para acceder solo a los datos y funciones de mi organización sin ver información de otros clientes.
```

**Criterios de Aceptación:**
- **Dado que** soy empleado de "Restaurante La Mesa" (tenant_id: 1001)
- **Cuando** ingreso email "juan@lamesa.com" y contraseña correcta
- **Entonces** obtengo acceso solo a datos del tenant 1001
- **Y** no puedo ver información de otros restaurantes
- **Y** recibo un JWT token con claims de tenant y rol

**Criterios de Aceptación - Flujos Alternativos:**
- **Dado que** ingreso credenciales incorrectas
- **Cuando** intento login 3 veces consecutivas
- **Entonces** mi cuenta se bloquea temporalmente por 15 minutos
- **Y** recibo notificación de bloqueo por seguridad

---

#### **US-AUTH-002: Gestión de Permisos Granulares**
```
Como ADMINISTRADOR del sistema,
Quiero definir permisos específicos por rol (mesero, gerente, admin)
Para controlar exactamente qué puede hacer cada empleado en el sistema.
```

**Criterios de Aceptación:**
- **Dado que** soy admin creando un rol "Mesero"
- **Cuando** asigno permisos "ver_menu", "crear_orden", "procesar_pago"
- **Entonces** usuarios con rol "Mesero" solo pueden ejecutar esas acciones
- **Y** reciben error 403 si intentan acceder a reportes o configuración

---

#### **US-AUTH-003: Renovación Automática de Sesión**
```
Como EMPLEADO trabajando activamente,
Quiero que mi sesión se renueve automáticamente mientras uso el sistema
Para no tener que logearme constantemente durante mi turno de trabajo.
```

**Criterios de Aceptación:**
- **Dado que** tengo una sesión activa y estoy usando el sistema
- **Cuando** mi token está próximo a expirar (5 min restantes)
- **Entonces** el sistema renueva automáticamente mi token
- **Y** puedo continuar trabajando sin interrupción

---

### **2. MÓDULO: PAYMENTS (Motor de Pagos)**

#### **US-PAY-001: Pago Universal Simplificado**
```
Como CLIENTE de cualquier vertical (restaurante/hotel/retail),
Quiero pagar con mi método preferido (tarjeta, efectivo, PayPal, Apple Pay)
Para completar mi transacción de forma rápida y segura sin importar dónde esté comprando.
```

**Criterios de Aceptación:**
- **Dado que** tengo una orden de $50.00 en un restaurante
- **Cuando** selecciono "Tarjeta de Crédito" como método de pago
- **Entonces** el sistema procesa el pago via Stripe
- **Y** recibo confirmación inmediata de pago exitoso
- **Y** la orden se marca como "Pagada" automáticamente

**Criterios de Aceptación - Fallos:**
- **Dado que** mi tarjeta es rechazada
- **Cuando** intento procesar el pago
- **Entonces** puedo seleccionar un método alternativo
- **Y** la orden permanece activa para reintentar

---

#### **US-PAY-002: Split Billing en Grupo**
```
Como CLIENTE cenando/hospedándome con amigos,
Quiero pagar solo mi parte de la cuenta sin manejar efectivo
Para dividir gastos de forma justa y conveniente usando mi teléfono.
```

**Criterios de Aceptación:**
- **Dado que** estoy en mesa 5 con 3 amigos más
- **Cuando** escaneo el QR de la mesa
- **Entonces** veo solo los items que yo pedí
- **Y** puedo pagar mi parte ($23.50) independientemente
- **Y** el sistema consolida todos los pagos automáticamente

**Historia Epic relacionada:**
- **Dado que** somos 4 personas en la mesa
- **Cuando** todos pagamos nuestras partes individualmente
- **Entonces** la cuenta total se marca como "Pagada Completa"
- **Y** el mesero recibe notificación para limpiar la mesa

---

### **3. MÓDULO: CUSTOMERS (Gestión de Clientes 360)**

#### **US-CUST-001: Perfil Unificado Cross-Vertical**
```
Como CLIENTE que usa múltiples servicios (restaurante + hotel del mismo grupo),
Quiero tener un solo perfil que me reconozca en todos los establecimientos
Para recibir un servicio personalizado y acumular beneficios en toda la cadena.
```

**Criterios de Aceptación:**
- **Dado que** me registré inicialmente en "Hotel Plaza" con email "maria@email.com"
- **Cuando** visito "Restaurante Plaza" (mismo grupo empresarial)
- **Entonces** el sistema me reconoce automáticamente
- **Y** puede aplicar mis preferencias dietarias del hotel al restaurante
- **Y** acumulo puntos de fidelidad en el mismo programa

---

#### **US-CUST-002: Historial de Interacciones**
```
Como GERENTE de atención al cliente,
Quiero ver el historial completo de interacciones de un cliente
Para brindar servicio personalizado y resolver problemas efectivamente.
```

**Criterios de Aceptación:**
- **Dado que** el cliente "Juan Pérez" llama con una queja
- **Cuando** busco su perfil en el sistema
- **Entonces** veo su historial: 5 visitas al restaurante, 2 noches en hotel, 1 compra retail
- **Y** veo sus preferencias: vegetariano, alérgico a mariscos, habitación silenciosa
- **Y** puedo personalizar la solución basada en su historial

---

### **4. MÓDULO: QR_SELFSERVICE (Sistema QR Nativo)**

#### **US-QR-001: Experiencia Sin Contacto**
```
Como CLIENTE preocupado por higiene (post-COVID),
Quiero completar todo mi pedido y pago desde mi teléfono
Para minimizar contacto físico con superficies y personal.
```

**Criterios de Aceptación:**
- **Dado que** llego a la mesa 12 del restaurante
- **Cuando** escaneo el QR de la mesa con mi teléfono
- **Entonces** accedo al menú digital completo
- **Y** puedo hacer pedido, customizar items y pagar
- **Y** solo necesito contacto humano para recibir la comida

---

#### **US-QR-002: QR Dinámico con Contexto**
```
Como EMPLEADO del hotel,
Quiero generar códigos QR específicos para cada habitación y servicio
Para que cada huésped acceda automáticamente a sus opciones personalizadas.
```

**Criterios de Aceptación:**
- **Dado que** genero QR para habitación 205
- **Cuando** el huésped escanea el código
- **Entonces** ve servicios disponibles para su habitación específicamente
- **Y** puede pedir room service con entrega automática a habitación 205
- **Y** los cargos se aplican automáticamente a su cuenta de huésped

---

### **5. MÓDULO: ML_ENGINE (Motor de Machine Learning)**

#### **US-ML-001: Recomendaciones Inteligentes**
```
Como CLIENTE navegando el menú/catálogo,
Quiero ver recomendaciones personalizadas basadas en mi historial
Para descubrir productos que realmente me gustarán y optimizar mi experiencia.
```

**Criterios de Aceptación:**
- **Dado que** soy cliente vegetariano con historial de compras saludables
- **Cuando** abro el menú del restaurante
- **Entonces** veo destacados: ensaladas gourmet, bowls vegetarianos, smoothies
- **Y** NO veo recomendaciones de carnes o comida chatarra
- **Y** las recomendaciones tienen 85%+ precisión basada en mis gustos

---

#### **US-ML-002: Predicciones para el Negocio**
```
Como GERENTE de operaciones,
Quiero recibir predicciones sobre demanda y tendencias
Para optimizar inventario, staffing y operaciones proactivamente.
```

**Criterios de Aceptación:**
- **Dado que** es domingo por la mañana
- **Cuando** reviso el dashboard predictivo
- **Entonces** veo predicción: "Aumento 40% en brunches, preparar 20 mesas adicionales"
- **Y** recibo alertas automáticas si algún ingrediente se agotará
- **Y** las predicciones tienen 80%+ precisión basada en datos históricos

---

### **6. MÓDULO: INVENTORY (Gestión de Inventario Universal)**

#### **US-INV-001: Control Automático de Stock**
```
Como CHEF/GERENTE de cocina,
Quiero que el inventario se actualice automáticamente con cada venta
Para saber en tiempo real qué ingredientes tengo disponibles sin contar manualmente.
```

**Criterios de Aceptación:**
- **Dado que** se vende 1 "Pasta Carbonara" (requiere: 200g pasta, 100g bacon, 2 huevos)
- **Cuando** el pedido se confirma en cocina
- **Entonces** el stock se reduce automáticamente: pasta (-200g), bacon (-100g), huevos (-2)
- **Y** si algún ingrediente queda < mínimo, recibo alerta inmediata
- **Y** puedo bloquear automáticamente el platillo si faltan ingredientes

---

### **7. MÓDULO: ANALYTICS (Analytics y Reportes)**

#### **US-ANA-001: Dashboard en Tiempo Real**
```
Como GERENTE/DUEÑO del negocio,
Quiero monitorear métricas clave en tiempo real desde cualquier dispositivo
Para tomar decisiones informadas durante las operaciones diarias.
```

**Criterios de Aceptación:**
- **Dado que** es viernes por la noche (hora pico)
- **Cuando** abro el dashboard desde mi teléfono
- **Entonces** veo métricas actualizadas cada 30 segundos: ventas del día, mesas ocupadas, tiempo promedio de servicio
- **Y** recibo alertas si alguna métrica sale del rango normal
- **Y** puedo hacer drill-down para ver detalles específicos

---

#### **US-ANA-002: Reportes Automáticos**
```
Como CONTADOR/ADMINISTRADOR,
Quiero recibir reportes financieros automáticos por email
Para tener información actualizada sin tener que generar reportes manualmente.
```

**Criterios de Aceptación:**
- **Dado que** configuré reportes diarios a las 8:00 AM
- **Cuando** llega la hora programada
- **Entonces** recibo por email el reporte de ventas del día anterior
- **Y** el reporte incluye: ingresos totales, métodos de pago, productos más vendidos
- **Y** el formato es profesional (PDF) listo para compartir con stakeholders

---

### **8. MÓDULO: EVENT_BUS (Bus de Eventos)**

#### **US-EVT-001: Integración Fluida entre Módulos**
```
Como DESARROLLADOR del sistema,
Quiero que los módulos se comuniquen automáticamente cuando ocurren eventos importantes
Para mantener todos los sistemas sincronizados sin intervención manual.
```

**Criterios de Aceptación:**
- **Dado que** se completa un pago en el módulo Payments
- **Cuando** el evento "payment_completed" se dispara
- **Entonces** el módulo Inventory actualiza stock automáticamente
- **Y** el módulo Analytics registra la venta
- **Y** el módulo Customer actualiza el historial del cliente
- **Y** todo ocurre en menos de 2 segundos

---

### **9. MÓDULO: REGISTRY (Registro de Servicios)**

#### **US-REG-001: Auto-Discovery de Servicios**
```
Como ADMINISTRADOR de sistemas,
Quiero que los microservicios se registren automáticamente al iniciarse
Para no tener que configurar manualmente las conexiones entre servicios.
```

**Criterios de Aceptación:**
- **Dado que** inicio el servicio "payment-processor-v2"
- **Cuando** el servicio arranca completamente
- **Entonces** se registra automáticamente en el service registry
- **Y** otros servicios pueden descubrirlo inmediatamente
- **Y** si el servicio falla, se remueve automáticamente del registro

---

### **10. MÓDULO: DATABASE (Gestión de Base de Datos)**

#### **US-DB-001: Aislamiento Total de Datos**
```
Como DUEÑO de un restaurante usando IntelliCore POS,
Quiero garantía absoluta de que mis datos no pueden ser vistos por otros restaurantes
Para cumplir con regulaciones de privacidad y proteger información confidencial del negocio.
```

**Criterios de Aceptación:**
- **Dado que** soy "Restaurante La Mesa" (tenant_id: 1001)
- **Cuando** cualquier empleado ejecuta cualquier consulta
- **Entonces** solo ve datos con tenant_id = 1001
- **Y** es imposible acceder a datos de otros tenants (incluso con SQL injection)
- **Y** todos los accesos quedan registrados en audit log inmutable

---

## 🎯 **ÉPICAS TRANSVERSALES**

### **ÉPICA 1: Experiencia de Cliente Sin Fricción**
```
Como CLIENTE de cualquier vertical,
Quiero una experiencia fluida desde que llego hasta que me voy
Para sentir que el servicio es eficiente, moderno y se adapta a mis necesidades.

Historias incluidas:
- US-AUTH-003 (Sesión continua)
- US-PAY-001 (Pago simplificado)  
- US-PAY-002 (Split billing)
- US-QR-001 (Sin contacto)
- US-CUST-001 (Perfil unificado)
- US-ML-001 (Recomendaciones)
```

### **ÉPICA 2: Operaciones Inteligentes**
```
Como GERENTE/DUEÑO de negocio,
Quiero que el sistema maneje automáticamente las operaciones rutinarias
Para enfocarme en la estrategia y la experiencia del cliente en lugar de tareas manuales.

Historias incluidas:
- US-INV-001 (Stock automático)
- US-ANA-001 (Dashboard tiempo real)
- US-ANA-002 (Reportes automáticos)
- US-ML-002 (Predicciones)
- US-EVT-001 (Integración automática)
```

### **ÉPICA 3: Seguridad y Compliance**
```
Como EMPRESA usando IntelliCore POS,
Quiero garantías de seguridad y cumplimiento regulatorio
Para proteger mi negocio y mis clientes sin preocuparme por aspectos técnicos.

Historias incluidas:
- US-AUTH-001 (Login seguro)
- US-AUTH-002 (Permisos granulares)
- US-DB-001 (Aislamiento de datos)
- US-PAY-001 (Pagos seguros PCI DSS)
```

---

## 📊 **CRITERIOS DE COMPLETITUD**

### **VALIDACIÓN DE HISTORIAS DE USUARIO:**
- ✅ Formato estándar aplicado (Como/Quiero/Para)
- ✅ Criterios de aceptación específicos y medibles
- ✅ Cobertura completa de casos de uso identificados
- ✅ Flujos alternativos considerados
- ✅ Épicas transversales definidas
- ✅ Perspectiva del usuario mantenida (no técnica)

### **MÉTRICAS DE CALIDAD:**
- **Historias totales:** 18 historias de usuario
- **Módulos cubiertos:** 10/10 módulos core
- **Actores representados:** Cliente, Empleado, Gerente, Admin, Desarrollador
- **Épicas transversales:** 3 épicas estratégicas

### **PRÓXIMOS PASOS:**
1. **Fase 1.3:** Requisitos Funcionales detallados
2. **Fase 1.4:** Requisitos No Funcionales (performance, seguridad, escalabilidad)
3. **Fase 2.1:** Modelo de Datos por módulo

---

**Estado:** ✅ COMPLETADO  
**Validado por:** ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR + UX_DESIGNER  
**Fecha:** 27 de Julio, 2025
