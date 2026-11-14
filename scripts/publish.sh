#!/bin/bash
# Usage: publish.sh <orbit|infall>
# Waits until the cask's DMG is live at its URL with the SHA-256 written in the
# cask, then commits and pushes. Never pushes a cask whose download would 404
# or fail the checksum. Gives up after ~60 min (run it again to retry).
set -euo pipefail
cd "$(dirname "$0")/.."
CASK="Casks/$1.rb"
VERSION=$(sed -nE 's/^  version "(.*)"/\1/p' "$CASK")
SHA=$(sed -nE 's/^  sha256 "(.*)"/\1/p' "$CASK")
URL=$(sed -nE 's/^  url "(.*)"/\1/p' "$CASK")
if [[ "$VERSION" == *,* ]]; then
  URL=${URL//\#\{version.csv.first\}/${VERSION%%,*}}
  URL=${URL//\#\{version.csv.second\}/${VERSION##*,}}
else
  URL=${URL//\#\{version\}/$VERSION}
fi
if git diff --quiet -- "$CASK"; then echo "$CASK: nothing to publish"; exit 0; fi
for _ in $(seq 120); do
  [ "$(curl -fsL "$URL" 2>/dev/null | shasum -a 256 | awk '{print $1}')" = "$SHA" ] && break
  sleep 30
done
[ "$(curl -fsL "$URL" | shasum -a 256 | awk '{print $1}')" = "$SHA" ] || { echo "DMG not live at $URL; not pushed" >&2; exit 1; }
git add "$CASK"
git commit -qm "$1 $VERSION"
git push -q origin main
echo "pushed $1 $VERSION"
