#!/usr/bin/env bash
# Builds the dino game (dino_game/, made with Flame) into assets/dino/, from
# where Jekyll serves it as an iframe on the home page.
#
# Usage:
#   ./scripts/build-dino.sh
#
# Requires: flutter (see dino_game/README.md).

set -euo pipefail

cd "$(dirname "$0")/.."

echo "==> Building the dino game"
(
  cd dino_game
  flutter pub get
  flutter build web --release --pwa-strategy=none --base-href /assets/dino/ --output ../assets/dino
)

echo "==> Done. Output is in ./assets/dino"
