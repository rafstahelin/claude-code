#!/bin/bash
# Claude Code Uninstall Script for RunPod

LOG_FILE="/workspace/claude-uninstall.log"
INSTALL_DIR="/workspace/.claude-code"

echo "Starting Claude Code uninstallation at $(date)" > $LOG_FILE

# Remove startup script
if [ -f "/workspace/start_claude.sh" ]; then
  echo "Removing startup script" | tee -a $LOG_FILE
  rm /workspace/start_claude.sh
fi

# Remove symlink if it exists
if [ -L "/usr/local/bin/claude" ]; then
  echo "Removing symlink from /usr/local/bin" | tee -a $LOG_FILE
  rm /usr/local/bin/claude
fi

# Remove source line from .bashrc
echo "Removing Claude Code lines from .bashrc" | tee -a $LOG_FILE
sed -i '/# Claude Code setup/d' ~/.bashrc
sed -i '/source \/workspace\/.claude-code\/setup.sh/d' ~/.bashrc

# Ask for confirmation before removing installation directory
read -p "Remove all Claude Code files from $INSTALL_DIR? (y/N): " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
  echo "Removing Claude Code installation directory" | tee -a $LOG_FILE
  rm -rf $INSTALL_DIR
  echo "Claude Code has been completely removed" | tee -a $LOG_FILE
else
  echo "Keeping Claude Code files at $INSTALL_DIR" | tee -a $LOG_FILE
  echo "You can remove them manually later with 'rm -rf $INSTALL_DIR'" | tee -a $LOG_FILE
fi

echo "Uninstallation completed at $(date)" | tee -a $LOG_FILE
echo -e "\nClaude Code has been uninstalled."
echo "You may need to restart your terminal session for all changes to take effect."
