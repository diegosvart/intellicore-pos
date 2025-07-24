-- ===============================================
-- QUERIES DE CASOS DE USO - IntelliCore POS
-- Documentación SQL Optimizada para LLM
-- ===============================================

-- 🎯 PROPÓSITO: Queries específicos para implementar casos de uso reales
-- 📝 CONTEXTO: Cada query resuelve un problema específico del negocio
-- 🔧 USO: Copy-paste ready para desarrollo rápido

-- ===============================================
-- 📱 GESTIÓN QR SESSIONS
-- ===============================================

-- QR-001: Crear nueva sesión QR cuando cliente escanea código
INSERT INTO qr_sessions_analytics (
    mesa_id,
    qr_code_hash,
    fecha_escaneo,
    ip_cliente,
    user_agent,
    pagina_inicial_cargada,
    tiempo_carga_milisegundos,
    dispositivo_tipo
) VALUES (
    $1, -- mesa_id del QR escaneado
    $2, -- hash único del QR
    NOW(),
    $3, -- IP del cliente
    $4, -- User agent del navegador
    true,
    $5, -- tiempo de carga medido en frontend
    $6  -- 'mobile' | 'tablet' | 'desktop'
) RETURNING id, mesa_id;

-- QR-002: Obtener información completa de mesa al escanear QR
SELECT 
    m.id,
    m.numero_mesa,
    m.capacidad,
    m.zona,
    m.estado,
    r.nombre as restaurante_nombre,
    r.direccion,
    r.telefono,
    -- Verificar si hay comanda activa
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM comandas c 
            WHERE c.mesa_id = m.id 
            AND c.estado IN ('pendiente', 'en_preparacion', 'lista')
        ) THEN true 
        ELSE false 
    END as tiene_comanda_activa,
    -- Última comanda de la mesa
    (SELECT c.id FROM comandas c WHERE c.mesa_id = m.id ORDER BY c.fecha_hora DESC LIMIT 1) as ultima_comanda_id
FROM mesas m
JOIN restaurantes r ON m.restaurante_id = r.id
WHERE m.id = $1;

-- QR-003: Actualizar métricas de navegación durante sesión QR
UPDATE qr_sessions_analytics 
SET 
    tiempo_navegacion_segundos = $2,
    productos_anadidos = $3,
    productos_vistos = $4,
    tiempo_decision_segundos = $5,
    abandono_carrito = $6,
    fecha_ultima_actividad = NOW()
WHERE id = $1;

-- QR-004: Finalizar sesión QR cuando se completa pedido
UPDATE qr_sessions_analytics 
SET 
    comanda_id = $2,
    pedido_completado = true,
    tiempo_total_sesion_segundos = EXTRACT(EPOCH FROM (NOW() - fecha_escaneo)),
    conversion_exitosa = true
WHERE id = $1;

-- ===============================================
-- 🍽 GESTIÓN DE COMANDAS
-- ===============================================

-- COM-001: Crear nueva comanda desde sesión QR
INSERT INTO comandas (
    mesa_id,
    qr_session_id,
    numero_comanda,
    fecha_hora,
    estado,
    tipo_servicio,
    numero_personas,
    observaciones_generales,
    canal_origen
) VALUES (
    $1, -- mesa_id
    $2, -- qr_session_id
    (SELECT COALESCE(MAX(numero_comanda), 0) + 1 FROM comandas WHERE DATE(fecha_hora) = CURRENT_DATE),
    NOW(),
    'pendiente',
    'mesa', -- mesa | delivery | takeaway
    $3, -- número de personas
    $4, -- observaciones
    'qr_autoservicio'
) RETURNING id, numero_comanda;

-- COM-002: Añadir producto a comanda con soporte para split billing
INSERT INTO comanda_productos (
    comanda_id,
    producto_id,
    cantidad,
    precio_unitario,
    observaciones,
    persona_identificador, -- NULL para items compartidos
    timestamp_agregado
) VALUES (
    $1, -- comanda_id
    $2, -- producto_id
    $3, -- cantidad
    (SELECT precio_venta FROM productos WHERE id = $2), -- precio actual
    $4, -- observaciones del producto
    $5, -- identificador persona (para split billing)
    NOW()
) RETURNING id;

