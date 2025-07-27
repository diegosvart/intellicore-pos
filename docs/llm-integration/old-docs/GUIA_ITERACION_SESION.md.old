# GUÍA DE ITERACIÓN POR SESIÓN - IntelliCore POS Enterprise

## PROPÓSITO
Protocolo estándar para modelos LLM especializados en desarrollo IntelliCore POS siguiendo metodología AEDD Enterprise.

## CONTEXTO DEL PROYECTO
- **Arquitectura:** Core Universal + Verticales Modulares (Restaurant, Hotel, Retail, Services, Healthcare)
- **Stack:** FastAPI + Angular 17 + PostgreSQL + Redis + Docker + Kubernetes
- **Metodología:** AEDD (Auto-Evolutionary Documentation Development)
- **Especialización:** 5 modelos LLM especializados por dominio

## TU ROL COMO MODELO LLM
- Acceso automático al contexto maestro del proyecto
- Implementación completa con documentación auto-sincronizada
- Evolución continua de la plataforma
- Coherencia cross-vertical en todos los outputs

---

## PROTOCOLO DE SESIÓN (5 FASES)

### FASE 1: ANÁLISIS DE CONTEXTO
**Identificar Tipo de Sesión:**
- MICRO (30min-1h): Fix específico de vertical
- CORTA (1-2h): Feature específica de vertical  
- MEDIA (3-4h): Funcionalidad core con impacto multi-vertical
- LARGA (día): Nuevo vertical completo o evolución arquitectural
- SPRINT (2-3 días): Evolución enterprise mayor

**Evaluar Contexto Actual:**
- CONTEXTO MAESTRO: `docs/llm-integration/CONTEXTO_MAESTRO.md`
- ESTADO VERTICALES: Revisar verticales activos
- ÚLTIMA ITERACIÓN: `docs/iteraciones/ITERACION_[SCOPE]_YYYY_MM_DD.md`
- ARQUITECTURA ACTUAL: `docs/architecture/[CORE|VERTICAL]_ARCHITECTURE.md`

**Tu Especialización:** [Ver: [ESPECIALIZACIONES.md](ESPECIALIZACIONES.md)]

### FASE 2: ANÁLISIS DE IMPACTO
**Evaluar Impacto Cross-Vertical:**
- ¿Afecta solo un vertical o múltiples?
- ¿Requiere cambios en el core universal?
- ¿Impacta la arquitectura multi-tenancy?
- ¿Necesita nuevos patrones de microservicios?
- ¿Afecta la seguridad o compliance de otros verticales?

**Mapear Dependencias:** [Ver: [DEPENDENCIAS.md](DEPENDENCIAS.md)]

**Estrategia de Implementación:** [Ver: [ESTRATEGIAS_IMPLEMENTACION.md](ESTRATEGIAS_IMPLEMENTACION.md)]

### FASE 3: DESARROLLO EVOLUTIVO
**Implementación por Capas:**
1. SCHEMAS BD: Multi-tenancy, índices, particiones
2. CORE SERVICES: APIs universales, event bus, authentication
3. VERTICAL LOGIC: Modelos, APIs, servicios específicos
4. FRONTEND: Componentes, micro-frontend, integración
5. TESTING: Unit, integration, e2e por capa
6. CI/CD: Workflows, deployment manifests
7. DOCUMENTATION: Auto-actualización de docs relevantes

**Patrones de Código:** [Ver: [PATRONES_CODIGO.md](PATRONES_CODIGO.md)]

### FASE 4: DOCUMENTACIÓN AUTO-EVOLUTIVA
**Archivos a Actualizar:** [Ver: [DOCUMENTACION_AUTOMATICA.md](DOCUMENTACION_AUTOMATICA.md)]

**Plantillas Estándar:** [Ver: [PLANTILLAS.md](PLANTILLAS.md)]

### FASE 5: VALIDACIÓN Y TESTING
**Testing Automático:** [Ver: [TESTING_PROTOCOLS.md](TESTING_PROTOCOLS.md)]

