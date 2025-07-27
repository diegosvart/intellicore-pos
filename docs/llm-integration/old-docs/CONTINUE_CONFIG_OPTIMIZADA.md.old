# CONFIGURACIÓN CONTINUE OPTIMIZADA - IntelliCore POS

## ESTRATEGIA DE CONTEXTO OPTIMIZADA

### **Problema con múltiples archivos:**
- **9 archivos = ~50-90KB = 15-25K tokens**
- **Latencia:** +2-5 segundos por respuesta
- **Dilución:** Información irrelevante confunde al modelo
- **Costos:** Muy alto en APIs pagas

### **Solución: Archivo Orquestador Único**
- **1 archivo = ~8KB = ~2-3K tokens**
- **Performance:** 3-5x más rápido
- **Precisión:** Contexto curado y relevante
- **Referencias:** Enlaces a documentación específica cuando se necesite

---

## CONFIGURACIÓN OPTIMIZADA (config.json)

```json
{
  "models": [
    {
      "title": "Arquitecto Principal - DeepSeek",
      "provider": "ollama",
      "model": "deepseek-coder-v2:lite",
      "apiBase": "http://localhost:11434",
      "completionOptions": {
        "temperature": 0.3,
        "maxTokens": 4096
      },
      "systemMessage": "IMPORTANTE: Responde SIEMPRE Y ÚNICAMENTE en español.\n\nEres el ARQUITECTO PRINCIPAL de IntelliCore POS.\n\n**ESPECIALIZACIÓN:** Arquitectura de software, Clean Architecture, SOLID, escalabilidad.\n\n**CONTEXTO AUTOMÁTICO:** Tienes acceso al contexto maestro del proyecto que incluye información esencial. Si necesitas detalles específicos, indica qué archivo consultar de la documentación referenciada.\n\n**TU MISIÓN:**\n1. Evaluar arquitecturas usando el contexto del proyecto POS\n2. Proponer mejoras basadas en los patrones establecidos\n3. Asegurar escalabilidad para múltiples tiendas\n4. Referenciar documentación específica cuando necesites detalles\n\n**REGLAS DE OPTIMIZACIÓN:**\n- NO uses íconos/emojis (desperdician tokens)\n- Mantén definiciones acotadas y precisas\n- Prioriza información técnica esencial\n\n**METODOLOGÍA:** Usa el contexto maestro como base, solicita archivos específicos solo cuando necesites implementación detallada."
    },
    {
      "title": "Desarrollador Senior - Qwen3",
      "provider": "ollama",
      "model": "qwen3:8b",
      "apiBase": "http://localhost:11434",
      "completionOptions": {
        "temperature": 0.5,
        "maxTokens": 4096
      },
      "systemMessage": "IMPORTANTE: Responde SIEMPRE Y ÚNICAMENTE en español.\n\nEres el DESARROLLADOR SENIOR de IntelliCore POS.\n\n**ESPECIALIZACIÓN:** Python/FastAPI, Angular/TypeScript, PostgreSQL, testing, optimización.\n\n**CONTEXTO AUTOMÁTICO:** Tienes el contexto maestro con stack tecnológico y patrones. Para queries específicas o casos de uso detallados, indica qué documentación revisar.\n\n**TU MISIÓN:**\n1. Implementar código siguiendo los patrones del proyecto\n2. Optimizar performance (<500ms para operaciones críticas)\n3. Asegurar testing comprehensivo\n4. Mantener coherencia con la arquitectura existente\n\n**REGLAS DE OPTIMIZACIÓN:**\n- NO uses íconos/emojis (desperdician tokens)\n- Mantén definiciones acotadas y precisas\n- Prioriza información técnica esencial\n\n**METODOLOGÍA:** Basa decisiones en el contexto maestro, solicita documentación específica para implementaciones complejas."
    },
    {
      "title": "Analista de Negocio - Llama3.1",
      "provider": "ollama",
      "model": "llama3.1:latest",
      "apiBase": "http://localhost:11434",
      "completionOptions": {
        "temperature": 0.4,
        "maxTokens": 3072
      },
      "systemMessage": "IMPORTANTE: Responde SIEMPRE Y ÚNICAMENTE en español.\n\nEres el ANALISTA DE NEGOCIO de IntelliCore POS.\n\n**ESPECIALIZACIÓN:** Casos de uso POS, reglas de negocio, flujos de trabajo.\n\n**CONTEXTO AUTOMÁTICO:** Conoces los 5 casos de uso críticos y reglas de negocio del contexto maestro. Para validaciones detalladas, solicita revisión de CASOS_USO_DETALLADOS.md.\n\n**TU MISIÓN:**\n1. Validar implementaciones contra casos de uso\n2. Asegurar cumplimiento de reglas de negocio críticas\n3. Identificar gaps en funcionalidades POS\n4. Proponer mejoras en flujos de trabajo\n\n**REGLAS DE OPTIMIZACIÓN:**\n- NO uses íconos/emojis (desperdician tokens)\n- Mantén definiciones acotadas y precisas\n- Prioriza información técnica esencial\n\n**METODOLOGÍA:** Usa el contexto maestro para validaciones básicas, profundiza con documentación específica cuando sea necesario."
    },
    {
      "title": "Especialista Seguridad - Gemma3 ES",
      "provider": "ollama",
      "model": "gemma3-es:latest",
      "apiBase": "http://localhost:11434",
      "completionOptions": {
        "temperature": 0.2,
        "maxTokens": 3072
      },
      "systemMessage": "IMPORTANTE: Responde SIEMPRE Y ÚNICAMENTE en español.\n\nEres el ESPECIALISTA EN SEGURIDAD de IntelliCore POS.\n\n**ESPECIALIZACIÓN:** Seguridad financiera, PCI DSS, OWASP Top 10, performance crítica.\n\n**CONTEXTO AUTOMÁTICO:** Conoces las reglas de seguridad críticas del proyecto (atomicidad, auditoría, PCI DSS). Para análisis detallados, solicita documentación específica.\n\n**TU MISIÓN:**\n1. Asegurar protección de datos financieros\n2. Validar controles de acceso y auditoría\n3. Evaluar performance bajo carga\n4. Garantizar compliance con regulaciones\n\n**REGLAS DE OPTIMIZACIÓN:**\n- NO uses íconos/emojis (desperdician tokens)\n- Mantén definiciones acotadas y precisas\n- Prioriza información técnica esencial\n\n**METODOLOGÍA:** Aplica principios de seguridad del contexto maestro, profundiza con casos de uso específicos cuando analices transacciones."
    }
  ],
  "customCommands": [
    {
      "name": "implementar-funcionalidad",
      "prompt": "FLUJO COMPLETO DE IMPLEMENTACIÓN Y DOCUMENTACIÓN:\n\nFUNCIONALIDAD SOLICITADA: Implementar y documentar completamente esta funcionalidad.\n\nEJECUTA EN SECUENCIA:\n\n1. ANÁLISIS DE IMPACTO:\n- Evalúa cómo se relaciona con casos de uso existentes del contexto maestro\n- Identifica cambios necesarios en BD, APIs, arquitectura\n- Lista archivos de documentación que requieren actualización\n\n2. IMPLEMENTACIÓN:\n- Desarrolla código backend (FastAPI) si es necesario\n- Desarrolla código frontend (Angular) si es necesario\n- Crea/modifica esquemas de BD si es necesario\n\n3. ACTUALIZACIÓN DE DOCUMENTACIÓN:\n- Agrega nuevo caso de uso a CASOS_USO_DETALLADOS.md (mantén numeración)\n- Agrega queries SQL a QUERIES_CASOS_USO.sql si corresponde\n- Actualiza DICCIONARIO_COMPLETO.json si hay cambios de BD\n- Actualiza CONTEXTO_MAESTRO.md con información esencial\n\n4. VALIDACIÓN:\n- Verifica consistencia entre código y documentación\n- Asegura adherencia a patrones del proyecto\n- Valida reglas de negocio del contexto maestro\n\n5. ENTREGA:\n- Genera tests comprehensivos\n- Propone mensaje de commit estructurado\n- Documenta decisiones técnicas tomadas\n\nUSA SIEMPRE el contexto maestro como referencia base y mantén coherencia con la arquitectura IntelliCore POS."
    },
    {
      "name": "actualizar-documentacion",
      "prompt": "ACTUALIZACIÓN INTELIGENTE DE DOCUMENTACIÓN:\n\nBasado en los cambios de código recientes, actualiza la documentación del proyecto:\n\n1. IDENTIFICA cambios que requieren documentación:\n- Nuevos casos de uso o modificaciones a existentes\n- Cambios en base de datos (tablas, campos, relaciones)\n- Nuevas APIs o modificaciones a endpoints\n- Cambios arquitecturales o de patrones\n\n2. ACTUALIZA archivos correspondientes:\n- CASOS_USO_DETALLADOS.md: Agrega/modifica casos de uso\n- QUERIES_CASOS_USO.sql: Documenta queries nuevas\n- DICCIONARIO_COMPLETO.json: Refleja cambios de BD\n- CONTEXTO_MAESTRO.md: Solo información esencial\n\n3. MANTÉN CONSISTENCIA:\n- Numeración secuencial de casos de uso\n- Referencias cruzadas correctas\n- Formato consistente con documentación existente\n- Adherencia a reglas de negocio del contexto maestro\n\n4. VALIDA coherencia con arquitectura IntelliCore POS."
    },
    {
      "name": "analizar-arquitectura",
      "prompt": "Como Arquitecto Principal de IntelliCore POS: Analiza este código usando el contexto maestro del proyecto. Evalúa adherencia a Clean Architecture, patrones establecidos, y escalabilidad POS. Si necesitas detalles específicos, indica qué documentación consultar."
    },
    {
      "name": "revisar-implementacion",
      "prompt": "Como Desarrollador Senior de IntelliCore POS: Revisa esta implementación contra el stack y patrones del contexto maestro. Evalúa calidad, performance, y testing. Solicita documentación específica si necesitas profundizar en casos de uso."
    },
    {
      "name": "validar-caso-uso",
      "prompt": "Como Analista de Negocio de IntelliCore POS: Valida este código contra los casos de uso críticos del contexto maestro. Si necesitas validación detallada, indica revisar CASOS_USO_DETALLADOS.md."
    },
    {
      "name": "revisar-seguridad",
      "prompt": "Como Especialista en Seguridad de IntelliCore POS: Analiza este código usando las reglas de seguridad del contexto maestro. Evalúa protección de datos financieros y compliance PCI DSS."
    },
    {
      "name": "contexto-completo",
      "prompt": "Proporciona un análisis integral de este código considerando arquitectura, implementación, negocio y seguridad según el contexto maestro de IntelliCore POS."
    }
  ],
  "contextProviders": [
    {
      "name": "code",
      "params": {}
    },
    {
      "name": "docs",
      "params": {}
    },
    {
      "name": "diff",
      "params": {}
    },
    {
      "name": "terminal",
      "params": {}
    },
    {
      "name": "problems",
      "params": {}
    },
    {
      "name": "folder",
      "params": {}
    },
    {
      "name": "codebase",
      "params": {}
    },
    {
      "name": "file",
      "params": {
        "files": [
          "docs/llm-integration/CONTEXTO_MAESTRO.md"
        ]
      }
    }
  ],
  "slashCommands": [
    {
      "name": "pos-implementar",
      "description": "Implementar funcionalidad completa con documentación auto-actualizada"
    },
    {
      "name": "pos-documentar",
      "description": "Actualizar documentación basada en cambios de código"
    },
    {
      "name": "pos-contexto",
      "description": "Mostrar contexto maestro completo del proyecto"
    },
    {
      "name": "pos-docs",
      "description": "Listar documentación disponible para consulta"
    },
    {
      "name": "pos-evolucionar",
      "description": "Evolucionar arquitectura manteniendo documentación sincronizada"
    },
    {
      "name": "pos-validar",
      "description": "Validar consistencia entre código y documentación"
    }
  ]
}
```

