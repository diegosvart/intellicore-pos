-- ===============================================
-- CONFIGURACIÓN BASE DE PARÁMETROS DEL SISTEMA
-- Sistema de Control de Bar/Restaurante v3.0
-- ===============================================

-- Insertar parámetros de configuración modular
INSERT INTO parametro (
    codigo_parametro, nombre, valor, tipo_dato, descripcion, 
    categoria, nivel, dependencias, impacto_performance, 
    modificable, requiere_reinicio, valor_default
) VALUES 

-- ===============================================
-- MÓDULOS PRINCIPALES
-- ===============================================
('MODULO_COCINA_ACTIVO', 'Módulo de Cocina', 'true', 'boolean', 
 'Habilita/deshabilita todo el módulo de cocina y sus funcionalidades', 
 'modulos', 'sistema', NULL, true, true, false, 'true'),

('MODULO_INVENTARIO_ACTIVO', 'Control de Inventario', 'true', 'boolean', 
 'Habilita control automático de stock y materias primas', 
 'modulos', 'sistema', '["MODULO_COCINA_ACTIVO"]', true, true, false, 'true'),

('MODULO_CUENTAS_CORRIENTES', 'Cuentas Corrientes', 'true', 'boolean', 
 'Habilita manejo de cuentas corrientes de clientes', 
 'modulos', 'sistema', NULL, false, true, false, 'false'),

('MODULO_REPORTES_AVANZADOS', 'Reportes Avanzados', 'true', 'boolean', 
 'Habilita módulo completo de reportes y analytics', 
 'modulos', 'sistema', NULL, true, true, false, 'true'),

-- ===============================================
-- INTERFACES DE USUARIO
-- ===============================================
('VISTA_COCINA_ACTIVA', 'Vista de Cocina', 'true', 'boolean', 
 'Muestra interfaz específica para cocina', 
 'interfaces', 'modulo', '["MODULO_COCINA_ACTIVO"]', false, true, false, 'true'),

('VISTA_INVENTARIO_ACTIVA', 'Vista de Inventario', 'true', 'boolean', 
 'Muestra interfaz de gestión de inventarios', 
 'interfaces', 'modulo', '["MODULO_INVENTARIO_ACTIVO"]', false, true, false, 'true'),

('VISTA_DASHBOARD_PROPIETARIO', 'Dashboard Propietario', 'true', 'boolean', 
 'Muestra dashboard completo para propietarios', 
 'interfaces', 'modulo', '["MODULO_REPORTES_AVANZADOS"]', false, true, false, 'true'),

('VISTA_SIMPLIFICADA_MESERO', 'Vista Simplificada Mesero', 'false', 'boolean', 
 'Activa vista simplificada sin opciones avanzadas para meseros', 
 'interfaces', 'modulo', NULL, false, true, false, 'false'),

-- ===============================================
-- REGLAS DE NEGOCIO
-- ===============================================
('RECETAS_OBLIGATORIAS', 'Recetas Obligatorias', 'false', 'boolean', 
 'Requiere receta obligatoria para todos los platos de comida', 
 'business_rules', 'modulo', '["MODULO_INVENTARIO_ACTIVO"]', false, true, false, 'false'),

('CONTROL_STOCK_AUTOMATICO', 'Control Stock Automático', 'true', 'boolean', 
 'Descuenta automáticamente stock al confirmar pedidos', 
 'business_rules', 'modulo', '["MODULO_INVENTARIO_ACTIVO"]', true, true, false, 'true'),

('ALERTAS_STOCK_ACTIVAS', 'Alertas de Stock', 'true', 'boolean', 
 'Genera alertas automáticas cuando stock está bajo mínimo', 
 'business_rules', 'modulo', '["MODULO_INVENTARIO_ACTIVO"]', false, true, false, 'true'),

('VALIDAR_STOCK_ANTES_PEDIDO', 'Validar Stock en Pedidos', 'false', 'boolean', 
 'Valida disponibilidad de stock antes de aceptar pedidos', 
 'business_rules', 'modulo', '["MODULO_INVENTARIO_ACTIVO"]', true, true, false, 'false'),