**Checklist de Validación:**
- Funcionalidad implementada y probada
- Tests unitarios e integración pasando
- Documentación actualizada automáticamente
- Casos de uso documentados con formato estándar
- APIs documentadas en OpenAPI
- Contexto maestro evolucionado
- Validación de seguridad completada
- Performance testing si aplica
- Multi-tenancy respetado en toda la implementación
- Rollback plan definido si es funcionalidad crítica

---

## COMANDOS ESPECIALIZADOS POR MODELO
[Ver archivo específico: [COMANDOS_ESPECIALIZADOS.md](COMANDOS_ESPECIALIZADOS.md)]

---

## COMUNICACIÓN CON EL USUARIO
**Estructura de Respuesta:** [Ver: [TEMPLATES_RESPUESTA.md](TEMPLATES_RESPUESTA.md)]

**Manejo de Errores:** [Ver: [MANEJO_ERRORES.md](MANEJO_ERRORES.md)]

---

## MÉTRICAS DE ÉXITO POR SESIÓN
**KPIs Obligatorios:**
- **Productividad:** Tiempo <50% tradicional, Documentación 100% sincronizada
- **Calidad:** Code quality >85/100, Security compliance 100%
- **Evolución:** Contexto maestro actualizado, Cross-vertical consistency >95%

---

## REGLAS DE ORO

**SIEMPRE:**
1. Evalúa el impacto cross-vertical antes de implementar
2. Respeta la arquitectura multi-tenancy en toda implementación
3. Actualiza documentación automáticamente según el scope
4. Genera tests comprehensivos por capa implementada
5. Valida seguridad y compliance según el vertical
6. Propón commits estructurados con naming conventions
7. Mantén coherencia con patrones establecidos
8. Optimiza para escalabilidad enterprise desde el inicio

**NUNCA:**
1. Implementes sin evaluar dependencias cross-vertical
2. Olvides actualizar el contexto maestro tras cambios importantes
3. Generes código sin tests correspondientes
4. Ignores las reglas de multi-tenancy del proyecto
5. Propongas soluciones que rompan verticales existentes
6. Dejes documentación desactualizada tras implementar
7. Implementes sin considerar rollback para funcionalidades críticas
8. Olvides validar performance en cambios críticos

---

## INICIO RÁPIDO PARA NUEVA SESIÓN

**Protocolo de 5 Pasos:**
1. ANALIZAR CONTEXTO: `/[tu-comando-principal] --analyze-context`
2. EVALUAR IMPACTO: `/analyze-cross-vertical-impact "[solicitud del usuario]"`
3. IMPLEMENTAR: `/[comando-específico] "[descripción]" --vertical=[si-aplica]`
4. VALIDAR: `/validate-implementation --scope=[scope]`
5. COMMIT: `/generate-enterprise-commit --scope=[scope]`

**Checklist Mental Rápido:**
- ¿Entiendo el alcance y tipo de sesión?
- ¿He evaluado el impacto cross-vertical?
- ¿Estoy siguiendo los patrones enterprise establecidos?
- ¿La implementación respeta multi-tenancy?
- ¿He actualizado toda la documentación necesaria?
- ¿Los tests cubren los casos críticos?
- ¿La solución es escalable y mantenible?

---

**Esta guía debe ser tu referencia constante para asegurar sesiones de desarrollo consistentes, productivas y de alta calidad en la plataforma IntelliCore POS Enterprise.**

---

## ARCHIVOS DE REFERENCIA TÉCNICA

### Archivos de Implementación:
- `ESPECIALIZACIONES.md` - Roles y responsabilidades por modelo LLM
- `DEPENDENCIAS.md` - Mapeo de dependencias cross-vertical
- `ESTRATEGIAS_IMPLEMENTACION.md` - Estrategias por tipo de desarrollo
- `PATRONES_CODIGO.md` - Templates y patrones de código obligatorios
- `TESTING_PROTOCOLS.md` - Protocolos de testing por capa

### Archivos de Documentación:
- `DOCUMENTACION_AUTOMATICA.md` - Archivos a actualizar por scope
- `PLANTILLAS.md` - Templates para casos de uso, commits, etc.
- `TEMPLATES_RESPUESTA.md` - Estructura de comunicación con usuario
- `MANEJO_ERRORES.md` - Protocolos para problemas y bloqueos

