#!/bin/bash
set -euo pipefail

# Ensure ~/.local/bin is on PATH for this script
export PATH="$HOME/.local/bin:$PATH"

echo "Installing Claude Code (native)..."
curl -fsSL https://claude.ai/install.sh | bash

echo "Installing OpenCode..."
curl -fsSL https://opencode.ai/install | bash

echo "Configuring Chrome DevTools MCP server..."
claude mcp add chrome-devtools -- npx -y chrome-devtools-mcp@latest

echo "Enabling remote control for all sessions..."
claude config set -g preferRemoteControl true

echo "Claude Code and OpenCode setup complete."