-- COM-003: Calcular total de comanda con separación por persona
WITH calculo_comanda AS (
    SELECT 
        c.id as comanda_id,
        -- Total general
        SUM(cp.cantidad * cp.precio_unitario) as subtotal,
        -- Subtotal por persona (para split billing)
        json_object_agg(
            COALESCE(cp.persona_identificador, 'compartido'),
            SUM(cp.cantidad * cp.precio_unitario)
        ) FILTER (WHERE cp.persona_identificador IS NOT NULL OR 
                        (cp.persona_identificador IS NULL AND 
                         EXISTS(SELECT 1 FROM comanda_productos cp2 
                                WHERE cp2.comanda_id = cp.comanda_id 
                                AND cp2.persona_identificador IS NOT NULL))
        ) as subtotales_por_persona,
        -- Items compartidos
        SUM(cp.cantidad * cp.precio_unitario) FILTER (WHERE cp.persona_identificador IS NULL) as items_compartidos
    FROM comandas c
    JOIN comanda_productos cp ON c.id = cp.comanda_id
    WHERE c.id = $1
    GROUP BY c.id
),
calculo_impuestos AS (
    SELECT 
        comanda_id,
        subtotal,
        (subtotal * 0.16) as iva,
        (subtotal * 1.16) as total_con_iva,
        subtotales_por_persona,
        items_compartidos
    FROM calculo_comanda
)
UPDATE comandas 
SET 
    subtotal = ci.subtotal,
    iva = ci.iva,
    total = ci.total_con_iva,
    subtotales_split = ci.subtotales_por_persona,
    items_compartidos_total = ci.items_compartidos,
    fecha_calculo = NOW()
FROM calculo_impuestos ci
WHERE comandas.id = ci.comanda_id AND comandas.id = $1
RETURNING subtotal, iva, total, subtotales_split;

-- ===============================================
-- 💰 FACTURACIÓN SPLIT BILLING
-- ===============================================

-- FACT-001: Generar facturas individuales para split billing
WITH personas_comanda AS (
    SELECT DISTINCT persona_identificador
    FROM comanda_productos 
    WHERE comanda_id = $1 AND persona_identificador IS NOT NULL
),
calculo_por_persona AS (
    SELECT 
        cp.persona_identificador,
        SUM(cp.cantidad * cp.precio_unitario) as consumo_individual,
        COUNT(*) as items_ordenados,
        -- Proporción de items compartidos
        SUM(cp.cantidad * cp.precio_unitario) / (
            SELECT SUM(cantidad * precio_unitario) 
            FROM comanda_productos 
            WHERE comanda_id = $1 AND persona_identificador IS NOT NULL
        ) as proporcion_consumo
    FROM comanda_productos cp
    WHERE cp.comanda_id = $1 AND cp.persona_identificador IS NOT NULL
    GROUP BY cp.persona_identificador
),
distribucion_compartidos AS (
    SELECT 
        cpp.persona_identificador,
        cpp.consumo_individual,
        -- Distribución proporcional de items compartidos
        (SELECT SUM(cantidad * precio_unitario) 
         FROM comanda_productos 
         WHERE comanda_id = $1 AND persona_identificador IS NULL
        ) * cpp.proporcion_consumo as items_compartidos_asignados,
        cpp.consumo_individual + 
        (SELECT SUM(cantidad * precio_unitario) 
         FROM comanda_productos 
         WHERE comanda_id = $1 AND persona_identificador IS NULL
        ) * cpp.proporcion_consumo as subtotal_persona
    FROM calculo_por_persona cpp
)
INSERT INTO facturas (
    comanda_id,
    persona_identificador,
    numero_factura,
    fecha_emision,
    subtotal,
    iva,
    total,
    estado,
    tipo_factura
)
SELECT 
    $1,
    dc.persona_identificador,
    'F' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || dc.persona_identificador,
    NOW(),
    dc.subtotal_persona,
    dc.subtotal_persona * 0.16,
    dc.subtotal_persona * 1.16,
    'pendiente',
    'individual_split'
FROM distribucion_compartidos dc
RETURNING numero_factura, persona_identificador, total;

