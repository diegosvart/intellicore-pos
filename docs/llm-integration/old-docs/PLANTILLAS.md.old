# PLANTILLAS Y TEMPLATES - IntelliCore POS

## TEMPLATES DE CÓDIGO

### Template Nuevo Vertical
```bash
# scripts/create_vertical.sh
#!/bin/bash
VERTICAL_NAME=$1

if [ -z "$VERTICAL_NAME" ]; then
    echo "Usage: $0 <vertical_name>"
    exit 1
fi

# Crear estructura de directorios
mkdir -p "verticales/${VERTICAL_NAME}"/{models,api,services,schemas,tests}

# Generar archivos base
cat > "verticales/${VERTICAL_NAME}/__init__.py" << EOF
"""
${VERTICAL_NAME^} Vertical Module
Auto-generated template for IntelliCore POS
"""
EOF

cat > "verticales/${VERTICAL_NAME}/models/__init__.py" << EOF
from .base import Base${VERTICAL_NAME^}Model

__all__ = ["Base${VERTICAL_NAME^}Model"]
EOF

cat > "verticales/${VERTICAL_NAME}/models/base.py" << EOF
from core.models.base import BaseModel
from sqlalchemy import Column, String
from sqlalchemy.dialects.postgresql import UUID

class Base${VERTICAL_NAME^}Model(BaseModel):
    """Modelo base para el vertical ${VERTICAL_NAME}"""
    __abstract__ = True
    
    # Campos comunes del vertical
    vertical_type: str = Column(String(50), default="${VERTICAL_NAME}")
    
    class Config:
        orm_mode = True
EOF

# Generar API router base
cat > "verticales/${VERTICAL_NAME}/api/__init__.py" << EOF
from fastapi import APIRouter
from .main import router as main_router

router = APIRouter()
router.include_router(main_router, prefix="/${VERTICAL_NAME}")

__all__ = ["router"]
EOF

cat > "verticales/${VERTICAL_NAME}/api/main.py" << EOF
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from core.auth.dependencies import get_current_user
from core.database.dependencies import get_db
from core.models.user import User

router = APIRouter(prefix="/api/v1/${VERTICAL_NAME}", tags=["${VERTICAL_NAME^}"])

@router.get("/health")
async def health_check():
    """Health check para ${VERTICAL_NAME} vertical"""
    return {"status": "healthy", "vertical": "${VERTICAL_NAME}"}

@router.get("/config")
async def get_vertical_config(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Obtener configuración del vertical ${VERTICAL_NAME}"""
    # TODO: Implementar lógica específica
    return {
        "vertical": "${VERTICAL_NAME}",
        "tenant_id": current_user.tenant_id,
        "features": []
    }
EOF

# Generar servicio base
cat > "verticales/${VERTICAL_NAME}/services/__init__.py" << EOF
from .main_service import ${VERTICAL_NAME^}Service

__all__ = ["${VERTICAL_NAME^}Service"]
EOF

cat > "verticales/${VERTICAL_NAME}/services/main_service.py" << EOF
from sqlalchemy.orm import Session
from core.services.base import BaseService
from typing import Dict, Any
from uuid import UUID

class ${VERTICAL_NAME^}Service(BaseService):
    """Servicio principal para ${VERTICAL_NAME} vertical"""
    
    def __init__(self, db: Session, tenant_id: UUID):
        super().__init__(db, tenant_id)
        self.vertical_name = "${VERTICAL_NAME}"
    
    def get_vertical_config(self) -> Dict[str, Any]:
        """Obtener configuración específica del vertical"""
        return {
            "vertical": self.vertical_name,
            "tenant_id": str(self.tenant_id),
            "initialized": True
        }
    
    def initialize_vertical_data(self) -> bool:
        """Inicializar datos específicos del vertical para el tenant"""
        # TODO: Implementar inicialización específica
        return True
EOF

# Generar schemas
cat > "verticales/${VERTICAL_NAME}/schemas/__init__.py" << EOF
from .main_schemas import (
    ${VERTICAL_NAME^}ConfigSchema,
    ${VERTICAL_NAME^}ConfigResponse
)

__all__ = [
    "${VERTICAL_NAME^}ConfigSchema",
    "${VERTICAL_NAME^}ConfigResponse"
]
EOF

cat > "verticales/${VERTICAL_NAME}/schemas/main_schemas.py" << EOF
from pydantic import BaseModel, Field
from typing import Optional, List, Dict, Any
from uuid import UUID

class ${VERTICAL_NAME^}ConfigSchema(BaseModel):
    """Schema para configuración del vertical ${VERTICAL_NAME}"""
    features: List[str] = Field(
        default_factory=list,
        description="Lista de características habilitadas"
    )
    settings: Optional[Dict[str, Any]] = Field(
        None,
        description="Configuraciones específicas del vertical"
    )

class ${VERTICAL_NAME^}ConfigResponse(${VERTICAL_NAME^}ConfigSchema):
    """Schema de respuesta para configuración del vertical"""
    vertical: str = Field(..., description="Nombre del vertical")
    tenant_id: UUID = Field(..., description="ID del tenant")
    
    class Config:
        schema_extra = {
            "example": {
                "vertical": "${VERTICAL_NAME}",
                "tenant_id": "123e4567-e89b-12d3-a456-426614174000",
                "features": ["feature1", "feature2"],
                "settings": {"key": "value"}
            }
        }
EOF

# Generar tests básicos
cat > "verticales/${VERTICAL_NAME}/tests/__init__.py" << EOF
"""Tests para ${VERTICAL_NAME} vertical"""
EOF

cat > "verticales/${VERTICAL_NAME}/tests/test_main.py" << EOF
import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session

class Test${VERTICAL_NAME^}API:
    """Tests básicos para API del vertical ${VERTICAL_NAME}"""
    
    def test_health_check(self, client: TestClient):
        """Test health check endpoint"""
        response = client.get("/api/v1/${VERTICAL_NAME}/health")
        assert response.status_code == 200
        assert response.json()["status"] == "healthy"
        assert response.json()["vertical"] == "${VERTICAL_NAME}"
    
    def test_get_config_requires_auth(self, client: TestClient):
        """Test que obtener config requiere autenticación"""
        response = client.get("/api/v1/${VERTICAL_NAME}/config")
        assert response.status_code == 401
    
    def test_get_config_with_auth(self, client: TestClient, auth_headers):
        """Test obtener config con autenticación"""
        response = client.get(
            "/api/v1/${VERTICAL_NAME}/config",
            headers=auth_headers
        )
        assert response.status_code == 200
        assert response.json()["vertical"] == "${VERTICAL_NAME}"
EOF

echo "✅ Vertical '${VERTICAL_NAME}' creado exitosamente!"
echo "📁 Estructura creada en: verticales/${VERTICAL_NAME}/"
echo ""
echo "📋 Próximos pasos:"
echo "1. Agregar el router en main.py"
echo "2. Crear modelos específicos del vertical"
echo "3. Implementar lógica de negocio en servicios"
echo "4. Agregar tests específicos"
echo "5. Actualizar documentación"
```

