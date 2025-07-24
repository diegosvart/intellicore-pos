# CASOS DE USO DETALLADOS - IntelliCore POS
## Documentación Optimizada para LLM

### 📋 ÍNDICE DE CASOS DE USO

1. **[Gestión de Comandas QR](#gestión-de-comandas-qr)**
2. **[Facturación Inteligente](#facturación-inteligente)**
3. **[Analytics en Tiempo Real](#analytics-en-tiempo-real)**
4. **[Gestión de Personal](#gestión-de-personal)**
5. **[Control de Inventario](#control-de-inventario)**
6. **[Reportes Ejecutivos](#reportes-ejecutivos)**

---

## 🔄 GESTIÓN DE COMANDAS QR

### CU-001: Cliente Escanea QR y Realiza Pedido Individual

**🎯 Objetivo**: Cliente realiza pedido completo desde mesa mediante QR  
**👤 Actor Principal**: Cliente individual  
**📱 Dispositivo**: Móvil propio del cliente  

#### Flujo Principal
1. **Escaneo QR**: Cliente escanea código QR de la mesa
2. **Identificación Mesa**: Sistema identifica mesa automáticamente
3. **Creación Sesión**: Se genera nueva sesión de comanda
4. **Navegación Menú**: Cliente navega menú digital interactivo
5. **Selección Productos**: Añade productos con personalizaciones
6. **Confirmación Pedido**: Revisa y confirma comanda
7. **Notificación Cocina**: Sistema envía orden a cocina automáticamente

#### Tablas Involucradas
```sql
-- Flujo principal de datos
qr_sessions_analytics (registro sesión)
→ comandas (creación comanda)
→ comanda_productos (productos del pedido)
→ productos (información productos)
→ mesas (identificación mesa)
→ analytics_eventos (tracking comportamiento)
```

#### Métricas Capturadas
- **Tiempo navegación menú**: Para optimización UX
- **Productos más vistos**: Para recomendaciones
- **Abandono carrito**: Para mejoras conversión
- **Tiempo decisión**: Para insights comportamiento

### CU-002: Grupo de Amigos con Facturación Dividida

**🎯 Objetivo**: Grupo realiza pedidos individuales con facturación separada  
**👥 Actor Principal**: Grupo de 4 personas  
**💰 Tipo Factura**: Individual por persona  

#### Flujo Colaborativo
1. **Primera Persona** escanea QR → Crea sesión grupal
2. **Comparte Enlace** → Otros 3 se unen a la sesión
3. **Pedidos Paralelos** → Cada uno hace su pedido individual
4. **Identificación Items** → Sistema asigna productos por persona
5. **Facturación Split** → 4 facturas individuales automáticas
6. **Pago Paralelo** → Cada uno paga su consumo

#### Diferenciador Clave
```sql
-- Asignación automática de productos por persona
SELECT 
    cp.id,
    cp.comanda_id,
    cp.producto_id,
    cp.persona_identificador, -- 🔑 CLAVE: Separación automática
    cp.cantidad,
    cp.precio_unitario,
    (cp.cantidad * cp.precio_unitario) as subtotal_persona
FROM comanda_productos cp
WHERE cp.comanda_id = ? AND cp.persona_identificador = ?;
```

### CU-003: Mesa Corporativa con Factura Única

**🎯 Objetivo**: Comida de empresa con factura corporativa única  
**🏢 Actor Principal**: Grupo corporativo (8 personas)  
**💰 Tipo Factura**: Única empresarial  

#### Flujo Empresarial
1. **Líder Escanea** → Configura sesión como "corporativa"
2. **Invita Equipo** → 7 personas se unen
3. **Pedidos Libres** → Sin restricciones por persona
4. **Factura Única** → Todo consolidado en una factura
5. **Datos Fiscales** → RFC/NIT empresarial automático
6. **Pago Corporativo** → Tarjeta empresarial o transferencia

---

## 💰 FACTURACIÓN INTELIGENTE

### CU-004: Split Billing Automático con Propinas

**🎯 Objetivo**: División automática con cálculo inteligente de propinas  
**⚡ Complejidad**: Alta - Cálculos distribuidos  

#### Escenarios de División
1. **División Equitativa**: Total ÷ número personas
2. **División por Consumo**: Cada quien paga lo suyo + proporcional servicios
3. **División Mixta**: Algunos items compartidos, otros individuales

#### Algoritmo Split Billing
```sql
-- Cálculo automático facturación dividida
WITH consumo_individual AS (
    SELECT 
        persona_identificador,
        SUM(cantidad * precio_unitario) as consumo_directo,
        COUNT(DISTINCT producto_id) as items_ordenados
    FROM comanda_productos 
    WHERE comanda_id = ? AND persona_identificador IS NOT NULL
    GROUP BY persona_identificador
),
items_compartidos AS (
    SELECT SUM(cantidad * precio_unitario) as total_compartido
    FROM comanda_productos 
    WHERE comanda_id = ? AND persona_identificador IS NULL
),
calculo_split AS (
    SELECT 
        ci.persona_identificador,
        ci.consumo_directo,
        (ic.total_compartido / (SELECT COUNT(DISTINCT persona_identificador) 
                               FROM comanda_productos 
                               WHERE comanda_id = ?)) as porcion_compartida,
        (ci.consumo_directo + 
         ic.total_compartido / (SELECT COUNT(DISTINCT persona_identificador) 
                               FROM comanda_productos 
                               WHERE comanda_id = ?)) as subtotal_persona
    FROM consumo_individual ci
    CROSS JOIN items_compartidos ic
)
SELECT 
    persona_identificador,
    subtotal_persona,
    (subtotal_persona * 0.16) as iva,
    (subtotal_persona * 1.16 * 0.10) as propina_sugerida,
    (subtotal_persona * 1.16 * 1.10) as total_con_propina
FROM calculo_split;
```

---

## 📊 ANALYTICS EN TIEMPO REAL

### CU-005: Dashboard Ejecutivo en Vivo

**🎯 Objetivo**: Monitoreo tiempo real para toma de decisiones  
**👥 Usuario**: Gerente de restaurante  
**⏱ Frecuencia**: Actualización cada 30 segundos  

#### KPIs Críticos Tiempo Real
1. **Mesas Activas**: Ocupación actual
2. **Comandas Pendientes**: Cola de cocina
3. **Ticket Promedio**: Por mesa/persona
4. **Tiempo Servicio**: Desde pedido hasta entrega
5. **Abandono QR**: Sesiones sin completar pedido

#### Query Dashboard Principal
```sql
-- Dashboard ejecutivo tiempo real
WITH metricas_tiempo_real AS (
    SELECT 
        -- Ocupación mesas
        COUNT(DISTINCT m.id) FILTER (WHERE m.estado = 'ocupada') as mesas_ocupadas,
        COUNT(DISTINCT m.id) as total_mesas,
        
        -- Comandas activas
        COUNT(DISTINCT c.id) FILTER (WHERE c.estado IN ('pendiente', 'en_preparacion')) as comandas_activas,
        
        -- Ingresos hora actual
        SUM(c.total) FILTER (WHERE c.fecha_hora >= CURRENT_TIMESTAMP - INTERVAL '1 hour') as ingresos_ultima_hora,
        
        -- Ticket promedio
        AVG(c.total) FILTER (WHERE c.fecha_hora >= CURRENT_DATE) as ticket_promedio_dia,
        
        -- Tiempo promedio servicio
        AVG(EXTRACT(MINUTES FROM (c.fecha_entrega - c.fecha_hora))) 
        FILTER (WHERE c.fecha_hora >= CURRENT_DATE AND c.estado = 'entregada') as tiempo_promedio_servicio
        
    FROM mesas m
    LEFT JOIN comandas c ON m.id = c.mesa_id
    WHERE c.fecha_hora >= CURRENT_DATE OR c.id IS NULL
)
SELECT 
    mesas_ocupadas,
    total_mesas,
    ROUND((mesas_ocupadas::decimal / total_mesas) * 100, 1) as porcentaje_ocupacion,
    comandas_activas,
    ingresos_ultima_hora,
    ticket_promedio_dia,
    tiempo_promedio_servicio
FROM metricas_tiempo_real;
```

### CU-006: Predicción de Demanda con ML

**🎯 Objetivo**: Predicción demanda próximas 2 horas  
**🤖 Algoritmo**: Time series + datos históricos  
**📈 Precisión Target**: 85%+  

#### Factores Predictivos
1. **Histórico Horario**: Misma hora días anteriores
2. **Día Semana**: Patrones laborales vs fin de semana
3. **Clima**: API clima externo
4. **Eventos**: Calendario eventos locales
5. **Tendencias**: Movimiento últimas 4 semanas

---

## 👥 GESTIÓN DE PERSONAL

### CU-007: Optimización Turnos Dinámicos

**🎯 Objetivo**: Asignación automática de personal según demanda predicha  
**⚡ Tiempo Respuesta**: < 5 minutos para ajustes  

#### Sistema de Alertas Inteligentes
```sql
-- Detección necesidad personal adicional
WITH demanda_predicha AS (
    SELECT 
        fecha_hora_prediccion,
        comandas_estimadas,
        personal_requerido_calculado
    FROM ml_predicciones_demanda 
    WHERE fecha_hora_prediccion BETWEEN NOW() AND NOW() + INTERVAL '2 hours'
),
personal_actual AS (
    SELECT COUNT(*) as personal_turno_actual
    FROM empleados e
    JOIN turnos t ON e.id = t.empleado_id
    WHERE t.fecha = CURRENT_DATE 
    AND t.hora_inicio <= CURRENT_TIME 
    AND t.hora_fin >= CURRENT_TIME
)
SELECT 
    dp.fecha_hora_prediccion,
    dp.comandas_estimadas,
    dp.personal_requerido_calculado,
    pa.personal_turno_actual,
    CASE 
        WHEN dp.personal_requerido_calculado > pa.personal_turno_actual 
        THEN 'LLAMAR_REFUERZO'
        WHEN dp.personal_requerido_calculado < pa.personal_turno_actual 
        THEN 'OPTIMIZAR_COSTOS'
        ELSE 'OPTIMO'
    END as accion_recomendada
FROM demanda_predicha dp
CROSS JOIN personal_actual pa;
```

---

## 📦 CONTROL DE INVENTARIO

### CU-008: Reabastecimiento Predictivo

**🎯 Objetivo**: Nunca quedarse sin productos populares  
**📊 Método**: Análisis velocidad rotación + demanda predicha  

#### Algoritmo de Reorder Point
```sql
-- Cálculo punto de reorden inteligente
WITH velocidad_rotacion AS (
    SELECT 
        p.id as producto_id,
        p.nombre,
        AVG(daily_sales.cantidad_vendida) as promedio_diario,
        STDDEV(daily_sales.cantidad_vendida) as desviacion_estandar,
        MAX(daily_sales.cantidad_vendida) as maximo_diario
    FROM productos p
    JOIN (
        SELECT 
            cp.producto_id,
            DATE(c.fecha_hora) as fecha,
            SUM(cp.cantidad) as cantidad_vendida
        FROM comanda_productos cp
        JOIN comandas c ON cp.comanda_id = c.id
        WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '30 days'
        GROUP BY cp.producto_id, DATE(c.fecha_hora)
    ) daily_sales ON p.id = daily_sales.producto_id
    GROUP BY p.id, p.nombre
),
calculo_reorder AS (
    SELECT 
        vr.producto_id,
        vr.nombre,
        vr.promedio_diario,
        i.stock_actual,
        i.tiempo_reabastecimiento_dias,
        -- Punto de reorden = (demanda promedio × tiempo reabastecimiento) + stock seguridad
        CEIL(
            (vr.promedio_diario * i.tiempo_reabastecimiento_dias) + 
            (vr.desviacion_estandar * 1.5) -- Factor seguridad
        ) as punto_reorden,
        -- Cantidad óptima = cobertura 1 semana + buffer
        CEIL(vr.promedio_diario * 7 + vr.desviacion_estandar * 2) as cantidad_optima_pedido
    FROM velocidad_rotacion vr
    JOIN inventario i ON vr.producto_id = i.producto_id
)
SELECT 
    producto_id,
    nombre,
    stock_actual,
    punto_reorden,
    cantidad_optima_pedido,
    CASE 
        WHEN stock_actual <= punto_reorden THEN 'URGENTE_REORDER'
        WHEN stock_actual <= (punto_reorden * 1.2) THEN 'PLANIFICAR_REORDER'
        ELSE 'STOCK_OK'
    END as status_inventario
FROM calculo_reorder
ORDER BY stock_actual ASC;
```

---

## 📈 REPORTES EJECUTIVOS

### CU-009: Análisis de Rentabilidad por Producto

**🎯 Objetivo**: Identificar productos estrella vs productos problemáticos  
**💡 Insight**: Decisiones menu data-driven  

#### Matriz BCG Productos
```sql
-- Análisis BCG: Estrella, Vaca Lechera, Interrogante, Perro
WITH analisis_productos AS (
    SELECT 
        p.id,
        p.nombre,
        p.categoria_id,
        p.precio_venta,
        p.costo_producto,
        (p.precio_venta - p.costo_producto) as margen_unitario,
        ((p.precio_venta - p.costo_producto) / p.precio_venta) * 100 as porcentaje_margen,
        
        -- Volumen ventas últimos 30 días
        COALESCE(SUM(cp.cantidad), 0) as unidades_vendidas_30d,
        COALESCE(SUM(cp.cantidad * cp.precio_unitario), 0) as ingresos_30d,
        COALESCE(SUM(cp.cantidad * p.costo_producto), 0) as costos_30d,
        COALESCE(SUM(cp.cantidad * (cp.precio_unitario - p.costo_producto)), 0) as utilidad_30d,
        
        -- Frecuencia pedidos
        COUNT(DISTINCT cp.comanda_id) as comandas_con_producto,
        
        -- Crecimiento vs período anterior
        COALESCE(SUM(cp.cantidad) 
                FILTER (WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '30 days'), 0) as ventas_actual,
        COALESCE(SUM(cp.cantidad) 
                FILTER (WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '60 days' 
                         AND c.fecha_hora < CURRENT_DATE - INTERVAL '30 days'), 0) as ventas_anterior
        
    FROM productos p
    LEFT JOIN comanda_productos cp ON p.id = cp.producto_id
    LEFT JOIN comandas c ON cp.comanda_id = c.id
    WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '60 days' OR c.id IS NULL
    GROUP BY p.id, p.nombre, p.categoria_id, p.precio_venta, p.costo_producto
),
percentiles AS (
    SELECT 
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY unidades_vendidas_30d) as mediana_volumen,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY porcentaje_margen) as mediana_margen
    FROM analisis_productos
),
clasificacion_bcg AS (
    SELECT 
        ap.*,
        p.mediana_volumen,
        p.mediana_margen,
        CASE 
            WHEN ap.unidades_vendidas_30d > p.mediana_volumen AND ap.porcentaje_margen > p.mediana_margen 
            THEN 'ESTRELLA'
            WHEN ap.unidades_vendidas_30d > p.mediana_volumen AND ap.porcentaje_margen <= p.mediana_margen 
            THEN 'INTERROGANTE'
            WHEN ap.unidades_vendidas_30d <= p.mediana_volumen AND ap.porcentaje_margen > p.mediana_margen 
            THEN 'VACA_LECHERA'
            ELSE 'PERRO'
        END as categoria_bcg,
        
        CASE 
            WHEN ap.ventas_anterior = 0 THEN 100
            ELSE ROUND(((ap.ventas_actual - ap.ventas_anterior)::decimal / ap.ventas_anterior) * 100, 1)
        END as crecimiento_porcentual
    FROM analisis_productos ap
    CROSS JOIN percentiles p
)
SELECT 
    nombre,
    categoria_bcg,
    unidades_vendidas_30d,
    porcentaje_margen,
    utilidad_30d,
    crecimiento_porcentual,
    CASE categoria_bcg
        WHEN 'ESTRELLA' THEN 'Mantener y promocionar - Alto volumen, alta rentabilidad'
        WHEN 'VACA_LECHERA' THEN 'Optimizar costos - Baja demanda pero buena rentabilidad'
        WHEN 'INTERROGANTE' THEN 'Evaluar precio/costo - Alto volumen, baja rentabilidad'
        WHEN 'PERRO' THEN 'Considerar eliminación - Bajo volumen, baja rentabilidad'
    END as recomendacion_estrategica
FROM clasificacion_bcg
ORDER BY categoria_bcg, utilidad_30d DESC;
```

### CU-010: Análisis de Comportamiento Cliente QR

**🎯 Objetivo**: Optimizar experiencia digital para maximizar conversión  
**📱 Foco**: Journey desde escaneo QR hasta pago completado  

#### Funnel de Conversión QR
```sql
-- Análisis funnel conversión QR sessions
WITH funnel_qr AS (
    SELECT 
        DATE(fecha_escaneo) as fecha,
        COUNT(*) as total_escaneos,
        
        -- Paso 1: Escaneo exitoso
        COUNT(*) FILTER (WHERE pagina_inicial_cargada = true) as carga_exitosa,
        
        -- Paso 2: Navegación menú
        COUNT(*) FILTER (WHERE tiempo_navegacion_segundos > 0) as navego_menu,
        
        -- Paso 3: Añadió productos
        COUNT(*) FILTER (WHERE productos_anadidos > 0) as anadio_productos,
        
        -- Paso 4: Completó pedido
        COUNT(*) FILTER (WHERE comanda_id IS NOT NULL) as completo_pedido,
        
        -- Paso 5: Pagó
        COUNT(*) FILTER (WHERE comanda_id IS NOT NULL 
                        AND EXISTS (
                            SELECT 1 FROM comandas c 
                            WHERE c.id = qr_sessions_analytics.comanda_id 
                            AND c.estado_pago = 'pagado'
                        )) as pago_completado,
        
        -- Métricas tiempo
        AVG(tiempo_navegacion_segundos) FILTER (WHERE tiempo_navegacion_segundos > 0) as tiempo_promedio_navegacion,
        AVG(productos_anadidos) FILTER (WHERE productos_anadidos > 0) as productos_promedio,
        AVG(tiempo_decision_segundos) FILTER (WHERE tiempo_decision_segundos > 0) as tiempo_promedio_decision
        
    FROM qr_sessions_analytics
    WHERE fecha_escaneo >= CURRENT_DATE - INTERVAL '7 days'
    GROUP BY DATE(fecha_escaneo)
)
SELECT 
    fecha,
    total_escaneos,
    
    -- Tasas de conversión por paso
    ROUND((carga_exitosa::decimal / total_escaneos) * 100, 1) as tasa_carga_exitosa,
    ROUND((navego_menu::decimal / carga_exitosa) * 100, 1) as tasa_navegacion,
    ROUND((anadio_productos::decimal / navego_menu) * 100, 1) as tasa_adicion_productos,
    ROUND((completo_pedido::decimal / anadio_productos) * 100, 1) as tasa_completado_pedido,
    ROUND((pago_completado::decimal / completo_pedido) * 100, 1) as tasa_pago,
    
    -- Conversión total
    ROUND((pago_completado::decimal / total_escaneos) * 100, 1) as conversion_total,
    
    -- Métricas UX
    ROUND(tiempo_promedio_navegacion, 1) as tiempo_navegacion_seg,
    ROUND(productos_promedio, 1) as productos_por_sesion,
    ROUND(tiempo_promedio_decision, 1) as tiempo_decision_seg,
    
    -- Puntos de fuga principales
    (total_escaneos - carga_exitosa) as abandono_carga,
    (carga_exitosa - navego_menu) as abandono_navegacion,
    (navego_menu - anadio_productos) as abandono_seleccion,
    (anadio_productos - completo_pedido) as abandono_pedido,
    (completo_pedido - pago_completado) as abandono_pago
    
FROM funnel_qr
ORDER BY fecha DESC;
```

---

## 🎯 MÉTRICAS DE ÉXITO Y KPIS

### Métricas Operacionales
- **Tiempo Medio Atención**: < 3 minutos desde escaneo QR
- **Conversión QR→Pedido**: > 75%
- **Precisión Inventario**: > 95%
- **Uptime Sistema**: > 99.5%

### Métricas Financieras
- **Incremento Ticket Promedio**: +25% vs POS tradicional
- **Reducción Costos Operativos**: -15% personal requerido
- **ROI Implementación**: < 6 meses

### Métricas de Experiencia
- **NPS Clientes**: > 8.5/10
- **Tiempo Servicio**: Reducción 20%
- **Errores Pedidos**: < 2%

---

*📝 Esta documentación está optimizada para ser procesada por LLMs y facilitar el desarrollo iterativo inteligente del sistema IntelliCore POS.*
