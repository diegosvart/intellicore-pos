# GUÍA DE DESARROLLO LLM - IntelliCore POS
## Metodología de Desarrollo Iterativo Inteligente

### 🎯 PROPÓSITO DE ESTA DOCUMENTACIÓN

Esta documentación está **específicamente optimizada** para que **LLMs (Large Language Models)** puedan:

1. **Comprender completamente** el contexto del sistema IntelliCore POS
2. **Generar código funcional** sin necesidad de contexto adicional
3. **Realizar iteraciones inteligentes** con conocimiento completo del dominio
4. **Proporcionar soluciones consistentes** alineadas con la arquitectura

---

## 📚 ESTRUCTURA DE LA DOCUMENTACIÓN LLM

### 1. **MODELO_BD_COMPLETO_LLM.md**
- **Propósito**: Contexto completo de la base de datos y arquitectura de negocio
- **Uso para LLM**: Primera referencia para entender el dominio y las relaciones entre entidades
- **Contiene**: 
  - 5 capas de arquitectura claramente definidas
  - Casos de uso principales y diferenciadores del sistema
  - Guías de desarrollo y consideraciones técnicas

### 2. **DICCIONARIO_COMPLETO.json**
- **Propósito**: Metadatos estructurados para generación automática de código
- **Uso para LLM**: Referencia técnica para nombres de campos, tipos de datos, relaciones
- **Contiene**: 
  - Definiciones exactas de todas las tablas
  - Patrones de queries comunes
  - Características de ML y analytics

### 3. **CASOS_USO_DETALLADOS.md**
- **Propósito**: Escenarios reales de negocio con flujos completos
- **Uso para LLM**: Entender la lógica de negocio y implementar funcionalidades end-to-end
- **Contiene**: 
  - Flujos paso a paso de cada caso de uso
  - Queries SQL específicos para cada escenario
  - Métricas y KPIs esperados

### 4. **QUERIES_CASOS_USO.sql**
- **Propósito**: Biblioteca de queries SQL copy-paste ready para desarrollo rápido
- **Uso para LLM**: Reutilización directa de código SQL probado y optimizado
- **Contiene**: 
  - Queries organizados por módulo funcional
  - Comentarios explicativos para cada query
  - Patrones de optimización y buenas prácticas

---

## 🤖 INSTRUCCIONES PARA LLMs

### Protocolo de Consulta Recomendado

Cuando un desarrollador te solicite ayuda con IntelliCore POS, sigue este protocolo:

#### 1. **Análisis de Contexto** (Paso Obligatorio)
```
1. Leer MODELO_BD_COMPLETO_LLM.md para entender el dominio
2. Consultar DICCIONARIO_COMPLETO.json para datos técnicos precisos
3. Identificar el caso de uso relevante en CASOS_USO_DETALLADOS.md
4. Buscar queries relacionados en QUERIES_CASOS_USO.sql
```

#### 2. **Generación de Respuesta**
- **Siempre** usar nombres de tablas y campos exactos del diccionario
- **Reutilizar** queries existentes cuando sea posible
- **Mantener** consistencia con la arquitectura de 5 capas
- **Explicar** el razonamiento detrás de las decisiones técnicas

#### 3. **Validación de Solución**
- Verificar que la solución esté alineada con los casos de uso documentados
- Confirmar que las métricas generadas sean las esperadas
- Asegurar que el código siga los patrones establecidos

---

## 🎯 CASOS DE USO PARA LLMs

### CU-LLM-001: Desarrollador Solicita Nueva Funcionalidad

**Contexto**: "Necesito implementar notificaciones automáticas cuando el inventario esté bajo"

**Proceso LLM**:
1. **Consultar** MODELO_BD_COMPLETO_LLM.md → Sección "Control de Inventario"
2. **Revisar** DICCIONARIO_COMPLETO.json → Tabla `inventario` y campos relacionados
3. **Localizar** en QUERIES_CASOS_USO.sql → Query `INV-003: Alertas de stock bajo`
4. **Generar** código adaptado usando el query base como foundation

**Output Esperado**:
```sql
-- Basado en query INV-003 pero adaptado para notificaciones automáticas
CREATE OR REPLACE FUNCTION check_low_inventory_alerts()
RETURNS TABLE(producto_id INT, mensaje TEXT, nivel_alerta TEXT) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        'Stock bajo: ' || p.nombre || ' (Quedan ' || i.stock_actual || ' unidades)' as mensaje,
        CASE 
            WHEN i.stock_actual <= 0 THEN 'CRITICO'
            WHEN i.stock_actual <= i.stock_minimo THEN 'ALTO'
            WHEN i.stock_actual <= i.punto_reorden THEN 'MEDIO'
        END as nivel_alerta
    FROM productos p
    JOIN inventario i ON p.id = i.producto_id
    WHERE i.stock_actual <= i.punto_reorden;
END;
$$ LANGUAGE plpgsql;
```

