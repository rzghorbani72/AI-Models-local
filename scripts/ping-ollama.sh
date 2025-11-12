#!/usr/bin/env bash
set -euo pipefail

HOST=${1:-http://localhost:11434}

echo "Checking Ollama host: $HOST"

endpoints=("/" "/models" "/v1/models" "/ping")
for e in "${endpoints[@]}"; do
  url="$HOST$e"
  printf "%-20s -> %s\n" "Endpoint" "$url"
  status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 5 "$url" || echo "000")
  echo "HTTP status: $status"
done

echo
echo "Try an OpenAI-compatible completion endpoint (may or may not be supported):"
echo "POST $HOST/v1/completions (short timeout)"
curl -s -X POST -H "Content-Type: application/json" --max-time 5 -d '{"model":"deepseek-coder-v2:16b","prompt":"print(1+2)","max_tokens":5}' "$HOST/v1/completions" || echo "completion request failed or timed out"

echo
echo "Done. If none of the endpoints returned 200, check Ollama is running and the model is loaded."
