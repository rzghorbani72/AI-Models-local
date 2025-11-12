# Complete Offline AI Code Assistant Setup for VS Code

A step-by-step guide to set up a fully offline code assistant in VS Code using Ollama and Continue extension. Supports JavaScript, React, Next.js, Python, Node.js, NestJS, PostgreSQL, and databases.

---

## 📋 Prerequisites

- **VS Code** (latest version)
- **Ollama** installed and running on your machine
- **Continue extension** for VS Code
- One or more code-optimized LLMs pulled in Ollama

---

## 🚀 QUICK START (5 minutes)

### Step 1: Install Continue Extension
1. Open VS Code
2. Go to **Extensions** (Ctrl+Shift+X / Cmd+Shift+X)
3. Search for **"Continue"** (by Continue.dev)
4. Click **Install**

### Step 2: Ensure Ollama is Running
```bash
# Start Ollama (if not running in background)
ollama serve
```

Or check if Ollama is accessible:
```bash
# From repo root:
./scripts/ping-ollama.sh
```

Expected output: HTTP status codes should show 200 for at least one endpoint.

### Step 3: Pull a Code Model (Choose One)
Pull at least one model optimized for coding:

```bash
# Recommended for general coding (balanced speed/quality)
ollama pull deepseek-coder-v2:16b

# Or smaller alternative (faster)
ollama pull neural-chat:latest

# Or larger model (better quality, slower)
ollama pull dolphin-mixtral:latest

# For JavaScript/React/TypeScript
ollama pull starling-lm:7b

# For Python
ollama pull mistral:latest

# For code specific tasks
ollama pull codellama:13b
```

### Step 4: VS Code Auto-Configuration
This workspace comes pre-configured with:
- **Continue URL**: `http://localhost:11434`
- **Default Model**: `deepseek-coder-v2:16b`
- **Settings Location**: `.vscode/settings.json`

**No manual configuration needed!** The workspace settings will be applied automatically.

### Step 5: Verify Setup
1. Open any code file in this workspace
2. Highlight some code
3. Press **Ctrl+K** (Windows/Linux) or **Cmd+K** (Mac) → Continue should open on the right
4. Ask: *"What does this code do?"*
5. If you get a response → ✅ **Setup complete!**

---

## 🔧 DETAILED SETUP GUIDE

### A. Install Ollama

#### macOS
```bash
# Using Homebrew
brew install ollama

# Or download from: https://ollama.ai/download
```

#### Linux (Ubuntu/Debian)
```bash
curl -fsSL https://ollama.ai/install.sh | sh

# Start Ollama service
sudo systemctl start ollama
sudo systemctl enable ollama  # Auto-start on boot
```

#### Windows
- Download installer: https://ollama.ai/download
- Run the installer
- Ollama will start automatically

### B. Verify Ollama Installation
```bash
ollama --version

# Check if service is running
curl http://localhost:11434/api/tags

# You should get JSON back with installed models
```

### C. Pull Models for Your Use Cases

#### For **JavaScript/React/Next.js** Development
```bash
# Best for TypeScript/JavaScript
ollama pull deepseek-coder-v2:16b    # Current default
ollama pull neural-chat:latest        # Lightweight alternative
```

#### For **Python** Development
```bash
ollama pull mistral:latest            # General purpose
ollama pull dolphin-mixtral:latest    # Better for complex problems
```

#### For **Node.js/NestJS** Development
```bash
ollama pull starling-lm:7b            # Node.js specialized
ollama pull codellama:13b             # Code-specific model
```

#### For **Database/SQL** Work
```bash
ollama pull neural-chat:latest        # Good SQL generation
ollama pull mistral:latest            # Reliable SQL queries
```

#### For **Full Stack** Development (Recommended Setup)
```bash
# Pull these 2-3 models for all your needs:
ollama pull deepseek-coder-v2:16b     # Main coding model
ollama pull mistral:latest            # Quick responses, SQL queries
ollama pull dolphin-mixtral:latest    # Complex reasoning (optional)
```

### D. Install Continue Extension

1. **Open VS Code**
2. **Extensions panel** → Ctrl+Shift+X
3. **Search** for "Continue"
4. **Install** the Continue extension (by continue.dev)
5. **Reload** VS Code

### E. Configure Workspace Settings

The workspace is **already configured** in `.vscode/settings.json`:

```json
{
  "continue.customModelUrl": "http://localhost:11434",
  "continue.customModel": "deepseek-coder-v2:16b"
}
```

