# NAVIGATOR DEVELOPMENT METHODOLOGY - Metodología Estructurada AEDD

## 🎯 PROPÓSITO
Sistema de gestión de desarrollo estructurado que integra una metodología completa de 20 fases para el desarrollo de nuevas características en IntelliCore POS. Cada fase está asociada a ramas específicas y estados verificables.

## 🚀 COMANDO DE ACTIVACIÓN
```bash
/start-development <componente> <característica>
/check-development-status <componente>
/continue-development <fase> <componente>
```

### **EJEMPLOS DE ACTIVACIÓN:**
```bash
/start-development core "sistema de autenticación biométrica"
/start-development vertical-hotel "sistema de reservas con overbooking"
/start-development cross-vertical "dashboard de analytics unificado"
/check-development-status core
/continue-development "modelo-datos" core
```

---

## 📋 METODOLOGÍA DE 20 FASES - MATRIZ DE ESTADO

### **🎯 FASE 1: ANÁLISIS Y DEFINICIÓN**

#### **FASE 1.1: Casos de Uso (Use Cases)**
```yaml
Objetivo: Define exactamente QUÉ debe hacer la característica
Entregables: 
  - casos_uso_[componente]_[feature].md
  - diagramas_casos_uso_[componente].mermaid
Rama: analysis/[fecha]-casos-uso-[componente]-[feature]
Criterios_Completado:
  - ✅ Casos de uso principales documentados
  - ✅ Casos de uso alternativos identificados
  - ✅ Actores y precondiciones definidos
  - ✅ Revisión por ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 1.2: Historias de Usuario (User Stories)**
```yaml
Objetivo: Traduce casos de uso a formato ágil con criterios aceptación
Entregables:
  - historias_usuario_[componente]_[feature].md
  - criterios_aceptacion_[componente]_[feature].md
Rama: analysis/[fecha]-user-stories-[componente]-[feature]
Criterios_Completado:
  - ✅ Historias con formato: Como [rol] quiero [acción] para [beneficio]
  - ✅ Criterios aceptación SMART definidos
  - ✅ Estimación de story points asignada
  - ✅ Priorización realizada
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 1.3: Requisitos Funcionales**
```yaml
Objetivo: Documenta funcionalidades específicas y reglas de negocio
Entregables:
  - requisitos_funcionales_[componente]_[feature].md
  - matriz_trazabilidad_[componente]_[feature].xlsx
Rama: analysis/[fecha]-requisitos-funcionales-[componente]-[feature]
Criterios_Completado:
  - ✅ Requisitos funcionales numerados y priorizados
  - ✅ Reglas de negocio explícitas
  - ✅ Validaciones y flujos alternativos
  - ✅ Matriz de trazabilidad requisito-historia
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 1.4: Requisitos No Funcionales**
```yaml
Objetivo: Define rendimiento, seguridad, escalabilidad requeridos
Entregables:
  - requisitos_no_funcionales_[componente]_[feature].md
  - metricas_rendimiento_[componente]_[feature].md
Rama: analysis/[fecha]-requisitos-no-funcionales-[componente]-[feature]
Criterios_Completado:
  - ✅ Métricas de rendimiento cuantificadas
  - ✅ Requisitos de seguridad especificados
  - ✅ Criterios de escalabilidad definidos
  - ✅ Requisitos de usabilidad documentados
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

---

### **🏗️ FASE 2: DISEÑO TÉCNICO**

#### **FASE 2.1: Modelo de Datos**
```yaml
Objetivo: Define estructuras de datos, relaciones y restricciones
Entregables:
  - modelo_datos_[componente]_[feature].sql
  - diagrama_entidad_relacion_[componente].mermaid
  - diccionario_datos_[componente]_[feature].md
Rama: design/[fecha]-modelo-datos-[componente]-[feature]
Criterios_Completado:
  - ✅ Esquema de base de datos definido
  - ✅ Relaciones y constraints especificados
  - ✅ Índices y optimizaciones planificados
  - ✅ Scripts de migración preparados
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 2.2: Arquitectura del Sistema**
```yaml
Objetivo: Define cómo la característica se integra al sistema existente
Entregables:
  - arquitectura_[componente]_[feature].md
  - diagramas_arquitectura_[componente].mermaid
  - analisis_impacto_[componente]_[feature].md
