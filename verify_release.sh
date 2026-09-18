#!/bin/bash
# Runs the full release-readiness check chain and writes every log to audit_logs/.
# Nothing here changes the project; it only builds and reports.
#
#   ./verify_release.sh                 # finds the Flutter SDK itself
#   FLUTTER=/path/to/flutter/bin/flutter ./verify_release.sh
#
# Then hand audit_logs/ back to the reviewer.
set -u

OUT=audit_logs
mkdir -p "$OUT"
: > "$OUT/summary.txt"

# ---------------------------------------------------------------- find flutter
find_flutter() {
  [ -n "${FLUTTER:-}" ] && [ -x "$FLUTTER" ] && { echo "$FLUTTER"; return; }
  command -v flutter >/dev/null 2>&1 && { command -v flutter; return; }

  local candidates=(
    "$HOME/flutter/bin/flutter"
    "$HOME/development/flutter/bin/flutter"
    "$HOME/sdk/flutter/bin/flutter"
    "$HOME/Developer/flutter/bin/flutter"
    /opt/homebrew/bin/flutter
    /usr/local/bin/flutter
    /opt/flutter/bin/flutter
    /Applications/flutter/bin/flutter
  )
  # brew cask, fvm and puro keep the SDK under a version directory
  candidates+=( /opt/homebrew/Caskroom/flutter/*/flutter/bin/flutter )
  candidates+=( "$HOME/fvm/versions"/*/bin/flutter "$HOME/fvm/default/bin/flutter" )
  candidates+=( "$HOME/.puro/envs"/*/flutter/bin/flutter )

  local c
  for c in "${candidates[@]}"; do
    [ -x "$c" ] && { echo "$c"; return; }
  done

  # last resort: the SDK recorded by a previous build of this project
  local recorded
  recorded=$(sed -n 's/^flutter\.sdk=//p' android/local.properties 2>/dev/null)
  [ -n "$recorded" ] && [ -x "$recorded/bin/flutter" ] && { echo "$recorded/bin/flutter"; return; }

  return 1
}

# ------------------------------------------------- fall back to the pinned image
# Dockerfile.android already pins the exact toolchain this project builds with, so a
# machine without a local Flutter SDK can still run the whole chain.
IMAGE=instrumentisto/flutter:3.41.6-androidsdk36-r0

run_in_docker() {
  echo "No local Flutter SDK; running the checks inside $IMAGE"
  echo "flutter: docker $IMAGE" >> "$OUT/summary.txt"
  docker run --rm \
    -v "$PWD":/app -w /app \
    -e OUT="$OUT" \
    "$IMAGE" bash -lc '
      set -u
      mkdir -p "$OUT"
      step() {
        name="$1"; shift
        echo "==> $name"
        if "$@" > "$OUT/$name.log" 2>&1; then
          echo "PASS $name" | tee -a "$OUT/summary.txt"
        else
          echo "FAIL $name (exit $?) -- see $OUT/$name.log" | tee -a "$OUT/summary.txt"
        fi
      }
      git config --global --add safe.directory /app 2>/dev/null
      step version   flutter --version
      step doctor    flutter doctor -v
      step clean     flutter clean
      step pub_get   flutter pub get
      step outdated  flutter pub outdated
      step analyze   flutter analyze
      step test      flutter test --reporter expanded
      step build_apk flutter build apk --release
      step build_aab flutter build appbundle --release
    '
}

if ! FLUTTER_BIN=$(find_flutter); then
  if command -v docker >/dev/null 2>&1 && docker info >/dev/null 2>&1; then
    run_in_docker
    echo
    echo "Logs in $OUT/ -- start with $OUT/summary.txt"
    cat "$OUT/summary.txt"
    exit 0
  fi

  cat <<'MSG'
Flutter SDK not found, and Docker is not running either.

Looked on PATH, in the usual install locations (~/flutter, ~/development/flutter,
Homebrew, fvm, puro) and at the flutter.sdk path recorded in android/local.properties
(/private/tmp/codex_flutter_sdk/flutter - macOS clears /private/tmp on reboot, so that
SDK is gone).

Pick one:

  1. Install Flutter (the project needs >= 3.41.6 / Dart >= 3.11):
         git clone -b stable --depth 1 https://github.com/flutter/flutter.git ~/flutter
         export PATH="$HOME/flutter/bin:$PATH"
         ./verify_release.sh

  2. Point the script at an SDK you already have:
         FLUTTER=/path/to/flutter/bin/flutter ./verify_release.sh

  3. Start Docker Desktop and re-run - the script will then use the pinned image
     instrumentisto/flutter:3.41.6-androidsdk36-r0 from Dockerfile.android.
MSG
  exit 1
fi

FLUTTER_ROOT_DIR=$(cd "$(dirname "$FLUTTER_BIN")/.." && pwd)
export PATH="$FLUTTER_ROOT_DIR/bin:$PATH"
echo "Using Flutter at $FLUTTER_BIN"

run() {
  local name="$1"; shift
  echo "==> $name"
  echo "--- $name :: $* ---" >> "$OUT/summary.txt"
  if "$@" > "$OUT/$name.log" 2>&1; then
    echo "PASS $name" | tee -a "$OUT/summary.txt"
  else
    echo "FAIL $name (exit $?) -- see $OUT/$name.log" | tee -a "$OUT/summary.txt"
  fi
}

{
  echo "date: $(date -u +%FT%TZ)"
  echo "branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  echo "commit: $(git rev-parse --short HEAD 2>/dev/null)"
  echo "dirty files: $(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
  echo "flutter: $FLUTTER_BIN"
  echo "java: $(java -version 2>&1 | head -1)"
} >> "$OUT/summary.txt"

run version        "$FLUTTER_BIN" --version
run doctor         "$FLUTTER_BIN" doctor -v
run clean          "$FLUTTER_BIN" clean
run pub_get        "$FLUTTER_BIN" pub get
run outdated       "$FLUTTER_BIN" pub outdated
run analyze        "$FLUTTER_BIN" analyze
run test           "$FLUTTER_BIN" test --reporter expanded
run build_apk      "$FLUTTER_BIN" build apk --release
run build_aab      "$FLUTTER_BIN" build appbundle --release

# Whatever the release build actually produced, signed with whatever key.
for artifact in build/app/outputs/flutter-apk/app-release.apk \
                build/app/outputs/bundle/release/app-release.aab; do
  if [ -f "$artifact" ]; then
    {
      echo "--- $artifact ---"
      ls -l "$artifact"
      keytool -printcert -jarfile "$artifact" 2>&1 | head -20
    } >> "$OUT/signing.log"
  fi
done

echo
echo "Logs in $OUT/ -- start with $OUT/summary.txt"
cat "$OUT/summary.txt"
