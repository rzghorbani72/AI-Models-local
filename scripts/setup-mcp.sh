#!/usr/bin/env bash
# MCP (Model Context Protocol) Servers for Continue Extension
# These servers provide context to the AI model for smarter debugging.
#
# Servers included:
# 1. Git MCP - inspect commits, diffs, branches
# 2. Filesystem MCP - read/browse project files
# 3. Shell MCP - run tests and capture output
#
# Usage:
#   - Ensure Node.js is installed: node --version
#   - These are started automatically by Continue if configured in config.yaml
#   - See: ~/.continue/config.yaml

# Check if Node.js is available (required for MCP servers)
if ! command -v node &> /dev/null; then
  echo "ERROR: Node.js not found. MCP servers require Node.js."
  echo "Install Node.js from: https://nodejs.org/"
  exit 1
fi

echo "MCP servers will be initialized when Continue loads config.yaml"
echo "Verify: check ~/.continue/config.yaml for 'tools' section"
echo "Test: In Continue, ask the model to inspect your git history or filesystem"
