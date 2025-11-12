# Continue (VS Code) + Ollama local model

This project is preconfigured to point the Continue extension at a local Ollama instance running on port 11434 using the model `deepseek-coder-v2:16b`.

What I added previously in the workspace
- Workspace settings: `.vscode/settings.json` contains:

```
# Continue (VS Code) + Ollama Local Model

**Configure Continue extension to use local Ollama instance running on port 11434 with the model `deepseek-coder-v2:16b`.**

> ⚠️ **IMPORTANT:** Continue extension reads configuration from `~/.continue/config.yaml`, NOT from VS Code workspace settings!

---

## ⚡ Quick Setup

### Step 1: Create/Update Continue Configuration

Create or update `~/.continue/config.yaml`:

```yaml
name: Local Ollama Config
version: 1.0.0
schema: v1

models:
  - name: deepseek-coder-v2:16b
    provider: ollama
    model: deepseek-coder-v2:16b
    title: "DeepSeek Coder v2 (16B)"

tabAutocompleteModel:
  name: deepseek-coder-v2:16b
  provider: ollama
  model: deepseek-coder-v2:16b

slashCommands:
  - name: explain
    description: Explain selected code
  - name: refactor
    description: Suggest refactoring
  - name: test
    description: Write a test for this code
```

**Command to create it:**
```bash
mkdir -p ~/.continue
cat > ~/.continue/config.yaml << 'EOF'
name: Local Ollama Config
version: 1.0.0
schema: v1

models:
  - name: deepseek-coder-v2:16b
    provider: ollama
    model: deepseek-coder-v2:16b
    title: "DeepSeek Coder v2 (16B)"

tabAutocompleteModel:
  name: deepseek-coder-v2:16b
  provider: ollama
  model: deepseek-coder-v2:16b

slashCommands:
  - name: explain
    description: Explain selected code
  - name: refactor
    description: Suggest refactoring
  - name: test
    description: Write a test for this code
EOF
```

### Step 2: Ensure Ollama is Running

```bash
# Check if Ollama is running
curl -s http://localhost:11434/v1/models | head -20

# Or start Ollama
ollama serve

# Or (if systemd service exists)
sudo systemctl start ollama
```

### Step 3: Verify Model is Available

```bash
ollama list | grep deepseek-coder-v2

# If not found, pull it:
ollama pull deepseek-coder-v2:16b
```

### Step 4: Restart VS Code

Close and reopen VS Code completely (this reloads the extension).

### Step 5: Test Continue

1. Open any code file
2. Press **Ctrl+K** (Windows/Linux) or **Cmd+K** (macOS)
3. Continue panel should appear on the right
4. Ask: *"What does this code do?"*

---

## 🧪 Verification

### Run diagnostic script:

```bash
/home/reza/Developer/AI/scripts/ping-ollama.sh
```

Expected output: At least one endpoint should return `HTTP status: 200`

### Test curl directly:

```bash
# Check models endpoint
curl -s http://localhost:11434/v1/models

# Test completion
curl -X POST -H "Content-Type: application/json" \
  -d '{"model":"deepseek-coder-v2:16b","prompt":"print(1+2)","max_tokens":5}' \
  http://localhost:11434/v1/completions
```

---

## 🐛 Troubleshooting

**See:** `CONTINUE_OFFLINE_TROUBLESHOOTING.md` in the workspace root

Common issues:
- ❌ Continue panel doesn't open → Restart VS Code
- ❌ No response from model → Check Ollama is running
- ❌ "Connection refused" → Start Ollama with `ollama serve`
- ❌ Model not found → Pull with `ollama pull deepseek-coder-v2:16b`

---

## 📁 Files in This Setup

- **`~/.continue/config.yaml`** ← Main configuration file (user's home directory)
- **`.vscode/settings.json`** ← Workspace settings (not used by Continue for models)
- **`scripts/ping-ollama.sh`** ← Diagnostic script

---

## 🔐 Security Note

The Continue extension connects to `http://localhost:11434`. This is:
- ✅ Safe on localhost (only your machine)
- ⚠️ Not safe if exposed to network
- 💡 Tip: Only expose to network if you trust all network users
```

Files moved here
- `/home/reza/Developer/AI/docs/continue-ollama.md` (this file)
- `/home/reza/Developer/AI/scripts/ping-ollama.sh` (small diagnostic script to verify the local Ollama endpoint)

How to verify the model is reachable
1. Start Ollama and ensure `deepseek-coder-v2:16b` is pulled and running locally.
2. From this directory run the diagnostic script:

```bash
/home/reza/Developer/AI/scripts/ping-ollama.sh
```

The script tries several common endpoints and prints HTTP status codes. If one of them responds with `200`, the endpoint is reachable.

How VS Code uses the settings
- Open your project workspace in VS Code. The Continue extension should pick up the workspace settings and use the custom model URL.
- To double-check: open Settings (Workspace) and search for Continue's Custom Model configuration.

If you want, I can add a minimal test that issues a small completion using the Ollama HTTP API — tell me if you'd like that and whether your Ollama instance accepts OpenAI-compatible endpoints (e.g., `/v1/completions`).

Security note
- The workspace settings point to `http://localhost:11434`. If you expose that port, anyone who can reach it might be able to query your local model. Keep the service bound to localhost unless you intentionally want remote access.

Contact me if you want the script extended to test a sample completion or to add CI checks.
