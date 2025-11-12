# Continue Extension - Quick Reference (Offline Mode)

## 🚀 One-Command Fix

```bash
# Create/update Continue configuration for offline Ollama
mkdir -p ~/.continue && cat > ~/.continue/config.yaml << 'EOF'
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

Then: **Close and reopen VS Code**

---

## ✅ Verify Setup

```bash
# 1. Check Ollama is running
curl -s http://localhost:11434/v1/models | head -5

# 2. Check model exists
ollama list | grep deepseek-coder-v2

# 3. Verify config exists
cat ~/.continue/config.yaml | head -10
```

---

## 🎮 Using Continue in VS Code

| Action | Shortcut | What it does |
|--------|----------|-------------|
| Open Continue | **Ctrl+K** (Windows/Linux) | Opens chat panel on the right |
| | **Cmd+K** (macOS) | |
| Generate Code | **Ctrl+Shift+K** | Generate code at cursor |
| | **Cmd+Shift+K** (macOS) | |
| Slash Commands | Type `/` | `/explain`, `/refactor`, `/test` |
| Select Code | Highlight text | Include in prompt |

---

## 🔧 Common Tasks

### Change Model
Edit `~/.continue/config.yaml`:
```yaml
models:
  - name: mistral
    provider: ollama
    model: mistral:latest
    title: "Mistral (Faster)"
```
Then restart VS Code.

### Download More Models
```bash
ollama pull mistral:latest
ollama pull neural-chat:latest
ollama pull codellama:13b
```

### Check if Ollama is Running
```bash
ps aux | grep ollama
# or
sudo systemctl status ollama
```

### Start Ollama (if not running)
```bash
ollama serve
# or
sudo systemctl start ollama
```

---

## 🚨 Troubleshooting

| Problem | Solution |
|---------|----------|
| **Continue panel won't open** | Close & reopen VS Code |
| **No response from model** | Check Ollama: `curl http://localhost:11434/v1/models` |
| **"Connection refused"** | Start Ollama: `ollama serve` |
| **Model not found** | Pull it: `ollama pull deepseek-coder-v2:16b` |
| **Very slow responses** | Use smaller model: `ollama pull mistral:latest` |
| **Tab autocomplete not working** | Restart VS Code |

---

## 📍 File Locations

- **Config:** `~/.continue/config.yaml` ← **Main file!**
- **Models:** `~/.ollama/models/`
- **Workspace Settings:** `/home/reza/Developer/AI/.vscode/settings.json`

---

## 💡 Pro Tips

1. **Pre-download models** before going offline:
   ```bash
   ollama pull deepseek-coder-v2:16b
   ollama pull mistral:latest
   ```

2. **Use `/explain` slash command** for specific questions:
   - `/explain` - Explain selected code
   - `/refactor` - Get refactoring suggestions
   - `/test` - Generate test code

3. **Enable tab autocomplete** in VS Code:
   ```json
   "continue.enableTabAutocomplete": true
   ```

4. **Auto-start Ollama on boot:**
   ```bash
   sudo systemctl enable ollama
   ```

---

## 📚 Resources

- **Full Guide:** `CONTINUE_OFFLINE_TROUBLESHOOTING.md` (this workspace)
- **Continue Docs:** https://docs.continue.dev
- **Ollama Docs:** https://ollama.ai

---

## ✨ Success Checklist

- [ ] `~/.continue/config.yaml` created with models
- [ ] Ollama running and responding
- [ ] Model downloaded: `ollama list`
- [ ] VS Code closed and reopened
- [ ] **Ctrl+K** opens Continue panel
- [ ] Can ask questions and get responses

🎉 **You're ready to code offline!**