Rama: design/[fecha]-arquitectura-[componente]-[feature]
Criterios_Completado:
  - ✅ Diagramas de componentes y deployment
  - ✅ Patrones arquitecturales definidos
  - ✅ Dependencias e integraciones identificadas
  - ✅ Análisis de impacto en sistema existente
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 2.3: API Design / Contratos**
```yaml
Objetivo: Define interfaces para interacción con otros componentes
Entregables:
  - api_spec_[componente]_[feature].yaml (OpenAPI)
  - contratos_interfaces_[componente]_[feature].md
  - ejemplos_uso_api_[componente]_[feature].md
Rama: design/[fecha]-api-design-[componente]-[feature]
Criterios_Completado:
  - ✅ Especificación OpenAPI completa
  - ✅ Contratos de entrada y salida definidos
  - ✅ Códigos de error y manejo especificados
  - ✅ Ejemplos de uso documentados
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 2.4: Diseño de UI/UX (si aplica)**
```yaml
Objetivo: Valida experiencia de usuario antes del desarrollo
Entregables:
  - wireframes_[componente]_[feature].fig
  - mockups_[componente]_[feature].fig
  - flujos_usuario_[componente]_[feature].md
Rama: design/[fecha]-ui-ux-[componente]-[feature]
Criterios_Completado:
  - ✅ Wireframes de pantallas principales
  - ✅ Mockups de alta fidelidad
  - ✅ Flujos de usuario validados
  - ✅ Guía de estilo aplicada
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

---

### **🔧 FASE 3: ESPECIFICACIONES TÉCNICAS**

#### **FASE 3.1: Algoritmos y Lógica**
```yaml
Objetivo: Documenta lógica compleja antes de codificar
Entregables:
  - algoritmos_[componente]_[feature].md
  - pseudocodigo_[componente]_[feature].md
  - diagramas_flujo_[componente]_[feature].mermaid
Rama: specs/[fecha]-algoritmos-[componente]-[feature]
Criterios_Completado:
  - ✅ Algoritmos principales documentados
  - ✅ Pseudocódigo para lógica compleja
  - ✅ Diagramas de flujo de procesos
  - ✅ Consideraciones de rendimiento
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 3.2: Matriz de Trazabilidad**
```yaml
Objetivo: Conecta requisitos con componentes técnicos
Entregables:
  - matriz_trazabilidad_completa_[componente]_[feature].xlsx
  - mapeo_requisitos_codigo_[componente]_[feature].md
Rama: specs/[fecha]-trazabilidad-[componente]-[feature]
Criterios_Completado:
  - ✅ Cada requisito mapeado a componente
  - ✅ Cada componente vinculado a prueba
  - ✅ Cobertura de requisitos 100%
  - ✅ Herramientas de tracking configuradas
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 3.3: Plan de Migración**
```yaml
Objetivo: Define migración de datos y sistema existente
Entregables:
  - plan_migracion_[componente]_[feature].md
  - scripts_migracion_[componente]_[feature].sql
  - rollback_procedures_[componente]_[feature].md
Rama: specs/[fecha]-migracion-[componente]-[feature]
Criterios_Completado:
  - ✅ Estrategia de migración definida
  - ✅ Scripts de migración validados
  - ✅ Procedimientos de rollback probados
  - ✅ Backup y recovery planificados
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

---

### **🧪 FASE 4: ESTRATEGIA DE TESTING**

#### **FASE 4.1: Plan de Pruebas**
```yaml
Objetivo: Define estrategia completa de testing
Entregables:
  - plan_pruebas_[componente]_[feature].md
  - estrategia_testing_[componente]_[feature].md
  - matriz_casos_prueba_[componente]_[feature].xlsx
Rama: testing/[fecha]-plan-pruebas-[componente]-[feature]
Criterios_Completado:
  - ✅ Estrategia de unit testing definida
  - ✅ Plan de integration testing
  - ✅ Estrategia de e2e testing
  - ✅ Performance testing planificado
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 4.2: Casos de Prueba Detallados**
```yaml
Objetivo: Especifica escenarios exactos incluyendo edge cases
Entregables:
  - casos_prueba_[componente]_[feature].md
  - test_data_[componente]_[feature].sql
  - expected_results_[componente]_[feature].json
Rama: testing/[fecha]-casos-prueba-[componente]-[feature]
Criterios_Completado:
  - ✅ Casos de prueba positivos documentados
  - ✅ Casos de prueba negativos incluidos
  - ✅ Edge cases identificados
  - ✅ Data de prueba preparada
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 4.3: Criterios de Aceptación**
```yaml
Objetivo: Establece métricas objetivas para "terminado"
Entregables:
  - criterios_aceptacion_[componente]_[feature].md
  - metricas_calidad_[componente]_[feature].md
  - definition_of_done_[componente]_[feature].md
