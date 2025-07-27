#!/bin/bash

# Script de setup inicial para IntelliCore POS

echo "🚀 Iniciando setup de IntelliCore POS..."

# Crear directorio de logs
mkdir -p logs

# Copiar archivo de entorno si no existe
if [ ! -f .env ]; then
    echo "📋 Copiando archivo de configuración..."
    cp .env.example .env
    echo "✅ Archivo .env creado. Por favor configura las variables de entorno."
fi

# Crear entorno virtual Python
echo "🐍 Creando entorno virtual Python..."
python -m venv venv

# Activar entorno virtual
echo "🔧 Activando entorno virtual..."
source venv/bin/activate

# Instalar dependencias
echo "📦 Instalando dependencias..."
pip install -r requirements.txt

# Crear estructura de base de datos
echo "🗄️ Preparando base de datos..."
# TODO: Ejecutar migraciones cuando estén implementadas

echo "✅ Setup completado!"
echo ""
echo "Para iniciar el desarrollo:"
echo "1. Configura las variables en .env"
echo "2. Ejecuta: docker-compose -f docker-compose.dev.yml up"
echo "3. Ve a http://localhost:8000/docs para la API"
echo "4. Ve a http://localhost:4200 para el frontend"
