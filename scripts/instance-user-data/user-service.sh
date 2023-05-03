#!/bin/bash

REGISTRY=www.thinhlh.com

docker run \
    --env MONGO_INITDB_HOST=${mongo_host} \
    --env MONGO_INITDB_PORT=${mongo_port} \
    --env MONGO_INITDB_DATABASE=${mongo_db_name} \
    --env MONGO_INITDB_ROOT_USERNAME=${mongo_username} \
    --env MONGO_INITDB_ROOT_PASSWORD=${mongo_password} \
    --env AUTH_HOST=${auth_host} \
    --env AUTH_PORT=${auth_port}
    -p 8081:8081 \
    --name user_container \
    -d \
    $REGISTRY/user_service:latest