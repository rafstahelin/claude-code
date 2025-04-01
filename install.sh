#!/bin/bash
# Claude Code Persistent Installation Script for RunPod

set -e  # Exit on any error
LOG_FILE="/workspace/claude-install.log"
INSTALL_DIR="/workspace/.claude-code"
mkdir -p $INSTALL_DIR

echo "Starting Claude Code installation at $(date)" > $LOG_FILE
echo "Installation directory: $INSTALL_DIR" >> $LOG_FILE

# Check Node.js version
NODE_VERSION=$(node -v)
echo "Node.js version: $NODE_VERSION" >> $LOG_FILE
if [[ "${NODE_VERSION:1:2}" -lt 18 ]]; then
  echo "Upgrading Node.js to v18+" >> $LOG_FILE
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash - >> $LOG_FILE 2>&1
  apt-get update >> $LOG_FILE 2>&1
  apt-get install -y nodejs >> $LOG_FILE 2>&1
  NODE_VERSION=$(node -v)
  echo "Node.js upgraded to: $NODE_VERSION" >> $LOG_FILE
fi

# Set up persistent npm directory in workspace
echo "Setting up persistent npm directory in workspace" >> $LOG_FILE
mkdir -p $INSTALL_DIR/npm-global
npm config set prefix $INSTALL_DIR/npm-global >> $LOG_FILE 2>&1

# Create a setup script that will be sourced on each startup
cat > $INSTALL_DIR/setup.sh << 'EOF'
#!/bin/bash
# Claude Code environment setup script
CLAUDE_DIR="/workspace/.claude-code"
export PATH="$CLAUDE_DIR/npm-global/bin:$PATH"
export NODE_PATH="$CLAUDE_DIR/npm-global/lib/node_modules:$NODE_PATH"

# Claude specific configuration
export CLAUDE_CODE_HOME="$CLAUDE_DIR"

echo "Claude Code environment configured"
EOF

chmod +x $INSTALL_DIR/setup.sh

# Add sourcing to bashrc to ensure persistence
if ! grep -q "source /workspace/.claude-code/setup.sh" ~/.bashrc; then
  echo -e "\n# Claude Code setup" >> ~/.bashrc
  echo "source /workspace/.claude-code/setup.sh" >> ~/.bashrc
fi

# Source it now for current session
source $INSTALL_DIR/setup.sh

# Install Claude Code with correct package name
echo "Installing Claude Code (this may take a minute)..." | tee -a $LOG_FILE
npm install -g @anthropic-ai/claude-code >> $LOG_FILE 2>&1

# Check if installation was successful
if command -v claude &> /dev/null; then
  echo "Claude Code installed successfully!" | tee -a $LOG_FILE
  CLAUDE_VERSION=$(claude --version 2>&1)
  echo "Claude Code version: $CLAUDE_VERSION" | tee -a $LOG_FILE
else
  echo "Claude executable not found. Checking installation directory..." | tee -a $LOG_FILE
  find $INSTALL_DIR/npm-global -name "claude" >> $LOG_FILE 2>&1
  if [ -f "$INSTALL_DIR/npm-global/bin/claude" ]; then
    echo "Claude found at $INSTALL_DIR/npm-global/bin/claude but not in PATH" | tee -a $LOG_FILE
    echo "Creating symlink to /usr/local/bin for convenience" | tee -a $LOG_FILE
    ln -sf "$INSTALL_DIR/npm-global/bin/claude" /usr/local/bin/claude
  fi
fi

# Create a simple startup script in workspace root
cat > /workspace/start_claude.sh << 'EOF'
#!/bin/bash
# Claude Code quick startup script
source /workspace/.claude-code/setup.sh
echo "Claude Code is ready to use!"
echo "Run 'claude' to start the interactive terminal."
echo "Run 'claude \"your query\"' to start with a specific query."
echo "Run 'claude -p \"your query\"' for non-interactive mode."
EOF

chmod +x /workspace/start_claude.sh

# Set up default ML-specific ignore patterns
echo "Setting up default ML-specific ignore patterns" | tee -a $LOG_FILE
if command -v claude &> /dev/null; then
  echo "Configuring ignore patterns for ML workloads..." | tee -a $LOG_FILE
  claude config set ignorePatterns '[]' >> $LOG_FILE 2>&1 || true
  claude config add ignorePatterns "ComfyUI/output/**" >> $LOG_FILE 2>&1 || true
  claude config add ignorePatterns "ComfyUI/input/**" >> $LOG_FILE 2>&1 || true
  claude config add ignorePatterns "**/venv/**" >> $LOG_FILE 2>&1 || true
  claude config add ignorePatterns "**/node_modules/**" >> $LOG_FILE 2>&1 || true
  claude config add ignorePatterns "**/.git/**" >> $LOG_FILE 2>&1 || true
  claude config add ignorePatterns "**/models/**" >> $LOG_FILE 2>&1 || true
  claude config add ignorePatterns "**/weights/**" >> $LOG_FILE 2>&1 || true
  claude config add ignorePatterns "**/checkpoints/**" >> $LOG_FILE 2>&1 || true
  echo "Ignore patterns configured successfully" | tee -a $LOG_FILE
else
  echo "Claude not installed properly. Skipping ignore pattern configuration." | tee -a $LOG_FILE
fi

echo "Installation completed at $(date)" | tee -a $LOG_FILE
echo -e "\nTo use Claude Code:"
echo "1. Run 'source ~/.bashrc' to update your current session"
echo "2. Run 'claude' to start the interactive terminal"
echo "3. For future pod starts, run '/workspace/start_claude.sh' first"