('PROPINAS_OBLIGATORIAS', 'Propinas Obligatorias', 'false', 'boolean', 
 'Requiere ingresar propina obligatoriamente al cerrar cuenta', 
 'business_rules', 'modulo', NULL, false, true, false, 'false'),

('DIVISION_CUENTA_AUTOMATICA', 'División de Cuenta Automática', 'true', 'boolean', 
 'Permite dividir cuentas automáticamente por cliente', 
 'business_rules', 'modulo', NULL, false, true, false, 'true'),

-- ===============================================
-- MODOS DE OPERACIÓN
-- ===============================================
('MODO_RESTAURANTE_RAPIDO', 'Modo Fast Food', 'false', 'boolean', 
 'Simplifica flujo para comida rápida - pedidos van directo a listo', 
 'modos', 'sistema', NULL, true, true, false, 'false'),

('MODO_BAR_SIMPLE', 'Modo Bar Simple', 'false', 'boolean', 
 'Modo ultra-simplificado solo para bebidas sin cocina', 
 'modos', 'sistema', NULL, true, true, true, 'false'),

('MODO_RESTAURANTE_GOURMET', 'Modo Restaurante Gourmet', 'false', 'boolean', 
 'Activa todas las funcionalidades con control granular', 
 'modos', 'sistema', NULL, true, true, true, 'false'),

('MODO_AUTOSERVICIO', 'Modo Autoservicio', 'false', 'boolean', 
 'Habilita funcionalidades para autoservicio/buffet', 
 'modos', 'sistema', NULL, true, true, false, 'false'),

-- ===============================================
-- CONFIGURACIONES DE RENDIMIENTO
-- ===============================================
('CALCULAR_METRICAS_TIEMPO_REAL', 'Métricas en Tiempo Real', 'true', 'boolean', 
 'Calcula métricas diarias en tiempo real vs batch nocturno', 
 'performance', 'sistema', NULL, true, true, false, 'true'),

('CACHE_MENU_ACTIVO', 'Cache de Menú', 'true', 'boolean', 
 'Mantiene cache de menú en memoria para mejor performance', 
 'performance', 'sistema', NULL, true, true, true, 'true'),

('LOG_DETALLADO_PEDIDOS', 'Log Detallado de Pedidos', 'false', 'boolean', 
 'Registra log detallado de todos los cambios en pedidos', 
 'performance', 'sistema', NULL, true, true, false, 'false'),

-- ===============================================
-- CONFIGURACIONES FUNCIONALES
-- ===============================================
('TIEMPO_LIMITE_MESA_MINUTOS', 'Tiempo Límite Mesa', '180', 'integer', 
 'Tiempo máximo en minutos antes de alerta de mesa ocupada', 
 'operaciones', 'modulo', NULL, false, true, false, '180'),

('STOCK_MINIMO_DEFAULT', 'Stock Mínimo Default', '10', 'decimal', 
 'Valor por defecto para stock mínimo de nuevas materias primas', 
 'operaciones', 'modulo', NULL, false, true, false, '10'),

('PORCENTAJE_PROPINA_SUGERIDO', 'Propina Sugerida %', '10', 'decimal', 
 'Porcentaje de propina sugerido por defecto', 
 'operaciones', 'modulo', NULL, false, true, false, '10'),

('NUMERO_PEDIDOS_SIMULTANEOS_MAX', 'Máx Pedidos Simultáneos', '50', 'integer', 
 'Número máximo de pedidos que puede procesar la cocina simultáneamente', 
 'operaciones', 'modulo', '["MODULO_COCINA_ACTIVO"]', true, true, false, '50'),

-- ===============================================
-- CONFIGURACIONES DE INTEGRACIÓN
-- ===============================================
('API_EXTERNA_ACTIVA', 'API Externa', 'false', 'boolean', 
 'Habilita integración con APIs externas (delivery, pagos)', 
 'integraciones', 'sistema', NULL, false, true, true, 'false'),

('SINCRONIZACION_NUBE', 'Sincronización en Nube', 'false', 'boolean', 
 'Sincroniza datos con respaldo en nube', 
 'integraciones', 'sistema', NULL, true, true, true, 'false'),