### Template Entity (Modelo + API + Servicio)
```python
# scripts/generate_entity.py
import os
import sys
from pathlib import Path

def generate_entity(vertical: str, entity: str):
    """Genera entidad completa para un vertical"""
    
    entity_class = entity.title()
    entity_lower = entity.lower()
    vertical_lower = vertical.lower()
    
    # Path base del vertical
    vertical_path = Path(f"verticales/{vertical_lower}")
    
    if not vertical_path.exists():
        print(f"❌ Vertical '{vertical}' no existe. Ejecuta primero create_vertical.sh")
        return
    
    # 1. Generar modelo
    model_content = f'''from sqlalchemy import Column, String, Integer, DateTime, Boolean, Text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.sql import func
from ..models.base import Base{vertical.title()}Model

class {entity_class}(Base{vertical.title()}Model):
    """Modelo {entity_class} para vertical {vertical}"""
    __tablename__ = "{vertical_lower}_{entity_lower}"
    
    # Campos específicos - PERSONALIZAR SEGÚN NECESIDADES
    name: str = Column(String(255), nullable=False, index=True)
    description: str = Column(Text, nullable=True)
    is_active: bool = Column(Boolean, default=True, nullable=False)
    
    # Timestamps
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())
    
    def __repr__(self):
        return f"<{entity_class}(id={{self.id}}, name={{self.name}})>"
    
    def to_dict(self):
        """Convertir a diccionario para serialización"""
        return {{
            "id": str(self.id),
            "name": self.name,
            "description": self.description,
            "is_active": self.is_active,
            "tenant_id": str(self.tenant_id),
            "created_at": self.created_at.isoformat() if self.created_at else None,
            "updated_at": self.updated_at.isoformat() if self.updated_at else None
        }}
'''
    
    model_file = vertical_path / "models" / f"{entity_lower}.py"
    with open(model_file, "w") as f:
        f.write(model_content)
    
    # 2. Generar schemas
    schema_content = f'''from pydantic import BaseModel, Field, validator
from typing import Optional
from datetime import datetime
from uuid import UUID

class {entity_class}BaseSchema(BaseModel):
    """Schema base para {entity_class}"""
    name: str = Field(
        ...,
        min_length=1,
        max_length=255,
        description="Nombre del {entity_lower}"
    )
    description: Optional[str] = Field(
        None,
        max_length=2000,
        description="Descripción opcional"
    )
    is_active: bool = Field(
        True,
        description="Indica si está activo"
    )

class {entity_class}CreateSchema({entity_class}BaseSchema):
    """Schema para crear {entity_class}"""
    
    @validator('name')
    def validate_name(cls, v):
        if not v.strip():
            raise ValueError('Name cannot be empty')
        return v.strip()
    
    class Config:
        schema_extra = {{
            "example": {{
                "name": "Ejemplo {entity_class}",
                "description": "Descripción de ejemplo",
                "is_active": True
            }}
        }}

class {entity_class}UpdateSchema(BaseModel):
    """Schema para actualizar {entity_class}"""
    name: Optional[str] = Field(None, min_length=1, max_length=255)
    description: Optional[str] = Field(None, max_length=2000)
    is_active: Optional[bool] = None

class {entity_class}ResponseSchema({entity_class}BaseSchema):
    """Schema de respuesta para {entity_class}"""
    id: UUID = Field(..., description="ID único")
    tenant_id: UUID = Field(..., description="ID del tenant")
    created_at: datetime = Field(..., description="Fecha de creación")
    updated_at: Optional[datetime] = Field(None, description="Fecha de actualización")
    
    class Config:
        orm_mode = True
        schema_extra = {{
            "example": {{
                "id": "123e4567-e89b-12d3-a456-426614174000",
                "name": "Ejemplo {entity_class}",
                "description": "Descripción de ejemplo",
                "is_active": True,
                "tenant_id": "123e4567-e89b-12d3-a456-426614174001",
                "created_at": "2024-01-15T10:30:00Z",
                "updated_at": "2024-01-15T10:30:00Z"
            }}
        }}
'''
    
    schema_file = vertical_path / "schemas" / f"{entity_lower}_schemas.py"
    with open(schema_file, "w") as f:
        f.write(schema_content)
    
    # 3. Generar servicio
    service_content = f'''from sqlalchemy.orm import Session
from sqlalchemy import and_
from typing import List, Optional
from uuid import UUID
from core.services.base import BaseService
from ..models.{entity_lower} import {entity_class}
from ..schemas.{entity_lower}_schemas import {entity_class}CreateSchema, {entity_class}UpdateSchema

class {entity_class}Service(BaseService):
    """Servicio para gestión de {entity_class}"""
    
    def __init__(self, db: Session, tenant_id: UUID):
        super().__init__(db, tenant_id)
        self.model = {entity_class}
    
    def create(self, data: {entity_class}CreateSchema) -> {entity_class}:
        """Crear nuevo {entity_lower}"""
        db_entity = {entity_class}(
            **data.dict(),
            tenant_id=self.tenant_id
        )
        
        # Aplicar reglas de negocio específicas
        self._apply_business_rules(db_entity, "create")
        
        self.db.add(db_entity)
        self.db.commit()
        self.db.refresh(db_entity)
        
        return db_entity
    
    def get_all(self, skip: int = 0, limit: int = 100, active_only: bool = True) -> List[{entity_class}]:
        """Obtener todos los {entity_lower}s del tenant"""
        query = self.db.query({entity_class}).filter({entity_class}.tenant_id == self.tenant_id)
        
        if active_only:
            query = query.filter({entity_class}.is_active == True)
        
        return query.offset(skip).limit(limit).all()
    
    def get_by_id(self, entity_id: UUID) -> Optional[{entity_class}]:
        """Obtener {entity_lower} por ID"""
        return self.db.query({entity_class}).filter(
            and_(
                {entity_class}.id == entity_id,
                {entity_class}.tenant_id == self.tenant_id
            )
        ).first()
    
    def update(self, entity_id: UUID, data: {entity_class}UpdateSchema) -> Optional[{entity_class}]:
        """Actualizar {entity_lower}"""
        db_entity = self.get_by_id(entity_id)
        if not db_entity:
            return None
        
        # Actualizar solo campos proporcionados
        update_data = data.dict(exclude_unset=True)
        for field, value in update_data.items():
            setattr(db_entity, field, value)
        
        # Aplicar reglas de negocio
        self._apply_business_rules(db_entity, "update")
        
        self.db.commit()
        self.db.refresh(db_entity)
        
        return db_entity
    
    def delete(self, entity_id: UUID) -> bool:
        """Eliminar {entity_lower} (soft delete)"""
        db_entity = self.get_by_id(entity_id)
        if not db_entity:
            return False
        
        # Soft delete
        db_entity.is_active = False
        self.db.commit()
        
        return True
    
    def _apply_business_rules(self, entity: {entity_class}, operation: str):
        """Aplicar reglas de negocio específicas del {entity_lower}"""
        # TODO: Implementar reglas específicas del vertical
        
        if operation == "create":
            # Reglas para creación
            pass
        elif operation == "update":
            # Reglas para actualización
            pass
'''
    
    service_file = vertical_path / "services" / f"{entity_lower}_service.py"
    with open(service_file, "w") as f:
        f.write(service_content)
    
    # 4. Generar API endpoints
    api_content = f'''from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
from typing import List, Optional
from uuid import UUID
from core.auth.dependencies import get_current_user
from core.database.dependencies import get_db
from core.models.user import User
from ..services.{entity_lower}_service import {entity_class}Service
from ..schemas.{entity_lower}_schemas import (
    {entity_class}CreateSchema,
    {entity_class}UpdateSchema,
    {entity_class}ResponseSchema
)

router = APIRouter()

def get_{entity_lower}_service(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
) -> {entity_class}Service:
    """Dependency para obtener servicio de {entity_lower}"""
    return {entity_class}Service(db, current_user.tenant_id)

@router.post(
    "/{entity_lower}s",
    response_model={entity_class}ResponseSchema,
    status_code=status.HTTP_201_CREATED,
    summary="Crear {entity_lower}",
    description="Crear un nuevo {entity_lower} en el sistema"
)
async def create_{entity_lower}(
    data: {entity_class}CreateSchema,
    service: {entity_class}Service = Depends(get_{entity_lower}_service)
):
    """Crear nuevo {entity_lower}"""
    try:
        return service.create(data)
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=str(e)
        )

@router.get(
    "/{entity_lower}s",
    response_model=List[{entity_class}ResponseSchema],
    summary="Listar {entity_lower}s",
    description="Obtener lista de {entity_lower}s con filtros opcionales"
)
async def list_{entity_lower}s(
    skip: int = Query(0, ge=0, description="Número de registros a omitir"),
    limit: int = Query(100, ge=1, le=1000, description="Número máximo de registros"),
    active_only: bool = Query(True, description="Solo {entity_lower}s activos"),
    service: {entity_class}Service = Depends(get_{entity_lower}_service)
):
    """Listar {entity_lower}s"""
    return service.get_all(skip=skip, limit=limit, active_only=active_only)

@router.get(
    "/{entity_lower}s/{{entity_id}}",
    response_model={entity_class}ResponseSchema,
    summary="Obtener {entity_lower}",
    description="Obtener {entity_lower} específico por ID"
)
async def get_{entity_lower}(
    entity_id: UUID,
    service: {entity_class}Service = Depends(get_{entity_lower}_service)
):
    """Obtener {entity_lower} por ID"""
    entity = service.get_by_id(entity_id)
    if not entity:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"{entity_class} not found"
        )
    return entity

@router.put(
    "/{entity_lower}s/{{entity_id}}",
    response_model={entity_class}ResponseSchema,
    summary="Actualizar {entity_lower}",
    description="Actualizar {entity_lower} existente"
)
async def update_{entity_lower}(
    entity_id: UUID,
    data: {entity_class}UpdateSchema,
    service: {entity_class}Service = Depends(get_{entity_lower}_service)
):
    """Actualizar {entity_lower}"""
    entity = service.update(entity_id, data)
    if not entity:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"{entity_class} not found"
        )
    return entity

@router.delete(
    "/{entity_lower}s/{{entity_id}}",
    status_code=status.HTTP_204_NO_CONTENT,
    summary="Eliminar {entity_lower}",
    description="Eliminar {entity_lower} (soft delete)"
)
async def delete_{entity_lower}(
    entity_id: UUID,
    service: {entity_class}Service = Depends(get_{entity_lower}_service)
):
    """Eliminar {entity_lower}"""
    if not service.delete(entity_id):
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"{entity_class} not found"
        )
'''
    
    api_file = vertical_path / "api" / f"{entity_lower}_api.py"
    with open(api_file, "w") as f:
        f.write(api_content)
    
    # 5. Generar tests
    test_content = f'''import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session
from uuid import UUID, uuid4
from verticales.{vertical_lower}.models.{entity_lower} import {entity_class}
from verticales.{vertical_lower}.services.{entity_lower}_service import {entity_class}Service
from verticales.{vertical_lower}.schemas.{entity_lower}_schemas import {entity_class}CreateSchema

class Test{entity_class}Service:
    """Tests unitarios para {entity_class}Service"""
    
    @pytest.fixture
    def {entity_lower}_service(self, db_session: Session):
        """Servicio de {entity_lower} para tests"""
        return {entity_class}Service(db_session, uuid4())
    
    def test_create_{entity_lower}(self, {entity_lower}_service):
        """Test crear {entity_lower}"""
        data = {entity_class}CreateSchema(
            name="Test {entity_class}",
            description="Test description"
        )
        
        result = {entity_lower}_service.create(data)
        
        assert result.name == "Test {entity_class}"
        assert result.description == "Test description"
        assert result.is_active is True
        assert result.tenant_id == {entity_lower}_service.tenant_id
    
    def test_get_all_{entity_lower}s(self, {entity_lower}_service):
        """Test obtener todos los {entity_lower}s"""
        # Crear algunos {entity_lower}s de prueba
        for i in range(3):
            data = {entity_class}CreateSchema(name=f"Test {entity_class} {{i}}")
            {entity_lower}_service.create(data)
        
        result = {entity_lower}_service.get_all()
        
        assert len(result) == 3
        assert all(item.tenant_id == {entity_lower}_service.tenant_id for item in result)
    
    def test_get_{entity_lower}_by_id(self, {entity_lower}_service):
        """Test obtener {entity_lower} por ID"""
        # Crear {entity_lower}
        data = {entity_class}CreateSchema(name="Test {entity_class}")
        created = {entity_lower}_service.create(data)
        
        # Obtener por ID
        result = {entity_lower}_service.get_by_id(created.id)
        
        assert result is not None
        assert result.id == created.id
        assert result.name == "Test {entity_class}"

class Test{entity_class}API:
    """Tests de integración para API de {entity_class}"""
    
    def test_create_{entity_lower}_api(self, client: TestClient, auth_headers):
        """Test crear {entity_lower} vía API"""
        data = {{
            "name": "Test {entity_class} API",
            "description": "Test description",
            "is_active": True
        }}
        
        response = client.post(
            "/api/v1/{vertical_lower}/{entity_lower}s",
            json=data,
            headers=auth_headers
        )
        
        assert response.status_code == 201
        result = response.json()
        assert result["name"] == "Test {entity_class} API"
        assert result["is_active"] is True
    
    def test_list_{entity_lower}s_api(self, client: TestClient, auth_headers):
        """Test listar {entity_lower}s vía API"""
        response = client.get(
            "/api/v1/{vertical_lower}/{entity_lower}s",
            headers=auth_headers
        )
        
        assert response.status_code == 200
        assert isinstance(response.json(), list)
    
    def test_get_{entity_lower}_not_found(self, client: TestClient, auth_headers):
        """Test obtener {entity_lower} inexistente"""
        fake_id = str(uuid4())
        response = client.get(
            f"/api/v1/{vertical_lower}/{entity_lower}s/{{fake_id}}",
            headers=auth_headers
        )
        
        assert response.status_code == 404
'''
    
    test_file = vertical_path / "tests" / f"test_{entity_lower}.py"
    with open(test_file, "w") as f:
        f.write(test_content)
    
    print(f"✅ Entidad '{entity_class}' generada exitosamente para vertical '{vertical}'!")
    print(f"📁 Archivos creados:")
    print(f"   - {model_file}")
    print(f"   - {schema_file}")
    print(f"   - {service_file}")
    print(f"   - {api_file}")
    print(f"   - {test_file}")
    print("")
    print("📋 Próximos pasos:")
    print("1. Revisar y personalizar los campos del modelo")
    print("2. Implementar reglas de negocio específicas")
    print("3. Agregar el router a main.py del vertical")
    print("4. Ejecutar y validar los tests")
    print("5. Crear migración de base de datos")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python generate_entity.py <vertical> <entity>")
        sys.exit(1)
    
    vertical = sys.argv[1]
    entity = sys.argv[2]
    generate_entity(vertical, entity)
```

