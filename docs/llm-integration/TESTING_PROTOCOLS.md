# PROTOCOLOS DE TESTING - IntelliCore POS

## TESTING HIERARCHY (Pirámide de Testing)

### Unit Tests (70% de coverage mínimo)
```python
# tests/unit/verticales/restaurant/test_order_service.py
import pytest
from unittest.mock import Mock, patch
from verticales.restaurant.services.order_service import OrderService
from verticales.restaurant.models.order import Order

class TestOrderService:
    """Tests unitarios para OrderService del vertical Restaurant"""
    
    @pytest.fixture
    def mock_db_session(self):
        """Mock session de base de datos"""
        return Mock()
    
    @pytest.fixture
    def order_service(self, mock_db_session):
        """Instancia de OrderService con dependencies mockeadas"""
        return OrderService(
            db=mock_db_session,
            tenant_id="test-tenant-uuid"
        )
    
    def test_create_order_with_valid_data(self, order_service, mock_db_session):
        """Test creación de orden con datos válidos"""
        # Arrange
        order_data = {
            "table_number": 5,
            "items": [{"item_id": "123", "quantity": 2}],
            "customer_id": "customer-uuid"
        }
        expected_order = Order(**order_data, tenant_id="test-tenant-uuid")
        mock_db_session.add.return_value = None
        mock_db_session.commit.return_value = None
        mock_db_session.refresh.return_value = None
        
        # Act
        result = order_service.create_order(order_data)
        
        # Assert
        assert result.table_number == 5
        assert result.tenant_id == "test-tenant-uuid"
        mock_db_session.add.assert_called_once()
        mock_db_session.commit.assert_called_once()
    
    def test_create_order_invalid_tenant_raises_exception(self, order_service):
        """Test que orden con tenant_id inválido lance excepción"""
        # Arrange
        order_data = {
            "table_number": 5,
            "tenant_id": "different-tenant-uuid"  # Tenant diferente
        }
        
        # Act & Assert
        with pytest.raises(ValueError, match="Invalid tenant"):
            order_service.create_order(order_data)
    
    @patch('verticales.restaurant.services.order_service.send_kitchen_notification')
    def test_create_order_sends_kitchen_notification(self, mock_notification, order_service):
        """Test que crear orden envíe notificación a cocina"""
        # Arrange
        order_data = {"table_number": 5, "items": []}
        
        # Act
        order_service.create_order(order_data)
        
        # Assert
        mock_notification.assert_called_once()
```

### Integration Tests (20% de coverage)
```python
# tests/integration/test_restaurant_order_flow.py
import pytest
from fastapi.testclient import TestClient
from sqlalchemy.orm import Session
from main import app
from core.database.base import get_db
from tests.conftest import get_test_db

class TestRestaurantOrderIntegration:
    """Tests de integración para flujo completo de órdenes"""
    
    @pytest.fixture
    def client(self):
        """Cliente de pruebas con base de datos de test"""
        app.dependency_overrides[get_db] = get_test_db
        return TestClient(app)
    
    @pytest.fixture
    def auth_headers(self, test_user):
        """Headers de autenticación para requests"""
        return {"Authorization": f"Bearer {test_user.access_token}"}
    
    def test_complete_order_flow(self, client, auth_headers, db_session):
        """Test flujo completo: crear orden -> agregar items -> procesar pago"""
        # Step 1: Crear orden
        order_response = client.post(
            "/api/v1/restaurant/orders",
            json={
                "table_number": 5,
                "customer_id": "test-customer-uuid"
            },
            headers=auth_headers
        )
        assert order_response.status_code == 201
        order_id = order_response.json()["id"]
        
        # Step 2: Agregar items a la orden
        items_response = client.post(
            f"/api/v1/restaurant/orders/{order_id}/items",
            json={
                "items": [
                    {"menu_item_id": "item-1", "quantity": 2},
                    {"menu_item_id": "item-2", "quantity": 1}
                ]
            },
            headers=auth_headers
        )
        assert items_response.status_code == 200
        
        # Step 3: Procesar pago
        payment_response = client.post(
            f"/api/v1/restaurant/orders/{order_id}/payment",
            json={
                "payment_method": "credit_card",
                "amount": 45.50
            },
            headers=auth_headers
        )
        assert payment_response.status_code == 200
        
        # Step 4: Verificar estado final en base de datos
        final_order = db_session.query(Order).filter(Order.id == order_id).first()
        assert final_order.status == "paid"
        assert len(final_order.items) == 2
    
    def test_cross_vertical_event_propagation(self, client, auth_headers):
        """Test propagación de eventos entre verticales"""
        # Crear orden en restaurant
        order_response = client.post(
            "/api/v1/restaurant/orders",
            json={"table_number": 5},
            headers=auth_headers
        )
        
        # Verificar que evento se propagó al sistema de analytics
        analytics_response = client.get(
            "/api/v1/analytics/events",
            params={"event_type": "order_created"},
            headers=auth_headers
        )
        
        assert analytics_response.status_code == 200
        events = analytics_response.json()
        assert len(events) > 0
        assert events[0]["vertical"] == "restaurant"
```

