# IntelliCore POS - Verticales
# Módulos especializados para diferentes tipos de negocio

__version__ = "1.0.0"

from .restaurant import RestaurantModule
from .hotel import HotelModule
from .retail import RetailModule
from .services import ServicesModule
from .healthcare import HealthcareModule

__all__ = [
    "RestaurantModule",
    "HotelModule", 
    "RetailModule",
    "ServicesModule",
    "HealthcareModule"
]