**To switch models**, edit `.vscode/settings.json` and change the `continue.customModel` value:

```json
"continue.customModel": "mistral:latest"        // Switch to Mistral
"continue.customModel": "dolphin-mixtral:latest" // Switch to Dolphin
"continue.customModel": "codellama:13b"         // Switch to CodeLlama
```

---

## 💡 HOW TO USE OFFLINE AI ASSISTANT

### Basic Usage

#### In VS Code:
1. **Highlight** code or write a comment/question
2. **Press** Ctrl+K (Windows/Linux) or Cmd+K (Mac)
3. **Type** your prompt or question
4. **Press Enter** → Continue makes a request to your local Ollama model

#### Example Prompts:
```javascript
// Highlight this function, press Ctrl+K, then ask:
// "Refactor this to use async/await"
// "Add error handling"
// "Write unit tests for this"
// "Optimize performance"
```

```python
# Ask your offline AI:
# "Convert this to use list comprehension"
# "Add type hints"
# "Suggest a better variable name"
```

### Advanced Features

#### Generate Code
```
// Open a blank file, Ctrl+K, ask:
// "Create a React component for a login form"
// "Write a NestJS controller for users"
// "Write a Python function to connect to PostgreSQL"
```

#### Explain Code
```
// Highlight any code, Ctrl+K, ask:
// "What does this SQL query do?"
// "Explain this regex pattern"
// "Why might this be slow?"
```

#### Fix Issues
```
// Highlight code with error, Ctrl+K, ask:
// "Fix this bug"
// "This is throwing a TypeError, help"
// "Why is this not working?"
```

#### Refactor
```
// "Make this more readable"
// "Follow Next.js best practices"
// "Optimize for performance"
// "Add better error handling"
```

---

## 📊 RECOMMENDED MODELS FOR YOUR TECH STACK

| Use Case | Recommended Model | Speed | Quality | Size |
|----------|------------------|-------|---------|------|
| **JavaScript/React/Next.js** | deepseek-coder-v2:16b | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 10GB |
| **Python** | mistral:latest | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 4GB |
| **Node.js/NestJS** | starling-lm:7b | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | 5GB |
| **SQL/Databases** | neural-chat:latest | ⭐⭐⭐⭐ | ⭐⭐⭐ | 4GB |
| **Full Stack** (all) | deepseek + mistral | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 14GB |
| **Quick Testing** | neural-chat:latest | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | 4GB |

---

## 🔄 WORKFLOW: Using Offline AI Each Time

### Workflow A: Code Writing
```
1. Start coding your feature
2. When stuck, highlight relevant code → Ctrl+K
3. Ask: "How should I structure this?"
4. Get suggestions from offline model
5. Implement → Test → Iterate
```

### Workflow B: Debugging
```
1. See an error message
2. Copy error message → Create a prompt
3. Highlight the problematic code → Ctrl+K
4. Ask: "Why is this failing? How to fix?"
5. Get debugging help from offline model
6. Apply fix → Retest
```

### Workflow C: Code Review (Offline)
```
1. Review your own code before commit
2. Highlight each function → Ctrl+K
3. Ask: "Is this optimized?"
4. Ask: "Does this follow best practices?"
5. Get feedback → Refactor
6. Commit improved code
```

### Workflow D: Learning New Patterns
```
1. New framework or library needed
2. Ask offline AI: "Show me a Next.js middleware example"
3. Ask: "How do I set up PostgreSQL with NestJS?"
4. Get examples from offline model (privacy!)
5. Adapt to your use case
```

---

## 🛠️ TROUBLESHOOTING

### Continue shows no response
1. **Check Ollama is running:**
   ```bash
   curl http://localhost:11434/api/tags
   ```
   Should return JSON with model list.

2. **Verify model is loaded:**
   ```bash
   ollama list
   ```
   Should show your models. If not installed:
   ```bash
   ollama pull deepseek-coder-v2:16b
   ```

3. **Check port 11434 is not blocked:**
   ```bash
   netstat -tuln | grep 11434
   ```

4. **Run diagnostic script:**
   ```bash
   ./scripts/ping-ollama.sh
   ```

### Model is too slow
- Try a smaller model: `neural-chat:latest` or `mistral:latest`
- Check system resources: `free -h` (Linux/Mac) or Task Manager (Windows)
- Reduce `max_tokens` in Continue settings if supported

### Model gives poor responses
- Try a larger model: `dolphin-mixtral:latest`
- Ask more specific questions
- Provide more context in your prompt