('NOTIFICACIONES_PUSH', 'Notificaciones Push', 'false', 'boolean', 
 'Envía notificaciones push a dispositivos móviles', 
 'integraciones', 'sistema', NULL, false, true, false, 'false');

-- ===============================================
-- CONFIGURACIONES CONTEXTUALES DE EJEMPLO
-- ===============================================

-- Configuración para turno nocturno (cocina cerrada)
INSERT INTO configuracion_contextual (
    contexto, parametro_codigo, valor_override, fecha_inicio, fecha_fin, 
    activa, descripcion, creado_por, fecha_creacion
) VALUES 
('turno_noche', 'MODULO_COCINA_ACTIVO', 'false', 
 '2025-01-01 22:00:00', '2025-12-31 06:00:00', true, 
 'Deshabilitar cocina durante turno nocturno', 1, NOW()),

('fin_de_semana', 'TIEMPO_LIMITE_MESA_MINUTOS', '240', 
 '2025-01-01 00:00:00', '2025-12-31 23:59:59', true, 
 'Extender tiempo límite de mesa los fines de semana', 1, NOW()),

('evento_buffet', 'MODO_AUTOSERVICIO', 'true', 
 '2025-02-14 00:00:00', '2025-02-14 23:59:59', true, 
 'Activar modo autoservicio para evento especial', 1, NOW()),

('promocion_happy_hour', 'PROPINAS_OBLIGATORIAS', 'false', 
 '2025-01-01 17:00:00', '2025-12-31 19:00:00', true, 
 'Eliminar propinas obligatorias durante happy hour', 1, NOW());

-- ===============================================
-- PRESETS PARA TIPOS DE NEGOCIO
-- ===============================================

-- PRESET: Bar Simple
-- UPDATE parametro SET valor = 'false' WHERE codigo_parametro IN (
--     'MODULO_COCINA_ACTIVO', 'MODULO_INVENTARIO_ACTIVO', 'RECETAS_OBLIGATORIAS'
-- );
-- UPDATE parametro SET valor = 'true' WHERE codigo_parametro = 'MODO_BAR_SIMPLE';

-- PRESET: Fast Food
-- UPDATE parametro SET valor = 'true' WHERE codigo_parametro IN (
--     'MODO_RESTAURANTE_RAPIDO', 'VISTA_SIMPLIFICADA_MESERO'
-- );
-- UPDATE parametro SET valor = 'false' WHERE codigo_parametro IN (
--     'RECETAS_OBLIGATORIAS', 'VALIDAR_STOCK_ANTES_PEDIDO'
-- );

-- PRESET: Restaurante Gourmet
-- UPDATE parametro SET valor = 'true' WHERE codigo_parametro IN (
--     'MODO_RESTAURANTE_GOURMET', 'MODULO_COCINA_ACTIVO', 'MODULO_INVENTARIO_ACTIVO',
--     'RECETAS_OBLIGATORIAS', 'CONTROL_STOCK_AUTOMATICO', 'ALERTAS_STOCK_ACTIVAS'
-- );

-- ===============================================
-- FUNCIONES AUXILIARES PARA CONFIGURACIÓN
-- ===============================================

