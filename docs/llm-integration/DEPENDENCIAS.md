# DEPENDENCIAS Y STACK TECNOLÓGICO - IntelliCore POS

## CORE DEPENDENCIES (Invariables en todos los verticales)

### Backend Core
```json
{
  "fastapi": "^0.104.1",
  "uvicorn": "^0.24.0",
  "sqlalchemy": "^2.0.23",
  "alembic": "^1.12.1",
  "pydantic": "^2.5.0",
  "python-jose": "^3.3.0",
  "passlib": "^1.7.4",
  "python-multipart": "^0.0.6",
  "redis": "^5.0.1",
  "celery": "^5.3.4",
  "pytest": "^7.4.3",
  "pytest-asyncio": "^0.21.1"
}
```

### Frontend Core (Angular 17)
```json
{
  "@angular/core": "^17.0.0",
  "@angular/common": "^17.0.0",
  "@angular/router": "^17.0.0",
  "@angular/forms": "^17.0.0",
  "@angular/material": "^17.0.0",
  "@ngrx/store": "^17.0.0",
  "@ngrx/effects": "^17.0.0",
  "rxjs": "^7.8.1",
  "typescript": "^5.2.0",
  "zone.js": "^0.14.0"
}
```

### Base de Datos y Cache
```yaml
# docker-compose.yml
services:
  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: intellicore_pos
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    
  redis:
    image: redis:7-alpine
    command: redis-server --appendonly yes
    
  minio:
    image: minio/minio:latest
    command: server /data --console-address ":9001"
```

## VERTICAL-SPECIFIC DEPENDENCIES

### Vertical Restaurant
```python
# requirements.txt adicionales
stripe==7.8.0           # Pagos
square-python-sdk==21.0.0.20231115  # POS integrations
qrcode==7.4.2           # QR para mesas
pillow==10.1.0          # Manipulación imágenes menú
reportlab==4.0.7        # Reportes PDF tickets
```

### Vertical Hotel
```python
# requirements.txt adicionales
channels==4.0.0         # WebSocket para reservas real-time
channels-redis==4.1.0   # Backend Redis para channels
python-dateutil==2.8.2  # Manejo fechas complejas
icalendar==5.0.11       # Integración calendarios
folium==0.15.0          # Mapas ubicación hotel
```

### Vertical Retail
```python
# requirements.txt adicionales
barcode==1.0.1          # Códigos de barras productos
python-escpos==3.0a9    # Impresoras térmicas
woocommerce==3.0.0      # Integración WooCommerce
shopify-python-api==12.3.0  # Integración Shopify
xmltodict==0.13.0       # XML parsers para EDI
```

### Vertical Services
```python
# requirements.txt adicionales
google-calendar==0.7.2  # Integración Google Calendar
twilio==8.11.1          # SMS notifications
sendgrid==6.11.0        # Email automatizado
geopy==2.4.1            # Cálculos geográficos
googlemaps==4.10.0      # Integración Google Maps
```

### Vertical Healthcare
```python
# requirements.txt adicionales
fhir-py==4.0.0          # Estándar FHIR
cryptography==41.0.8    # Encriptación datos médicos
python-hl7==0.4.5       # Protocolo HL7
dicom-numpy==0.6.5      # Manejo imágenes DICOM
python-gnupg==0.5.2     # Firma digital documentos
```

## MICRO-FRONTENDS DEPENDENCIES

### Core UI Components
```json
{
  "@intellicore/ui-components": "workspace:*",
  "@intellicore/auth-module": "workspace:*",
  "@intellicore/shared-utils": "workspace:*",
  "@angular/cdk": "^17.0.0",
  "primeNG": "^17.0.0",
  "chart.js": "^4.4.0",
  "ng2-charts": "^5.0.0"
}
```

### Vertical-Specific Frontend Dependencies

