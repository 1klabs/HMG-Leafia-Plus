#!/bin/sh
# Build the Wireless CarPlay/AA NEMESIS package.
# usage: build-package.sh <payload dir> [output zip]
# The payload dir holds the app builds kept out of this repo:
#   2_tbt/files 2_tbt/files_neev 2_tbt/files_dl3hev 3_bridge/files 3_bridge/files_neev 3_bridge/files_dl3hev
set -e
ROOT=$(cd "$(dirname "$0")/.." && pwd)
PAY=${1:?usage: build-package.sh <payload dir> [output zip]}
OUT=${2:-$ROOT/dist/HMG_Leafia_Plus_Wireless_CarPlay_AA.zip}
case "$OUT" in /*) ;; *) OUT=$(pwd)/$OUT ;; esac
for d in 2_tbt/files 2_tbt/files_neev 2_tbt/files_dl3hev 3_bridge/files 3_bridge/files_neev 3_bridge/files_dl3hev; do
    [ -d "$PAY/$d" ] || { echo "missing $PAY/$d" >&2; exit 1; }
done
STAGE=$(mktemp -d)
cp -R "$ROOT/packages/wireless-carplay-aa/." "$STAGE/inner"
rm -f "$STAGE/inner/README.md"
for d in 2_tbt/files 2_tbt/files_neev 2_tbt/files_dl3hev 3_bridge/files 3_bridge/files_neev 3_bridge/files_dl3hev; do
    mkdir -p "$STAGE/inner/comp/$d" && cp "$PAY/$d"/* "$STAGE/inner/comp/$d/"
done
mkdir -p "$STAGE/inner/tools" "$STAGE/inner/recipes"
cp "$ROOT/tools/lpatch/lpatch" "$STAGE/inner/tools/lpatch"
cp "$ROOT"/recipes/*.recipe "$STAGE/inner/recipes/"
mkdir -p "$STAGE/outer/packages"
(cd "$STAGE/inner" && zip -qrX "$STAGE/outer/packages/wireless.carplay.aa.zip" .)
printf '[nemesis]\nversion=1.0\ntype=install\npath=packages/wireless.carplay.aa.zip\n' > "$STAGE/outer/NEMESIS.data"
mkdir -p "$(dirname "$OUT")" && rm -f "$OUT"
(cd "$STAGE/outer" && zip -qrX "$OUT" NEMESIS.data packages)
rm -r "$STAGE"
echo "$OUT"
