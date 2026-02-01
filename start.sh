#!/usr/bin/env sh
set -eu

echo "▶ Starting OpenClaw gateway..."
echo "▶ User: $(id -u):$(id -g)  (name: $(id -un 2>/dev/null || echo unknown))"
echo "▶ PWD:  $(pwd)"
echo "▶ PATH: $PATH"
echo "▶ PORT: ${PORT:-<not set>}"

# Show whether secrets are present (does NOT print secret values)
echo "DEBUG: OPENCLAW_GATEWAY_TOKEN set? ${OPENCLAW_GATEWAY_TOKEN:+yes}${OPENCLAW_GATEWAY_TOKEN:-no}"
echo "DEBUG: OPENCLAW_SETUP_PASSWORD set? ${OPENCLAW_SETUP_PASSWORD:+yes}${OPENCLAW_SETUP_PASSWORD:-no}"
echo "DEBUG: OPENCLAW_STATE_DIR: ${OPENCLAW_STATE_DIR:-<not set>}"
echo "DEBUG: OPENCLAW_WORKSPACE_DIR: ${OPENCLAW_WORKSPACE_DIR:-<not set>}"

# Ensure we are in the app directory
cd /app

# Fail fast if required secrets are missing/empty
: "${OPENCLAW_GATEWAY_TOKEN:?set OPENCLAW_GATEWAY_TOKEN in Render}"
: "${OPENCLAW_SETUP_PASSWORD:?set OPENCLAW_SETUP_PASSWORD in Render}"

# Render provides PORT automatically; default to 8080 for local runs
PORT="${PORT:-8080}"

# Make sure corepack is ready (pnpm via corepack)
corepack enable >/dev/null 2>&1 || true

# Start the gateway.
# NOTE: We avoid '--host' (not supported). OpenClaw uses '--port' and bind modes.
# Using setup password enables pairing flow.
exec corepack pnpm exec openclaw gateway \
  --port "${PORT}" \
  --setup-password "${OPENCLAW_SETUP_PASSWORD}"