### Template Frontend Component
```typescript
// scripts/templates/angular-component.template.ts
import { Component, OnInit, inject, Input, Output, EventEmitter } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { {{ENTITY_CLASS}}Service } from '../services/{{ENTITY_LOWER}}.service';
import { {{ENTITY_CLASS}} } from '../models/{{ENTITY_LOWER}}.model';

@Component({
  selector: 'app-{{ENTITY_KEBAB}}',
  templateUrl: './{{ENTITY_KEBAB}}.component.html',
  styleUrls: ['./{{ENTITY_KEBAB}}.component.scss']
})
export class {{ENTITY_CLASS}}Component implements OnInit {
  private fb = inject(FormBuilder);
  private {{ENTITY_LOWER}}Service = inject({{ENTITY_CLASS}}Service);
  
  @Input() {{ENTITY_LOWER}}Id?: string;
  @Input() readonly = false;
  @Output() saved = new EventEmitter<{{ENTITY_CLASS}}>();
  @Output() cancelled = new EventEmitter<void>();
  
  {{ENTITY_LOWER}}Form: FormGroup;
  loading = false;
  saving = false;
  
  ngOnInit(): void {
    this.initialize{{ENTITY_CLASS}}Form();
    
    if (this.{{ENTITY_LOWER}}Id) {
      this.load{{ENTITY_CLASS}}();
    }
  }
  
  private initialize{{ENTITY_CLASS}}Form(): void {
    this.{{ENTITY_LOWER}}Form = this.fb.group({
      name: ['', [Validators.required, Validators.maxLength(255)]],
      description: ['', [Validators.maxLength(2000)]],
      is_active: [true]
    });
    
    if (this.readonly) {
      this.{{ENTITY_LOWER}}Form.disable();
    }
  }
  
  private async load{{ENTITY_CLASS}}(): Promise<void> {
    if (!this.{{ENTITY_LOWER}}Id) return;
    
    this.loading = true;
    try {
      const {{ENTITY_LOWER}} = await this.{{ENTITY_LOWER}}Service.getById(this.{{ENTITY_LOWER}}Id);
      if ({{ENTITY_LOWER}}) {
        this.{{ENTITY_LOWER}}Form.patchValue({{ENTITY_LOWER}});
      }
    } catch (error) {
      console.error('Error loading {{ENTITY_LOWER}}:', error);
    } finally {
      this.loading = false;
    }
  }
  
  async onSave(): Promise<void> {
    if (this.{{ENTITY_LOWER}}Form.invalid || this.saving) return;
    
    this.saving = true;
    try {
      const formValue = this.{{ENTITY_LOWER}}Form.value;
      
      let result: {{ENTITY_CLASS}};
      if (this.{{ENTITY_LOWER}}Id) {
        result = await this.{{ENTITY_LOWER}}Service.update(this.{{ENTITY_LOWER}}Id, formValue);
      } else {
        result = await this.{{ENTITY_LOWER}}Service.create(formValue);
      }
      
      this.saved.emit(result);
    } catch (error) {
      console.error('Error saving {{ENTITY_LOWER}}:', error);
    } finally {
      this.saving = false;
    }
  }
  
  onCancel(): void {
    this.cancelled.emit();
  }
  
  getFieldError(fieldName: string): string | null {
    const field = this.{{ENTITY_LOWER}}Form.get(fieldName);
    if (field?.errors && field.touched) {
      if (field.errors['required']) return `${fieldName} is required`;
      if (field.errors['maxlength']) return `${fieldName} is too long`;
    }
    return null;
  }
}
```