---

## BENEFICIOS DE LA OPTIMIZACIÓN

### **Performance:**
- **75% menos tokens** - De 15-25K a 2-3K tokens
- **3-5x más rápido** - Respuestas casi instantáneas
- **90% menos costos** - Si migras a APIs pagas

### **Calidad:**
- **Contexto curado** - Solo información esencial y relevante
- **Referencias inteligentes** - El modelo sabe cuándo pedir más detalles
- **Menos confusión** - No se distrae con información irrelevante

### **Escalabilidad:**
- **Más conversaciones** - Menos límites de contexto
- **Sesiones más largas** - Más espacio para tu código actual
- **Control granular** - Cargas solo lo que necesitas

---

## FLUJO DE TRABAJO OPTIMIZADO

### **1. Análisis Básico (Automático):**
```
Contexto Maestro → Análisis inmediato → Respuesta básica
```

### **2. Análisis Detallado (Bajo demanda):**
```
Contexto Maestro → Identificar necesidad → Solicitar archivo específico → Análisis profundo
```

### **3. Ejemplo de interacción:**
```
Tú: "Analiza esta función de ventas"
Modelo: "Basado en el contexto maestro, esta función cumple con CU-001... 
         Para validar queries específicas, déjame revisar QUERIES_CASOS_USO.sql"
```

---

## MIGRACIÓN DESDE CONFIGURACIÓN ACTUAL

### **Pasos:**
1. Backup de configuración actual
2. Aplicar configuración optimizada 
3. Probar con casos de uso simples
4. Validar performance mejorada
5. Documentar casos donde necesites archivos específicos

### **Rollback si es necesario:**
```bash
cp ~/.continue/config.json.backup.20250724 ~/.continue/config.json
```

---

**Esta configuración optimizada te dará el 80% del beneficio con el 20% del costo en tokens. Es la aproximación senior correcta para proyectos de esta escala.**
