#!/usr/bin/env bash
set -euo pipefail

# Script to pull a recommended set of models for offline dev.
# Edit the MODELS array to add/remove models.

MODELS=(
  "deepseek-coder-v2:16b"    # General coding (recommended)
  "neural-chat:latest"       # Lightweight, fast
  "mistral:latest"           # Balanced general-purpose model
  "codellama:13b"            # CodeLlama, useful for code tasks
  "starling-lm:7b"           # Another code-oriented model
  "dolphin-mixtral:latest"   # Large, high-quality reasoning
)

HOST_CMD=${1:-ollama}

echo "Pulling models with: $HOST_CMD"
for m in "${MODELS[@]}"; do
  echo
  echo "Pulling model: $m"
  # run the pull command; keep trying on transient failures
  if $HOST_CMD pull "$m"; then
    echo "Successfully pulled $m"
  else
    echo "Failed to pull $m; continuing to next model"
  fi
done

echo
echo "All pull attempts finished. Use 'ollama list' to verify."
