# Full-Stack AI Debugging with Models + MCP Servers

**Expert-level offline debugging setup combining local LLMs + Model Context Protocol servers.**

---

## 📊 Architecture Overview

Your setup consists of **two layers:**

### Layer 1: LLM Models (The Brain)
```
Ollama (Local Model Server)
├── deepseek-coder-v2:16b      [Primary - Balanced quality/speed]
├── dolphin-mixtral:latest     [High-reasoning, deep analysis]
├── codellama:13b              [Code-specific, detailed]
├── starling-lm:7b             [Fast JS/TS specialist]
├── mistral:latest             [General-purpose, versatile]
└── neural-chat:latest         [Lightweight, quick responses]
```

### Layer 2: MCP Servers (The Tools)
```
MCP Servers (Context Providers)
├── Git MCP          [reads commits, diffs, branches]
├── Filesystem MCP   [browses and reads project files]
└── Shell/Bash MCP   [runs tests, captures output, diagnostics]
```

### How They Work Together
```
User selects code in VS Code
       ↓
Continue extension (Ctrl+K)
       ↓
┌──────────────────────────────┐
│   MCP Servers gather context │
├──────────────────────────────┤
│ • Git: Recent changes        │
│ • Filesystem: Project layout │
│ • Shell: Test results        │
└──────────────────────────────┘
       ↓
   LLM receives enriched context
       ↓
   Model generates expert response
       ↓
Response displayed in Continue panel
```

---

## 🚀 Setup (3 Steps)

### Step 1: Verify Node.js (Required for MCP Servers)

MCP servers run via Node.js. Check if it's installed:
```bash
node --version
npm --version
```

If not installed, download from https://nodejs.org/ (LTS recommended).

### Step 2: Download All Models

This pulls 6 models optimized for full-stack debugging. **Total: ~35–50 GB depending on which get cached.**

```bash
/home/reza/Developer/AI/scripts/pull-models.sh
```

Or pull individually:
```bash
ollama pull deepseek-coder-v2:16b   # Primary (12 GB)
ollama pull dolphin-mixtral:latest  # Reasoning (40 GB, or pull the 8b variant)
ollama pull codellama:13b           # Code-focused (7.3 GB)
ollama pull starling-lm:7b          # Fast JS/TS (4.1 GB)
ollama pull mistral:latest          # General (4 GB)
ollama pull neural-chat:latest      # Lightweight (3.8 GB)
```

Verify:
```bash
ollama list
```

### Step 3: Restart VS Code

```bash
# Close VS Code completely (not minimize)
# Reopen VS Code
```

Continue will automatically load the new config with MCP servers.

---

## 🎮 Using the Full-Stack Setup

### Basic Usage: Explain Code

1. Select code in your editor
2. Press **Ctrl+K** (or **Cmd+K** on macOS)
3. The Continue panel opens with MCP context loaded
4. Ask: *"Explain this code"*
5. Model responds with full context from Git, Filesystem, and Shell

### Advanced Usage: Debug with Full Context

#### Example 1: Debug a failing API
```
You select the API route handler code
You type: "Debug this - why is it failing?"

What happens:
- Git MCP shows recent changes to this file
- Filesystem MCP loads dependencies (package.json, imports)
- Shell MCP runs `npm test` to see error output
- Model analyzes all three contexts and says:
  "You removed the error handler in commit abc123,
   but the new dependency X requires it. Here's the fix:"
```

#### Example 2: Refactor with Safety
```
You select a database query function
You use slash command: /refactor

What happens:
- Git MCP shows what code depends on this function
- Filesystem MCP reads other files using this function
- Model provides refactoring that won't break dependents
```

#### Example 3: Generate Tests
```
You select a complex utility function
You use slash command: /test

What happens:
- Model reads the function logic
- Shell MCP can check existing test patterns
- Model generates tests that fit your codebase style
```

---

## 📋 Available Slash Commands

