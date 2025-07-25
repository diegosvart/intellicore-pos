# CONTEXTO MAESTRO - IntelliCore POS

## INFORMACIÓN ESENCIAL DEL PROYECTO

### **Identidad del Proyecto**
- **Nombre:** IntelliCore POS
- **Tipo:** Sistema de Punto de Venta Inteligente para PyMEs
- **Stack Principal:** FastAPI (Backend) + Angular (Frontend) + PostgreSQL

### **Arquitectura Clave**
```
Backend (Python/FastAPI) ←→ Frontend (Angular/TypeScript) ←→ PostgreSQL
     ↓                           ↓                            ↓
  Servicios              Componentes UI              Esquemas BD
  APIs REST              Estado NgRx                 Migraciones
  Modelos ORM            Routing                     Indexes
```

### **Casos de Uso Críticos (Top 5)**
1. **CU-001: Registro de Ventas** - Transacciones y pagos
2. **CU-002: Gestión de Inventario** - Stock y productos  
3. **CU-003: Analytics de Ventas** - Reportes y métricas
4. **CU-004: Gestión de Clientes** - Perfiles y fidelización
5. **CU-005: Configuración Multi-tienda** - Administración centralizada

### **Reglas de Negocio Críticas**
- **Atomicidad:** Todas las transacciones deben ser atómicas
- **Auditoría:** Todo cambio debe ser trazable
- **Performance:** < 500ms para operaciones críticas de venta
- **Seguridad:** Protección PCI DSS para datos financieros
- **Escalabilidad:** Soporte multi-tienda y alta concurrencia

### **Tecnologías y Patrones**
- **Backend:** Clean Architecture + SOLID + Repository Pattern
- **Frontend:** Component-based + Reactive Programming (RxJS)
- **Base de Datos:** ACID compliance + Optimistic locking
- **Infraestructura:** Docker + Kubernetes + CI/CD (GitHub Actions)

---

## REFERENCIAS DOCUMENTALES (Solo cuando necesites detalles)

### **Para Arquitectura y Patrones:**
- `docs/llm-documentation/GUIA_DESARROLLO_LLM.md` - Metodología completa
- `docs/GUIA_ITERACION_PROYECTO.md` - Flujo de trabajo

### **Para Casos de Uso y Negocio:**
- `docs/llm-documentation/CASOS_USO_DETALLADOS.md` - 10 casos completos
- `docs/llm-documentation/QUERIES_CASOS_USO.sql` - 50+ queries

### **Para Base de Datos:**
- `docs/llm-documentation/DICCIONARIO_COMPLETO.json` - Estructura completa
- `database/schemas/crear_modelo_bd.sql` - DDL actual

### **Para Configuración:**
- `package.json` - Dependencias y scripts
- `docker-compose.yml` - Infraestructura local

---

## INSTRUCCIONES PARA LLMs

### **Principios de Respuesta:**
1. **Contexto primero:** Usa la información de este archivo como base
2. **Referencias específicas:** Si necesitas detalles, menciona qué archivo consultar
3. **Coherencia:** Mantén consistencia con la arquitectura descrita
4. **Especialización:** Responde según tu rol (Arquitecto/Developer/Analista/Seguridad)
5. **Optimización:** No uses íconos/emojis (consumen tokens), mantén definiciones acotadas y precisas

### **Cuando solicitar archivos específicos:**
- **Implementación detallada** → "Consulta CASOS_USO_DETALLADOS.md"
- **Queries complejas** → "Revisa QUERIES_CASOS_USO.sql" 
- **Estructura de BD** → "Referencia DICCIONARIO_COMPLETO.json"
- **Metodología** → "Ver GUIA_DESARROLLO_LLM.md"
- **Nueva funcionalidad** → "Ejecuta `/implementar-funcionalidad [descripción]`"

### **Para evolución de documentación:**
- **Siempre actualiza** este contexto maestro al agregar funcionalidades críticas
- **Mantén numeración** secuencial de casos de uso (CU-006, CU-007, etc.)
- **Preserva consistencia** con reglas de negocio establecidas
- **Valida coherencia** entre código implementado y documentación

### **Red flags para el contexto:**
- No inventes casos de uso no documentados
- No asumas tecnologías no mencionadas en el stack
- No ignores las reglas de negocio críticas
- No propongas cambios arquitecturales sin justificación
- No olvides actualizar documentación al implementar funcionalidades
- No uses íconos/emojis en respuestas o documentación (desperdician tokens)
- No generes definiciones extensas cuando puedes ser preciso y conciso

---

## COMANDOS ESPECIALIZADOS DISPONIBLES

- `/implementar-funcionalidad [descripción]` - **NUEVO:** Implementación completa con documentación auto-actualizada
- `/actualizar-documentacion` - **NUEVO:** Sincronizar documentación con cambios de código
- `/analizar-arquitectura` - Evaluación arquitectural completa
- `/validar-caso-uso` - Verificación contra casos de uso documentados  
- `/revisar-seguridad` - Análisis de seguridad POS-específico
- `/optimizar-pos` - Optimización integral del componente

---

**Última actualización:** 2025-07-24 | **Versión:** 1.0-optimizado | **Auto-evolutivo:** Activado
