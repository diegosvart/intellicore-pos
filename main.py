"""
FastAPI application factory para IntelliCore POS
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from core.config import config

def create_app() -> FastAPI:
    """Factory para crear aplicación FastAPI"""
    
    app = FastAPI(
        title="IntelliCore POS API",
        description="Sistema POS multi-vertical inteligente",
        version="1.0.0",
        docs_url="/docs" if config.debug else None,
        redoc_url="/redoc" if config.debug else None
    )
    
    # Configurar CORS
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],  # En producción especificar dominios
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
    
    # Registrar rutas de core
    from core.auth.api import router as auth_router
    from core.payments.api import router as payments_router
    from core.customers.api import router as customers_router
    
    app.include_router(auth_router, prefix="/api/v1/auth", tags=["auth"])
    app.include_router(payments_router, prefix="/api/v1/payments", tags=["payments"])
    app.include_router(customers_router, prefix="/api/v1/customers", tags=["customers"])
    
    # Registrar rutas de verticales
    from verticales.restaurant.api import router as restaurant_router
    from verticales.hotel.api import router as hotel_router
    from verticales.retail.api import router as retail_router
    
    app.include_router(restaurant_router, prefix="/api/v1/restaurant", tags=["restaurant"])
    app.include_router(hotel_router, prefix="/api/v1/hotel", tags=["hotel"])
    app.include_router(retail_router, prefix="/api/v1/retail", tags=["retail"])
    
    @app.get("/")
    async def root():
        return {"message": "IntelliCore POS API v1.0.0", "status": "running"}
    
    @app.get("/health")
    async def health():
        return {"status": "healthy", "version": "1.0.0"}
    
    return app

# Crear instancia de la aplicación
app = create_app()
