#!/bin/bash

read -p "Enter the name of your traefik docker bridge " TRAEFIK_BRIDGE
read -p "What domain are you using? (e.g. example.com) " DOMAIN

echo "TRAEFIK_BRIDGE=$TRAEFIK_BRIDGE" > .env
echo "DOMAIN=$DOMAIN" >> .env

docker compose config
docker compose config up
