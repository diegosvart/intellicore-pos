# FLUJO DE ITERACIÓN AUTO-EVOLUTIVA - IntelliCore POS

## ESTRATEGIA DE DOCUMENTACIÓN ITERATIVA

### **Problema a resolver:**
- **Escribir código** - Los modelos lo hacen bien
- **Actualizar documentación** - Frecuentemente se olvida
- **Mantener consistencia** - Entre código y documentación
- **Evolucionar arquitectura** - Sin perder el contexto

### **Solución: Documentación Auto-Evolutiva**
Cada nueva funcionalidad dispara un **flujo de actualización automática** de la documentación.

---

## FLUJO DE ITERACIÓN INTELIGENTE

### **FASE 1: DESARROLLO (Como siempre)**
```
1. Desarrollador solicita nueva funcionalidad
2. Modelo implementa código
3. Tests y validación
```

### **FASE 2: DOCUMENTACIÓN AUTO-ACTUALIZADA (Nuevo)**
```
4. Modelo analiza cambios realizados
5. Identifica archivos de documentación a actualizar
6. Propone actualizaciones específicas
7. Desarrollador revisa y aprueba
```

### **FASE 3: EVOLUCIÓN DEL CONTEXTO (Automático)**
```
8. Contexto maestro se actualiza con información esencial
9. Referencias cruzadas se mantienen consistentes
10. Numeración de casos de uso se preserva
11. Git commit incluye código + documentación
```

---

## COMANDO PRINCIPAL: /implementar-funcionalidad

### **Uso:**
```
/implementar-funcionalidad "Agregar descuentos por cliente frecuente"
```

### **El modelo ejecuta automáticamente:**

**1. ANÁLISIS DE IMPACTO:**
- Identifica que afecta CU-001 (Registro de Ventas) y CU-004 (Gestión de Clientes)
- Determina cambios necesarios en BD (tabla clientes, ventas)
- Lista archivos de documentación a actualizar

**2. IMPLEMENTACIÓN:**
- Backend: Modelos, servicios, APIs para descuentos
- Frontend: Componentes UI para aplicar descuentos
- BD: Campos adicionales y lógica de descuentos

**3. DOCUMENTACIÓN AUTO-ACTUALIZADA:**
- Agrega CU-006 a CASOS_USO_DETALLADOS.md
- Agrega queries SQL a QUERIES_CASOS_USO.sql
- Actualiza DICCIONARIO_COMPLETO.json
- Evoluciona CONTEXTO_MAESTRO.md

**4. ENTREGA COMPLETA:**
- Tests generados automáticamente
- Commit message propuesto
- Documentación sincronizada

---

## ARCHIVOS QUE SE ACTUALIZAN AUTOMÁTICAMENTE

### **SIEMPRE SE ACTUALIZAN:**
- `docs/llm-integration/CONTEXTO_MAESTRO.md` - Información esencial
- `docs/iteraciones/ITERACION_YYYY_MM_DD.md` - Log de cambios

### **SE ACTUALIZAN SEGÚN NECESIDAD:**
- `docs/llm-documentation/CASOS_USO_DETALLADOS.md` - Nuevos casos de uso
- `docs/llm-documentation/QUERIES_CASOS_USO.sql` - Queries nuevos
- `docs/llm-documentation/DICCIONARIO_COMPLETO.json` - Cambios de BD
- `docs/GUIA_ITERACION_PROYECTO.md` - Cambios de proceso

---

## VENTAJAS DEL FLUJO AUTO-EVOLUTIVO

### **Para el Desarrollador:**
- **Menos trabajo manual** - El modelo actualiza documentación
- **Consistencia garantizada** - No se olvida ningún archivo
- **Contexto siempre actualizado** - Documentación refleja código real
- **Commits completos** - Código + documentación en un solo commit

### **Para el Proyecto:**
- **Documentación viva** - Siempre sincronizada con el código
- **Contexto evolutivo** - El modelo mejora con cada iteración
- **Trazabilidad completa** - Cada cambio queda documentado
- **Onboarding más fácil** - Documentación siempre actualizada

