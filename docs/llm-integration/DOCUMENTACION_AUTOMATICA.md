# DOCUMENTACIÓN AUTOMÁTICA - IntelliCore POS

## GENERACIÓN AUTOMÁTICA DE DOCUMENTACIÓN

### OpenAPI/Swagger Auto-Generation
```python
# main.py - Configuración FastAPI con documentación automática
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from verticales.restaurant.api import restaurant_router
from verticales.hotel.api import hotel_router

app = FastAPI(
    title="IntelliCore POS API",
    description="API empresarial multi-vertical para sistema POS",
    version="1.0.0",
    docs_url="/docs",  # Swagger UI
    redoc_url="/redoc",  # ReDoc
    openapi_url="/openapi.json"
)

# Tags para organización automática de documentación
tags_metadata = [
    {
        "name": "Authentication",
        "description": "Operaciones de autenticación y autorización",
        "externalDocs": {
            "description": "Documentación externa de autenticación",
            "url": "https://docs.intellicore.com/auth",
        },
    },
    {
        "name": "Restaurant",
        "description": "APIs específicas del vertical Restaurant",
    },
    {
        "name": "Hotel", 
        "description": "APIs específicas del vertical Hotel",
    },
]

app = FastAPI(
    title="IntelliCore POS API",
    openapi_tags=tags_metadata
)

# Inclusión automática de routers con documentación
app.include_router(restaurant_router, prefix="/api/v1/restaurant", tags=["Restaurant"])
app.include_router(hotel_router, prefix="/api/v1/hotel", tags=["Hotel"])
```

### Schemas con Documentación Automática
```python
# schemas/restaurant_schemas.py
from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from uuid import UUID

class OrderItemSchema(BaseModel):
    """Schema para items de una orden"""
    menu_item_id: UUID = Field(
        ...,
        description="ID único del item del menú",
        example="123e4567-e89b-12d3-a456-426614174000"
    )
    quantity: int = Field(
        ...,
        ge=1,
        le=99,
        description="Cantidad del item (1-99)",
        example=2
    )
    special_instructions: Optional[str] = Field(
        None,
        max_length=500,
        description="Instrucciones especiales para preparación",
        example="Sin cebolla, extra queso"
    )
    
    class Config:
        schema_extra = {
            "example": {
                "menu_item_id": "123e4567-e89b-12d3-a456-426614174000",
                "quantity": 2,
                "special_instructions": "Sin cebolla, extra queso"
            }
        }

class OrderCreateSchema(BaseModel):
    """Schema para crear una nueva orden"""
    table_number: int = Field(
        ...,
        ge=1,
        le=999,
        description="Número de mesa (1-999)",
        example=15
    )
    customer_id: Optional[UUID] = Field(
        None,
        description="ID del cliente si está registrado",
        example="123e4567-e89b-12d3-a456-426614174001"
    )
    items: List[OrderItemSchema] = Field(
        default_factory=list,
        description="Lista de items de la orden"
    )
    notes: Optional[str] = Field(
        None,
        max_length=1000,
        description="Notas adicionales de la orden",
        example="Cliente prefiere mesa cerca de la ventana"
    )

class OrderResponseSchema(OrderCreateSchema):
    """Schema de respuesta para órdenes"""
    id: UUID = Field(..., description="ID único de la orden")
    order_number: str = Field(..., description="Número de orden visible al cliente")
    status: str = Field(..., description="Estado actual de la orden")
    total_amount: Optional[float] = Field(None, description="Monto total de la orden")
    created_at: datetime = Field(..., description="Fecha y hora de creación")
    updated_at: datetime = Field(..., description="Fecha y hora de última actualización")
    
    class Config:
        orm_mode = True
        schema_extra = {
            "example": {
                "id": "123e4567-e89b-12d3-a456-426614174002",
                "order_number": "ORD-2024-001",
                "table_number": 15,
                "status": "pending",
                "total_amount": 45.50,
                "created_at": "2024-01-15T10:30:00Z",
                "updated_at": "2024-01-15T10:30:00Z"
            }
        }
```

