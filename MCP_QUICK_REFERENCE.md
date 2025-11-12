# MCP + Models Quick Reference

## ⚡ Quick Start (30 seconds)

```bash
# 1. Download all models (takes time, can run in background)
/home/reza/Developer/AI/scripts/pull-models.sh &

# 2. Verify Ollama
ollama list

# 3. Verify Continue config is in place
cat ~/.continue/config.yaml | head -20

# 4. Close and reopen VS Code

# 5. In VS Code: Ctrl+K → Ask a question
```

---

## 🎮 Keyboard Shortcuts

| Action | Shortcut | What It Does |
|--------|----------|-------------|
| Open Continue | **Ctrl+K** | Open chat with MCP context |
| Generate Code | **Ctrl+Shift+K** | Generate at cursor |
| Autocomplete | **Tab** | AI suggestions while typing |

---

## 💬 Slash Commands (Type in Continue)

```
/explain    → Explain the code
/refactor   → Suggest improvements
/test       → Generate tests
/debug      → Find and fix bugs
/optimize   → Performance suggestions
/docs       → Generate documentation
```

---

## 🛠️ Custom Commands

```
full-audit   → Complete code review (bugs + security + performance)
git-explain  → What changed in this code (with git context)
test-debug   → Debug failing tests (runs tests automatically)
```

---

## 🧠 Model Selection

```
Fast (2–5 sec)      → starling-lm:7b, neural-chat:latest
Balanced (5–15 sec) → mistral:latest, codellama:13b
Best quality        → deepseek-coder-v2:16b
Deep reasoning      → dolphin-mixtral:latest
```

---

## 🔌 MCP Context Providers

| MCP Server | What It Gives Model | Example Use |
|-----------|-------------------|-------------|
| **Git** | Commits, diffs, branches | "Show me what changed" |
| **Filesystem** | Project files & structure | "Where is the DB logic?" |
| **Shell** | Test output & diagnostics | "Fix my failing tests" |

---

## 🧪 Test the Setup

1. Open any code file
2. Select some code
3. **Ctrl+K**
4. Ask: _"What files reference this function?"_
   - If Filesystem MCP works → model answers from codebase
5. Ask: _"Show me recent changes"_
   - If Git MCP works → model shows commit history

---

## 📊 System Status

```bash
# Check models installed
ollama list

# Check Ollama running
curl -s http://localhost:11434/v1/models | head -20

# Check Continue config
cat ~/.continue/config.yaml | grep "name:" | head -10

# Check Node.js (required for MCP)
node --version
npm --version
```

---

## 🆘 Quick Fixes

| Problem | Fix |
|---------|-----|
| Continue won't open | Close/reopen VS Code |
| No MCP context | Node.js installed? `node --version` |
| Models not listed | Run `ollama list` |
| Slow responses | Use smaller model (starling-lm:7b) |
| Config not loading | Check syntax: `cat ~/.continue/config.yaml` |

---

## 📚 Workflows

### Debug a Bug
```
1. Select buggy code
2. Ctrl+K
3. Say: "There's a bug here"
4. Model uses Git + Shell MCP to analyze
5. Get fix with full context
```

### Understand Code
```
1. Select confusing code
2. /explain
3. Model reads related files + git history
4. Get detailed explanation
```

### Refactor Safely
```
1. Select code
2. /refactor
3. Model checks all usages via Filesystem MCP
4. Get safe refactoring
```

---

## 🎯 Next Steps

1. **Pull models:** `./scripts/pull-models.sh` (in background)
2. **Restart VS Code** (close and reopen)
3. **Test:** Ctrl+K → Select code → Ask a question
4. **Explore:** Try different models and slash commands

---

**Status:** ✅ Full setup complete with MCP + 6 models
