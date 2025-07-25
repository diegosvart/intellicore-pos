# PROMPTS ITERATIVOS - IntelliCore POS

## PROMPTS ESPECIALIZADOS POR ROL

### **ARQUITECTO PRINCIPAL (DeepSeek)**

#### Análisis Arquitectural Completo:
```
Analiza la arquitectura del proyecto IntelliCore POS considerando:

CONTEXTO: Sistema POS para PyMEs con stack FastAPI + Angular + PostgreSQL

EVALÚA:
1. Adherencia a Clean Architecture y principios SOLID
2. Separación de responsabilidades entre capas
3. Escalabilidad para múltiples tiendas
4. Patrones de diseño implementados vs documentados
5. Puntos de mejora arquitectural específicos

ENFOQUE: Basado en casos de uso CU-001 a CU-005 del contexto maestro
SALIDA: Recomendaciones técnicas precisas y accionables
```

#### Evaluación de Escalabilidad:
```
Evalúa la escalabilidad del componente/módulo para IntelliCore POS:

CONTEXTO: Sistema debe soportar múltiples tiendas y alta concurrencia

ANALIZA:
1. Performance bajo carga (objetivo <500ms operaciones críticas)
2. Patrones de concurrencia implementados
3. Optimización de queries y acceso a datos
4. Caching y estrategias de optimización
5. Preparación para crecimiento horizontal

REFERENCIA: Reglas de negocio críticas del contexto maestro
SALIDA: Plan de escalabilidad específico
```

---

### **DESARROLLADOR SENIOR (Qwen3)**

#### Revisión de Implementación:
```
Revisa esta implementación de IntelliCore POS:

STACK: FastAPI + Angular + PostgreSQL + Docker

EVALÚA:
1. Calidad del código y mejores prácticas
2. Adherencia a patrones del proyecto
3. Testing comprehensivo (unitario + integración)
4. Manejo de errores y casos edge
5. Optimización de performance

CONTEXTO: Debe cumplir reglas de atomicidad, auditoría y seguridad PCI DSS
SALIDA: Código mejorado + tests + documentación técnica
```

#### Optimización Técnica:
```
Optimiza este código para IntelliCore POS:

OBJETIVO: <500ms para operaciones críticas de venta

OPTIMIZA:
1. Queries SQL y acceso a base de datos
2. Lógica de negocio y algoritmos
3. Manejo de memoria y recursos
4. Paralelización donde sea apropiado
5. Caching inteligente

MANTÉN: Atomicidad transaccional y trazabilidad de auditoría
SALIDA: Código optimizado + métricas de performance
```

---

### **ANALISTA DE NEGOCIO (Gemma3)**

#### Validación de Casos de Uso:
```
Valida la implementación contra casos de uso de IntelliCore POS:

CASOS CRÍTICOS: CU-001 a CU-005 (Ventas, Inventario, Analytics, Clientes, Multi-tienda)

VERIFICA:
1. Cumplimiento de flujos de trabajo documentados
2. Adherencia a reglas de negocio críticas
3. Cobertura de escenarios edge del POS
4. Consistencia con expectativas de PyMEs
5. Gaps de funcionalidad identificados

REGLAS: Atomicidad, auditoría, performance, seguridad, escalabilidad
SALIDA: Reporte de conformidad + casos de uso faltantes
```

#### Análisis de Reglas de Negocio:
```
Analiza el cumplimiento de reglas de negocio para IntelliCore POS:

CONTEXTO: Sistema POS para PyMEs con múltiples tiendas

REGLAS CRÍTICAS:
1. Atomicidad: Todas las transacciones deben ser atómicas
2. Auditoría: Todo cambio debe ser trazable
3. Performance: <500ms para operaciones críticas
4. Seguridad: Protección PCI DSS datos financieros
5. Escalabilidad: Soporte multi-tienda y alta concurrencia

EVALÚA: Implementación actual vs reglas establecidas
SALIDA: Matriz de conformidad + plan de corrección
```

---

### **ESPECIALISTA EN SEGURIDAD (Gemma3-ES)**

