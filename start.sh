#!/bin/bash
# Load env variables
if [ -f ".env" ]; then
    export $(grep -v '^#' .env | xargs)
fi

mkdir -p .openclaw workspace logs
CONFIG_FILE="./.openclaw/openclaw.json"

# Remove any stale lock files
rm -f ./.openclaw/gateway.pid

if [ ! -f "$CONFIG_FILE" ]; then
    echo "🦞 No config found. Starting Onboarding Wizard..."
    # 'run' overrides compose commands to let you interact with the wizard
    docker compose run --rm openclaw onboard
else
    echo "🦞 Config detected. Starting OpenClaw Gateway..."
    docker compose down > /dev/null 2>&1
    echo "🦞 Gateway will start in this terminal."
    echo "👉 To chat, open another terminal tab and run: ./tui.sh"
    docker compose run --rm openclaw gateway
fi