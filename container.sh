#!/usr/bin/env bash
IMAGE_TAG=roop-unleashed:latest
NAME=roop-unleashed

docker buildx build -t $IMAGE_TAG .

docker rm $NAME
docker run --runtime=nvidia --gpus all \
    --name $NAME \
    --restart unless-stopped \
    --detach \
    -p 7860:7860 \
    -v $PWD/models:/app/models \
    -v $PWD/config.yaml:/app/config.yaml \
    $IMAGE_TAG
