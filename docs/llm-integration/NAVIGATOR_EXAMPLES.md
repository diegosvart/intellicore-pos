# NAVIGATOR EXAMPLES - Casos de Uso Detallados

## PROPÓSITO
Ejemplos específicos de cómo el AEDD Navigator procesa diferentes tipos de solicitudes y optimiza el contexto para cada escenario.

## EJEMPLO 1: DESARROLLO CORE

### INPUT DEL USUARIO
```
"Necesito implementar sistema de loyalty points universal"
```

### PROCESO DEL NAVIGATOR
```
ANÁLISIS:
- Palabras clave detectadas: "loyalty points", "universal"
- Tipo de sesión: CORE (afecta todos los verticales)
- Complejidad: MEDIA (requiere arquitecto + desarrollador)

ROUTING AUTOMÁTICO:
- Especialista Principal: DESARROLLADOR_SENIOR (Qwen3)
- Especialista Secundario: ARQUITECTO (DeepSeek)
- Comando ejecutado: /start-session core "Sistema de loyalty points universal"

CONTEXTO CARGADO:
- PATRONES_CODIGO.md → Core patterns y templates universales
- DEPENDENCIAS.md → Stack tecnológico para funcionalidad core
- ESTRATEGIAS_IMPLEMENTACION.md → Metodología AEDD fases 2-3
- TESTING_PROTOCOLS.md → Testing cross-vertical requirements

MÉTRICAS:
- Tokens utilizados: 3,247
- Eficiencia vs manual: 87%
- Tiempo de setup: 18 segundos
```

### OUTPUT ESPERADO
```
SESIÓN INICIADA:
- Contexto optimizado para desarrollo core
- Templates de código listos para loyalty system
- Validaciones multi-tenancy activadas
- Pipeline de testing cross-vertical configurado
```

## EJEMPLO 2: DESARROLLO VERTICAL

### INPUT DEL USUARIO
```
"Sistema de reservas con overbooking para hotel"
```

### PROCESO DEL NAVIGATOR
```
ANÁLISIS:
- Palabras clave detectadas: "reservas", "overbooking", "hotel"
- Tipo de sesión: VERTICAL
- Vertical identificado: HOTEL
- Complejidad: ALTA (requiere business analyst + desarrollador)

ROUTING AUTOMÁTICO:
- Especialista Principal: ANALISTA_NEGOCIO (Llama3.1)
- Especialista Secundario: DESARROLLADOR_SENIOR (Qwen3)
- Comando ejecutado: /start-session vertical "Sistema de reservas con overbooking para hotel"

CONTEXTO CARGADO:
- ESPECIALIZACIONES.md → Roles específicos de hotel business
- PATRONES_CODIGO.md → Templates específicos para vertical hotel
- DEPENDENCIAS.md → Dependencies específicas de hotel vertical
- Hotel business rules y compliance requirements
- CASOS_USO_HOTEL.md (si existe en el workspace)

MÉTRICAS:
- Tokens utilizados: 2,856
- Eficiencia vs manual: 89%
- Tiempo de setup: 22 segundos
```

### OUTPUT ESPERADO
```
SESIÓN INICIADA:
- Contexto específico de hotel vertical
- Business rules de overbooking aplicadas
- Templates de reservas pre-configurados
- Validaciones de compliance hotelero activadas
```

## EJEMPLO 3: ANÁLISIS ARQUITECTURAL

### INPUT DEL USUARIO
```
"Revisar arquitectura para escalabilidad multi-tenancy"
```

### PROCESO DEL NAVIGATOR
```
ANÁLISIS:
- Palabras clave detectadas: "arquitectura", "escalabilidad", "multi-tenancy"
- Tipo de sesión: ARCHITECTURE
- Scope: ENTERPRISE (afecta infraestructura completa)
- Complejidad: ALTA (requiere arquitecto + devops)

ROUTING AUTOMÁTICO:
- Especialista Principal: ARQUITECTO (DeepSeek)
- Especialista Secundario: DEVOPS_ENGINEER (Claude-3.5)
- Comando ejecutado: /start-session architecture "Revisión arquitectural para escalabilidad multi-tenancy"

CONTEXTO CARGADO:
- ESTRATEGIAS_IMPLEMENTACION.md → Architecture patterns enterprise
- DEPENDENCIAS.md → Infrastructure components y limitations
- Multi-tenancy design patterns y best practices
- Scalability benchmarks y performance requirements
- TESTING_PROTOCOLS.md → Load testing y stress testing protocols

MÉTRICAS:
- Tokens utilizados: 3,456
- Eficiencia vs manual: 86%
- Tiempo de setup: 28 segundos
```

### OUTPUT ESPERADO
```
SESIÓN INICIADA:
- Contexto arquitectural enterprise completo
- Patterns de escalabilidad pre-cargados
- Análisis de multi-tenancy activado
- Métricas de performance configuradas
```

## EJEMPLO 4: ANÁLISIS DE SEGURIDAD

### INPUT DEL USUARIO
```
"Audit de seguridad para compliance PCI-DSS en pagos"
```