-- FACT-002: Generar factura única corporativa
INSERT INTO facturas (
    comanda_id,
    numero_factura,
    fecha_emision,
    razon_social,
    rfc_nit,
    direccion_fiscal,
    subtotal,
    iva,
    total,
    estado,
    tipo_factura
)
SELECT 
    c.id,
    'FC' || TO_CHAR(NOW(), 'YYYYMMDD') || '-' || LPAD(c.numero_comanda::text, 4, '0'),
    NOW(),
    $2, -- razón social empresa
    $3, -- RFC/NIT
    $4, -- dirección fiscal
    c.subtotal,
    c.iva,
    c.total,
    'pendiente',
    'corporativa'
FROM comandas c
WHERE c.id = $1
RETURNING numero_factura, total;

-- ===============================================
-- 📊 ANALYTICS Y REPORTES
-- ===============================================

-- ANA-001: Dashboard tiempo real - KPIs principales
SELECT 
    -- Métricas ocupación
    COUNT(DISTINCT m.id) FILTER (WHERE m.estado = 'ocupada') as mesas_ocupadas,
    COUNT(DISTINCT m.id) as total_mesas,
    ROUND(
        (COUNT(DISTINCT m.id) FILTER (WHERE m.estado = 'ocupada')::decimal / 
         COUNT(DISTINCT m.id)) * 100, 1
    ) as porcentaje_ocupacion,
    
    -- Métricas comandas
    COUNT(DISTINCT c.id) FILTER (WHERE c.estado IN ('pendiente', 'en_preparacion')) as comandas_activas,
    COUNT(DISTINCT c.id) FILTER (WHERE c.fecha_hora >= CURRENT_DATE) as comandas_hoy,
    
    -- Métricas financieras
    COALESCE(SUM(c.total) FILTER (WHERE c.fecha_hora >= CURRENT_TIMESTAMP - INTERVAL '1 hour'), 0) as ingresos_ultima_hora,
    COALESCE(SUM(c.total) FILTER (WHERE c.fecha_hora >= CURRENT_DATE), 0) as ingresos_hoy,
    COALESCE(AVG(c.total) FILTER (WHERE c.fecha_hora >= CURRENT_DATE), 0) as ticket_promedio_hoy,
    
    -- Métricas operacionales
    COALESCE(AVG(EXTRACT(MINUTES FROM (c.fecha_entrega - c.fecha_hora))) 
             FILTER (WHERE c.fecha_hora >= CURRENT_DATE AND c.estado = 'entregada'), 0) as tiempo_promedio_servicio,
    
    -- Métricas QR
    COUNT(DISTINCT qr.id) FILTER (WHERE qr.fecha_escaneo >= CURRENT_DATE) as escaneos_qr_hoy,
    COUNT(DISTINCT qr.id) FILTER (WHERE qr.fecha_escaneo >= CURRENT_DATE AND qr.conversion_exitosa = true) as conversiones_qr_hoy,
    CASE 
        WHEN COUNT(DISTINCT qr.id) FILTER (WHERE qr.fecha_escaneo >= CURRENT_DATE) > 0
        THEN ROUND(
            (COUNT(DISTINCT qr.id) FILTER (WHERE qr.fecha_escaneo >= CURRENT_DATE AND qr.conversion_exitosa = true)::decimal /
             COUNT(DISTINCT qr.id) FILTER (WHERE qr.fecha_escaneo >= CURRENT_DATE)) * 100, 1
        )
        ELSE 0
    END as tasa_conversion_qr
    
FROM mesas m
LEFT JOIN comandas c ON m.id = c.mesa_id
LEFT JOIN qr_sessions_analytics qr ON m.id = qr.mesa_id;

-- ANA-002: Análisis productos más populares últimos 7 días
SELECT 
    p.id,
    p.nombre,
    p.categoria_id,
    cat.nombre as categoria_nombre,
    SUM(cp.cantidad) as total_vendido,
    COUNT(DISTINCT cp.comanda_id) as apariciones_comandas,
    SUM(cp.cantidad * cp.precio_unitario) as ingresos_generados,
    AVG(cp.cantidad) as promedio_por_comanda,
    RANK() OVER (ORDER BY SUM(cp.cantidad) DESC) as ranking_volumen,
    RANK() OVER (ORDER BY SUM(cp.cantidad * cp.precio_unitario) DESC) as ranking_ingresos
