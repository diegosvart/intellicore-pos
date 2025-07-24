-- Script SQL para crear el modelo completo del Sistema de Control de Bar
-- Compatible con PostgreSQL

-- Crear base de datos
-- CREATE DATABASE sistema_control_bar;
-- USE sistema_control_bar;

-- Tabla de sectores (debe crearse primero)
CREATE TABLE sector (
    id_sector SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de unidades de medida
CREATE TABLE unidad_medida (
    id_unidad SERIAL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

-- Tabla de métodos de pago
CREATE TABLE metodo_pago (
    id_metodo SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de motivos
CREATE TABLE motivo (
    id_motivo SERIAL PRIMARY KEY,
    descripcion VARCHAR(200) NOT NULL
);

-- Tabla de parámetros de configuración
CREATE TABLE parametro (
    codigo_parametro VARCHAR(20) PRIMARY KEY,
    valor VARCHAR(100) NOT NULL
);

-- Tabla de usuarios
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    perfil VARCHAR(50) NOT NULL,
    acceso BOOLEAN NOT NULL DEFAULT TRUE,
    permisos VARCHAR(200)
);

-- Tabla de clientes
CREATE TABLE cliente (
    rut VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    cuenta_corriente DECIMAL(10,2) DEFAULT 0.00
);

-- Tabla de mesas
CREATE TABLE mesa (
    id_mesa SERIAL PRIMARY KEY,
    sector INTEGER NOT NULL,
    FOREIGN KEY (sector) REFERENCES sector(id_sector)
);

-- Tabla de recetas
CREATE TABLE receta (
    id_receta SERIAL PRIMARY KEY,
    descripcion VARCHAR(200),
    costo DECIMAL(10,2) NOT NULL DEFAULT 0.00
);

-- Tabla de materias primas
CREATE TABLE materia_prima (
    id_materia SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    unidad_medida INTEGER NOT NULL,
    stock_actual DECIMAL(10,3) NOT NULL DEFAULT 0.000,
    FOREIGN KEY (unidad_medida) REFERENCES unidad_medida(id_unidad)
);

-- Tabla de relación receta-materia prima
CREATE TABLE receta_materia (
    id_receta INTEGER NOT NULL,
    id_materia INTEGER NOT NULL,
    cantidad DECIMAL(10,3) NOT NULL,
    PRIMARY KEY (id_receta, id_materia),
    FOREIGN KEY (id_receta) REFERENCES receta(id_receta) ON DELETE CASCADE,
    FOREIGN KEY (id_materia) REFERENCES materia_prima(id_materia) ON DELETE CASCADE
);

-- Tabla de comidas
CREATE TABLE comida (
    id_comida SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    receta INTEGER,
    precio_costo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    precio_venta DECIMAL(10,2) NOT NULL,
    familia VARCHAR(50),
    FOREIGN KEY (receta) REFERENCES receta(id_receta)
);

-- Tabla de tragos
CREATE TABLE trago (
    id_trago SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio_costo DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    precio_venta DECIMAL(10,2) NOT NULL,
    familia VARCHAR(50),
    sub_familia VARCHAR(50)
);

-- Tabla de cuentas
CREATE TABLE cuenta (
    id_cuenta SERIAL PRIMARY KEY,
    mesa_id INTEGER NOT NULL,
    total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    metodo_pago INTEGER NOT NULL,
    propina DECIMAL(10,2) DEFAULT 0.00,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (mesa_id) REFERENCES mesa(id_mesa),
    FOREIGN KEY (metodo_pago) REFERENCES metodo_pago(id_metodo)
);

-- Tabla de productos en cuenta (detalle de factura)
CREATE TABLE cuenta_producto (
    id_cuenta INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    tipo_producto VARCHAR(10) NOT NULL CHECK (tipo_producto IN ('comida', 'trago')),
    cantidad INTEGER NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_cuenta, producto_id, tipo_producto),
    FOREIGN KEY (id_cuenta) REFERENCES cuenta(id_cuenta) ON DELETE CASCADE
);

-- Tabla de movimientos de cuenta corriente
CREATE TABLE cuenta_corriente (
    id_cc SERIAL PRIMARY KEY,
    cliente_id VARCHAR(12) NOT NULL,
    fecha DATE NOT NULL DEFAULT CURRENT_DATE,
    detalle VARCHAR(200),
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(rut)
);

-- Índices para mejorar rendimiento
CREATE INDEX idx_mesa_sector ON mesa(sector);
CREATE INDEX idx_cuenta_mesa ON cuenta(mesa_id);
CREATE INDEX idx_cuenta_fecha ON cuenta(fecha_creacion);
CREATE INDEX idx_cuenta_corriente_cliente ON cuenta_corriente(cliente_id);
CREATE INDEX idx_cuenta_corriente_fecha ON cuenta_corriente(fecha);
CREATE INDEX idx_materia_prima_unidad ON materia_prima(unidad_medida);
CREATE INDEX idx_comida_receta ON comida(receta);
CREATE INDEX idx_cuenta_producto_cuenta ON cuenta_producto(id_cuenta);

-- Insertar datos básicos de ejemplo
INSERT INTO sector (nombre) VALUES 
('Terraza'),
('Salón Principal'),
('Bar'),
('VIP');

INSERT INTO unidad_medida (nombre) VALUES 
('Kilogramos'),
('Gramos'),
('Litros'),
('Mililitros'),
('Unidades');

INSERT INTO metodo_pago (nombre) VALUES 
('Efectivo'),
('Tarjeta de Crédito'),
('Tarjeta de Débito'),
('Transferencia'),
('Cuenta Corriente');

-- Comentarios en las tablas
COMMENT ON TABLE cliente IS 'Información de clientes del bar';
COMMENT ON TABLE mesa IS 'Mesas disponibles en el establecimiento';
COMMENT ON TABLE sector IS 'Sectores donde se ubican las mesas';
COMMENT ON TABLE cuenta IS 'Cuentas/facturas generadas';
COMMENT ON TABLE cuenta_corriente IS 'Movimientos de cuenta corriente de clientes';
COMMENT ON TABLE comida IS 'Platos del menú';
COMMENT ON TABLE trago IS 'Bebidas del menú';
COMMENT ON TABLE cuenta_producto IS 'Detalle de productos en cada cuenta';
COMMENT ON TABLE receta IS 'Recetas para preparar comidas';
COMMENT ON TABLE materia_prima IS 'Ingredientes y materias primas';
COMMENT ON TABLE receta_materia IS 'Relación entre recetas y materias primas';
COMMENT ON TABLE unidad_medida IS 'Unidades de medida para materias primas';
COMMENT ON TABLE metodo_pago IS 'Métodos de pago disponibles';
COMMENT ON TABLE motivo IS 'Motivos para diferentes operaciones';
COMMENT ON TABLE parametro IS 'Parámetros de configuración del sistema';
COMMENT ON TABLE usuario IS 'Usuarios del sistema';
