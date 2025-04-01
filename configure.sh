#!/bin/bash
# Claude Code Configuration Script

# Check if Claude is installed and in path
if ! command -v claude &> /dev/null; then
    echo "Claude Code not found in path. Trying to source setup script..."
    if [ -f "/workspace/.claude-code/setup.sh" ]; then
        source /workspace/.claude-code/setup.sh
    else
        echo "Error: Claude Code not installed or not in path."
        echo "Please run the installation script first or verify your installation."
        exit 1
    fi
fi

# Function to display current ignore patterns
show_current_patterns() {
    echo "Current ignore patterns:"
    claude config list | grep ignorePatterns
}

# Function to add an ignore pattern
add_pattern() {
    pattern="$1"
    echo "Adding ignore pattern: $pattern"
    claude config add ignorePatterns "$pattern"
    echo "Pattern added successfully."
}

# Function to reset ignore patterns
reset_patterns() {
    echo "Resetting all ignore patterns..."
    claude config set ignorePatterns "[]"
    echo "Patterns reset. Adding default ML patterns..."
    
    # Add default ML patterns
    claude config add ignorePatterns "ComfyUI/output/**"
    claude config add ignorePatterns "ComfyUI/input/**"
    claude config add ignorePatterns "**/venv/**"
    claude config add ignorePatterns "**/node_modules/**"
    claude config add ignorePatterns "**/.git/**"
    claude config add ignorePatterns "**/models/**"
    claude config add ignorePatterns "**/weights/**"
    claude config add ignorePatterns "**/checkpoints/**"
    
    echo "Default patterns restored."
}

# Main menu
show_menu() {
    echo "===== Claude Code Configuration ====="
    echo "1) Show current ignore patterns"
    echo "2) Add a new ignore pattern"
    echo "3) Reset to default ML patterns"
    echo "4) Show all configuration"
    echo "5) Exit"
    echo "===================================="
    echo -n "Select an option: "
}

# Main loop
while true; do
    show_menu
    read -r option
    
    case $option in
        1)
            show_current_patterns
            echo ""
            ;;
        2)
            echo -n "Enter new pattern (use glob format, e.g., 'path/to/dir/**'): "
            read -r new_pattern
            add_pattern "$new_pattern"
            echo ""
            ;;
        3)
            echo -n "Are you sure you want to reset all patterns? (y/N): "
            read -r confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                reset_patterns
            else
                echo "Reset cancelled."
            fi
            echo ""
            ;;
        4)
            echo "Full Claude Code configuration:"
            claude config list
            echo ""
            ;;
        5)
            echo "Exiting configuration tool."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            echo ""
            ;;
    esac
done
