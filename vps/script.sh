#!/bin/bash

# 1. Fallar inmediatamente si un comando falla o si se usa una variable no definida
set -euo pipefail

# Configuración básica
PROJECT_DIR="/opt/docker/nginx"
COMPOSE_FILE="docker-compose.yml"

echo "--- Iniciando despliegue en $PROJECT_DIR ---"


cd "$PROJECT_DIR" || { echo "Error: No se pudo acceder a $PROJECT_DIR"; exit 1; }

echo "Descargando imágenes actualizadas..."
docker compose pull


echo "Levantando servicios..."
docker compose up -d --remove-orphans

echo "Limpiando imágenes antiguas..."
docker image prune -f

echo "--- Despliegue completado con éxito ---"