FROM productos p
JOIN categorias cat ON p.categoria_id = cat.id
JOIN comanda_productos cp ON p.id = cp.producto_id
JOIN comandas c ON cp.comanda_id = c.id
WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '7 days'
AND c.estado NOT IN ('cancelada')
GROUP BY p.id, p.nombre, p.categoria_id, cat.nombre
ORDER BY total_vendido DESC
LIMIT 20;

-- ANA-003: Análisis de rendimiento por zona de mesas
SELECT 
    m.zona,
    COUNT(DISTINCT m.id) as total_mesas,
    COUNT(DISTINCT c.id) FILTER (WHERE c.fecha_hora >= CURRENT_DATE) as comandas_hoy,
    COALESCE(SUM(c.total) FILTER (WHERE c.fecha_hora >= CURRENT_DATE), 0) as ingresos_zona_hoy,
    COALESCE(AVG(c.total) FILTER (WHERE c.fecha_hora >= CURRENT_DATE), 0) as ticket_promedio_zona,
    COALESCE(
        SUM(c.total) FILTER (WHERE c.fecha_hora >= CURRENT_DATE) / 
        NULLIF(COUNT(DISTINCT m.id), 0), 0
    ) as ingreso_promedio_por_mesa,
    -- Tiempo promedio ocupación
    COALESCE(AVG(EXTRACT(MINUTES FROM (c.fecha_fin_comanda - c.fecha_hora))) 
             FILTER (WHERE c.fecha_hora >= CURRENT_DATE AND c.fecha_fin_comanda IS NOT NULL), 0) as tiempo_promedio_ocupacion
FROM mesas m
LEFT JOIN comandas c ON m.id = c.mesa_id
GROUP BY m.zona
ORDER BY ingresos_zona_hoy DESC;

-- ANA-004: Predicción de demanda para próximas 2 horas
WITH historico_horario AS (
    SELECT 
        EXTRACT(HOUR FROM fecha_hora) as hora,
        EXTRACT(DOW FROM fecha_hora) as dia_semana, -- 0=domingo, 6=sábado
        DATE(fecha_hora) as fecha,
        COUNT(*) as comandas_hora
    FROM comandas
    WHERE fecha_hora >= CURRENT_DATE - INTERVAL '28 days'
    AND estado NOT IN ('cancelada')
    GROUP BY EXTRACT(HOUR FROM fecha_hora), EXTRACT(DOW FROM fecha_hora), DATE(fecha_hora)
),
promedios_por_hora AS (
    SELECT 
        hora,
        dia_semana,
        AVG(comandas_hora) as promedio_comandas,
        STDDEV(comandas_hora) as desviacion_comandas,
        COUNT(*) as dias_data
    FROM historico_horario
    GROUP BY hora, dia_semana
    HAVING COUNT(*) >= 3 -- Al menos 3 días de data
),
prediccion AS (
    SELECT 
        (CURRENT_DATE + (EXTRACT(HOUR FROM NOW()) + generate_series(1,2)) * INTERVAL '1 hour')::timestamp as hora_prediccion,
        EXTRACT(DOW FROM CURRENT_DATE) as dia_actual,
        (EXTRACT(HOUR FROM NOW()) + generate_series(1,2))::int % 24 as hora_objetivo
    FROM generate_series(1,2)
)
SELECT 
    p.hora_prediccion,
    COALESCE(ph.promedio_comandas, 0) as comandas_predichas,
    COALESCE(ph.promedio_comandas + ph.desviacion_comandas, 0) as escenario_alto,
    COALESCE(ph.promedio_comandas - ph.desviacion_comandas, 0) as escenario_bajo,
    CASE 
        WHEN ph.promedio_comandas > 15 THEN 'ALTA'
        WHEN ph.promedio_comandas > 8 THEN 'MEDIA'
        ELSE 'BAJA'
    END as intensidad_predicha
FROM prediccion p
LEFT JOIN promedios_por_hora ph ON p.hora_objetivo = ph.hora AND p.dia_actual = ph.dia_semana
ORDER BY p.hora_prediccion;

-- ===============================================
-- 🔄 GESTIÓN DE INVENTARIO
-- ===============================================

