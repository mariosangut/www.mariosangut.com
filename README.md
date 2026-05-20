# Portfolio de Mario Sánchez Gutiérrez

Este repositorio contiene el código fuente del portfolio personal de **Mario Sánchez Gutiérrez**, Infrastructure & DevOps Engineer. Es un sitio web estático desarrollado con HTML, CSS y JavaScript (sin frameworks pesados), diseñado con una estética interactiva inspirada en la terminal y enfocado en el rendimiento.

## Despliegue

El proyecto se encuentra desplegado en producción y es accesible desde: **[www.mariosangut.com](https://www.mariosangut.com)**.

La arquitectura de despliegue sigue una filosofía **GitOps** completamente automatizada (Zero-Downtime):

1. **Integración Continua:** Cada `git push` a la rama principal desencadena un pipeline en **GitHub Actions**.
2. **Build:** El pipeline construye una imagen **Docker** y la sube a **GitHub Container Registry (GHCR)**, etiquetada unívocamente por el SHA del commit.
3. **Despliegue Continuo (CD):** El pipeline se conecta vía SSH al VPS de producción.
4. **Actualización:** En el servidor se ejecuta `docker-compose pull` y `docker-compose up -d`, lo que actualiza los contenedores al instante mediante el proxy inverso.

Todo el proceso de subida a producción toma menos de 2 minutos y mantiene un historial inmutable, siendo 100% declarativo en git.
