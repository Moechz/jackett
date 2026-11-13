#!/bin/bash
# Add the optional TOS front-end bundle (webui.bz2) to the built Jackett
# packages. The official Docker spec needs the four core files; the review's
# F22 asks for a webui.bz2 bundle, and TOSAppSelfTestingTool accepts it with a
# D20 "extra top-level entry" warning. The bundle is a small HTML redirect to
# the Jackett web UI on port 8019.
set -euo pipefail
cd "$(dirname "$0")/.."
BUNDLE=src/webui.bz2
[ -f "$BUNDLE" ] || { echo "missing $BUNDLE" >&2; exit 1; }
for pkg in out/jackettdocker.tar.gz out/jackettdocker_x86_64.tar.gz out/jackettdocker_aarch64.tar.gz; do
  [ -f "$pkg" ] || continue
  tmp=$(mktemp -d)
  tar -xzf "$pkg" -C "$tmp"
  cp "$BUNDLE" "$tmp/webui.bz2"
  tar --sort=name --owner=0 --group=0 --numeric-owner --mtime='UTC 1970-01-01' -czf "$pkg" -C "$tmp" .
  rm -rf "$tmp"
  (cd out && sha256sum "$(basename "$pkg")" > "$(basename "$pkg").sha256")
  echo "bundled $pkg"
done
