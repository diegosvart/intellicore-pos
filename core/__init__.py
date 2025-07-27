# IntelliCore POS - Core Universal
# Módulo principal que contiene toda la funcionalidad común
# para los diferentes verticales de la plataforma POS

__version__ = "1.0.0"
__author__ = "IntelliCore Team"

from .auth import AuthManager
from .payments import PaymentEngine
from .customers import CustomerManager
from .qr_selfservice import QRSelfService
from .ml_engine import MLEngine
from .inventory import InventoryManager
from .analytics import AnalyticsEngine
from .event_bus import EventBus
from .registry import ServiceRegistry
from .database import DatabaseManager
from .config import ConfigManager

__all__ = [
    "AuthManager",
    "PaymentEngine", 
    "CustomerManager",
    "QRSelfService",
    "MLEngine",
    "InventoryManager",
    "AnalyticsEngine",
    "EventBus",
    "ServiceRegistry",
    "DatabaseManager",
    "ConfigManager"
]
