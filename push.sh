#!/bin/bash
export TAG=v0.0.7
docker build -t reg.registry.open-rbt.com/mobile-wash-control-web:$TAG .
docker push reg.registry.open-rbt.com/mobile-wash-control-web:$TAG
