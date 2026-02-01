#!/usr/bin/env sh
set -eu

cd /app

exec node dist/index.js gateway \
  --dev \
  --allow-unconfigured \
  --port "${PORT:-8080}" \
  --bind lan \
  --auth token \
  --token "${OPENCLAW_GATEWAY_TOKEN:?set OPENCLAW_GATEWAY_TOKEN in Render}" \
  --setup-password "${OPENCLAW_SETUP_PASSWORD:?set OPENCLAW_SETUP_PASSWORD in Render}"