### VS Code doesn't use custom model URL
1. Check `.vscode/settings.json` exists
2. Verify JSON syntax is correct (use JSON Validator)
3. Close and reopen VS Code
4. Check Settings (Workspace) → search "continue.customModelUrl"

### Ollama won't start
- **Linux**: Check service status: `sudo systemctl status ollama`
- **macOS**: Restart Ollama.app
- **Windows**: Check if port 11434 is in use
- **All**: Try: `ollama serve --debug`

---

## 📈 PERFORMANCE OPTIMIZATION

### Increase Response Speed
```bash
# Use smaller models for quick iterations
ollama pull neural-chat:latest        # 4GB, very fast
ollama pull mistral:latest            # Balanced

# Switch in VS Code settings:
# "continue.customModel": "neural-chat:latest"
```

### Improve Response Quality
```bash
# Use larger models for complex tasks
ollama pull dolphin-mixtral:latest    # 26GB, better reasoning
ollama pull deepseek-coder-v2:16b     # 10GB, best for coding
```

### Manage Disk Space
```bash
# List all models
ollama list

# Remove unused model
ollama rm model-name

# Example:
ollama rm neural-chat:latest
```

### Monitor Resource Usage
```bash
# Linux/Mac: Watch Ollama memory usage
watch -n 1 'ps aux | grep ollama'

# Windows: Use Task Manager
# Watch: "ollama.exe" in Processes tab
```

---

## 🔐 SECURITY & PRIVACY

✅ **Advantages of Local/Offline AI:**
- ✅ **No data sent to cloud** → 100% privacy
- ✅ **No API costs** → Unlimited requests
- ✅ **No internet required** → Work anywhere
- ✅ **No rate limits** → Use as much as needed
- ✅ **Fully customizable** → Control everything

⚠️ **Keep Ollama Local:**
- ✅ By default: `localhost:11434` (only your machine)
- ❌ Don't expose port 11434 to the internet
- ❌ If needed for team: Use VPN + firewall

---

## 📚 USEFUL RESOURCES

- **Ollama Homepage**: https://ollama.ai
- **Continue Documentation**: https://continue.dev/docs
- **Model Library**: https://ollama.ai/library
- **GitHub Repo**: https://github.com/ollama/ollama

---

## 📝 QUICK REFERENCE

### Essential Commands
```bash
# Start Ollama
ollama serve

# Pull a model
ollama pull model-name

# List models
ollama list

# Run a model in CLI
ollama run deepseek-coder-v2:16b

# Test connection
./scripts/ping-ollama.sh
```

### VS Code Shortcuts
| Action | Shortcut |
|--------|----------|
| Open Continue | Ctrl+K (Windows/Linux) or Cmd+K (Mac) |
| Submit prompt | Enter |
| Clear chat | Ctrl+L |
| Open settings | Ctrl+, |

---

## ✨ NEXT STEPS

1. **✅ Install Ollama** → `ollama serve`
2. **✅ Install Continue** → Search in VS Code Extensions
3. **✅ Pull a model** → `ollama pull deepseek-coder-v2:16b`
4. **✅ Test it** → Open a `.js`, `.py`, or `.sql` file, press Ctrl+K
5. **✅ Use it daily** → Make it part of your workflow!

---

## 🎯 COMMON FIRST TASKS

After setup is complete, try these:

### Test 1: Simple Code Question
```javascript
// Create a new file, paste this:
function add(a, b) {
  return a + b;
}

// Highlight it, Ctrl+K, ask: "What does this function do?"
// Expected: Quick explanation (proves offline AI works)
```

### Test 2: Generate Code
```
// Ctrl+K, ask: "Write a React component that displays a counter"
// Expected: Full React component code
```

### Test 3: Python Help
```
# Create a Python file:
# Ctrl+K, ask: "How do I connect to PostgreSQL in Python?"
# Expected: Code example with psycopg2 or similar
```

### Test 4: SQL Query Help
```sql
-- Create a SQL file:
-- Ctrl+K, ask: "Write a query to find users created in the last 30 days"
-- Expected: SQL SELECT statement
```

---

## 💬 SUPPORT & FEEDBACK

If you encounter issues:
1. Run diagnostic: `./scripts/ping-ollama.sh`
2. Check Ollama is running: `ollama list`
3. Verify VS Code has Continue extension installed
4. Check `.vscode/settings.json` syntax

---

**Happy coding offline!** 🚀

Created: 2025-11-11
Version: 1.0