-- INV-001: Verificar disponibilidad antes de confirmar comanda
SELECT 
    cp.producto_id,
    p.nombre,
    cp.cantidad as cantidad_pedida,
    i.stock_actual,
    CASE 
        WHEN i.stock_actual >= cp.cantidad THEN 'DISPONIBLE'
        WHEN i.stock_actual > 0 THEN 'DISPONIBLE_PARCIAL'
        ELSE 'NO_DISPONIBLE'
    END as estado_disponibilidad,
    LEAST(i.stock_actual, cp.cantidad) as cantidad_servible
FROM comanda_productos cp
JOIN productos p ON cp.producto_id = p.id
JOIN inventario i ON p.id = i.producto_id
WHERE cp.comanda_id = $1;

-- INV-002: Descontar inventario al confirmar comanda
WITH productos_comanda AS (
    SELECT producto_id, SUM(cantidad) as total_cantidad
    FROM comanda_productos 
    WHERE comanda_id = $1
    GROUP BY producto_id
)
UPDATE inventario i
SET 
    stock_actual = stock_actual - pc.total_cantidad,
    fecha_ultima_salida = NOW(),
    comandas_afectadas = COALESCE(comandas_afectadas, 0) + 1
FROM productos_comanda pc
WHERE i.producto_id = pc.producto_id
RETURNING producto_id, stock_actual;

-- INV-003: Alertas de stock bajo
SELECT 
    p.id,
    p.nombre,
    p.categoria_id,
    i.stock_actual,
    i.stock_minimo,
    i.punto_reorden,
    -- Velocidad de consumo últimos 7 días
    COALESCE(avg_consumption.consumo_promedio_diario, 0) as consumo_promedio_diario,
    -- Días de inventario restante
    CASE 
        WHEN COALESCE(avg_consumption.consumo_promedio_diario, 0) > 0 
        THEN i.stock_actual / avg_consumption.consumo_promedio_diario
        ELSE 999
    END as dias_inventario_restante,
    CASE 
        WHEN i.stock_actual <= 0 THEN 'SIN_STOCK'
        WHEN i.stock_actual <= i.stock_minimo THEN 'STOCK_CRITICO'
        WHEN i.stock_actual <= i.punto_reorden THEN 'REORDER_REQUERIDO'
        ELSE 'STOCK_OK'
    END as estado_alerta
FROM productos p
JOIN inventario i ON p.id = i.producto_id
LEFT JOIN (
    SELECT 
        cp.producto_id,
        AVG(daily_consumption.consumo_diario) as consumo_promedio_diario
    FROM comanda_productos cp
    JOIN (
        SELECT 
            producto_id,
            DATE(c.fecha_hora) as fecha,
            SUM(cantidad) as consumo_diario
        FROM comanda_productos cp2
        JOIN comandas c ON cp2.comanda_id = c.id
        WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '7 days'
        AND c.estado NOT IN ('cancelada')
        GROUP BY producto_id, DATE(c.fecha_hora)
    ) daily_consumption ON cp.producto_id = daily_consumption.producto_id
    GROUP BY cp.producto_id
) avg_consumption ON p.id = avg_consumption.producto_id
WHERE i.stock_actual <= i.punto_reorden
ORDER BY estado_alerta, dias_inventario_restante ASC;

-- ===============================================
-- 👥 GESTIÓN DE PERSONAL Y TURNOS
-- ===============================================

-- PERS-001: Personal activo en turno actual
SELECT 
    e.id,
    e.nombre,
    e.apellido,
    e.posicion,
    t.hora_inicio,
    t.hora_fin,
    EXTRACT(HOURS FROM (NOW() - t.hora_inicio)) as horas_trabajadas,
    -- Comandas atendidas hoy
    COUNT(DISTINCT c.id) as comandas_atendidas_hoy,
    -- Promedio tiempo servicio del empleado
    AVG(EXTRACT(MINUTES FROM (c.fecha_entrega - c.fecha_hora))) 
    FILTER (WHERE c.fecha_entrega IS NOT NULL) as tiempo_promedio_servicio
FROM empleados e
JOIN turnos t ON e.id = t.empleado_id
LEFT JOIN comandas c ON e.id = c.empleado_asignado_id AND DATE(c.fecha_hora) = CURRENT_DATE
WHERE t.fecha = CURRENT_DATE
AND t.hora_inicio <= CURRENT_TIME
AND t.hora_fin >= CURRENT_TIME
GROUP BY e.id, e.nombre, e.apellido, e.posicion, t.hora_inicio, t.hora_fin
ORDER BY e.posicion, e.nombre;