### Endpoints con Documentación Rica
```python
# verticales/restaurant/api/orders.py
from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session
from typing import List, Optional

router = APIRouter()

@router.post(
    "/orders",
    response_model=OrderResponseSchema,
    status_code=status.HTTP_201_CREATED,
    summary="Crear nueva orden",
    description="""
    Crea una nueva orden en el sistema del restaurante.
    
    **Funcionalidades:**
    - Asignación automática de número de orden
    - Validación de disponibilidad de mesa
    - Cálculo automático de totales
    - Notificación automática a cocina
    
    **Reglas de negocio:**
    - Una mesa solo puede tener una orden activa
    - Todos los items deben existir en el menú
    - El usuario debe tener permisos para crear órdenes
    """,
    responses={
        201: {
            "description": "Orden creada exitosamente",
            "content": {
                "application/json": {
                    "example": {
                        "id": "123e4567-e89b-12d3-a456-426614174002",
                        "order_number": "ORD-2024-001",
                        "table_number": 15,
                        "status": "pending"
                    }
                }
            }
        },
        400: {
            "description": "Datos inválidos",
            "content": {
                "application/json": {
                    "example": {
                        "detail": "Table 15 already has an active order"
                    }
                }
            }
        },
        403: {
            "description": "Sin permisos suficientes"
        },
        422: {
            "description": "Error de validación de datos"
        }
    },
    tags=["Orders"]
)
async def create_order(
    order_data: OrderCreateSchema,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Crear una nueva orden con validación completa"""
    # Implementación...
    pass

@router.get(
    "/orders",
    response_model=List[OrderResponseSchema],
    summary="Listar órdenes",
    description="""
    Obtiene la lista de órdenes con filtros opcionales.
    
    **Filtros disponibles:**
    - Por estado de orden
    - Por rango de fechas
    - Por número de mesa
    - Por mesero asignado
    
    **Paginación:**
    - Resultados limitados a 100 por página por defecto
    - Use offset y limit para paginación
    """,
    tags=["Orders"]
)
async def list_orders(
    status: Optional[str] = Query(
        None, 
        description="Filtrar por estado",
        enum=["pending", "confirmed", "preparing", "ready", "delivered", "paid", "cancelled"]
    ),
    table_number: Optional[int] = Query(
        None,
        ge=1,
        le=999,
        description="Filtrar por número de mesa"
    ),
    date_from: Optional[datetime] = Query(
        None,
        description="Fecha de inicio (ISO format)"
    ),
    date_to: Optional[datetime] = Query(
        None,
        description="Fecha de fin (ISO format)"
    ),
    offset: int = Query(
        0,
        ge=0,
        description="Número de registros a omitir"
    ),
    limit: int = Query(
        100,
        ge=1,
        le=1000,
        description="Número máximo de registros a retornar"
    ),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Listar órdenes con filtros y paginación"""
    # Implementación...
    pass
```

## DOCUMENTACIÓN DE ARQUITECTURA AUTO-GENERADA

### PlantUML Integration
```python
# scripts/generate_architecture_docs.py
import os
import ast
from pathlib import Path

def generate_class_diagram():
    """Genera diagrama de clases automáticamente desde el código"""
    plantuml_content = "@startuml\n"
    plantuml_content += "!theme aws-orange\n"
    plantuml_content += "title IntelliCore POS - Architecture Overview\n\n"
    
    # Escanear todos los modelos
    models_path = Path("src/verticales")
    for vertical_path in models_path.iterdir():
        if vertical_path.is_dir():
            models_dir = vertical_path / "models"
            if models_dir.exists():
                plantuml_content += f"package {vertical_path.name} {{\n"
                
                for model_file in models_dir.glob("*.py"):
                    if model_file.name != "__init__.py":
                        classes = extract_classes_from_file(model_file)
                        for class_info in classes:
                            plantuml_content += f"  class {class_info['name']} {{\n"
                            for field in class_info['fields']:
                                plantuml_content += f"    {field}\n"
                            plantuml_content += "  }\n"
                
                plantuml_content += "}\n\n"
    
    plantuml_content += "@enduml"
    
    # Guardar diagrama
    with open("docs/architecture/class_diagram.puml", "w") as f:
        f.write(plantuml_content)

def extract_classes_from_file(file_path):
    """Extrae información de clases desde archivo Python"""
    with open(file_path, "r") as f:
        tree = ast.parse(f.read())
    
    classes = []
    for node in ast.walk(tree):
        if isinstance(node, ast.ClassDef):
            fields = []
            for item in node.body:
                if isinstance(item, ast.AnnAssign) and hasattr(item.target, 'id'):
                    field_name = item.target.id
                    field_type = ast.unparse(item.annotation) if item.annotation else "Any"
                    fields.append(f"{field_name}: {field_type}")
            
            classes.append({
                "name": node.name,
                "fields": fields
            })
    
    return classes

if __name__ == "__main__":
    generate_class_diagram()
```