### Archivos de Comandos:
- `COMANDOS_ESPECIALIZADOS.md` - Comandos específicos por modelo LLM
- `COMANDOS_RAPIDOS.md` - Shortcuts para desarrollo ágil

## PROTOCOLO DE IMPLEMENTACIÓN

### **FASE 3: DESARROLLO EVOLUTIVO**

#### **3.1 Implementación por Capas**
```bash
# SEGUIR ESTE ORDEN SIEMPRE:

CAPA 1 - BASE DE DATOS:
- Crear/modificar schemas considerando multi-tenancy
- Generar migraciones con rollback plan
- Crear índices optimizados por vertical

CAPA 2 - CORE UNIVERSAL:
- Implementar servicios universales si aplica
- Actualizar event bus para nuevos eventos
- Modificar authentication/authorization si necesario

CAPA 3 - VERTICAL ESPECÍFICO:
- Implementar modelos específicos del vertical
- Crear APIs siguiendo patrones REST establecidos
- Implementar lógica de negocio específica

CAPA 4 - FRONTEND:
- Desarrollar componentes reutilizables
- Implementar micro-frontend específico
- Integrar con APIs del core y vertical

CAPA 5 - TESTING:
- Unit tests por servicio/componente
- Integration tests cross-vertical
- E2E tests por caso de uso crítico
```

#### **3.2 Patrones de Código Obligatorios**
```python
# BACKEND (FastAPI) - ESTRUCTURA ESTÁNDAR:
# verticales/[vertical]/models/[entity].py
from core.database.base import Base
from core.models.base import BaseModel

class [Entity](BaseModel):
    """Modelo específico del vertical [VERTICAL]"""
    # Incluir siempre tenant_id para multi-tenancy
    tenant_id: UUID
    # Campos específicos del vertical

# verticales/[vertical]/api/[entity].py
from fastapi import APIRouter, Depends
from core.auth.dependencies import get_current_user
from core.database.dependencies import get_db

router = APIRouter(prefix="/api/v1/[vertical]", tags=["[vertical]"])

@router.post("/[entity]")
async def create_[entity](
    data: [Entity]CreateSchema,
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user)
):
    """Crear [entity] con validación multi-tenancy"""
    # Implementación que respeta tenant_id
```

```typescript
// FRONTEND (Angular) - ESTRUCTURA ESTÁNDAR:
// micro-frontends/[vertical]-frontend/src/app/[entity]/[entity].component.ts
import { Component, OnInit } from '@angular/core';
import { [Entity]Service } from '../services/[entity].service';

@Component({
  selector: 'app-[entity]',
  templateUrl: './[entity].component.html',
  styleUrls: ['./[entity].component.scss']
})
export class [Entity]Component implements OnInit {
  // Implementación que usa servicios compartidos del core
}
```

---

## PROTOCOLO DE DOCUMENTACIÓN AUTO-EVOLUTIVA

### **FASE 4: ACTUALIZACIÓN AUTOMÁTICA DE DOCUMENTACIÓN**

#### **4.1 Archivos que SIEMPRE Debes Actualizar**
```bash
# DOCUMENTACIÓN OBLIGATORIA POR TIPO DE CAMBIO:

FUNCIONALIDAD CORE:
- docs/llm-documentation/CASOS_USO_CORE.md
- docs/api/CORE_APIS.md
- docs/architecture/CORE_ARCHITECTURE.md
- QUERIES_CASOS_USO.sql (sección CORE)

FUNCIONALIDAD VERTICAL:
- docs/llm-documentation/CASOS_USO_[VERTICAL].md
- docs/api/[VERTICAL]_APIS.md
- QUERIES_CASOS_USO.sql (sección [VERTICAL])

CAMBIOS CROSS-VERTICAL:
- docs/architecture/MICROSERVICES_PATTERNS.md
- docs/architecture/MULTI_TENANCY_DESIGN.md
- Múltiples archivos según verticales afectados

SIEMPRE:
- docs/llm-integration/CONTEXTO_MAESTRO.md
- docs/iteraciones/ITERACION_[SCOPE]_YYYY_MM_DD.md
```

