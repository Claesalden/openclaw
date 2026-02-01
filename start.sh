#!/usr/bin/env sh
set -eu

cd /app

# Run the built CLI directly with Node (avoids pnpm/.bin permission issues)
exec node dist/index.js gateway --host 0.0.0.0 --port "${PORT:-8080}"
