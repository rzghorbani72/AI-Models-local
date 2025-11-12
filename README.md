# Offline AI Code Assistant for VS Code

Complete offline setup for **Continue** extension with local **Ollama** models. Works fully offline with JavaScript, React, Python, Node.js, and more.

---

## 🚀 Quick Start (5 minutes)

### 1. Install Prerequisites
```bash
# Install Ollama from https://ollama.ai
# Install Continue extension in VS Code (search "Continue")
```

### 2. Pull a Model
```bash
ollama pull deepseek-coder-v2:16b
```

### 3. Start Ollama
```bash
ollama serve
```

### 4. Close and Reopen VS Code

### 5. Test It
- Open any code file
- Press **Ctrl+K** (Windows/Linux) or **Cmd+K** (macOS)
- Ask: "What does this code do?"
- You should get a response ✅

---

## 📚 Documentation

| Guide | Purpose | Read Time |
|-------|---------|-----------|
| **[OFFLINE_AI_SETUP.md](OFFLINE_AI_SETUP.md)** | Complete setup guide for offline AI | 15 min |
| **[CONTINUE_QUICK_FIX.md](CONTINUE_QUICK_FIX.md)** | Quick reference & shortcuts | 2 min |
| **[CONTINUE_OFFLINE_TROUBLESHOOTING.md](CONTINUE_OFFLINE_TROUBLESHOOTING.md)** | Troubleshooting & advanced config | 10 min |
| **[docs/continue-ollama.md](docs/continue-ollama.md)** | Continue + Ollama setup details | 5 min |

---

## 🎮 Keyboard Shortcuts

| Action | Windows/Linux | macOS |
|--------|---------------|-------|
| Open Continue | **Ctrl+K** | **Cmd+K** |
| Generate Code | **Ctrl+Shift+K** | **Cmd+Shift+K** |
| Explain Code | **/explain** | **/explain** |
| Refactor | **/refactor** | **/refactor** |
| Generate Tests | **/test** | **/test** |

---

## 🔧 Verify Setup

```bash
# Check Ollama is running
curl -s http://localhost:11434/v1/models

# Check model is available
ollama list

# Run diagnostic
./scripts/ping-ollama.sh
```

---

## ❓ Troubleshooting

**Continue panel won't open?**
- Close VS Code completely and reopen it

**No response from model?**
- Check Ollama: `curl http://localhost:11434/v1/models`
- Start Ollama: `ollama serve`

**Model not found?**
- Pull it: `ollama pull deepseek-coder-v2:16b`

**Very slow responses?**
- Use smaller model: `ollama pull mistral:latest`
- Edit `~/.continue/config.yaml` and change model name

**→ See [CONTINUE_OFFLINE_TROUBLESHOOTING.md](CONTINUE_OFFLINE_TROUBLESHOOTING.md) for more help**

---

## 📋 Configuration

Continue reads from: `~/.continue/config.yaml`

Default setup includes:
- Model: `deepseek-coder-v2:16b`
- Provider: Ollama (localhost:11434)
- Tab autocomplete enabled
- Slash commands configured

---

## ✅ Features

✅ **100% Offline** - Runs locally, no internet needed
✅ **Fast** - Local inference, no API calls
✅ **Secure** - All data stays on your machine
✅ **Multi-Language** - JavaScript, Python, TypeScript, and more
✅ **Free** - Open source and no subscriptions

---

## 🎯 Common Workflows

### Explain Code
```
1. Select code
2. Press Ctrl+K
3. Type: "Explain this code"
4. Get explanation
```

### Generate Tests
```
1. Select function/class
2. Press Ctrl+K
3. Type: /test
4. Get test suggestions
```

### Refactor
```
1. Select code
2. Press Ctrl+K
3. Type: /refactor
4. Get refactoring suggestions
```

---

## 📦 What's Included

```
.
├── README.md                                    ← You are here
├── OFFLINE_AI_SETUP.md                          ← Main setup guide
├── CONTINUE_QUICK_FIX.md                        ← Quick reference
├── CONTINUE_OFFLINE_TROUBLESHOOTING.md          ← Troubleshooting
├── docs/
│   └── continue-ollama.md                       ← Setup details
├── scripts/
│   ├── ping-ollama.sh                           ← Verify connection
│   └── ... (utility scripts)
└── .vscode/
    └── settings.json                            ← Workspace config
```

---

## 🔗 Resources

- **Continue Docs:** https://docs.continue.dev
- **Ollama:** https://ollama.ai
- **VS Code:** https://code.visualstudio.com

---

## 🚀 Get Started

1. Read: [OFFLINE_AI_SETUP.md](OFFLINE_AI_SETUP.md)
2. Follow the quick start steps above
3. Start coding with AI assistance!

**Happy coding!** 🎉
