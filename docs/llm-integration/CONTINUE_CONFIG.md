# CONFIGURACIÓN CONTINUE BASE - IntelliCore POS

## CONFIGURACIÓN ESTÁNDAR (RESPALDO)

Esta es la configuración base de Continue antes de las optimizaciones. Se mantiene como respaldo y referencia.

```json
{
  "models": [
    {
      "title": "Local Ollama",
      "provider": "ollama",
      "model": "llama3.1:8b",
      "apiBase": "http://localhost:11434"
    },
    {
      "title": "GPT-4",
      "provider": "openai", 
      "model": "gpt-4",
      "apiKey": "[REDACTED]"
    }
  ],
  "customCommands": [
    {
      "name": "test",
      "prompt": "Write a comprehensive test suite for the selected code"
    },
    {
      "name": "check",
      "prompt": "Check this code for bugs and potential improvements"
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
          "docs/llm-documentation/README.md",
          "docs/llm-documentation/CASOS_USO_DETALLADOS.md",
          "docs/llm-documentation/DICCIONARIO_COMPLETO.json",
          "docs/llm-documentation/GUIA_DESARROLLO_LLM.md",
          "docs/llm-documentation/QUERIES_CASOS_USO.sql",
          "package.json",
          "docker-compose.yml",
          "database/schemas/crear_modelo_bd.sql",
          "docs/GUIA_ITERACION_PROYECTO.md"
        ]
      }
    }
  ]
}
```

## PROBLEMA IDENTIFICADO CON ESTA CONFIGURACIÓN

### **Contexto Excesivo:**
- **9 archivos en contextProviders** = 50-90KB = 15-25K tokens
- **Dilución de información** relevante
- **Latencia aumentada** en respuestas 
- **Costos elevados** en tokens

### **Falta de Especialización:**
- **Modelos genéricos** sin contexto específico del proyecto POS
- **Sin systemMessages** especializados
- **Comandos básicos** no adaptados a IntelliCore POS

### **Sin Optimización:**
- **Información redundante** cargada en cada consulta
- **Sin estrategia de referencias** bajo demanda
- **Sin reglas de eficiencia** de tokens

---

## MIGRACIÓN A CONFIGURACIÓN OPTIMIZADA

### **Cambios Principales:**
1. **Reducción drástica de contexto:** De 9 archivos a 1 archivo maestro
2. **Modelos especializados:** 4 roles específicos para POS
3. **Comandos evolutivos:** Implementación + documentación automática
4. **Referencias inteligentes:** Carga bajo demanda de documentación específica

### **Archivo de Migración:**
La configuración optimizada está en `CONTINUE_CONFIG_OPTIMIZADA.md`

### **Comando de Migración:**
```bash
# Backup de configuración actual
cp ~/.continue/config.json ~/.continue/config.json.backup.20250724

# Aplicar configuración optimizada
# (Copiar contenido desde CONTINUE_CONFIG_OPTIMIZADA.md)

# Reiniciar VS Code para aplicar cambios
```

---

## COMPARACIÓN DE PERFORMANCE

### **Configuración Base (esta):**
- Tokens por consulta: 15-25K
- Tiempo de respuesta: 2-5 segundos
- Precisión de contexto: Diluida
- Especialización: Genérica

### **Configuración Optimizada:**
- Tokens por consulta: 2-3K (reducción 75-85%)
- Tiempo de respuesta: <1 segundo  
- Precisión de contexto: Curada y específica
- Especialización: 4 roles POS específicos

---

## INSTRUCCIONES DE ROLLBACK

Si necesitas volver a esta configuración base:

```bash
# Restaurar desde backup
cp ~/.continue/config.json.backup.20250724 ~/.continue/config.json

# O usar esta configuración directamente
# (Copiar el JSON de arriba a ~/.continue/config.json)

# Reiniciar VS Code
```

---

**Propósito:** Configuración de respaldo y referencia | **Estado:** Obsoleta (usar OPTIMIZADA) | **Mantenimiento:** Solo para rollback
