#!/usr/bin/env sh
set -eu

echo "▶ Starting OpenClaw gateway..."

# Always run from app directory
cd /app

# Required secrets (must be provided by Render)
: "${OPENCLAW_GATEWAY_TOKEN:?set OPENCLAW_GATEWAY_TOKEN in Render}"
: "${SETUP_PASSWORD:?set SETUP_PASSWORD in Render}"

# Render injects PORT automatically
PORT="${PORT:-8080}"

# Ensure pnpm is available via Corepack
corepack enable >/dev/null 2>&1 || true

# Start OpenClaw gateway
exec corepack pnpm exec openclaw gateway \
  --port "${PORT}" \
  --setup-password "${OPENCLAW_SETUP_PASSWORD}"