-- PERS-002: Análisis de productividad por empleado
SELECT 
    e.nombre,
    e.apellido,
    e.posicion,
    COUNT(DISTINCT c.id) as comandas_ultimo_mes,
    SUM(c.total) as ingresos_generados,
    AVG(c.total) as ticket_promedio_empleado,
    AVG(EXTRACT(MINUTES FROM (c.fecha_entrega - c.fecha_hora))) 
    FILTER (WHERE c.fecha_entrega IS NOT NULL) as tiempo_promedio_servicio,
    -- Calificación promedio de servicio (si existe sistema de rating)
    AVG(c.calificacion_servicio) FILTER (WHERE c.calificacion_servicio IS NOT NULL) as rating_promedio,
    -- Productividad relativa
    RANK() OVER (PARTITION BY e.posicion ORDER BY COUNT(DISTINCT c.id) DESC) as ranking_volumen,
    RANK() OVER (PARTITION BY e.posicion ORDER BY SUM(c.total) DESC) as ranking_ingresos
FROM empleados e
LEFT JOIN comandas c ON e.id = c.empleado_asignado_id
WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '30 days'
OR c.id IS NULL
GROUP BY e.id, e.nombre, e.apellido, e.posicion
ORDER BY e.posicion, comandas_ultimo_mes DESC;

-- ===============================================
-- 🎯 MÉTRICAS DE CONVERSIÓN QR
-- ===============================================