### Template Migration
```python
# scripts/templates/migration.template.py
"""Create {{ENTITY_LOWER}} table for {{VERTICAL}} vertical

Revision ID: {{REVISION_ID}}
Revises: {{PREV_REVISION}}
Create Date: {{CREATE_DATE}}

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers
revision = '{{REVISION_ID}}'
down_revision = '{{PREV_REVISION}}'
branch_labels = None
depends_on = None

def upgrade() -> None:
    """Create {{ENTITY_LOWER}} table"""
    op.create_table(
        '{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}',
        sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('tenant_id', postgresql.UUID(as_uuid=True), nullable=False),
        sa.Column('name', sa.String(length=255), nullable=False),
        sa.Column('description', sa.Text(), nullable=True),
        sa.Column('is_active', sa.Boolean(), nullable=False, default=True),
        sa.Column('vertical_type', sa.String(length=50), nullable=True, default='{{VERTICAL_LOWER}}'),
        sa.Column('created_at', sa.DateTime(timezone=True), server_default=sa.text('now()'), nullable=True),
        sa.Column('updated_at', sa.DateTime(timezone=True), nullable=True),
        sa.PrimaryKeyConstraint('id')
    )
    
    # Índices para performance
    op.create_index(
        'ix_{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}_tenant_id',
        '{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}',
        ['tenant_id']
    )
    op.create_index(
        'ix_{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}_name',
        '{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}',
        ['name']
    )
    op.create_index(
        'ix_{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}_active',
        '{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}',
        ['is_active']
    )
    
    # Índice compuesto para queries frecuentes
    op.create_index(
        'ix_{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}_tenant_active',
        '{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}',
        ['tenant_id', 'is_active']
    )

def downgrade() -> None:
    """Drop {{ENTITY_LOWER}} table"""
    op.drop_index('ix_{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}_tenant_active')
    op.drop_index('ix_{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}_active')
    op.drop_index('ix_{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}_name')
    op.drop_index('ix_{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}_tenant_id')
    op.drop_table('{{VERTICAL_LOWER}}_{{ENTITY_LOWER}}')
```

