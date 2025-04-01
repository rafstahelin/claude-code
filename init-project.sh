#!/bin/bash
# Claude Code Project Initialization Script

TEMPLATES_DIR="$(dirname "$(readlink -f "$0")")/templates"
CURRENT_DIR="$(pwd)"

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

# Function to display available templates
show_templates() {
    echo "Available templates:"
    ls -1 "$TEMPLATES_DIR" | grep -v "README" | sed 's/\.md$//' | nl
}

# Function to copy template to current directory
copy_template() {
    template_path="$1"
    destination="$2"
    
    if [ ! -f "$template_path" ]; then
        echo "Error: Template file not found: $template_path"
        return 1
    fi
    
    if [ -f "$destination" ]; then
        echo "Warning: File $destination already exists."
        read -p "Overwrite? (y/N): " confirm
        if [[ ! $confirm =~ ^[Yy] ]]; then
            echo "Operation canceled."
            return 0
        fi
    fi
    
    cp "$template_path" "$destination"
    echo "Template copied to $destination"
    
    # Automatically run claude init if it exists
    if command -v claude &> /dev/null; then
        echo "Initializing Claude Code with the new template..."
        cd "$(dirname "$destination")"
        claude -p "/init"
        cd "$CURRENT_DIR"
    fi
}

# Main menu
show_menu() {
    echo "===== Claude Code Project Initialization ====="
    echo "1) Initialize with generic ML project template"
    echo "2) Initialize with Easy CLI template"
    echo "3) Initialize with ComfyUI download template"
    echo "4) Show all available templates"
    echo "5) Custom template selection"
    echo "6) Exit"
    echo "=============================================="
    echo -n "Select an option: "
}

# Main logic
if [ "$1" == "-l" ] || [ "$1" == "--list" ]; then
    show_templates
    exit 0
fi

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo "Usage: $0 [OPTIONS] [TEMPLATE_NAME]"
    echo ""
    echo "Initialize a Claude Code project with a template."
    echo ""
    echo "Options:"
    echo "  -l, --list          List available templates"
    echo "  -h, --help          Show this help message"
    echo ""
    echo "If TEMPLATE_NAME is provided, it will be used directly."
    echo "Otherwise, an interactive menu will be shown."
    exit 0
fi

if [ -n "$1" ]; then
    # Direct template selection
    template_file="$TEMPLATES_DIR/$1.md"
    if [ ! -f "$template_file" ]; then
        echo "Error: Template '$1' not found."
        echo "Available templates:"
        show_templates
        exit 1
    fi
    
    copy_template "$template_file" "$CURRENT_DIR/CLAUDE.md"
    exit 0
fi

# Interactive mode
while true; do
    show_menu
    read -r option
    
    case $option in
        1)
            copy_template "$TEMPLATES_DIR/CLAUDE.md" "$CURRENT_DIR/CLAUDE.md"
            break
            ;;
        2)
            copy_template "$TEMPLATES_DIR/CLAUDE-EASY-CLI.md" "$CURRENT_DIR/CLAUDE.md"
            break
            ;;
        3)
            copy_template "$TEMPLATES_DIR/CLAUDE-COMFY-DOWNLOAD.md" "$CURRENT_DIR/CLAUDE.md"
            break
            ;;
        4)
            show_templates
            ;;
        5)
            show_templates
            echo -n "Enter template number: "
            read -r template_num
            template_file=$(ls -1 "$TEMPLATES_DIR" | grep -v "README" | sed -n "${template_num}p")
            if [ -n "$template_file" ]; then
                copy_template "$TEMPLATES_DIR/$template_file" "$CURRENT_DIR/CLAUDE.md"
                break
            else
                echo "Invalid template number."
            fi
            ;;
        6)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done

echo "Project initialized. You can now run 'claude' to start working with your project."
