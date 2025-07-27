# Configuración principal de IntelliCore POS
import os
from typing import Dict, Any
from dataclasses import dataclass

@dataclass
class DatabaseConfig:
    """Configuración de base de datos"""
    host: str = os.getenv("DB_HOST", "localhost")
    port: int = int(os.getenv("DB_PORT", "5432"))
    name: str = os.getenv("DB_NAME", "intellicore_pos")
    user: str = os.getenv("DB_USER", "postgres")
    password: str = os.getenv("DB_PASSWORD", "")
    
    @property
    def url(self) -> str:
        return f"postgresql://{self.user}:{self.password}@{self.host}:{self.port}/{self.name}"

@dataclass
class AuthConfig:
    """Configuración de autenticación"""
    secret_key: str = os.getenv("SECRET_KEY", "your-secret-key")
    algorithm: str = "HS256"
    access_token_expire_minutes: int = 30
    refresh_token_expire_days: int = 7

@dataclass
class PaymentConfig:
    """Configuración de pagos"""
    stripe_secret_key: str = os.getenv("STRIPE_SECRET_KEY", "")
    stripe_public_key: str = os.getenv("STRIPE_PUBLIC_KEY", "")
    paypal_client_id: str = os.getenv("PAYPAL_CLIENT_ID", "")
    paypal_client_secret: str = os.getenv("PAYPAL_CLIENT_SECRET", "")

@dataclass
class RedisConfig:
    """Configuración de Redis para cache y sesiones"""
    host: str = os.getenv("REDIS_HOST", "localhost")
    port: int = int(os.getenv("REDIS_PORT", "6379"))
    db: int = int(os.getenv("REDIS_DB", "0"))
    password: str = os.getenv("REDIS_PASSWORD", "")

class ConfigManager:
    """Gestor centralizado de configuración"""
    
    def __init__(self):
        self.database = DatabaseConfig()
        self.auth = AuthConfig()
        self.payment = PaymentConfig()
        self.redis = RedisConfig()
        self.environment = os.getenv("ENVIRONMENT", "development")
        self.debug = os.getenv("DEBUG", "true").lower() == "true"
        
    def get_config(self) -> Dict[str, Any]:
        """Retorna toda la configuración como diccionario"""
        return {
            "database": self.database,
            "auth": self.auth,
            "payment": self.payment,
            "redis": self.redis,
            "environment": self.environment,
            "debug": self.debug
        }

# Instancia global de configuración
config = ConfigManager()