| Command | Purpose | Uses MCP? |
|---------|---------|-----------|
| **/explain** | Explain selected code | ✅ All 3 (context) |
| **/refactor** | Suggest improvements | ✅ Git, Filesystem |
| **/test** | Generate test code | ✅ Shell (check tests) |
| **/debug** | Find bugs and fix suggestions | ✅ All 3 |
| **/optimize** | Performance improvements | ✅ Git (history) |
| **/docs** | Generate documentation | ✅ Filesystem (patterns) |

---

## 🔧 Advanced Features

### Custom Commands (Auto-configured)

The config includes 3 pre-built custom commands:

#### 1. **full-audit**
Comprehensive code review in one command.
```
Use: Select code → Ctrl+K → "full-audit"
Does: Bug check + security scan + performance + patterns
Uses: All MCP servers + deep model reasoning
```

#### 2. **git-explain**
Understand what changed and why.
```
Use: Select code → Ctrl+K → "git-explain"
Does: Shows git diff + explains changes + side effects
Uses: Git MCP + model analysis
```

#### 3. **test-debug**
Fix failing tests automatically.
```
Use: Select test code → Ctrl+K → "test-debug"
Does: Runs tests + analyzes failures + provides fixes
Uses: Shell MCP + model reasoning
```

### Switching Models

Continue shows a model dropdown in the panel. Click to switch between:
- **Primary task:** deepseek-coder-v2 (best quality)
- **Complex reasoning:** dolphin-mixtral (slower but thorough)
- **Quick answers:** starling-lm:7b or neural-chat (fast)

### Enabling Tab Autocomplete

Press Tab while typing → Continue suggests completions based on the model.

Configured to use **starling-lm:7b** (fast, responsive).

---

## 🧪 Verification

### Check Ollama Models
```bash
ollama list
# Output should show all 6 models
```

### Check MCP Config
```bash
cat ~/.continue/config.yaml | grep -A 10 "tools:"
# Output should show git, filesystem, shell MCP entries
```

### Test Continue + MCP
1. Open any code file in your project
2. Select some code
3. Press Ctrl+K
4. Ask: *"What files import this function?"*
   - If Filesystem MCP works, model will read your project structure
5. Ask: *"Show me recent changes to this code"*
   - If Git MCP works, model will show commit history

---

## 🌐 MCP Servers Deep Dive

### Git MCP — Understand Code Changes

**What it does:**
- Reads git commit history
- Shows diffs between versions
- Lists branches and remotes
- Understands merge conflicts

**Example request to model:**
```
"Explain this function and what changed in the last 3 commits"
→ Model uses Git MCP to fetch diffs
→ Model explains: "This was refactored to use async/await in commit X,
                   which fixed the timeout bug from commit Y"
```

**Requires:** Git repository initialized in your project (`git init` or `git clone`)

### Filesystem MCP — Project Context

**What it does:**
- Lists directory structure
- Reads file contents
- Gets file metadata (size, modified date)
- Searches for files by pattern

**Example request to model:**
```
"Where is the database connection logic and how is it used?"
→ Model uses Filesystem MCP to:
  • Find db connection files
  • Read imports/references
  • Trace usage through codebase
→ Model shows you the full context
```

**Configured root:** `/home/reza/Developer` (you can change this in config)

### Shell MCP — Run Tests & Commands

**What it does:**
- Runs npm scripts, pytest, etc.
- Captures command output
- Reports errors and exit codes
- Helps model understand test failures

**Allowed commands (safe list):**
```
npm test, npm run, python -m pytest, pytest
npm run build, npm run dev, npm run lint
git, curl, grep, find, head, tail
```

**Example request to model:**
```
"My tests are failing. Fix them."
→ Model uses Shell MCP to run: npm test
→ Model reads output and failures
→ Model provides corrected code
```

---

## ⚙️ Configuration Files

