#!/bin/bash

cd /opt/docker/nginx
docker pull ghcr.io/mariosangut/mariosangut.com:latest
docker compose up -d
docker image prune -af