### End-to-End Tests (10% de coverage)
```python
# tests/e2e/test_restaurant_user_journey.py
import pytest
from playwright.sync_api import Page, expect

class TestRestaurantUserJourney:
    """Tests E2E para journey completo de usuario"""
    
    def test_waiter_complete_order_process(self, page: Page, authenticated_user):
        """Test journey completo de mesero creando y gestionando orden"""
        # Login como mesero
        page.goto("http://localhost:4200/restaurant")
        page.fill('[data-testid="username"]', authenticated_user.username)
        page.fill('[data-testid="password"]', "test-password")
        page.click('[data-testid="login-button"]')
        
        # Verificar llegada al dashboard
        expect(page.locator('[data-testid="dashboard-title"]')).to_contain_text("Restaurant Dashboard")
        
        # Crear nueva orden
        page.click('[data-testid="new-order-button"]')
        page.select_option('[data-testid="table-select"]', "5")
        page.click('[data-testid="create-order-button"]')
        
        # Agregar items al orden
        page.click('[data-testid="add-item-button"]')
        page.fill('[data-testid="item-search"]', "Pizza Margherita")
        page.click('[data-testid="item-pizza-margherita"]')
        page.fill('[data-testid="quantity-input"]', "2")
        page.click('[data-testid="add-to-order-button"]')
        
        # Verificar item agregado
        expect(page.locator('[data-testid="order-items"]')).to_contain_text("Pizza Margherita")
        expect(page.locator('[data-testid="order-total"]')).to_contain_text("$30.00")
        
        # Enviar orden a cocina
        page.click('[data-testid="send-to-kitchen-button"]')
        
        # Verificar confirmación
        expect(page.locator('[data-testid="success-message"]')).to_contain_text("Order sent to kitchen")
        
        # Verificar estado de orden actualizado
        expect(page.locator('[data-testid="order-status"]')).to_contain_text("In Kitchen")
    
    def test_manager_analytics_dashboard(self, page: Page, manager_user):
        """Test dashboard de analytics para manager"""
        # Login como manager
        page.goto("http://localhost:4200/restaurant/analytics")
        # ... implementar test completo
        pass
```

## TESTING POR VERTICAL ESPECÍFICO

### Restaurant Vertical Tests
```python
# tests/verticales/restaurant/test_specific_business_rules.py
class TestRestaurantBusinessRules:
    """Tests específicos de reglas de negocio del restaurant"""
    
    def test_table_cannot_have_multiple_active_orders(self):
        """Una mesa no puede tener múltiples órdenes activas"""
        pass
    
    def test_kitchen_notification_sent_on_order_creation(self):
        """Notificación a cocina se envía al crear orden"""
        pass
    
    def test_tip_calculation_follows_restaurant_policy(self):
        """Cálculo de propina sigue política del restaurante"""
        pass
    
    def test_inventory_updated_when_order_completed(self):
        """Inventario se actualiza cuando orden se completa"""
        pass
```