-- Función para obtener valor efectivo de parámetro (considerando contexto)
CREATE OR REPLACE FUNCTION get_parametro_efectivo(codigo VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
    valor_contextual VARCHAR;
    valor_base VARCHAR;
BEGIN
    -- Verificar si hay override contextual activo
    SELECT valor_override INTO valor_contextual
    FROM configuracion_contextual cc
    WHERE cc.parametro_codigo = codigo
    AND cc.activa = true
    AND NOW() BETWEEN cc.fecha_inicio AND cc.fecha_fin
    ORDER BY fecha_creacion DESC
    LIMIT 1;
    
    -- Si no hay override, usar valor base
    IF valor_contextual IS NULL THEN
        SELECT valor INTO valor_base
        FROM parametro
        WHERE codigo_parametro = codigo;
        RETURN valor_base;
    END IF;
    
    RETURN valor_contextual;
END;
$$ LANGUAGE plpgsql;

-- Función para aplicar preset de configuración
CREATE OR REPLACE FUNCTION aplicar_preset_configuracion(preset_nombre VARCHAR)
RETURNS TEXT AS $$
DECLARE
    mensaje TEXT;
BEGIN
    CASE preset_nombre
        WHEN 'bar_simple' THEN
            UPDATE parametro SET valor = 'false' WHERE codigo_parametro IN (
                'MODULO_COCINA_ACTIVO', 'MODULO_INVENTARIO_ACTIVO', 'RECETAS_OBLIGATORIAS'
            );
            UPDATE parametro SET valor = 'true' WHERE codigo_parametro = 'MODO_BAR_SIMPLE';
            mensaje := 'Configuración aplicada: Bar Simple';
            
        WHEN 'fast_food' THEN
            UPDATE parametro SET valor = 'true' WHERE codigo_parametro IN (
                'MODO_RESTAURANTE_RAPIDO', 'VISTA_SIMPLIFICADA_MESERO'
            );
            UPDATE parametro SET valor = 'false' WHERE codigo_parametro IN (
                'RECETAS_OBLIGATORIAS', 'VALIDAR_STOCK_ANTES_PEDIDO'
            );
            mensaje := 'Configuración aplicada: Fast Food';
            
        WHEN 'restaurante_gourmet' THEN
            UPDATE parametro SET valor = 'true' WHERE codigo_parametro IN (
                'MODO_RESTAURANTE_GOURMET', 'MODULO_COCINA_ACTIVO', 'MODULO_INVENTARIO_ACTIVO',
                'RECETAS_OBLIGATORIAS', 'CONTROL_STOCK_AUTOMATICO', 'ALERTAS_STOCK_ACTIVAS'
            );
            mensaje := 'Configuración aplicada: Restaurante Gourmet';
            
        ELSE
            mensaje := 'Preset no reconocido. Opciones: bar_simple, fast_food, restaurante_gourmet';
    END CASE;
    
    RETURN mensaje;
END;
$$ LANGUAGE plpgsql;

-- ===============================================
-- VISTAS PARA ADMINISTRACIÓN DE CONFIGURACIÓN
-- ===============================================

-- Vista para panel de administración
CREATE VIEW vista_configuracion_admin AS
SELECT 
    p.categoria,
    p.codigo_parametro,
    p.nombre,
    p.valor as valor_actual,
    get_parametro_efectivo(p.codigo_parametro) as valor_efectivo,
    p.tipo_dato,
    p.descripcion,
    p.nivel,
    p.modificable,
    p.requiere_reinicio,
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM configuracion_contextual cc 
            WHERE cc.parametro_codigo = p.codigo_parametro 
            AND cc.activa = true 
            AND NOW() BETWEEN cc.fecha_inicio AND cc.fecha_fin
        ) THEN 'Override activo'
        ELSE 'Valor base'
    END as estado_configuracion,
    p.dependencias
FROM parametro p
ORDER BY p.categoria, p.nombre;

-- Vista de configuraciones contextuales activas
CREATE VIEW vista_configuraciones_contextuales_activas AS
SELECT 
    cc.contexto,
    p.nombre as parametro_nombre,
    cc.parametro_codigo,
    p.valor as valor_base,
    cc.valor_override,
    cc.fecha_inicio,
    cc.fecha_fin,
    cc.descripcion,
    u.nombre as creado_por_nombre
FROM configuracion_contextual cc
JOIN parametro p ON cc.parametro_codigo = p.codigo_parametro
JOIN usuario u ON cc.creado_por = u.id_usuario
WHERE cc.activa = true
AND NOW() BETWEEN cc.fecha_inicio AND cc.fecha_fin
ORDER BY cc.fecha_inicio DESC;

-- ===============================================
-- COMENTARIOS FINALES
-- ===============================================

-- Esta configuración proporciona:
-- 1. Máxima flexibilidad para diferentes tipos de negocio
-- 2. Configuración granular por módulo y funcionalidad
-- 3. Soporte para configuraciones temporales/contextuales
-- 4. Presets listos para usar según tipo de establecimiento
-- 5. Funciones auxiliares para gestión automática
-- 6. Vistas administrativas para control total

-- Para usar, simplemente:
-- SELECT aplicar_preset_configuracion('bar_simple');
-- O configurar manualmente via UPDATE en tabla parametro