-- QR-CONV-001: Funnel completo de conversión QR por día
WITH funnel_diario AS (
    SELECT 
        DATE(fecha_escaneo) as fecha,
        COUNT(*) as total_escaneos,
        COUNT(*) FILTER (WHERE pagina_inicial_cargada = true) as paso_1_carga,
        COUNT(*) FILTER (WHERE tiempo_navegacion_segundos > 10) as paso_2_navegacion,
        COUNT(*) FILTER (WHERE productos_anadidos > 0) as paso_3_productos,
        COUNT(*) FILTER (WHERE comanda_id IS NOT NULL) as paso_4_pedido,
        COUNT(*) FILTER (WHERE conversion_exitosa = true) as paso_5_pago,
        
        -- Métricas de engagement
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
    paso_1_carga,
    paso_2_navegacion,
    paso_3_productos,
    paso_4_pedido,
    paso_5_pago,
    
    -- Tasas de conversión entre pasos
    ROUND((paso_1_carga::decimal / NULLIF(total_escaneos, 0)) * 100, 1) as tasa_carga,
    ROUND((paso_2_navegacion::decimal / NULLIF(paso_1_carga, 0)) * 100, 1) as tasa_navegacion,
    ROUND((paso_3_productos::decimal / NULLIF(paso_2_navegacion, 0)) * 100, 1) as tasa_productos,
    ROUND((paso_4_pedido::decimal / NULLIF(paso_3_productos, 0)) * 100, 1) as tasa_pedido,
    ROUND((paso_5_pago::decimal / NULLIF(paso_4_pedido, 0)) * 100, 1) as tasa_pago,
    
    -- Conversión total end-to-end
    ROUND((paso_5_pago::decimal / NULLIF(total_escaneos, 0)) * 100, 1) as conversion_total,
    
    -- Métricas UX
    ROUND(tiempo_promedio_navegacion, 1) as tiempo_navegacion_seg,
    ROUND(productos_promedio, 1) as productos_por_sesion,
    ROUND(tiempo_promedio_decision, 1) as tiempo_decision_seg
FROM funnel_diario
ORDER BY fecha DESC;

-- ===============================================
-- 💡 INSIGHTS Y RECOMENDACIONES
-- ===============================================

-- INSIGHT-001: Productos con mayor abandono en carrito QR
SELECT 
    p.nombre,
    COUNT(*) as veces_anadido,
    COUNT(*) FILTER (WHERE qr.conversion_exitosa = false) as abandonos,
    ROUND(
        (COUNT(*) FILTER (WHERE qr.conversion_exitosa = false)::decimal / COUNT(*)) * 100, 1
    ) as tasa_abandono,
    AVG(qr.tiempo_decision_segundos) as tiempo_promedio_decision,
    -- Posible razón de abandono
    CASE 
        WHEN AVG(qr.tiempo_decision_segundos) > 180 THEN 'TIEMPO_DECISION_LARGO'
        WHEN p.precio_venta > (SELECT AVG(precio_venta) * 1.5 FROM productos) THEN 'PRECIO_ALTO'
        WHEN COUNT(*) FILTER (WHERE qr.conversion_exitosa = false) > COUNT(*) * 0.7 THEN 'PROBLEMA_SISTEMATICO'
        ELSE 'ANALIZAR_MANUALMENTE'
    END as posible_causa
FROM productos p
JOIN comanda_productos cp ON p.id = cp.producto_id
JOIN comandas c ON cp.comanda_id = c.id
JOIN qr_sessions_analytics qr ON c.qr_session_id = qr.id
WHERE qr.fecha_escaneo >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY p.id, p.nombre, p.precio_venta
HAVING COUNT(*) >= 5 -- Solo productos con suficiente data
ORDER BY tasa_abandono DESC
LIMIT 10;

-- INSIGHT-002: Horarios óptimos para promociones según conversión QR
SELECT 
    EXTRACT(HOUR FROM qr.fecha_escaneo) as hora,
    COUNT(*) as total_escaneos,
    COUNT(*) FILTER (WHERE qr.conversion_exitosa = true) as conversiones,
    ROUND(
        (COUNT(*) FILTER (WHERE qr.conversion_exitosa = true)::decimal / COUNT(*)) * 100, 1
    ) as tasa_conversion,
    AVG(c.total) FILTER (WHERE qr.conversion_exitosa = true) as ticket_promedio,
    -- Oportunidad de mejora
    CASE 
        WHEN COUNT(*) >= 10 AND 
             (COUNT(*) FILTER (WHERE qr.conversion_exitosa = true)::decimal / COUNT(*)) < 0.6 
        THEN 'OPORTUNIDAD_PROMOCION'
        WHEN COUNT(*) >= 20 AND 
             (COUNT(*) FILTER (WHERE qr.conversion_exitosa = true)::decimal / COUNT(*)) >= 0.8 
        THEN 'HORARIO_ESTRELLA'
        ELSE 'MONITOREAR'
    END as clasificacion_horario
FROM qr_sessions_analytics qr
LEFT JOIN comandas c ON qr.comanda_id = c.id
WHERE qr.fecha_escaneo >= CURRENT_DATE - INTERVAL '14 days'
GROUP BY EXTRACT(HOUR FROM qr.fecha_escaneo)
HAVING COUNT(*) >= 5
ORDER BY tasa_conversion DESC;

-- ===============================================
-- 📈 COMPARATIVAS Y BENCHMARKS
-- ===============================================

-- BENCH-001: Comparación performance vs período anterior
WITH periodo_actual AS (
    SELECT 
        COUNT(DISTINCT c.id) as comandas,
        SUM(c.total) as ingresos,
        AVG(c.total) as ticket_promedio,
        COUNT(DISTINCT qr.id) as sesiones_qr,
        COUNT(DISTINCT qr.id) FILTER (WHERE qr.conversion_exitosa = true) as conversiones_qr
    FROM comandas c
    LEFT JOIN qr_sessions_analytics qr ON c.qr_session_id = qr.id
    WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '7 days'
),
periodo_anterior AS (
    SELECT 
        COUNT(DISTINCT c.id) as comandas,
        SUM(c.total) as ingresos,
        AVG(c.total) as ticket_promedio,
        COUNT(DISTINCT qr.id) as sesiones_qr,
        COUNT(DISTINCT qr.id) FILTER (WHERE qr.conversion_exitosa = true) as conversiones_qr
    FROM comandas c
    LEFT JOIN qr_sessions_analytics qr ON c.qr_session_id = qr.id
    WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '14 days'
    AND c.fecha_hora < CURRENT_DATE - INTERVAL '7 days'
)
SELECT 
    -- Métricas actuales
    pa.comandas as comandas_actual,
    pa.ingresos as ingresos_actual,
    pa.ticket_promedio as ticket_actual,
    pa.sesiones_qr as sesiones_qr_actual,
    
    -- Métricas período anterior
    pan.comandas as comandas_anterior,
    pan.ingresos as ingresos_anterior,
    pan.ticket_promedio as ticket_anterior,
    pan.sesiones_qr as sesiones_qr_anterior,
    
    -- Cambios porcentuales
    ROUND(((pa.comandas - pan.comandas)::decimal / NULLIF(pan.comandas, 0)) * 100, 1) as cambio_comandas_pct,
    ROUND(((pa.ingresos - pan.ingresos)::decimal / NULLIF(pan.ingresos, 0)) * 100, 1) as cambio_ingresos_pct,
    ROUND(((pa.ticket_promedio - pan.ticket_promedio)::decimal / NULLIF(pan.ticket_promedio, 0)) * 100, 1) as cambio_ticket_pct,
    ROUND(((pa.sesiones_qr - pan.sesiones_qr)::decimal / NULLIF(pan.sesiones_qr, 0)) * 100, 1) as cambio_qr_pct
FROM periodo_actual pa
CROSS JOIN periodo_anterior pan;

-- ===============================================
-- ⚠️ MONITOREO Y ALERTAS
-- ===============================================

-- ALERT-001: Sistema de alertas operacionales
SELECT 
    'OCUPACION_CRITICA' as tipo_alerta,
    'Ocupación de mesas superior al 90%' as mensaje,
    'ALTA' as prioridad,
    NOW() as timestamp_alerta
WHERE (
    SELECT COUNT(*) FILTER (WHERE estado = 'ocupada')::decimal / COUNT(*) 
    FROM mesas
) > 0.9

UNION ALL

SELECT 
    'COMANDAS_ACUMULADAS' as tipo_alerta,
    'Más de 10 comandas pendientes en cocina' as mensaje,
    'MEDIA' as prioridad,
    NOW() as timestamp_alerta
WHERE (
    SELECT COUNT(*) 
    FROM comandas 
    WHERE estado IN ('pendiente', 'en_preparacion')
) > 10

UNION ALL

SELECT 
    'CONVERSION_QR_BAJA' as tipo_alerta,
    'Conversión QR por debajo del 60% en última hora' as mensaje,
    'MEDIA' as prioridad,
    NOW() as timestamp_alerta
WHERE (
    SELECT 
        COUNT(*) FILTER (WHERE conversion_exitosa = true)::decimal / 
        NULLIF(COUNT(*), 0)
    FROM qr_sessions_analytics
    WHERE fecha_escaneo >= CURRENT_TIMESTAMP - INTERVAL '1 hour'
) < 0.6

UNION ALL

SELECT 
    'PRODUCTOS_SIN_STOCK' as tipo_alerta,
    COUNT(*) || ' productos sin stock disponible' as mensaje,
    'ALTA' as prioridad,
    NOW() as timestamp_alerta
FROM inventario
WHERE stock_actual <= 0
HAVING COUNT(*) > 0;

-- ===============================================
-- 📝 NOTAS PARA DESARROLLO
-- ===============================================

/*
🎯 IMPLEMENTACIÓN RECOMENDADA:

1. **Índices Críticos**:
   - CREATE INDEX idx_comandas_fecha_estado ON comandas(fecha_hora, estado);
   - CREATE INDEX idx_qr_sessions_fecha ON qr_sessions_analytics(fecha_escaneo);
   - CREATE INDEX idx_comanda_productos_comanda_persona ON comanda_productos(comanda_id, persona_identificador);

2. **Vistas Materializadas** (para queries frecuentes):
   - mv_dashboard_tiempo_real (actualización cada 30 seg)
   - mv_productos_populares_semanal (actualización diaria)
   - mv_metricas_conversion_qr (actualización cada hora)

3. **Triggers Automáticos**:
   - Actualización automática de totales en comandas
   - Descuento automático de inventario
   - Registro de eventos en analytics_eventos

4. **Optimizaciones**:
   - Particionamiento de tablas por fecha para analytics
   - Archivado automático de datos antiguos
   - Cache Redis para queries de dashboard

5. **Monitoreo**:
   - Alertas automáticas por email/SMS para situaciones críticas
   - Dashboard en tiempo real con WebSockets
   - Logs estructurados para debugging

*/
