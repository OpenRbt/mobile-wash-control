#!/bin/bash
set -e

# Release APK built inside the Flutter image, so the host needs nothing but
# docker. Values that build.sh takes from build_config.json are passed as build
# args here, because that file is kept out of the image context.
OUT_DIR=${OUT_DIR:-build/android}

DOCKER_BUILDKIT=1 docker build \
  -f Dockerfile.android \
  --target export \
  --output "type=local,dest=$OUT_DIR" \
  --build-arg api_base_url="${api_base_url:-}" \
  --build-arg android_api_key="${android_api_key:-}" \
  --build-arg android_app_id="${android_app_id:-}" \
  --build-arg messaging_sender_id="${messaging_sender_id:-}" \
  --build-arg project_id="${project_id:-}" \
  --build-arg storage_bucket="${storage_bucket:-}" \
  .

echo "APK: $OUT_DIR/app-release.apk"