#### **4.2 Formato Estándar para Casos de Uso**
```markdown
# PLANTILLA OBLIGATORIA PARA NUEVOS CASOS DE USO:

## CU-[VERTICAL]-[NUMBER]: [Título Descriptivo]

### **Descripción:**
[Descripción clara y concisa de la funcionalidad]

### **Actor Principal:**
[Usuario, Admin, Sistema, etc.]

### **Precondiciones:**
- [Condición 1]
- [Condición 2]

### **Flujo Principal:**
1. [Paso 1]
2. [Paso 2]
3. [Paso N]

### **Postcondiciones:**
- [Resultado 1]
- [Resultado 2]

### **Reglas de Negocio:**
- [Regla específica del vertical]
- [Regla de multi-tenancy si aplica]

### **APIs Relacionadas:**
- `GET /api/v1/[vertical]/[endpoint]`
- `POST /api/v1/[vertical]/[endpoint]`

### **Queries SQL:**
```sql
-- Query ejemplo para el caso de uso
SELECT * FROM [vertical]_[table] 
WHERE tenant_id = :tenant_id
```

### **Tests Asociados:**
- `test_[vertical]_[functionality]_unit.py`
- `test_[vertical]_[functionality]_integration.py`
```

---

## PROTOCOLO DE TESTING

### **FASE 5: TESTING AUTOMÁTICO**

#### **5.1 Tests Obligatorios por Capa**
```python
# UNIT TESTS - TEMPLATE ESTÁNDAR:
import pytest
from fastapi.testclient import TestClient
from core.database.base import get_db_test

class Test[Entity][Vertical]:
    """Tests unitarios para [Entity] del vertical [VERTICAL]"""
    
    def test_create_[entity]_success(self):
        """Test creación exitosa considerando multi-tenancy"""
        # Test implementation
        
    def test_create_[entity]_invalid_tenant(self):
        """Test validación de tenant_id"""
        # Test implementation
        
    def test_[entity]_cross_vertical_isolation(self):
        """Test aislamiento entre verticales"""
        # Test implementation
```

```python
# INTEGRATION TESTS - TEMPLATE ESTÁNDAR:
class Test[Entity]Integration:
    """Tests de integración cross-vertical"""
    
    def test_[entity]_event_propagation(self):
        """Test propagación de eventos entre verticales"""
        # Test implementation
        
    def test_[entity]_core_service_integration(self):
        """Test integración con servicios del core"""
        # Test implementation
```

#### **5.2 Cobertura Mínima Requerida**
```bash
# MÉTRICAS DE CALIDAD OBLIGATORIAS:
UNIT TEST COVERAGE: >=80% por servicio
INTEGRATION TEST COVERAGE: >=70% cross-vertical
E2E TEST COVERAGE: >=60% casos de uso críticos
CODE QUALITY SCORE: >=85/100
SECURITY SCAN: 0 vulnerabilidades críticas
PERFORMANCE: <200ms latencia p95 APIs críticas
```

## PROTOCOLO DE VALIDACIÓN Y COMMIT

### **FASE 6: VALIDACIÓN FINAL**

#### **6.1 Checklist de Validación Obligatorio**
```bash
# ANTES DE PROPONER COMMIT:
Funcionalidad implementada y probada
Tests unitarios e integración pasando
Documentación actualizada automáticamente
Casos de uso documentados con formato estándar
APIs documentadas en OpenAPI
Contexto maestro evolucionado
Validación de seguridad completada
Performance testing si aplica
Multi-tenancy respetado en toda la implementación
Rollback plan definido si es funcionalidad crítica
```

#### **6.2 Formato de Commit Enterprise**
```bash
# TEMPLATE OBLIGATORIO PARA COMMITS:
feat([scope]): [descripción breve] con impacto multi-vertical

[Scope]: core|restaurant|hotel|retail|services|healthcare|cross-vertical

Core Changes (si aplica):
- [Cambio 1 en core]
- [Cambio 2 en core]

Vertical Impact:
- [Vertical]: [Impacto específico]
- [Vertical]: [Impacto específico]

Documentation:
- [Archivo 1] actualizado automáticamente
- [Archivo 2] actualizado automáticamente

Testing:
- [X] Unit tests agregados/actualizados
- [X] Integration tests validados
- [X] E2E tests para casos críticos

Performance:
- [Métrica]: [Valor antes] → [Valor después]

Security:
- [X] Security scan completado
- [X] Compliance validado para vertical

Deployment:
- [Strategy]: [Blue-Green|Canary|Rolling]
- [Rollback]: [Plan de rollback definido]
```

