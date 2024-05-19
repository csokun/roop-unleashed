#!/usr/bin/env bash
IMAGE_TAG=roop-unleashed:latest
docker buildx build --platform linux/amd64,linux/arm64 -t $IMAGE_TAG .

docker run --rm --runtime=nvidia --gpus all \
    --restart unless-stopped \
    --detach \
    -p 7860:7860 \
    -v $PWD/models:/app/models \
    -v $PWD/output:/app/output \
    -v $PWD/config.yaml:/app/config.yaml \
    $IMAGE_TAG