### Hotel Vertical Tests
```python
# tests/verticales/hotel/test_reservation_business_rules.py
class TestHotelBusinessRules:
    """Tests específicos de reglas de negocio del hotel"""
    
    def test_room_cannot_be_double_booked(self):
        """Habitación no puede tener reservas superpuestas"""
        pass
    
    def test_early_checkin_requires_approval(self):
        """Check-in temprano requiere aprobación"""
        pass
    
    def test_cancellation_policy_applied_correctly(self):
        """Política de cancelación se aplica correctamente"""
        pass
    
    def test_housekeeping_notified_on_checkout(self):
        """Housekeeping es notificado en checkout"""
        pass
```

## TESTING DE PERFORMANCE

### Load Testing
```python
# tests/performance/test_api_load.py
import pytest
from locust import HttpUser, task, between

class RestaurantAPIUser(HttpUser):
    """Simulación de usuario para load testing"""
    wait_time = between(1, 3)
    
    def on_start(self):
        """Setup inicial - login"""
        response = self.client.post("/api/v1/auth/login", json={
            "username": "test_user",
            "password": "test_password"
        })
        self.token = response.json()["access_token"]
        self.headers = {"Authorization": f"Bearer {self.token}"}
    
    @task(3)
    def get_orders(self):
        """Task más frecuente - obtener órdenes"""
        self.client.get("/api/v1/restaurant/orders", headers=self.headers)
    
    @task(1)
    def create_order(self):
        """Task menos frecuente - crear orden"""
        self.client.post("/api/v1/restaurant/orders", 
                        json={"table_number": 5},
                        headers=self.headers)
    
    @task(2)
    def get_menu(self):
        """Task frecuente - obtener menú"""
        self.client.get("/api/v1/restaurant/menu", headers=self.headers)

# Ejecutar: locust -f tests/performance/test_api_load.py --host=http://localhost:8000
```

### Database Performance Tests
```python
# tests/performance/test_database_performance.py
import pytest
import time
from sqlalchemy.orm import Session
from verticales.restaurant.models.order import Order

class TestDatabasePerformance:
    """Tests de performance de base de datos"""
    
    def test_order_query_performance(self, db_session: Session):
        """Query de órdenes debe completarse en menos de 100ms"""
        start_time = time.time()
        
        orders = db_session.query(Order).filter(
            Order.tenant_id == "test-tenant",
            Order.created_at >= "2024-01-01"
        ).limit(100).all()
        
        end_time = time.time()
        query_time = (end_time - start_time) * 1000  # Convert to ms
        
        assert query_time < 100, f"Query took {query_time}ms, should be < 100ms"
        assert len(orders) <= 100
    
    def test_bulk_insert_performance(self, db_session: Session):
        """Inserción bulk debe manejar 1000 registros en menos de 1s"""
        orders_data = [
            {"table_number": i, "tenant_id": "test-tenant"}
            for i in range(1000)
        ]
        
        start_time = time.time()
        
        db_session.bulk_insert_mappings(Order, orders_data)
        db_session.commit()
        
        end_time = time.time()
        insert_time = end_time - start_time
        
        assert insert_time < 1.0, f"Bulk insert took {insert_time}s, should be < 1s"
```

## TESTING DE SEGURIDAD

