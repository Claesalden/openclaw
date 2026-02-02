#!/usr/bin/env sh
set -eu

cd /app

# Render provides PORT. Bind must be non-loopback so Render can reach it.
# --allow-unconfigured lets it boot even if no ~/.openclaw config exists yet.
exec node dist/index.js gateway \
  --allow-unconfigured \
  --port "${PORT:-8080}" \
  --bind lan \
  --auth token \
  --token "${OPENCLAW_GATEWAY_TOKEN:?set OPENCLAW_GATEWAY_TOKEN in Render}"
  --token "${SETUP_PASSWORD:?set SETUP_PASSWORD in Render}"
