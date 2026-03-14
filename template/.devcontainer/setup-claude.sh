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
mkdir -p ~/.claude
SETTINGS_FILE="$HOME/.claude/settings.json"
if [ -f "$SETTINGS_FILE" ]; then
  # Merge preferRemoteControl into existing settings using node (available in the container)
  node -e "
    const fs = require('fs');
    const s = JSON.parse(fs.readFileSync('$SETTINGS_FILE', 'utf8'));
    s.preferRemoteControl = true;
    fs.writeFileSync('$SETTINGS_FILE', JSON.stringify(s, null, 2));
  "
else
  echo '{"preferRemoteControl": true}' > "$SETTINGS_FILE"
fi

echo "Claude Code and OpenCode setup complete."