### Main Config: `~/.continue/config.yaml`

Located in your home directory. Contains:
- ✅ All 6 models with system prompts
- ✅ Tab autocomplete settings
- ✅ 3 MCP servers (Git, Filesystem, Shell)
- ✅ 6 slash commands
- ✅ 3 custom commands
- ✅ Embeddings provider

### Pull Script: `/home/reza/Developer/AI/scripts/pull-models.sh`

Downloads all models. Modify the `MODELS` array to customize.

---

## 🎯 Common Workflows

### Workflow 1: Debug a Bug (5 min)
```
1. Open the buggy file
2. Select the relevant function/section
3. Ctrl+K → "I think there's a bug here"
4. Model uses Git MCP to see recent changes
5. Model uses Shell MCP to check test results
6. Model suggests the fix
7. Apply the suggestion
```

### Workflow 2: Understand a Module (10 min)
```
1. Select a module you don't understand
2. Ctrl+K → /explain
3. Model uses Filesystem MCP to read related files
4. Model reads package.json to understand dependencies
5. Model provides full explanation
```

### Workflow 3: Refactor Safely (15 min)
```
1. Select code to refactor
2. Ctrl+K → /refactor
3. Model uses Git MCP to see usage history
4. Model uses Filesystem MCP to find all imports
5. Model generates refactoring that won't break anything
6. Apply and run tests (Shell MCP automates this)
```

---

## 🚨 Troubleshooting

### Issue: MCP Servers Not Loading

**Check:**
```bash
# 1. Node.js installed?
node --version

# 2. Config syntax valid?
cat ~/.continue/config.yaml | head -50

# 3. Restart Continue
#    Close VS Code, reopen
```

### Issue: Model Responds But No MCP Context

**Check:**
```bash
# 1. Is the disabled flag set to false?
grep -A 2 "disabled:" ~/.continue/config.yaml

# 2. Are npx packages available?
npx --version

# 3. Manual test:
npx @modelcontextprotocol/server-git --help
```

### Issue: Shell MCP Won't Run Commands

**Check:**
```bash
# 1. Is the command in the allowedCommands list?
grep -A 10 "allowedCommands:" ~/.continue/config.yaml

# 2. Does the command exist?
npm --version  # for npm commands
pytest --version  # for pytest
```

### Issue: Models Are Slow

**Solutions:**
1. Use smaller model: switch to `starling-lm:7b` or `neural-chat:latest`
2. Reduce context: Edit config, lower `contextLength` from 8000 to 4000
3. Free up RAM: Close other apps
4. Use GPU: If available, configure Ollama to use GPU (increases speed 5–10x)

---

## 📚 Model Selection Guide

| Task | Recommended Model | Why |
|------|-------------------|-----|
| **Quick explanations** | starling-lm:7b or neural-chat | Fast (~2–5 sec) |
| **Deep debugging** | deepseek-coder-v2:16b | High quality (~10–30 sec) |
| **Complex reasoning** | dolphin-mixtral:latest | Thorough analysis (~30–60 sec) |
| **General tasks** | mistral:latest | Good balance |
| **Code generation** | codellama:13b | Specialized for code |
| **Tab autocomplete** | starling-lm:7b | Must be fast |

---

## 🔗 Resources

- **Continue Docs:** https://docs.continue.dev
- **Ollama:** https://ollama.ai
- **MCP Protocol:** https://modelcontextprotocol.io
- **Node.js:** https://nodejs.org/

---

## ✅ You're Ready!

Your setup is complete with:
- ✅ 6 optimized models for full-stack debugging
- ✅ 3 MCP servers providing context (Git, Filesystem, Shell)
- ✅ 6 slash commands + 3 custom commands
- ✅ Tab autocomplete enabled
- ✅ Full offline, zero external APIs

**Start debugging:** Ctrl+K → Select code → Ask questions → Get expert responses with full context.

**Happy debugging!** 🚀