## PLANTILLAS DE CONFIGURACIÓN

### Docker Compose Template para Vertical
```yaml
# scripts/templates/docker-compose.vertical.template.yml
version: '3.8'

services:
  {{VERTICAL_LOWER}}-api:
    build:
      context: .
      dockerfile: verticales/{{VERTICAL_LOWER}}/Dockerfile
    environment:
      - DATABASE_URL=postgresql://postgres:${DB_PASSWORD}@postgres:5432/intellicore_pos
      - REDIS_URL=redis://redis:6379/0
      - VERTICAL={{VERTICAL_LOWER}}
    depends_on:
      - postgres
      - redis
    ports:
      - "800{{PORT_OFFSET}}:8000"
    volumes:
      - ./verticales/{{VERTICAL_LOWER}}:/app/verticales/{{VERTICAL_LOWER}}
      - ./core:/app/core
    networks:
      - intellicore-network

  {{VERTICAL_LOWER}}-frontend:
    build:
      context: ./micro-frontends/{{VERTICAL_LOWER}}-frontend
      dockerfile: Dockerfile.dev
    ports:
      - "420{{PORT_OFFSET}}:4200"
    volumes:
      - ./micro-frontends/{{VERTICAL_LOWER}}-frontend/src:/app/src
    environment:
      - NG_APP_API_URL=http://localhost:800{{PORT_OFFSET}}
    networks:
      - intellicore-network

networks:
  intellicore-network:
    external: true
```