#### Análisis de Seguridad PCI DSS:
```
Analiza la seguridad de este código para IntelliCore POS:

ENFOQUE: Protección de datos financieros y cumplimiento PCI DSS

EVALÚA:
1. Cifrado de datos sensibles (tarjetas, transacciones)
2. Controles de acceso y autenticación
3. Auditoría y logging de seguridad
4. Protección contra OWASP Top 10
5. Configuración segura de infraestructura

CONTEXTO: Sistema POS que maneja pagos y datos financieros
SALIDA: Reporte de vulnerabilidades + plan de mitigación
```

#### Revisión de Controles de Acceso:
```
Revisa los controles de acceso para IntelliCore POS:

CONTEXTO: Sistema multi-tienda con diferentes roles de usuario

ANALIZA:
1. Autenticación y autorización robusta
2. Principio de menor privilegio implementado
3. Segregación de funciones por rol
4. Protección de endpoints sensibles
5. Auditoría de accesos y cambios

CUMPLIMIENTO: PCI DSS y mejores prácticas de seguridad
SALIDA: Matriz de controles + recomendaciones específicas
```

---

## PROMPTS DE IMPLEMENTACIÓN COMPLETA

### **Comando: /implementar-funcionalidad**

#### Template Base:
```
IMPLEMENTACIÓN COMPLETA Y DOCUMENTACIÓN AUTO-ACTUALIZADA

FUNCIONALIDAD: [descripción detallada]

EJECUTAR EN SECUENCIA:

1. ANÁLISIS DE IMPACTO:
   - Casos de uso afectados (CU-001 a CU-005)
   - Cambios necesarios en BD, APIs, arquitectura
   - Archivos de documentación a actualizar

2. IMPLEMENTACIÓN:
   - Backend FastAPI: modelos, servicios, APIs
   - Frontend Angular: componentes, servicios, routing
   - Base de datos: esquemas, migraciones, índices

3. DOCUMENTACIÓN AUTO-ACTUALIZADA:
   - Nuevo caso de uso en CASOS_USO_DETALLADOS.md
   - Queries SQL en QUERIES_CASOS_USO.sql
   - Actualización DICCIONARIO_COMPLETO.json
   - Evolución CONTEXTO_MAESTRO.md

4. VALIDACIÓN:
   - Consistencia código-documentación
   - Adherencia a patrones del proyecto
   - Cumplimiento reglas de negocio críticas

5. ENTREGA:
   - Tests comprehensivos generados
   - Commit message estructurado propuesto
   - Decisiones técnicas documentadas

MANTENER: Arquitectura Clean + SOLID, reglas de negocio POS, optimización de tokens
```

---

## PROMPTS DE ANÁLISIS ESPECÍFICO

### **Análisis de Performance:**
```
Analiza el performance de este código para IntelliCore POS:

OBJETIVO: <500ms para operaciones críticas de venta

MEDIR:
1. Tiempo de respuesta de endpoints críticos
2. Eficiencia de queries SQL
3. Uso de memoria y CPU
4. Cuellos de botella identificados
5. Escalabilidad bajo carga

OPTIMIZAR: Manteniendo atomicidad y auditoría
SALIDA: Métricas + plan de optimización específico
```

### **Análisis de Consistencia:**
```
Verifica la consistencia entre código y documentación:

ARCHIVOS DE REFERENCIA:
- CONTEXTO_MAESTRO.md
- CASOS_USO_DETALLADOS.md
- DICCIONARIO_COMPLETO.json

VERIFICAR:
1. Casos de uso implementados vs documentados
2. Esquema BD real vs documentado
3. APIs implementadas vs especificadas
4. Reglas de negocio en código vs documentación

SALIDA: Reporte de discrepancias + plan de sincronización
```

---

## REGLAS DE OPTIMIZACIÓN PARA TODOS LOS PROMPTS

### **Principios de Eficiencia:**
1. **No usar íconos/emojis** - Desperdician tokens sin valor técnico
2. **Definiciones acotadas** - Máxima información útil por token
3. **Contexto técnico prioritario** - Evitar redundancias y decoraciones
4. **Referencias específicas** - Solicitar archivos solo cuando sea necesario

### **Estructura de Respuesta Optimizada:**
```
ANÁLISIS: [Evaluación técnica concisa]
HALLAZGOS: [Lista numerada de puntos específicos]
RECOMENDACIONES: [Acciones técnicas precisas]
SIGUIENTE PASO: [Acción específica siguiente]
```

---

**Última actualización:** 2025-07-24 | **Uso:** Plantillas para modelos especializados | **Estado:** Optimizado para tokens