### **Para el Modelo:**
- **Contexto más rico** - Aprende del proyecto conforme evoluciona
- **Especialización creciente** - Se vuelve más experto en IntelliCore POS
- **Decisiones más acertadas** - Basadas en historial real del proyecto

---

## REGLAS DEL FLUJO EVOLUTIVO

### **REGLAS DE ACTUALIZACIÓN:**
1. **Información esencial al contexto maestro** - Solo lo crítico
2. **Casos de uso numerados secuencialmente** - CU-001, CU-002, etc.
3. **Referencias cruzadas consistentes** - Entre archivos relacionados
4. **Commits estructurados** - feat/fix/docs con scope específico

### **REGLAS DE OPTIMIZACIÓN:**
1. **No usar íconos/emojis** - Desperdician tokens
2. **Definiciones acotadas** - Máxima información por token
3. **Priorizar contenido técnico** - Evitar redundancias

### **REGLAS DE CONSISTENCIA:**
1. **Preservar arquitectura** - No cambios arquitecturales sin justificación
2. **Mantener stack tecnológico** - FastAPI + Angular + PostgreSQL
3. **Respetar reglas de negocio** - Atomicidad, auditoría, performance

---

## COMANDO COMPLEMENTARIO: /actualizar-documentacion

### **Uso:**
```
/actualizar-documentacion
```

### **Función:**
Cuando se han hecho cambios manuales de código, este comando:
1. Analiza diferencias en el código
2. Identifica documentación desactualizada
3. Propone actualizaciones específicas
4. Mantiene consistencia con el contexto maestro

---

## EJEMPLO DE FLUJO COMPLETO

### **Solicitud:**
```
/implementar-funcionalidad "Sistema de alertas de stock bajo"
```

### **Respuesta del modelo:**
```
ANÁLISIS DE IMPACTO:
- Afecta CU-002 (Gestión de Inventario)
- Nuevo caso de uso: CU-006 (Alertas de Stock)
- Cambios en BD: campo stock_minimo en productos
- Nueva API: /productos/{id}/alertas
- Componente frontend: AlertasStock

IMPLEMENTACIÓN:
[Código backend, frontend, BD]

DOCUMENTACIÓN ACTUALIZADA:
- ✓ CU-006 agregado a CASOS_USO_DETALLADOS.md
- ✓ Query de alertas en QUERIES_CASOS_USO.sql  
- ✓ Campo stock_minimo en DICCIONARIO_COMPLETO.json
- ✓ CONTEXTO_MAESTRO.md actualizado con regla de alertas

TESTS GENERADOS:
[Tests para el sistema de alertas]

COMMIT PROPUESTO:
feat(inventory): add low stock alert system

- Add stock_minimo field to productos table
- Implement AlertasStock component
- Add /productos/{id}/alertas endpoint
- Update documentation with CU-006

Co-authored-by: LLM-Assistant
```

---

## FLUJO DE TRABAJO DEVELOPER

### **Workflow tradicional:**
```
1. Developer escribe código
2. (A veces) actualiza documentación  
3. Commit solo del código
4. Documentación queda desactualizada
```

### **Workflow auto-evolutivo:**
```
1. Developer: "/implementar-funcionalidad [descripción]"
2. Modelo:
   - Implementa código
   - Actualiza documentación
   - Valida consistencia
   - Propone tests
   - Genera commit

3. Developer obtiene:
   - Código implementado
   - Documentación actualizada
   - Tests generados
   - Commit listo
```

### **Resultado:**
- **Contexto evolutivo:** El modelo se vuelve más inteligente
- **Documentación viva:** Siempre sincronizada
- **Desarrollo acelerado:** Menos trabajo manual repetitivo

---

**Este flujo convierte la documentación de pasivo en activo, donde cada iteración de código mejora automáticamente el contexto del proyecto para futuras iteraciones.**
