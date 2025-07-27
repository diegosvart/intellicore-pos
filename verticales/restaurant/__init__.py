# IntelliCore POS - Vertical de Restaurante
from typing import Dict, Any, List, Optional
from dataclasses import dataclass
from datetime import datetime

@dataclass
class MenuItem:
    """Elemento del menú"""
    id: str
    name: str
    description: str
    price: float
    category: str
    ingredients: List[str]
    allergens: List[str]
    preparation_time: int  # en minutos
    available: bool = True

@dataclass
class Table:
    """Mesa del restaurante"""
    id: str
    number: int
    capacity: int
    status: str  # available, occupied, reserved, cleaning
    qr_code: str
    waiter_id: Optional[str] = None

@dataclass
class Order:
    """Orden del restaurante"""
    id: str
    table_id: str
    items: List[Dict[str, Any]]
    status: str  # pending, preparing, ready, served, paid
    created_at: datetime
    total_amount: float
    waiter_id: Optional[str] = None

class RestaurantModule:
    """Módulo principal del vertical de restaurante"""
    
    def __init__(self):
        self.menu_items = {}
        self.tables = {}
        self.orders = {}
        
    def add_menu_item(self, item: MenuItem) -> bool:
        """Agregar elemento al menú"""
        self.menu_items[item.id] = item
        return True
    
    def create_order(self, table_id: str, items: List[Dict[str, Any]]) -> Order:
        """Crear nueva orden"""
        order_id = self._generate_order_id()
        total = self._calculate_total(items)
        
        order = Order(
            id=order_id,
            table_id=table_id,
            items=items,
            status="pending",
            created_at=datetime.now(),
            total_amount=total
        )
        
        self.orders[order_id] = order
        return order
    
    def update_order_status(self, order_id: str, status: str) -> bool:
        """Actualizar estado de orden"""
        if order_id in self.orders:
            self.orders[order_id].status = status
            return True
        return False
    
    def get_table_qr(self, table_id: str) -> Optional[str]:
        """Obtener QR de mesa"""
        table = self.tables.get(table_id)
        return table.qr_code if table else None
    
    def _generate_order_id(self) -> str:
        """Generar ID único de orden"""
        import uuid
        return f"REST_{uuid.uuid4().hex[:8].upper()}"
    
    def _calculate_total(self, items: List[Dict[str, Any]]) -> float:
        """Calcular total de la orden"""
        total = 0.0
        for item in items:
            menu_item = self.menu_items.get(item["menu_item_id"])
            if menu_item:
                total += menu_item.price * item.get("quantity", 1)
        return total