### CU-LLM-002: Desarrollador Necesita Endpoint API

**Contexto**: "Crear endpoint para dashboard de métricas en tiempo real"

**Proceso LLM**:
1. **Identificar** en CASOS_USO_DETALLADOS.md → CU-005: Dashboard Ejecutivo en Vivo
2. **Usar** query `ANA-001: Dashboard tiempo real` de QUERIES_CASOS_USO.sql
3. **Generar** endpoint FastAPI completo

**Output Esperado**:
```python
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import Dict, Any

router = APIRouter()

@router.get("/dashboard/tiempo-real")
async def get_dashboard_tiempo_real(db: Session = Depends(get_db)) -> Dict[str, Any]:
    """
    Endpoint para métricas de dashboard en tiempo real
    Basado en CU-005 y query ANA-001
    """
    query = """
    -- Query ANA-001 de QUERIES_CASOS_USO.sql (versión adaptada)
    SELECT 
        COUNT(DISTINCT m.id) FILTER (WHERE m.estado = 'ocupada') as mesas_ocupadas,
        COUNT(DISTINCT m.id) as total_mesas,
        ROUND((COUNT(DISTINCT m.id) FILTER (WHERE m.estado = 'ocupada')::decimal / 
               COUNT(DISTINCT m.id)) * 100, 1) as porcentaje_ocupacion,
        -- ... resto del query
    FROM mesas m
    LEFT JOIN comandas c ON m.id = c.mesa_id
    LEFT JOIN qr_sessions_analytics qr ON m.id = qr.mesa_id
    """
    
    result = db.execute(query).fetchone()
    
    return {
        "mesas": {
            "ocupadas": result.mesas_ocupadas,
            "total": result.total_mesas,
            "porcentaje_ocupacion": result.porcentaje_ocupacion
        },
        "timestamp": datetime.now().isoformat()
    }
```

### CU-LLM-003: Desarrollador Pregunta Sobre Arquitectura

**Contexto**: "¿Cómo implementar split billing para grupos?"

**Proceso LLM**:
1. **Consultar** MODELO_BD_COMPLETO_LLM.md → Diferenciadores clave
2. **Revisar** CASOS_USO_DETALLADOS.md → CU-002 y CU-004
3. **Referenciar** queries FACT-001 y algoritmo de split billing
4. **Explicar** la arquitectura completa

**Output Esperado**:
```
El split billing en IntelliCore POS se basa en tres componentes clave:

1. **Campo persona_identificador** en tabla comanda_productos:
   - Permite asociar cada producto a una persona específica
   - NULL indica items compartidos del grupo
   
2. **Algoritmo de distribución** (query FACT-001):
   - Calcula consumo individual de cada persona
   - Distribuye items compartidos proporcionalmente
   - Genera facturas separadas automáticamente

3. **Flujo UX** (CU-002):
   - Primera persona escanea QR → Crea sesión grupal
   - Otros se unen mediante enlace compartido
   - Cada uno agrega sus productos con identificación automática
   - Sistema genera facturas individuales al finalizar

Este enfoque diferencia a IntelliCore POS de POS tradicionales y permite 
aumentar el ticket promedio al facilitar pedidos grupales.
```

---

## 🔧 PATRONES DE CÓDIGO RECOMENDADOS

### Patrón 1: Reutilización de Queries Base
```python
# ❌ MAL: Crear query desde cero
def get_productos_populares():
    query = "SELECT p.nombre, COUNT(*) FROM productos p JOIN..."
    
# ✅ BIEN: Usar query documentado como base
def get_productos_populares():
    # Basado en query ANA-002 de QUERIES_CASOS_USO.sql
    query = """
    SELECT 
        p.id, p.nombre, p.categoria_id, cat.nombre as categoria_nombre,
        SUM(cp.cantidad) as total_vendido,
        COUNT(DISTINCT cp.comanda_id) as apariciones_comandas,
        SUM(cp.cantidad * cp.precio_unitario) as ingresos_generados
    FROM productos p
    JOIN categorias cat ON p.categoria_id = cat.id
    JOIN comanda_productos cp ON p.id = cp.producto_id
    JOIN comandas c ON cp.comanda_id = c.id
    WHERE c.fecha_hora >= CURRENT_DATE - INTERVAL '7 days'
    AND c.estado NOT IN ('cancelada')
    GROUP BY p.id, p.nombre, p.categoria_id, cat.nombre
    ORDER BY total_vendido DESC
    LIMIT 20
    """
```

