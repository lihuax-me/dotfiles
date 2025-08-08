#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup"
README_FILE="$DOTFILES_DIR/README.md"

# List of modules (subdirectories in .dotfiles)
MODULES=("zsh" "tmux" "nvim" "hypr")

echo "=== Dotfiles Installer ==="
echo "Dotfiles directory: $DOTFILES_DIR"
echo "Modules: ${MODULES[*]}"
echo

# Ask for backup
read -rp "Do you want to back up existing config files to $BACKUP_DIR? (y/n): " backup_choice
if [[ "$backup_choice" =~ ^[Yy]$ ]]; then
    echo ">> Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    for module in "${MODULES[@]}"; do
        echo ">> Backing up module: $module"
        (
            cd "$DOTFILES_DIR/$module"
            for f in $(find . -type f); do
                target="$HOME/${f#./}"
                if [[ -e "$target" ]]; then
                    mkdir -p "$BACKUP_DIR/$(dirname "$f")"
                    mv "$target" "$BACKUP_DIR/$f"
                    echo "   Backed up $target -> $BACKUP_DIR/$f"
                fi
            done
        )
    done
    echo ">> Backup completed"
else
    echo ">> Skipping backup"
fi

# Install with Stow
for module in "${MODULES[@]}"; do
    echo ">> Installing module: $module"
    stow --dir="$DOTFILES_DIR" --target="$HOME" "$module"
done
echo ">> All modules installed"

# Update README.md
if [[ -f "$README_FILE" ]]; then
    echo ">> Updating README.md"
    {
        echo
        echo "## Install Log"
        echo "- Date: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "- Installed modules: ${MODULES[*]}"
        echo "- Backup performed: $([[ "$backup_choice" =~ ^[Yy]$ ]] && echo 'Yes' || echo 'No')"
    } >> "$README_FILE"
fi

echo "=== Installation completed ==="
