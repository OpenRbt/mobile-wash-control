#!/bin/bash
set -e
export TAG=v0.0.18

# Multi-arch (amd64 + arm64) build pushed straight to the registry.
# Requires a buildx builder on the docker-container driver (the default
# "docker" driver can't build/push multi-platform manifests). Create one if missing.
BUILDER=mwc-builder
if ! docker buildx ls --format '{{.Name}}' | grep -qx "$BUILDER"; then
  docker buildx create --name "$BUILDER" --driver docker-container --use
else
  docker buildx use "$BUILDER"
fi

docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t reg.registry.open-rbt.com/mobile-wash-control-web:$TAG \
  --push .