# PATRONES DE CÓDIGO OBLIGATORIOS - IntelliCore POS

## BACKEND (FastAPI) - ESTRUCTURA ESTÁNDAR

### Modelo de Vertical
```python
# verticales/[vertical]/models/[entity].py
from core.database.base import Base
from core.models.base import BaseModel
from sqlalchemy import Column, String, UUID, DateTime
from sqlalchemy.dialects.postgresql import UUID as pg_UUID

class [Entity](BaseModel):
    """Modelo específico del vertical [VERTICAL]"""
    __tablename__ = "[vertical]_[entity]"
    
    # OBLIGATORIO: Incluir siempre tenant_id para multi-tenancy
    tenant_id: UUID = Column(pg_UUID(as_uuid=True), nullable=False, index=True)
    
    # Campos específicos del vertical
    name: str = Column(String(255), nullable=False)
    created_at: DateTime = Column(DateTime(timezone=True), server_default=func.now())
    
    class Config:
        orm_mode = True
```

### API de Vertical
```python
# verticales/[vertical]/api/[entity].py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from core.auth.dependencies import get_current_user
from core.database.dependencies import get_db
from core.models.user import User

router = APIRouter(prefix="/api/v1/[vertical]", tags=["[vertical]"])

@router.post("/[entity]", response_model=[Entity]Response)
async def create_[entity](
    data: [Entity]CreateSchema,
    db: Session = Depends(get_db),
    user: User = Depends(get_current_user)
):
    """Crear [entity] con validación multi-tenancy"""
    # OBLIGATORIO: Validar tenant_id del usuario
    if data.tenant_id != user.tenant_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Access denied to different tenant"
        )
    
    # Implementación que respeta tenant_id
    db_entity = [Entity](**data.dict(), tenant_id=user.tenant_id)
    db.add(db_entity)
    db.commit()
    db.refresh(db_entity)
    
    return db_entity
```

### Servicio de Vertical
```python
# verticales/[vertical]/services/[entity]_service.py
from sqlalchemy.orm import Session
from core.services.base import BaseService
from ..models.[entity] import [Entity]

class [Entity]Service(BaseService):
    """Servicio para [Entity] con lógica de negocio específica"""
    
    def __init__(self, db: Session, tenant_id: UUID):
        super().__init__(db, tenant_id)
        self.model = [Entity]
    
    def create_with_business_rules(self, data: dict) -> [Entity]:
        """Crear con reglas de negocio específicas del vertical"""
        # OBLIGATORIO: Filtrar por tenant_id
        data["tenant_id"] = self.tenant_id
        
        # Aplicar reglas de negocio específicas del vertical
        validated_data = self._apply_business_rules(data)
        
        return self.create(validated_data)
    
    def _apply_business_rules(self, data: dict) -> dict:
        """Aplicar reglas específicas del vertical"""
        # Implementar reglas específicas aquí
        return data
```

## FRONTEND (Angular) - ESTRUCTURA ESTÁNDAR

### Componente de Vertical
```typescript
// micro-frontends/[vertical]-frontend/src/app/[entity]/[entity].component.ts
import { Component, OnInit, inject } from '@angular/core';
import { [Entity]Service } from '../services/[entity].service';
import { CoreAuthService } from '@core/auth/auth.service';
import { [Entity] } from '../models/[entity].model';

@Component({
  selector: 'app-[entity]',
  templateUrl: './[entity].component.html',
  styleUrls: ['./[entity].component.scss']
})
export class [Entity]Component implements OnInit {
  private [entity]Service = inject([Entity]Service);
  private authService = inject(CoreAuthService);
  
  [entity]List: [Entity][] = [];
  loading = false;
  
  ngOnInit(): void {
    this.load[Entity]List();
  }
  
  private async load[Entity]List(): Promise<void> {
    this.loading = true;
    try {
      // OBLIGATORIO: Usar servicios que respeten tenant_id automáticamente
      this.[entity]List = await this.[entity]Service.getAll();
    } catch (error) {
      console.error('Error loading [entity] list:', error);
    } finally {
      this.loading = false;
    }
  }
}
```