Rama: testing/[fecha]-criterios-aceptacion-[componente]-[feature]
Criterios_Completado:
  - ✅ Criterios de aceptación SMART
  - ✅ Métricas de calidad cuantificadas
  - ✅ Definition of Done consensuada
  - ✅ Herramientas de medición configuradas
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

---

### **🚀 FASE 5: IMPLEMENTACIÓN Y DEPLOYMENT**

#### **FASE 5.1: Git Flow y Branching**
```yaml
Objetivo: Organiza código en repositorio para colaboración
Entregables:
  - estrategia_branching_[componente]_[feature].md
  - git_flow_config_[componente]_[feature].md
  - code_review_guidelines_[componente]_[feature].md
Rama: implementation/[fecha]-git-flow-[componente]-[feature]
Criterios_Completado:
  - ✅ Estrategia de branching definida
  - ✅ Git Flow configurado
  - ✅ Guidelines de code review
  - ✅ Herramientas de CI/CD configuradas
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 5.2: Plan de Deployment**
```yaml
Objetivo: Define estrategia de releases y rollback
Entregables:
  - plan_deployment_[componente]_[feature].md
  - scripts_deployment_[componente]_[feature].sh
  - rollback_procedures_[componente]_[feature].md
Rama: deployment/[fecha]-plan-deployment-[componente]-[feature]
Criterios_Completado:
  - ✅ Estrategia de deployment (blue-green/canary)
  - ✅ Scripts de deployment automatizados
  - ✅ Procedimientos de rollback validados
  - ✅ Monitoreo post-deployment configurado
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 5.3: Monitoreo y Logging**
```yaml
Objetivo: Configura observabilidad para producción
Entregables:
  - config_monitoreo_[componente]_[feature].yaml
  - dashboards_[componente]_[feature].json
  - alertas_[componente]_[feature].yaml
Rama: monitoring/[fecha]-observabilidad-[componente]-[feature]
Criterios_Completado:
  - ✅ Métricas de negocio definidas
  - ✅ Dashboards de monitoreo configurados
  - ✅ Alertas críticas implementadas
  - ✅ Logging estructurado configurado
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 5.4: Documentación y Training**
```yaml
Objetivo: Prepara documentación para adopción y soporte
Entregables:
  - documentacion_usuario_[componente]_[feature].md
  - documentacion_admin_[componente]_[feature].md
  - training_materials_[componente]_[feature].md
Rama: documentation/[fecha]-docs-[componente]-[feature]
Criterios_Completado:
  - ✅ Documentación de usuario final
  - ✅ Documentación de administración
  - ✅ Materiales de training preparados
  - ✅ FAQ y troubleshooting guides
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

#### **FASE 5.5: Definition of Done**
```yaml
Objetivo: Checklist verificable de completitud
Entregables:
  - checklist_dod_[componente]_[feature].md
  - validation_report_[componente]_[feature].md
  - sign_off_[componente]_[feature].md
Rama: validation/[fecha]-definition-done-[componente]-[feature]
Criterios_Completado:
  - ✅ Todos los criterios DoD cumplidos
  - ✅ Testing completo ejecutado
  - ✅ Code review aprobado
  - ✅ Sign-off de stakeholders obtenido
Estado: [ ] TODO / [ ] IN_PROGRESS / [ ] COMPLETED / [ ] VALIDATED
```

---

## 🎛️ SISTEMA DE TRACKING Y ESTADO

### **COMANDO: /check-development-status <componente>**

#### **EJEMPLO: /check-development-status core**
```yaml
CORE COMPONENT - ESTADO DE DESARROLLO

📊 RESUMEN GENERAL:
  Características en desarrollo: 3
  Fases completadas: 67%
  Características en producción: 12
  
🔄 CARACTERÍSTICAS ACTIVAS:
  1. autenticacion-biometrica:
     Estado: FASE 2.1 (Modelo de Datos) - IN_PROGRESS
     Rama actual: design/20250727-modelo-datos-core-autenticacion
     Próximo: Completar esquema de BD + migración
     
  2. payment-gateway-v2:
     Estado: FASE 4.2 (Casos de Prueba) - IN_PROGRESS  
     Rama actual: testing/20250720-casos-prueba-core-payment-v2
     Próximo: Finalizar edge cases + data de prueba
     
  3. audit-logging:
     Estado: FASE 5.3 (Monitoreo) - COMPLETED
     Rama actual: monitoring/20250715-observabilidad-core-audit
     Próximo: LISTO PARA MERGE A DEVELOP

📋 PRÓXIMAS ACCIONES SUGERIDAS:
  1. Continuar modelo de datos autenticación biométrica
  2. Revisar casos de prueba payment gateway v2  
  3. Ejecutar merge audit-logging a develop
  
🎯 COMANDO PARA CONTINUAR:
  /continue-development "modelo-datos" core autenticacion-biometrica
```