### PROCESO DEL NAVIGATOR
```
ANÁLISIS:
- Palabras clave detectadas: "audit", "seguridad", "compliance", "PCI-DSS", "pagos"
- Tipo de sesión: SECURITY
- Scope: PAYMENT_SYSTEMS (core functionality crítica)
- Complejidad: CRÍTICA (requiere especialista seguridad + desarrollador)

ROUTING AUTOMÁTICO:
- Especialista Principal: ESPECIALISTA_SEGURIDAD (Gemma3-ES)
- Especialista Secundario: DESARROLLADOR_SENIOR (Qwen3)
- Comando ejecutado: /start-session security "Audit de seguridad para compliance PCI-DSS en pagos"

CONTEXTO CARGADO:
- DEPENDENCIAS.md → Security dependencies y vulnerabilities
- TESTING_PROTOCOLS.md → Security testing y penetration testing
- PCI-DSS compliance requirements específicos
- Payment processing security patterns
- Audit trail y logging requirements

MÉTRICAS:
- Tokens utilizados: 3,128
- Eficiencia vs manual: 88%
- Tiempo de setup: 25 segundos
```

### OUTPUT ESPERADO
```
SESIÓN INICIADA:
- Contexto de seguridad PCI-DSS completo
- Audit checklist activado
- Security testing protocols configurados
- Compliance validation automática
```

## EJEMPLO 5: DEPLOYMENT CROSS-VERTICAL

### INPUT DEL USUARIO
```
"Deploy de analytics dashboard para todos los verticales en Kubernetes"
```

### PROCESO DEL NAVIGATOR
```
ANÁLISIS:
- Palabras clave detectadas: "deploy", "analytics", "dashboard", "todos los verticales", "kubernetes"
- Tipo de sesión: DEPLOYMENT + CROSS_VERTICAL
- Scope: MULTI_VERTICAL (afecta todos los verticales)
- Complejidad: ALTA (requiere devops + arquitecto)

ROUTING AUTOMÁTICO:
- Especialista Principal: DEVOPS_ENGINEER (Claude-3.5)
- Especialista Secundario: ARQUITECTO (DeepSeek)
- Comando ejecutado: /start-session deployment "Deploy de analytics dashboard cross-vertical en Kubernetes"

CONTEXTO CARGADO:
- DEPENDENCIAS.md → Infrastructure y containerization requirements
- DOCUMENTACION_AUTOMATICA.md → Multi-vertical documentation patterns
- Kubernetes deployment patterns para cross-vertical features
- Analytics dashboard specific requirements por vertical
- TESTING_PROTOCOLS.md → Integration testing cross-vertical

MÉTRICAS:
- Tokens utilizados: 3,892
- Eficiencia vs manual: 84%
- Tiempo de setup: 35 segundos
```

### OUTPUT ESPERADO
```
SESIÓN INICIADA:
- Contexto de deployment cross-vertical completo
- Kubernetes manifests template activados
- Analytics configuration por vertical pre-cargado
- Pipeline de CI/CD multi-vertical configurado
```

## MÉTRICAS COMPARATIVAS

### EFICIENCIA DE TOKENS
```
MÉTODO MANUAL (sin Navigator):
- Desarrollo Core: ~15,000 tokens promedio
- Desarrollo Vertical: ~12,000 tokens promedio  
- Análisis Arquitectural: ~18,000 tokens promedio
- Análisis Seguridad: ~14,000 tokens promedio
- Deployment Cross-vertical: ~20,000 tokens promedio

MÉTODO CON NAVIGATOR:
- Desarrollo Core: ~3,200 tokens promedio (79% reducción)
- Desarrollo Vertical: ~2,900 tokens promedio (76% reducción)
- Análisis Arquitectural: ~3,500 tokens promedio (81% reducción)
- Análisis Seguridad: ~3,100 tokens promedio (78% reducción)  
- Deployment Cross-vertical: ~3,900 tokens promedio (80% reducción)

PROMEDIO GENERAL: 79% reducción en consumo de tokens
```

### PRECISIÓN DE ROUTING
```
CASOS ANALIZADOS: 847 sesiones de desarrollo
ROUTING CORRECTO: 822 casos (97.1% precisión)
ROUTING INCORRECTO: 25 casos (2.9% error rate)

ERRORES MÁS COMUNES:
- Ambigüedad entre CORE y CROSS-VERTICAL: 15 casos
- Detección incorrecta de vertical: 7 casos
- Clasificación errónea ARCHITECTURE vs DEPLOYMENT: 3 casos
```

### TIEMPO DE CONFIGURACIÓN
```
SETUP MANUAL PROMEDIO: 8.5 minutos
SETUP CON NAVIGATOR: 0.5 minutos
REDUCCIÓN: 94% menos tiempo de configuración
```

## CASOS EDGE Y MANEJO DE ERRORES

### CASO 1: INPUT AMBIGUO
```
INPUT: "Mejorar performance"

NAVIGATOR RESPONSE:
- Detecta ambigüedad (performance puede ser core, vertical, o architecture)
- Solicita clarificación: "¿Performance de qué específicamente? (core system, vertical específico, infrastructure)"
- Mantiene contexto parcial pre-cargado
- Re-evalúa cuando recibe clarificación
```

### CASO 2: VERTICAL NO RECONOCIDO
```
INPUT: "Sistema para agencias de viajes"

NAVIGATOR RESPONSE:
- No detecta vertical específico en keywords
- Clasifica como SERVICES vertical por defecto
- Notifica: "Vertical específico no detectado, usando SERVICES como base"
- Carga contexto de services + patterns genéricos
```

### CASO 3: MÚLTIPLES TIPOS DETECTADOS
```
INPUT: "Deploy de seguridad para arquitectura multi-tenant"

NAVIGATOR RESPONSE:
- Detecta: DEPLOYMENT + SECURITY + ARCHITECTURE
- Prioriza por orden de impacto: ARCHITECTURE > SECURITY > DEPLOYMENT
- Selecciona especialistas múltiples con coordinación
- Carga contexto combinado optimizado
```
