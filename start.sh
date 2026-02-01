#!/usr/bin/env sh
set -eu

cd /app

# Use Corepack so we don't care where pnpm lives
exec corepack pnpm exec openclaw gateway --host 0.0.0.0 --port "${PORT:-8080}"
