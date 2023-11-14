#!/bin/bash

read -p "Enter the name of your traefik docker bridge " TRAEFIK_BRIDGE
read -p "What domain are you using? (e.g. example.com) " DOMAIN

echo "TRAEFIK_BRIDGE=$TRAEFIK_BRIDGE" > .env
echo "DOMAIN=$DOMAIN" >> .env

docker network create --driver bridge $TRAEFIK_BRIDGE
echo 'This may take some time... Running build now... You can check the logs for errors using: docker logs traefik-ssl'
docker compose config
docker compose up -d
