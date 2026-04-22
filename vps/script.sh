#!/bin/bash

# 1. Fallar inmediatamente si un comando falla o si se usa una variable no definida
set -euo pipefail

# Configuración básica
PROJECT_DIR="/opt/docker/nginx"
COMPOSE_FILE="docker-compose.yml"

echo "--- Iniciando despliegue en $PROJECT_DIR ---"

# 2. Asegurar que estamos en el lugar correcto
cd "$PROJECT_DIR" || { echo "Error: No se pudo acceder a $PROJECT_DIR"; exit 1; }



# 3. Pull de las imágenes antes de apagar nada
# Punto ciego: Si haces 'up' sin 'pull' previo, el tiempo de inactividad aumenta 
# mientras el servidor descarga las capas. Descarga primero, despliega después.
echo "Descargando imágenes actualizadas..."
docker compose pull

# 4. Despliegue con cero fricción
# --remove-orphans elimina contenedores antiguos que ya no están en el compose.
# --wait (si tu versión de docker lo soporta) asegura que el contenedor esté 'healthy'
echo "Levantando servicios..."
docker compose up -d --remove-orphans

# 5. Higiene del VPS
# Si no limpias las imágenes antiguas (dangling), llenarás el disco en 3 despliegues.
# Jugar a lo grande significa no tener que entrar a borrar archivos a mano los domingos.
echo "Limpiando imágenes antiguas..."
docker image prune -f

echo "--- Despliegue completado con éxito ---"