### Patrón 2: Uso Consistente de Nomenclatura
```python
# ❌ MAL: Nombres inconsistentes
def create_order(table_num, items):
    
# ✅ BIEN: Usar nomenclatura exacta del diccionario
def create_comanda(mesa_id: int, productos: List[ComandaProducto]):
    # Usar campos exactos de tabla 'comandas'
    comanda_data = {
        "mesa_id": mesa_id,
        "numero_comanda": get_next_numero_comanda(),
        "fecha_hora": datetime.now(),
        "estado": "pendiente",
        "tipo_servicio": "mesa",
        "canal_origen": "qr_autoservicio"
    }
```

### Patrón 3: Implementación de Casos de Uso Completos
```python
# ✅ BIEN: Implementar caso de uso completo como está documentado
async def process_qr_order(qr_session_id: str, productos: List[ProductoRequest]):
    """
    Implementa CU-001: Cliente Escanea QR y Realiza Pedido Individual
    """
    # Paso 1: Validar sesión QR (como en flujo CU-001)
    session = await validate_qr_session(qr_session_id)
    
    # Paso 2: Crear comanda (query COM-001)
    comanda = await create_comanda_from_qr(session.mesa_id, qr_session_id)
    
    # Paso 3: Añadir productos (query COM-002)
    for producto in productos:
        await add_producto_to_comanda(comanda.id, producto)
    
    # Paso 4: Calcular totales (query COM-003)
    await calculate_comanda_totals(comanda.id)
    
    # Paso 5: Finalizar sesión QR (query QR-004)
    await finalize_qr_session(qr_session_id, comanda.id)
    
    return comanda
```

---

## 📊 MÉTRICAS DE EFECTIVIDAD LLM

Para medir la efectividad de esta documentación LLM, considera estos KPIs:

### Métricas de Desarrollo
- **Tiempo Implementación**: Reducción 60-80% vs desarrollo sin documentación LLM
- **Consistencia Código**: 95%+ uso correcto de nomenclatura y patrones
- **Reutilización**: 80%+ de queries reutilizados de biblioteca documentada

### Métricas de Calidad
- **Bugs por Funcionalidad**: Reducción 70% vs desarrollo tradicional
- **Alineación Arquitectura**: 100% conformidad con casos de uso documentados
- **Mantenibilidad**: Código auto-documentado y siguiendo patrones establecidos

---

## 🚀 FLUJO DE DESARROLLO RECOMENDADO

### Para el Desarrollador:
1. **Describe tu necesidad** al LLM en lenguaje natural
2. **Especifica el contexto** (QR, inventario, facturación, etc.)
3. **Solicita explicación** de la arquitectura si es necesario
4. **Revisa el código generado** y solicita ajustes específicos

### Para el LLM:
1. **Consulta SIEMPRE** la documentación antes de responder
2. **Referencia explícitamente** los documentos y queries utilizados
3. **Explica el razonamiento** detrás de las decisiones técnicas
4. **Proporciona contexto** sobre cómo la solución encaja en la arquitectura general

---

## 💡 TIPS PARA DESARROLLADORES

### Cómo Maximizar la Efectividad del LLM

1. **Sé específico en tus solicitudes**:
   ```
   ❌ "Necesito un reporte de ventas"
   ✅ "Necesito implementar el análisis BCG de productos del CU-009 como endpoint FastAPI"
   ```

2. **Referencia casos de uso documentados**:
   ```
   ❌ "Cómo hacer split billing?"
   ✅ "Implementar el flujo CU-002 de split billing para grupos de amigos"
   ```

3. **Solicita explicaciones de arquitectura**:
   ```
   ✅ "Explica cómo el split billing diferencia a IntelliCore POS de competidores"
   ```

4. **Pide código completo y funcional**:
   ```
   ✅ "Genera el endpoint completo con validaciones, usando los queries documentados"
   ```

---

## 🎯 OBJETIVOS DE ESTA METODOLOGÍA

1. **Acelerar Desarrollo**: Reducir tiempo de implementación 60-80%
2. **Mantener Consistencia**: Asegurar que todo el código siga los mismos patrones
3. **Facilitar Onboarding**: Nuevos desarrolladores pueden ser productivos inmediatamente
4. **Garantizar Calidad**: Código basado en casos de uso documentados y probados
5. **Habilitar Evolución**: Arquitectura clara para iteraciones futuras

---

*🤖 Esta guía está diseñada para maximizar la sinergia entre desarrolladores humanos y LLMs en el desarrollo de IntelliCore POS.*