### Database Schema Documentation
```python
# scripts/generate_db_docs.py
from sqlalchemy import create_engine, MetaData, inspect
from sqlalchemy.schema import CreateTable
import json

def generate_database_documentation():
    """Genera documentación automática de la base de datos"""
    engine = create_engine("postgresql://user:pass@localhost/intellicore_pos")
    inspector = inspect(engine)
    
    documentation = {
        "database": "intellicore_pos",
        "generated_at": datetime.now().isoformat(),
        "tables": {}
    }
    
    for table_name in inspector.get_table_names():
        columns = inspector.get_columns(table_name)
        foreign_keys = inspector.get_foreign_keys(table_name)
        indexes = inspector.get_indexes(table_name)
        
        documentation["tables"][table_name] = {
            "description": f"Tabla {table_name}",
            "columns": [
                {
                    "name": col["name"],
                    "type": str(col["type"]),
                    "nullable": col["nullable"],
                    "default": col.get("default"),
                    "primary_key": col.get("primary_key", False)
                }
                for col in columns
            ],
            "foreign_keys": [
                {
                    "column": fk["constrained_columns"],
                    "references": f"{fk['referred_table']}.{fk['referred_columns']}"
                }
                for fk in foreign_keys
            ],
            "indexes": [
                {
                    "name": idx["name"],
                    "columns": idx["column_names"],
                    "unique": idx["unique"]
                }
                for idx in indexes
            ]
        }
    
    # Generar Markdown
    markdown_content = "# Database Schema Documentation\n\n"
    markdown_content += f"Generated at: {documentation['generated_at']}\n\n"
    
    for table_name, table_info in documentation["tables"].items():
        markdown_content += f"## Table: {table_name}\n\n"
        markdown_content += f"{table_info['description']}\n\n"
        
        # Columns table
        markdown_content += "### Columns\n\n"
        markdown_content += "| Column | Type | Nullable | Default | Primary Key |\n"
        markdown_content += "|--------|------|----------|---------|-------------|\n"
        
        for col in table_info["columns"]:
            markdown_content += f"| {col['name']} | {col['type']} | {col['nullable']} | {col['default']} | {col['primary_key']} |\n"
        
        # Foreign Keys
        if table_info["foreign_keys"]:
            markdown_content += "\n### Foreign Keys\n\n"
            for fk in table_info["foreign_keys"]:
                markdown_content += f"- {fk['column']} → {fk['references']}\n"
        
        # Indexes
        if table_info["indexes"]:
            markdown_content += "\n### Indexes\n\n"
            for idx in table_info["indexes"]:
                unique_text = " (UNIQUE)" if idx["unique"] else ""
                markdown_content += f"- {idx['name']}: {', '.join(idx['columns'])}{unique_text}\n"
        
        markdown_content += "\n---\n\n"
    
    # Guardar documentación
    with open("docs/database/schema.md", "w") as f:
        f.write(markdown_content)
    
    with open("docs/database/schema.json", "w") as f:
        json.dump(documentation, f, indent=2)

if __name__ == "__main__":
    generate_database_documentation()
```

## DOCUMENTACIÓN DE ENDPOINTS AUTO-GENERADA