### Security Testing
```python
# tests/security/test_authentication_security.py
class TestAuthenticationSecurity:
    """Tests de seguridad para autenticación"""
    
    def test_jwt_token_expiration(self, client):
        """JWT tokens deben expirar después del tiempo configurado"""
        # Login y obtener token
        response = client.post("/api/v1/auth/login", json={
            "username": "test_user",
            "password": "test_password"
        })
        token = response.json()["access_token"]
        
        # Verificar que token es válido inicialmente
        response = client.get("/api/v1/auth/me", 
                             headers={"Authorization": f"Bearer {token}"})
        assert response.status_code == 200
        
        # Simular expiración de token (mock time)
        with patch('time.time', return_value=time.time() + 3700):  # 1 hour + 1 minute
            response = client.get("/api/v1/auth/me", 
                                 headers={"Authorization": f"Bearer {token}"})
            assert response.status_code == 401
    
    def test_tenant_isolation(self, client, user_tenant_a, user_tenant_b):
        """Usuarios de diferentes tenants no pueden acceder a datos de otros"""
        # Login como usuario de tenant A
        response_a = client.post("/api/v1/auth/login", json={
            "username": user_tenant_a.username,
            "password": "password"
        })
        token_a = response_a.json()["access_token"]
        
        # Crear orden como tenant A
        order_response = client.post("/api/v1/restaurant/orders",
                                   json={"table_number": 5},
                                   headers={"Authorization": f"Bearer {token_a}"})
        order_id = order_response.json()["id"]
        
        # Login como usuario de tenant B
        response_b = client.post("/api/v1/auth/login", json={
            "username": user_tenant_b.username,
            "password": "password"
        })
        token_b = response_b.json()["access_token"]
        
        # Intentar acceder a orden de tenant A como tenant B
        access_response = client.get(f"/api/v1/restaurant/orders/{order_id}",
                                   headers={"Authorization": f"Bearer {token_b}"})
        assert access_response.status_code == 404  # No debe encontrar la orden
    
    def test_sql_injection_protection(self, client, auth_headers):
        """APIs deben estar protegidas contra SQL injection"""
        malicious_input = "'; DROP TABLE orders; --"
        
        response = client.get("/api/v1/restaurant/orders",
                             params={"search": malicious_input},
                             headers=auth_headers)
        
        # No debe retornar error 500 (que indicaría SQL injection exitoso)
        assert response.status_code in [200, 400, 422]
```

## TESTING AUTOMATION

### CI/CD Pipeline Testing
```yaml
# .github/workflows/test.yml
name: Test Suite
on: [push, pull_request]

jobs:
  unit-tests:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: [3.11]
    
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}
      
      - name: Install dependencies
        run: |
          pip install -r requirements.txt
          pip install -r requirements-test.txt
      
      - name: Run unit tests
        run: |
          pytest tests/unit/ -v --cov=src --cov-report=xml
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage.xml
  
  integration-tests:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: test
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - uses: actions/checkout@v3
      - name: Run integration tests
        run: |
          pytest tests/integration/ -v
  
  e2e-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install Playwright
        run: |
          npm install playwright
          npx playwright install
      
      - name: Start application
        run: |
          docker-compose up -d
          sleep 30  # Wait for services to start
      
      - name: Run E2E tests
        run: |
          pytest tests/e2e/ -v
      
      - name: Stop application
        run: |
          docker-compose down
```

### Test Data Management
```python
# tests/factories.py
import factory
from factory.alchemy import SQLAlchemyModelFactory
from verticales.restaurant.models.order import Order
from core.models.user import User

class UserFactory(SQLAlchemyModelFactory):
    """Factory para crear usuarios de prueba"""
    class Meta:
        model = User
        sqlalchemy_session_persistence = "commit"
    
    username = factory.Sequence(lambda n: f"user{n}")
    email = factory.LazyAttribute(lambda obj: f"{obj.username}@test.com")
    tenant_id = factory.Faker("uuid4")
    is_active = True

class RestaurantOrderFactory(SQLAlchemyModelFactory):
    """Factory para crear órdenes de restaurante"""
    class Meta:
        model = Order
        sqlalchemy_session_persistence = "commit"
    
    table_number = factory.Faker("random_int", min=1, max=20)
    tenant_id = factory.Faker("uuid4")
    status = "pending"
    created_by = factory.SubFactory(UserFactory)
```