### **COMANDO: /continue-development <fase> <componente> <característica>**

#### **EJEMPLO: /continue-development "modelo-datos" core autenticacion-biometrica**
```yaml
🎯 CONTINUANDO DESARROLLO: Core > Autenticación Biométrica > Modelo de Datos

📂 CONTEXTO CARGADO:
  - Casos de uso autenticación biométrica ✅
  - Requisitos funcionales ✅  
  - Requisitos no funcionales ✅
  - Modelo actual de usuarios ✅
  - Patrones de datos existentes ✅

🎋 RAMA ACTIVA: design/20250727-modelo-datos-core-autenticacion

📋 ESTADO FASE 2.1 - MODELO DE DATOS:
  ✅ Análisis de entidades principales (COMPLETED)
  🔄 Definición de esquema BD (IN_PROGRESS - 60%)
  ⏳ Relaciones y constraints (TODO)
  ⏳ Scripts de migración (TODO)
  ⏳ Revisión arquitectural (TODO)

🎯 PRÓXIMA ACCIÓN REQUERIDA:
  Completar definición de esquema de base de datos:
  - Tabla biometric_templates (fields, types, constraints)
  - Tabla biometric_devices (configuración dispositivos)
  - Índices para optimización de consultas
  - Triggers para auditoría

📁 ARCHIVOS PARA EDITAR:
  - modelo_datos_core_autenticacion.sql (60% completo)
  - diagrama_entidad_relacion_core.mermaid (pendiente actualizar)
  - diccionario_datos_core_autenticacion.md (draft)

⚡ ESPECIALISTAS ASIGNADOS:
  - DESARROLLADOR_SENIOR (lead)
  - ARQUITECTO (review)
  - DBA (consulta)

💡 ¿LISTO PARA CONTINUAR CON EL ESQUEMA DE BD?
```

---

## 🔄 INTEGRACIÓN CON NAVIGATOR PRINCIPAL

### **DETECCIÓN AUTOMÁTICA EN NAVIGATOR**
```yaml
Triggers_Metodología:
  - "quiero trabajar en": → /check-development-status [componente]
  - "continuar desarrollo": → /continue-development [última_fase] [componente]
  - "nuevo desarrollo": → /start-development [componente] [descripción]
  - "estado del desarrollo": → /check-development-status [componente]
  - "próxima fase": → navegación automática a siguiente fase
  - "documentación fase": → carga contexto específico de fase actual
```

### **AUTO-ROUTING POR COMPONENTE**
```yaml
Core_Components:
  - authentication, payment, audit, security, users, permissions
  → Especialistas: DESARROLLADOR_SENIOR + ARQUITECTO
  → Contexto: Metodología + patrones core + dependencias shared

Vertical_Components:  
  - restaurant, hotel, retail, healthcare, education, logistics
  → Especialistas: ANALISTA_NEGOCIO + DESARROLLADOR_SENIOR
  → Contexto: Metodología + especializaciones vertical + casos uso

Cross_Vertical:
  - analytics, dashboard, reporting, integration, api-gateway
  → Especialistas: ARQUITECTO + DESARROLLADOR_SENIOR  
  → Contexto: Metodología + estrategias cross + testing protocols
```

---

## 📊 MÉTRICAS Y KPIs

### **MÉTRICAS DE ADOPCIÓN DE METODOLOGÍA**
```yaml
Eficiencia_Desarrollo:
  - Tiempo promedio por fase: Target <3 días
  - Fases completadas sin retraso: Target >85%
  - Detección temprana de problemas: Target >90%

Calidad_Entregables:
  - Documentación completa por fase: Target 100%
  - Code review approval rate: Target >95%  
  - Bug density post-release: Target <2 bugs/KLOC

Trazabilidad:
  - Requisitos traced to code: Target 100%
  - Test coverage: Target >90%
  - Documentation coverage: Target >95%
```

---

**💡 BENEFICIOS INTEGRADOS:**
- **Desarrollo guiado**: Cada nueva característica sigue metodología probada
- **Trazabilidad completa**: Desde requisito hasta código en producción
- **Gestión de estado**: Visibilidad instantánea de progreso en tiempo real
- **Reutilización**: Documentación y patrones reutilizables entre características
- **Calidad asegurada**: Gates de calidad en cada fase antes de continuar
