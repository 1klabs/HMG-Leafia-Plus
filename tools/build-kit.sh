#!/bin/sh
# Assemble the fingerprint kit zip: kit/ scripts + lpatch + recipes/
set -e
ROOT=$(cd "$(dirname "$0")/.." && pwd)
OUT=${1:-$ROOT/dist/leafia-fingerprint-kit.zip}
case "$OUT" in /*) ;; *) OUT=$(pwd)/$OUT ;; esac
STAGE=$(mktemp -d)
cp "$ROOT/kits/fingerprint/NEMESIS.data" "$ROOT/kits/fingerprint/NEMESIS.sh" "$ROOT/kits/fingerprint/README.txt" "$STAGE/"
cp "$ROOT/tools/lpatch/lpatch" "$STAGE/lpatch"
mkdir "$STAGE/recipes" && cp "$ROOT"/recipes/*.recipe "$STAGE/recipes/"
mkdir -p "$(dirname "$OUT")" && rm -f "$OUT"
(cd "$STAGE" && zip -qrX "$OUT" NEMESIS.data NEMESIS.sh README.txt lpatch recipes)
rm -r "$STAGE"
echo "$OUT"