#### Restaurant Frontend
```json
{
  "qr-scanner": "^1.4.2",
  "signature_pad": "^4.1.7",
  "html2canvas": "^1.4.1",
  "jspdf": "^2.5.1",
  "@stripe/stripe-js": "^2.2.2"
}
```

#### Hotel Frontend
```json
{
  "fullcalendar": "^6.1.10",
  "@angular/google-maps": "^17.0.0",
  "leaflet": "^1.9.4",
  "socket.io-client": "^4.7.4"
}
```

#### Retail Frontend
```json
{
  "quagga": "^0.12.1",
  "@zxing/library": "^0.20.0",
  "print-js": "^1.6.0",
  "xlsx": "^0.18.5"
}
```

## INFRASTRUCTURE AS CODE

### Kubernetes Base
```yaml
# k8s/base/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - namespace.yaml
  - configmap.yaml
  - secrets.yaml
  - postgres.yaml
  - redis.yaml
  - nginx.yaml

commonLabels:
  app: intellicore-pos
  version: v1.0.0
```

### Terraform AWS
```hcl
# infrastructure/aws/main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  
  name = "intellicore-pos-vpc"
  cidr = "10.0.0.0/16"
}

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "19.0.0"
  
  cluster_name = "intellicore-pos-cluster"
  cluster_version = "1.28"
}
```

## DEVELOPMENT TOOLS

### Pre-commit Hooks
```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/psf/black
    rev: 23.11.0
    hooks:
      - id: black
        language_version: python3.11
  
  - repo: https://github.com/pycqa/flake8
    rev: 6.1.0
    hooks:
      - id: flake8
  
  - repo: https://github.com/pre-commit/mirrors-prettier
    rev: v3.0.3
    hooks:
      - id: prettier
        files: \.(ts|js|html|scss|css|json)$
```

### Docker Development
```dockerfile
# Dockerfile.dev
FROM python:3.11-slim as backend-dev

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
RUN pip install watchdog[watchmedo]

COPY . .
CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]

# Frontend development en docker-compose
```

## TESTING DEPENDENCIES

### Backend Testing
```python
# requirements-test.txt
pytest==7.4.3
pytest-asyncio==0.21.1
pytest-cov==4.1.0
pytest-mock==3.12.0
httpx==0.25.2
factory-boy==3.3.0
freezegun==1.2.2
pytest-xdist==3.5.0  # Tests paralelos
```

### Frontend Testing
```json
{
  "@angular/testing": "^17.0.0",
  "jasmine": "^5.1.0",
  "karma": "^6.4.2",
  "karma-chrome-headless": "^3.1.0",
  "karma-coverage": "^2.2.1",
  "protractor": "^7.0.0",
  "cypress": "^13.6.0"
}
```

## MONITORING Y OBSERVABILIDAD

### Logging y Metrics
```python
# requirements-monitoring.txt
structlog==23.2.0
prometheus-client==0.19.0
opentelemetry-api==1.21.0
opentelemetry-sdk==1.21.0
opentelemetry-instrumentation-fastapi==0.42b0
sentry-sdk==1.38.0
```

### Monitoring Stack
```yaml
# monitoring/docker-compose.yml
version: '3.8'
services:
  prometheus:
    image: prom/prometheus:v2.47.0
    
  grafana:
    image: grafana/grafana:10.2.0
    
  jaeger:
    image: jaegertracing/all-in-one:1.51.0
    
  elk-stack:
    image: sebp/elk:8.11.1
```

## VERSION MANAGEMENT

### Semantic Versioning Strategy
```json
{
  "core": "1.0.0",
  "verticales": {
    "restaurant": "1.0.0",
    "hotel": "0.9.0",
    "retail": "0.8.0",
    "services": "0.7.0",
    "healthcare": "0.6.0"
  },
  "micro-frontends": {
    "core-ui": "1.0.0",
    "restaurant-frontend": "1.0.0",
    "hotel-frontend": "0.9.0"
  }
}
```
