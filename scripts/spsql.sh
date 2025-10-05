#!/usr/bin/env bash

CONTAINER_NAME="postgres-dev"
IMAGE="postgres"

if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping $CONTAINER_NAME..."
    docker stop $CONTAINER_NAME
elif [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Starting $CONTAINER_NAME..."
    docker start $CONTAINER_NAME
else
    echo "Running new $CONTAINER_NAME container..."
    docker run -d \
        --name $CONTAINER_NAME \
        -e POSTGRES_USER=devuser \
        -e POSTGRES_PASSWORD=devpass \
        -e POSTGRES_DB=devdb \
        -p 5432:5432 \
        -v pgdata:/var/lib/postgresql/data \
        $IMAGE
fi
