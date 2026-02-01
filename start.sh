#!/usr/bin/env sh
set -eu

echo "▶ Starting OpenClaw gateway..."

# Ensure we are in the app directory
cd /app

# Fail fast if required secrets are missing
: "${OPENCLAW_GATEWAY_TOKEN:?set OPENCLAW_GATEWAY_TOKEN in Render}"
: "${OPENCLAW_SETUP_PASSWORD:?set OPENCLAW_SETUP_PASSWORD in Render}"

# Render provides PORT automatically
PORT="${PORT:-8080}"

echo "▶ Using port ${PORT}"

# Ensure pnpm is available via Corepack
corepack enable >/dev/null 2>&1 || true

# Launch the gateway
exec corepack pnpm exec openclaw gateway \
  --port "${PORT}" \
  --setup-password "${OPENCLAW_SETUP_PASSWORD}"