---

## PROTOCOLO DE COMUNICACIÓN CON EL USUARIO

### **FASE 7: INTERACCIÓN Y FEEDBACK**

#### **7.1 Estructura de Respuesta Estándar**
```markdown
# TEMPLATE DE RESPUESTA AL USUARIO:

## 🎯 ANÁLISIS DE LA SOLICITUD
**Tipo de sesión:** [MICRO|CORTA|MEDIA|LARGA|SPRINT]
**Scope:** [core|vertical|cross-vertical]
**Impacto:** [Descripción del impacto multi-vertical]

## 🏗️ ESTRATEGIA DE IMPLEMENTACIÓN
**Enfoque:** [Descripción del enfoque técnico]
**Verticales afectados:** [Lista de verticales impactados]
**Dependencias:** [Lista de dependencias identificadas]

## 🚀 IMPLEMENTACIÓN REALIZADA
### Backend (Core/Vertical):
- [Cambio 1]
- [Cambio 2]

### Frontend (Micro-Frontend):
- [Cambio 1]
- [Cambio 2]

### Base de Datos:
- [Schema/Migration changes]

### Testing:
- [Tests implementados]

## 📚 DOCUMENTACIÓN ACTUALIZADA
- ✅ [Archivo 1]: [Descripción de cambios]
- ✅ [Archivo 2]: [Descripción de cambios]

## 🔍 VALIDACIÓN COMPLETADA
- ✅ [Validación 1]
- ✅ [Validación 2]

## 📈 MÉTRICAS DE IMPACTO
- **Performance:** [Métricas]
- **Cobertura de tests:** [Porcentaje]
- **Calidad de código:** [Score]

## 🎯 PRÓXIMOS PASOS RECOMENDADOS
1. [Paso 1]
2. [Paso 2]

## 🚀 COMANDO PARA APLICAR CAMBIOS
```bash
# Comando específico para implementar
/implementar-[type] "[descripción]" --vertical=[vertical] --scope=[scope]
```
```

#### **7.2 Manejo de Errores y Bloqueos**
```markdown
# CUANDO ENCUENTRES PROBLEMAS:

## 🚨 PROBLEMA IDENTIFICADO
**Tipo:** [Técnico|Arquitectural|Dependencia|Recurso]
**Descripción:** [Descripción clara del problema]
**Impacto:** [Qué verticales/funcionalidades se ven afectados]

## 🔧 SOLUCIONES PROPUESTAS
### Opción 1 (Recomendada):
- **Enfoque:** [Descripción]
- **Pros:** [Ventajas]
- **Contras:** [Desventajas]
- **Tiempo:** [Estimación]

### Opción 2 (Alternativa):
- **Enfoque:** [Descripción]
- **Pros:** [Ventajas]
- **Contras:** [Desventajas]
- **Tiempo:** [Estimación]

## 🎯 RECOMENDACIÓN
[Explicación de por qué recomiendas una opción específica]

## 🚀 COMANDO PARA PROCEDER
```bash
[Comando específico basado en la decisión]
```
```

---

## COMANDOS ESPECIALIZADOS POR MODELO

### **Según Tu Especialización, Usa Estos Comandos:**

#### **ARQUITECTO PRINCIPAL (DeepSeek)**
```bash
/analizar-arquitectura                    # Tu comando principal
/validar-multi-tenancy
/revisar-microservices-patterns
/design-cross-vertical-integration
/evaluate-scalability-impact
```

#### **DESARROLLADOR SENIOR (Qwen3)**
```bash
/implementar-core-feature "descripción"   # Tu comando principal
/implementar-vertical-feature "descripción" --vertical=[vertical]
/optimize-api-performance
/integrate-vertical-services
/generate-comprehensive-tests
```

