#!/usr/bin/env bash
set -euo pipefail

# Script to pull a recommended set of models for offline dev.
# Edit the MODELS array to add/remove models.

MODELS=(
  "deepseek-coder-v2:16b"    # 16B code-focused; strong on refactors, tests, bug hunts
  "neural-chat:latest"       # Lightweight chat; snappy brainstorming and shell help
  "mistral:latest"           # Balanced mix of reasoning + speed for general prompts : Want more general reasoning or non-code writing
  "codellama:13b"            # Open CodeLlama; excels at Python/scripts, reproducible outputs
  "starling-lm:7b"           # RLHF-tuned 7B; great for cooperative, low-latency coding
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
