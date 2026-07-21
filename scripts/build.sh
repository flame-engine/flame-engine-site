#!/usr/bin/env bash
# Builds the Flame Engine site locally.
#
# Mirrors the steps described in README.md and what the GitHub Actions workflows
# run in CI: install npm deps, install Ruby gems, then build the site into _site.
#
# Usage:
#   ./scripts/build.sh          # build once into _site
#   ./scripts/build.sh --serve  # serve locally with live reload instead
#
# Requires: node + npm, ruby + bundler (see README.md).

set -euo pipefail

cd "$(dirname "$0")/.."

echo "==> Installing npm dependencies"
if [ -f package-lock.json ]; then
  npm ci
else
  npm install
fi

echo "==> Installing Ruby gems (bundle install)"
bundle install

echo "==> Building Jekyll site"
if [ "${1:-}" = "--serve" ]; then
  bundle exec jekyll serve
else
  JEKYLL_ENV=production bundle exec jekyll build
  echo "==> Done. Output is in ./_site"
fi
