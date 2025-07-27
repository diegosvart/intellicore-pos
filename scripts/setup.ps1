# Script de setup inicial para IntelliCore POS (Windows)

Write-Host "🚀 Iniciando setup de IntelliCore POS..." -ForegroundColor Green

# Crear directorio de logs
if (!(Test-Path "logs")) {
    New-Item -ItemType Directory -Path "logs"
}

# Copiar archivo de entorno si no existe
if (!(Test-Path ".env")) {
    Write-Host "📋 Copiando archivo de configuración..." -ForegroundColor Yellow
    Copy-Item ".env.example" ".env"
    Write-Host "✅ Archivo .env creado. Por favor configura las variables de entorno." -ForegroundColor Green
}

# Crear entorno virtual Python
Write-Host "🐍 Creando entorno virtual Python..." -ForegroundColor Blue
python -m venv venv

# Activar entorno virtual
Write-Host "🔧 Activando entorno virtual..." -ForegroundColor Blue
& "venv\Scripts\Activate.ps1"

# Instalar dependencias
Write-Host "📦 Instalando dependencias..." -ForegroundColor Blue
pip install -r requirements.txt

# Crear estructura de base de datos
Write-Host "🗄️ Preparando base de datos..." -ForegroundColor Blue
# TODO: Ejecutar migraciones cuando estén implementadas

Write-Host "✅ Setup completado!" -ForegroundColor Green
Write-Host ""
Write-Host "Para iniciar el desarrollo:" -ForegroundColor Cyan
Write-Host "1. Configura las variables en .env" -ForegroundColor White
Write-Host "2. Ejecuta: docker-compose -f docker-compose.dev.yml up" -ForegroundColor White
Write-Host "3. Ve a http://localhost:8000/docs para la API" -ForegroundColor White
Write-Host "4. Ve a http://localhost:4200 para el frontend" -ForegroundColor White