### Kubernetes Deployment Template
```yaml
# scripts/templates/k8s-deployment.template.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{VERTICAL_LOWER}}-api
  namespace: intellicore-pos
  labels:
    app: {{VERTICAL_LOWER}}-api
    vertical: {{VERTICAL_LOWER}}
    component: backend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: {{VERTICAL_LOWER}}-api
  template:
    metadata:
      labels:
        app: {{VERTICAL_LOWER}}-api
        vertical: {{VERTICAL_LOWER}}
        component: backend
    spec:
      containers:
      - name: {{VERTICAL_LOWER}}-api
        image: intellicore/{{VERTICAL_LOWER}}-api:{{VERSION}}
        ports:
        - containerPort: 8000
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: postgres-secret
              key: database-url
        - name: REDIS_URL
          valueFrom:
            configMapKeyRef:
              name: redis-config
              key: redis-url
        - name: VERTICAL
          value: "{{VERTICAL_LOWER}}"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /api/v1/{{VERTICAL_LOWER}}/health
            port: 8000
          initialDelaySeconds: 30
          periodSeconds: 30
        readinessProbe:
          httpGet:
            path: /api/v1/{{VERTICAL_LOWER}}/health
            port: 8000
          initialDelaySeconds: 5
          periodSeconds: 5

---
apiVersion: v1
kind: Service
metadata:
  name: {{VERTICAL_LOWER}}-api-service
  namespace: intellicore-pos
spec:
  selector:
    app: {{VERTICAL_LOWER}}-api
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8000
  type: ClusterIP
```