### Postman Collection Auto-Generation
```python
# scripts/generate_postman_collection.py
import json
from fastapi.openapi.utils import get_openapi
from main import app

def generate_postman_collection():
    """Genera colección de Postman desde OpenAPI spec"""
    openapi_schema = get_openapi(
        title=app.title,
        version=app.version,
        description=app.description,
        routes=app.routes,
    )
    
    collection = {
        "info": {
            "name": "IntelliCore POS API",
            "description": "Colección auto-generada desde OpenAPI",
            "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
        },
        "item": [],
        "variable": [
            {
                "key": "baseUrl",
                "value": "{{baseUrl}}",
                "type": "string"
            },
            {
                "key": "authToken",
                "value": "{{authToken}}",
                "type": "string"
            }
        ]
    }
    
    # Procesar cada endpoint
    for path, methods in openapi_schema["paths"].items():
        folder_name = path.split("/")[3] if len(path.split("/")) > 3 else "General"
        
        # Buscar o crear folder
        folder = next((item for item in collection["item"] if item["name"] == folder_name), None)
        if not folder:
            folder = {
                "name": folder_name,
                "item": []
            }
            collection["item"].append(folder)
        
        for method, details in methods.items():
            request_item = {
                "name": details.get("summary", f"{method.upper()} {path}"),
                "request": {
                    "method": method.upper(),
                    "header": [
                        {
                            "key": "Authorization",
                            "value": "Bearer {{authToken}}",
                            "type": "text"
                        },
                        {
                            "key": "Content-Type",
                            "value": "application/json",
                            "type": "text"
                        }
                    ],
                    "url": {
                        "raw": "{{baseUrl}}" + path,
                        "host": ["{{baseUrl}}"],
                        "path": path.split("/")[1:]
                    }
                }
            }
            
            # Agregar body si es POST/PUT/PATCH
            if method.lower() in ["post", "put", "patch"]:
                if "requestBody" in details:
                    schema = details["requestBody"]["content"]["application/json"]["schema"]
                    example = schema.get("example", {})
                    request_item["request"]["body"] = {
                        "mode": "raw",
                        "raw": json.dumps(example, indent=2)
                    }
            
            # Agregar query parameters
            if "parameters" in details:
                query_params = [p for p in details["parameters"] if p["in"] == "query"]
                if query_params:
                    request_item["request"]["url"]["query"] = [
                        {
                            "key": param["name"],
                            "value": "",
                            "description": param.get("description", "")
                        }
                        for param in query_params
                    ]
            
            folder["item"].append(request_item)
    
    # Guardar colección
    with open("docs/api/postman_collection.json", "w") as f:
        json.dump(collection, f, indent=2)

if __name__ == "__main__":
    generate_postman_collection()
```

## DOCUMENTACIÓN DE TESTS AUTO-GENERADA