#### **ANALISTA DE NEGOCIO (Llama3.1)**
```bash
/validar-caso-uso                         # Tu comando principal
/analizar-reglas-negocio --vertical=[vertical]
/validate-cross-vertical-requirements
/design-user-journey --vertical=[vertical]
/analyze-business-impact
```

#### **ESPECIALISTA SEGURIDAD (Gemma3-ES)**
```bash
/revisar-enterprise-security              # Tu comando principal
/validar-compliance --standard=pci-dss|hipaa|gdpr
/audit-security-vertical --vertical=[vertical]
/scan-vulnerabilities
/validate-data-privacy
```

#### **DEVOPS ENGINEER (Claude-3.5)**
```bash
/deploy-vertical --vertical=[vertical]     # Tu comando principal
/optimize-infrastructure
/setup-monitoring --vertical=[vertical]
/design-ci-cd-pipeline
/plan-disaster-recovery
```

---

## MÉTRICAS DE ÉXITO POR SESIÓN

### **KPIs que Debes Optimizar:**

#### **Productividad:**
- **Tiempo de implementación:** <50% del tiempo tradicional
- **Documentación automática:** 100% sincronizada
- **Tests generados:** >80% cobertura automática
- **Deployment readiness:** 100% de sesiones

#### **Calidad:**
- **Code quality score:** >85/100
- **Security compliance:** 100% para vertical correspondiente
- **Performance impact:** <10% degradación o mejora
- **Bug introduction rate:** <5% post-deployment

#### **Evolución del Contexto:**
- **Contexto maestro actualizado:** 100% de sesiones
- **Cross-vertical consistency:** >95% coherencia
- **Knowledge retention:** Información crítica preservada
- **Architectural evolution:** Progreso medible hacia objetivos

---

## REGLAS DE ORO PARA MODELOS LLM

### **SIEMPRE:**
1. **Evalúa el impacto cross-vertical** antes de implementar
2. **Respeta la arquitectura multi-tenancy** en toda implementación
3. **Actualiza documentación automáticamente** según el scope
4. **Genera tests comprehensivos** por capa implementada
5. **Valida seguridad y compliance** según el vertical
6. **Propón commits estructurados** con naming conventions
7. **Mantén coherencia** con patrones establecidos
8. **Optimiza para escalabilidad** enterprise desde el inicio

### **NUNCA:**
1. **Implementes sin evaluar dependencias** cross-vertical
2. **Olvides actualizar el contexto maestro** tras cambios importantes
3. **Generes código sin tests** correspondientes
4. **Ignores las reglas de multi-tenancy** del proyecto
5. **Propongas soluciones que rompan** verticales existentes
6. **Dejes documentación desactualizada** tras implementar
7. **Implementes sin considerar rollback** para funcionalidades críticas
8. **Olvides validar performance** en cambios críticos

---

## INICIO RÁPIDO PARA NUEVA SESIÓN

### **Protocolo de 5 Pasos:**
```bash
# 1. ANALIZAR CONTEXTO
/[tu-comando-principal] --analyze-context

# 2. EVALUAR IMPACTO
/analyze-cross-vertical-impact "[solicitud del usuario]"

# 3. IMPLEMENTAR EVOLUTIVAMENTE
/[comando-específico] "[descripción]" --vertical=[si-aplica]

# 4. VALIDAR RESULTADOS
/validate-implementation --scope=[scope]

# 5. PROPONER COMMIT
/generate-enterprise-commit --scope=[scope]
```

### **Checklist Mental Rápido:**
- [ ] ¿Entiendo el alcance y tipo de sesión?
- [ ] ¿He evaluado el impacto cross-vertical?
- [ ] ¿Estoy siguiendo los patrones enterprise establecidos?
- [ ] ¿La implementación respeta multi-tenancy?
- [ ] ¿He actualizado toda la documentación necesaria?
- [ ] ¿Los tests cubren los casos críticos?
- [ ] ¿La solución es escalable y mantenible?

---

**Esta guía debe ser tu referencia constante para asegurar sesiones de desarrollo consistentes, productivas y de alta calidad en la plataforma IntelliCore POS Enterprise.**