### Servicio de Frontend
```typescript
// micro-frontends/[vertical]-frontend/src/app/services/[entity].service.ts
import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CoreApiService } from '@core/api/api.service';
import { [Entity] } from '../models/[entity].model';

@Injectable({
  providedIn: 'root'
})
export class [Entity]Service {
  private http = inject(HttpClient);
  private apiService = inject(CoreApiService);
  
  private readonly baseUrl = '/api/v1/[vertical]/[entity]';
  
  getAll(): Observable<[Entity][]> {
    // OBLIGATORIO: Usar apiService para incluir automáticamente headers de tenant
    return this.apiService.get<[Entity][]>(this.baseUrl);
  }
  
  create(data: Partial<[Entity]>): Observable<[Entity]> {
    return this.apiService.post<[Entity]>(this.baseUrl, data);
  }
  
  update(id: string, data: Partial<[Entity]>): Observable<[Entity]> {
    return this.apiService.put<[Entity]>(`${this.baseUrl}/${id}`, data);
  }
  
  delete(id: string): Observable<void> {
    return this.apiService.delete<void>(`${this.baseUrl}/${id}`);
  }
}
```

## TESTING - TEMPLATES ESTÁNDAR

### Unit Test Backend
```python
# tests/verticales/[vertical]/test_[entity].py
import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session
from core.database.base import get_db_test
from verticales.[vertical].models.[entity] import [Entity]

class Test[Entity][Vertical]:
    """Tests unitarios para [Entity] del vertical [VERTICAL]"""
    
    def test_create_[entity]_success(self, db_session: Session, test_user):
        """Test creación exitosa considerando multi-tenancy"""
        data = {
            "name": "Test [Entity]",
            "tenant_id": test_user.tenant_id
        }
        
        [entity] = [Entity](**data)
        db_session.add([entity])
        db_session.commit()
        
        assert [entity].id is not None
        assert [entity].tenant_id == test_user.tenant_id
        
    def test_create_[entity]_invalid_tenant(self, db_session: Session):
        """Test validación de tenant_id"""
        import uuid
        invalid_tenant_id = uuid.uuid4()
        
        data = {
            "name": "Test [Entity]",
            "tenant_id": invalid_tenant_id
        }
        
        # Este test debe fallar si no hay validación de tenant
        with pytest.raises(Exception):
            [entity] = [Entity](**data)
            db_session.add([entity])
            db_session.commit()
```

### Integration Test
```python
# tests/integration/test_[entity]_integration.py
class Test[Entity]Integration:
    """Tests de integración cross-vertical"""
    
    def test_[entity]_event_propagation(self, test_client, test_user):
        """Test propagación de eventos entre verticales"""
        # Crear entity en vertical
        response = test_client.post(
            "/api/v1/[vertical]/[entity]",
            json={"name": "Test [Entity]"},
            headers={"Authorization": f"Bearer {test_user.token}"}
        )
        
        assert response.status_code == 201
        
        # Verificar que el evento se propagó al core
        # ... verificaciones de eventos
        
    def test_[entity]_core_service_integration(self, test_client, test_user):
        """Test integración con servicios del core"""
        # Implementar tests de integración con servicios del core
        pass
```

## REGLAS DE NAMING CONVENTIONS

### Archivos y Directorios:
- **Verticales:** `verticales/[vertical_name]/`
- **Modelos:** `[entity_name].py` (snake_case)
- **APIs:** `[entity_name]_api.py` o `[entity_name].py` en carpeta api/
- **Servicios:** `[entity_name]_service.py`
- **Tests:** `test_[entity_name].py`

### Variables y Funciones:
- **Python:** snake_case para variables y funciones
- **TypeScript:** camelCase para variables y funciones
- **Clases:** PascalCase para nombres de clases
- **Constantes:** UPPER_SNAKE_CASE

### APIs:
- **Endpoints:** `/api/v1/[vertical]/[entity]`
- **Métodos:** Seguir convenciones REST estándar
- **Parámetros:** snake_case en request/response JSON