### Test Coverage Reports
```python
# scripts/generate_test_docs.py
import subprocess
import json
from pathlib import Path

def generate_test_coverage_report():
    """Genera reporte de coverage automático"""
    # Ejecutar tests con coverage
    result = subprocess.run([
        "pytest", 
        "--cov=src", 
        "--cov-report=json", 
        "--cov-report=html",
        "--cov-report=term"
    ], capture_output=True, text=True)
    
    # Leer datos de coverage
    with open("coverage.json", "r") as f:
        coverage_data = json.load(f)
    
    # Generar reporte markdown
    markdown_content = "# Test Coverage Report\n\n"
    markdown_content += f"**Total Coverage:** {coverage_data['totals']['percent_covered']:.1f}%\n\n"
    
    markdown_content += "## Coverage by Module\n\n"
    markdown_content += "| Module | Statements | Missing | Coverage |\n"
    markdown_content += "|--------|------------|---------|----------|\n"
    
    for file_path, file_data in coverage_data["files"].items():
        if "test" not in file_path:  # Excluir archivos de test
            statements = file_data["summary"]["num_statements"]
            missing = file_data["summary"]["missing_lines"]
            coverage = file_data["summary"]["percent_covered"]
            
            markdown_content += f"| {file_path} | {statements} | {len(missing)} | {coverage:.1f}% |\n"
    
    # Archivos con baja cobertura
    low_coverage_files = [
        (path, data["summary"]["percent_covered"])
        for path, data in coverage_data["files"].items()
        if data["summary"]["percent_covered"] < 80 and "test" not in path
    ]
    
    if low_coverage_files:
        markdown_content += "\n## ⚠️ Files with Low Coverage (<80%)\n\n"
        for file_path, coverage in sorted(low_coverage_files, key=lambda x: x[1]):
            markdown_content += f"- {file_path}: {coverage:.1f}%\n"
    
    # Guardar reporte
    with open("docs/testing/coverage_report.md", "w") as f:
        f.write(markdown_content)

def generate_test_matrix():
    """Genera matriz de tests por vertical"""
    test_dirs = Path("tests").glob("**/test_*.py")
    
    matrix = {
        "unit_tests": {},
        "integration_tests": {},
        "e2e_tests": {}
    }
    
    for test_file in test_dirs:
        # Determinar tipo de test por ubicación
        if "unit" in str(test_file):
            test_type = "unit_tests"
        elif "integration" in str(test_file):
            test_type = "integration_tests"
        elif "e2e" in str(test_file):
            test_type = "e2e_tests"
        else:
            test_type = "unit_tests"  # Default
        
        # Determinar vertical
        vertical = "core"
        if "restaurant" in str(test_file):
            vertical = "restaurant"
        elif "hotel" in str(test_file):
            vertical = "hotel"
        # ... otros verticales
        
        if vertical not in matrix[test_type]:
            matrix[test_type][vertical] = []
        
        matrix[test_type][vertical].append(str(test_file))
    
    # Generar markdown
    markdown_content = "# Test Matrix\n\n"
    
    for test_type, verticals in matrix.items():
        markdown_content += f"## {test_type.replace('_', ' ').title()}\n\n"
        
        for vertical, tests in verticals.items():
            markdown_content += f"### {vertical.title()}\n\n"
            for test in tests:
                markdown_content += f"- {test}\n"
            markdown_content += "\n"
    
    with open("docs/testing/test_matrix.md", "w") as f:
        f.write(markdown_content)

if __name__ == "__main__":
    generate_test_coverage_report()
    generate_test_matrix()
```

## AUTOMATIZACIÓN CON HOOKS

### Pre-commit Documentation Update
```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: update-api-docs
        name: Update API Documentation
        entry: python scripts/generate_postman_collection.py
        language: python
        files: ^(main\.py|.*\/api\/.*\.py)$
        pass_filenames: false
      
      - id: update-db-docs
        name: Update Database Documentation
        entry: python scripts/generate_db_docs.py
        language: python
        files: ^(.*\/models\/.*\.py|alembic\/versions\/.*\.py)$
        pass_filenames: false
      
      - id: update-architecture-docs
        name: Update Architecture Diagrams
        entry: python scripts/generate_architecture_docs.py
        language: python
        files: ^(.*\/models\/.*\.py|.*\/services\/.*\.py)$
        pass_filenames: false
```

### GitHub Actions for Documentation
```yaml
# .github/workflows/docs.yml
name: Auto-Update Documentation
on:
  push:
    branches: [main, develop]
    paths:
      - 'src/**/*.py'
      - 'main.py'

jobs:
  update-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install plantuml
      
      - name: Generate API Documentation
        run: |
          python scripts/generate_postman_collection.py
          python scripts/generate_openapi_docs.py
      
      - name: Generate Database Documentation
        run: |
          python scripts/generate_db_docs.py
      
      - name: Generate Architecture Diagrams
        run: |
          python scripts/generate_architecture_docs.py
          plantuml docs/architecture/*.puml
      
      - name: Commit updated docs
        run: |
          git config --local user.email "action@github.com"
          git config --local user.name "GitHub Action"
          git add docs/
          git diff --staged --quiet || git commit -m "Auto-update documentation [skip ci]"
          git push
```
