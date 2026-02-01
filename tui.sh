#!/bin/bash
if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "🦞 Connecting to OpenClaw TUI..."

CONTAINER=$(docker ps --filter 'name=openclaw-sandbox' --format '{{.Names}}' | head -n 1)

if [ -z "$CONTAINER" ]; then
  echo "No running OpenClaw container found. Start the gateway first!"
  exit 1
fi

docker exec -it \
  -e OPENCLAW_GATEWAY_URL="ws://127.0.0.1:18789" \
  -e OPENCLAW_GATEWAY_TOKEN="$OPENCLAW_GATEWAY_TOKEN" \
  "$CONTAINER" openclaw tui