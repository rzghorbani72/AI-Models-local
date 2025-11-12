#!/usr/bin/env bash
set -euo pipefail

HOST=${1:-http://localhost:11434}
MODEL=${2:-deepseek-coder-v2:16b}

echo "Testing completion on $HOST using model $MODEL"

payload=$(cat <<JSON
{
  "model": "${MODEL}",
  "prompt": "// Test prompt: return the string 'hello'\nconsole.log('hello')\n",
  "max_tokens": 16
}
JSON
)

# Try OpenAI-compatible endpoint; Ollama may or may not support it depending on version
resp=$(curl -s -X POST -H "Content-Type: application/json" --max-time 10 -d "$payload" "$HOST/v1/completions" || true)

if [ -z "$resp" ]; then
  echo "No response (request failed or timed out)."
  exit 1
fi

echo "Response:"
echo "$resp" | sed -n '1,200p'

# Try Ollama legacy endpoint (if available)
echo
echo "Also trying /models endpoint (to list models):"
curl -s "$HOST/models" | sed -n '1,200p' || true
