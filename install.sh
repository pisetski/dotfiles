#!/bin/bash
# Place this in ~/projects/dotfiles/install.sh

DOTFILES_DIR="$HOME/projects/dotfiles"
cd "$DOTFILES_DIR"

# Get all dotfiles (files starting with .)
for file in .*; do
    # Skip . and .. directories
    if [[ "$file" == "." || "$file" == ".." ]]; then
        continue
    fi

    # Skip .git directory if it exists
    if [[ "$file" == ".git" ]]; then
        continue
    fi

    # Create symlink
    ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
    echo "Linked $file"
done

# Handle non-dotfiles if needed (like README.md)
if [[ -f "README.md" ]]; then
    ln -sf "$DOTFILES_DIR/README.md" "$HOME/README.md"
    echo "Linked README.md"
fi
