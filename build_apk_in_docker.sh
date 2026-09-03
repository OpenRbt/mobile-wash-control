#!/bin/bash
set -e

# Release APK built inside the Flutter image, so the host needs nothing but docker.
OUT_DIR=${OUT_DIR:-build/android}

DOCKER_BUILDKIT=1 docker build \
  -f Dockerfile.android \
  --target export \
  --output "type=local,dest=$OUT_DIR" \
  .

echo "APK: $OUT_DIR/app-release.apk"
