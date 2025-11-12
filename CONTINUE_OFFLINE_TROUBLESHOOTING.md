# Continue Extension Offline Mode Troubleshooting

## 🔴 Problem: Continue Extension Not Working in Offline Mode

### Root Cause
Continue extension uses a **`config.yaml`** file located in `~/.continue/` (your user home directory), NOT VS Code workspace settings. The workspace settings `continue.customModelUrl` and `continue.customModel` are **not valid** Continue configuration options and are ignored.

---

## ✅ Solution Steps

### Step 1: Update Continue Configuration

Create/update your `~/.continue/config.yaml` file with the following content:

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

embeddingsProvider:
  provider: ollama
  model: deepseek-coder-v2:16b
```

**Or run this command:**
```bash
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

embeddingsProvider:
  provider: ollama
  model: deepseek-coder-v2:16b
EOF
```

### Step 2: Verify Ollama is Running
```bash
curl -s http://localhost:11434/v1/models | grep -q deepseek-coder-v2 && echo "✅ Ollama is running with deepseek-coder-v2"
```

### Step 3: Restart VS Code
1. Close VS Code completely
2. Reopen VS Code
3. Wait 10-15 seconds for extensions to load

### Step 4: Test Continue
1. Open any code file (`.py`, `.js`, `.ts`, etc.)
2. Highlight some code
3. Press **Ctrl+K** (Windows/Linux) or **Cmd+K** (macOS)
4. Continue panel should appear on the right
5. Ask a question: *"What does this code do?"*

---

## 📋 Verification Checklist

- [ ] `~/.continue/config.yaml` exists and contains the models configuration
- [ ] Ollama is running: `curl http://localhost:11434/v1/models`
- [ ] Model `deepseek-coder-v2:16b` is available: `ollama list`
- [ ] VS Code is closed and reopened
- [ ] Continue extension appears in the Extensions sidebar
- [ ] Pressing Ctrl+K shows the Continue panel
- [ ] You can type a question and get a response

---

## 🔧 Advanced Troubleshooting

### Issue: "No models available" in Continue

**Solution:** Make sure `config.yaml` has the `models:` section with at least one model configured.

### Issue: Continue panel appears but no response

**Symptoms:**
- Ctrl+K opens the panel
- You can type
- But no response from the model

**Solutions:**
1. Check Ollama is running: `ollama serve` (in another terminal)
2. Verify model is downloaded: `ollama list | grep deepseek-coder-v2`
3. If not, pull it: `ollama pull deepseek-coder-v2:16b`
4. Check connection: `curl -s http://localhost:11434/v1/models`

### Issue: "Connection refused" or "Cannot connect to Ollama"

**Solutions:**
1. Start Ollama:
   ```bash
   # Linux
   sudo systemctl start ollama

   # Or manually
   ollama serve
   ```

2. Check if Ollama is listening:
   ```bash
   netstat -tuln | grep 11434
   # or
   ss -tuln | grep 11434
   ```

3. Verify connectivity:
   ```bash
   curl -v http://localhost:11434/
   ```

### Issue: Continue works but very slow

**Cause:** Model is too large for your hardware

**Solutions:**
1. Switch to a smaller model:
   ```bash
   ollama pull mistral:latest
   ```

2. Update `~/.continue/config.yaml`:
   ```yaml
   models:
     - name: mistral
       provider: ollama
       model: mistral:latest
       title: "Mistral"
   ```

3. Restart VS Code

### Issue: Tab autocomplete not working

**Solutions:**
1. Enable it in VS Code settings:
   ```json
   "continue.enableTabAutocomplete": true
   ```

2. Verify `tabAutocompleteModel` is configured in `config.yaml`

3. Restart VS Code

---

## 📁 Key Locations

- **Continue Config:** `~/.continue/config.yaml`
- **VS Code Settings:** `/home/reza/Developer/AI/.vscode/settings.json`
- **Ollama Models:** `~/.ollama/models/` or `/var/lib/ollama/models/`
- **Ollama Service:** `sudo systemctl status ollama`

---

## 🧪 Test Commands

```bash
# Check Ollama is responding
curl -s http://localhost:11434/v1/models

# Test completion
curl -X POST -H "Content-Type: application/json" \
  -d '{"model":"deepseek-coder-v2:16b","prompt":"print(","max_tokens":10}' \
  http://localhost:11434/v1/completions

# List available models
ollama list

# Check config.yaml syntax
cat ~/.continue/config.yaml
```

---

## 📚 Additional Resources

- Continue Docs: https://docs.continue.dev
- Ollama Docs: https://ollama.ai
- VS Code Keybindings: https://code.visualstudio.com/docs/getstarted/keybindings

---

## 💡 Tips for Offline Use

1. **Pre-download models** when you have internet:
   ```bash
   ollama pull deepseek-coder-v2:16b
   ollama pull mistral:latest
   ollama pull neural-chat:latest
   ```

2. **Use smaller models** for faster responses:
   - `mistral:7b` - Fast and decent quality
   - `neural-chat:7b` - Optimized for chat
   - `deepseek-coder-v2:16b` - Best for code (slower)

3. **Optimize performance:**
   - Close other applications
   - Stop unneeded background services
   - Ensure Ollama can use all CPU cores

4. **Persist Ollama settings:**
   ```bash
   sudo systemctl enable ollama  # Auto-start on boot
   ```

---

## 🎯 Success Indicators

✅ **You'll know it's working when:**
- Continue panel opens with Ctrl+K
- You can ask "What does this code do?"
- The model responds within 5-30 seconds
- Syntax highlighting appears in the response
- You can select code and press Ctrl+K without errors

**If you see all these, you're fully set up!** 🎉
