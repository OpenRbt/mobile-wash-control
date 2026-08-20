#!/bin/bash
export TAG=v0.0.7
docker build -t reg.registry.open-rbt.com/mobile-wash-control-web:$TAG .
docker buildx build --platform linux/arm64 -t reg.registry.open-rbt.com/mobile-wash-control-web:$TAG --load .
docker push reg.registry.open-rbt.com/mobile-wash-control-web:$TAG
