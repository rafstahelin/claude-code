# Claude Code for RunPod

This repository provides scripts and documentation for installing and using Claude Code in RunPod environments. The installation is specifically optimized for persistence across container restarts by utilizing RunPod's persistent `/workspace` volume.

## Quick Install

```bash
git clone https://github.com/rafstahelin/claude-code
cd claude-code
chmod +x install.sh
./install.sh
source ~/.bashrc
```

The installation script:
1. Creates a persistent Claude Code environment in `/workspace/.claude-code`
2. Configures Node.js and npm correctly
3. Sets up environment variables through `.bashrc`
4. Adds ML-specific ignore patterns for large directories
5. Creates a startup script at `/workspace/start_claude.sh`

## Startup Commands

After RunPod initialization (or container restart):

```bash
/workspace/start_claude.sh
claude
```

Verify installation:
```bash
claude --version
```

## Essential Commands

| Command | Description |
|---------|-------------|
| `claude` | Start interactive terminal |
| `claude "query"` | Start with initial query |
| `claude -p "query"` | Run one-off query (non-interactive) |
| `/help` | Show all available commands |
| `/exit` or `/quit` | Exit Claude Code |
| `/clear` | Clear conversation history |
| `/cost` | Show token usage statistics |

## Memory Management

| Command | Description |
|---------|-------------|
| `/memory` | Edit CLAUDE.md memory files |
| `/init` | Initialize project with CLAUDE.md guide |
| `# Text` | Quickly add to memory (start message with #) |
| `/compact` | Compact conversation to save tokens |

## GitHub Operations

| Task | Example |
|------|---------|
| Create branch | `create a new feature branch named feature/post-process-bundle` |
| Check files | `examine easy/classes/validation_grid.py` |
| Create PR | `create a PR from feature/command-cleanup to main` |
| Find code | `find implementations of the two-step UI pattern` |

## Configuration

| Command | Description |
|---------|-------------|
| `claude config` | View/modify configuration |
| `claude config list` | List all settings |
| `claude config set key value` | Change a setting |
| `claude config add key value` | Add to a list setting |
| `claude config set ignorePatterns []` | Clear ignore patterns |
| `claude config add ignorePatterns "path/**"` | Add ignore pattern |

## ML-Specific Optimizations

The installation comes pre-configured with ignore patterns for common ML directories:

```
ComfyUI/output/**
ComfyUI/input/**
**/venv/**
**/node_modules/**
**/.git/**
**/models/**
**/weights/**
**/checkpoints/**
```

These patterns help Claude Code avoid scanning large files/directories that are common in ML workloads, improving performance and reducing token usage.

## Performance Tips for RunPod

1. **Add More Ignore Patterns** if needed:
   ```
   claude config add ignorePatterns "path/to/large/directory/**"
   ```

2. **Focus on Specific Directories**:
   ```
   cd /workspace/your-project
   ```

3. **Use Compact Mode** for long sessions:
   ```
   /compact
   ```

4. **Set up CLAUDE.md** with repository context:
   ```
   /init
   ```

## Uninstallation

To uninstall Claude Code:

```bash
./uninstall.sh
```

## Troubleshooting

1. **Command not found**:
   ```bash
   source /workspace/.claude-code/setup.sh
   ```

2. **Session timeout**:
   ```bash
   claude
   ```

3. **Low token balance**:
   Check balance at https://console.anthropic.com/settings/billing

4. **Scan taking too long**:
   Press `Esc` to interrupt
