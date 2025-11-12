# Full-Stack Debugging Setup Checklist

## ✅ Phase 1: Configuration (COMPLETE)

- [x] Created MCP server configuration (Git, Filesystem, Shell)
- [x] Updated Continue config.yaml with all MCP tools
- [x] Added 6 LLM models to Continue config
- [x] Configured 6 slash commands + 3 custom commands
- [x] Set up tab autocomplete (starling-lm:7b)
- [x] Verified Node.js installed (v22.18.0) ✅ MCP requires this
- [x] Created comprehensive documentation (MCP_AND_MODELS_SETUP.md)
- [x] Created quick reference (MCP_QUICK_REFERENCE.md)

**Status:** ✅ Configuration is READY

---

## ⏳ Phase 2: Download Models (NEXT)

Choose one of these options:

### Option A: Download All Models (Recommended)
```bash
# Run in terminal (takes 30–60 min, ~35–50 GB)
/home/reza/Developer/AI/scripts/pull-models.sh

# Or run in background
/home/reza/Developer/AI/scripts/pull-models.sh &
```

**Models to download:**
- [ ] deepseek-coder-v2:16b (12 GB) - Primary
- [ ] dolphin-mixtral:latest (40 GB or 13 GB for 8b version) - Reasoning
- [ ] codellama:13b (7.3 GB) - Code specialist
- [ ] starling-lm:7b (4.1 GB) - Fast JS/TS
- [ ] mistral:latest (4 GB) - General purpose
- [ ] neural-chat:latest (3.8 GB) - Lightweight

### Option B: Download Only Essential Models (Faster)
```bash
# Fast setup: only pull smaller, fast models
ollama pull starling-lm:7b
ollama pull mistral:latest
ollama pull neural-chat:latest
```

### Option C: Download One Model at a Time
```bash
# Download one, test, then download more
ollama pull deepseek-coder-v2:16b

# Check progress
ollama list
```

---

## 🧪 Phase 3: Verification (AFTER Models Downloaded)

### Step 1: Verify Models
```bash
# List all downloaded models
ollama list

# Expected: All models you pulled should be listed
```

### Step 2: Verify Continue Config
```bash
# Check MCP servers are configured
cat ~/.continue/config.yaml | grep "name:" | head -10

# Expected: 6 models + 3 MCP servers listed
```

### Step 3: Verify Ollama is Running
```bash
# Check Ollama service
ollama list

# Or test endpoint
curl -s http://localhost:11434/v1/models | head -20
```

**Checkboxes:**
- [ ] Models downloaded and listed with `ollama list`
- [ ] Continue config has all 6 models
- [ ] Ollama is running and responding
- [ ] Node.js available: `node --version` (already verified ✅)

---

## 🎯 Phase 4: Test the Full Setup

### Step 1: Restart VS Code
```bash
# Close VS Code completely (not minimize)
# Reopen VS Code
# (This loads the new config)
```

### Step 2: Test Basic Continue
1. Open any code file (JS, Python, etc.)
2. Select some code
3. Press **Ctrl+K** (Windows/Linux) or **Cmd+K** (macOS)
4. Continue panel should open on the right
5. Ask: *"What does this code do?"*
6. Model should respond with explanation

**Checklist:**
- [ ] Continue panel opens with Ctrl+K
- [ ] Model name is shown in the panel
- [ ] Can type a question
- [ ] Get a response within 10–30 seconds
- [ ] Response is relevant to the code

### Step 3: Test MCP Context

#### Test Git MCP
1. Select some code from a file tracked in git
2. Ask: *"What changed in this code recently?"*
3. Model should show git commit history + explanation

#### Test Filesystem MCP
1. Select any code
2. Ask: *"What files import this function?"*
3. Model should search your project and answer

#### Test Shell MCP
1. Select a test file
2. Ask: *"Run my tests and tell me what's failing"*
3. Model should run tests and show output

**Checklist:**
- [ ] Git MCP: Model can read commit history
- [ ] Filesystem MCP: Model can browse project files
- [ ] Shell MCP: Model can run and show test output

### Step 4: Test Slash Commands

Try each one:
```
/explain    → Select code, use command
/refactor   → Select code, use command
/test       → Select code, use command
/debug      → Select code, use command
/optimize   → Select code, use command
/docs       → Select code, use command
```

**Checklist:**
- [ ] /explain works
- [ ] /refactor works
- [ ] /test works
- [ ] /debug works
- [ ] /optimize works
- [ ] /docs works

---

## 📊 Final Status

### Current Status (as of now)
```
✅ Configuration        : COMPLETE (MCP + models configured)
✅ Node.js             : AVAILABLE (v22.18.0)
⏳ Models downloaded   : PENDING (run pull-models.sh)
⏳ MCP servers tested  : PENDING (after models)
⏳ Full system tested  : PENDING (after verification)
```

### Next Action
**Run this command to download all models:**
```bash
/home/reza/Developer/AI/scripts/pull-models.sh
```

Or see options above for faster/custom downloads.

---

## 📚 Documentation

**Quick Start (5 min):**
- MCP_QUICK_REFERENCE.md

**Full Guide (15 min):**
- MCP_AND_MODELS_SETUP.md

**Troubleshooting:**
- See MCP_AND_MODELS_SETUP.md → "Troubleshooting" section
- Or run: `cat ~/.continue/config.yaml | head -50`

---

## 🚀 Summary

### What You Have Now:
- ✅ MCP servers configured and ready (Git, Filesystem, Shell)
- ✅ 6 LLM models configured in Continue
- ✅ 6 slash commands + 3 advanced custom commands
- ✅ Tab autocomplete enabled
- ✅ Full documentation and guides
- ✅ Node.js available for MCP operation

### What's Next:
1. **Download models** (30–60 min, optional download size check first)
2. **Restart VS Code** (2 min)
3. **Test the setup** (5 min)
4. **Start debugging** (infinite expertise!)

---

## ⚡ Quick Commands Reference

```bash
# Check system ready
node --version              # ✅ v22.18.0 (already verified)
npm --version              # ✅ 11.5.2 (already verified)

# Download models
/home/reza/Developer/AI/scripts/pull-models.sh

# Check models
ollama list

# Verify Continue config
cat ~/.continue/config.yaml | grep -A 2 "tools:"

# Test Ollama
curl -s http://localhost:11434/v1/models | head -20
```

---

**Ready to download models? Run:** `/home/reza/Developer/AI/scripts/pull-models.sh`

**Questions? See:** `MCP_AND_MODELS_SETUP.md`
