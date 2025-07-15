#!/bin/bash

set -e  # Exit on any error

echo "🚀 Setting up your development environment..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages via Homebrew
echo "📦 Installing packages..."
brew install node@22 neovim fzf rg lazygit tmux bat zsh-syntax-highlighting typewritten zsh-autosuggestions
brew install --cask alacritty

# Install fonts via Homebrew
echo "🔤 Installing fonts..."
brew install --cask font-cascadia-code-nf

# Install Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "🐚 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install TPM (Tmux Plugin Manager)
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "🔌 Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Symlink dotfiles
echo "🔗 Symlinking dotfiles..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

echo "Installing dotfiles from: $DOTFILES_DIR"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local filename="$(basename "$source")"

    # If target already exists and is not a symlink, back it up
    if [[ -e "$target" && ! -L "$target" ]]; then
        echo "Backing up existing $filename to ${filename}.backup"
        mv "$target" "${target}.backup"
    fi

    # Create the symlink
    ln -sf "$source" "$target"
    echo "✓ Linked $filename"
}

# Process all dotfiles (files starting with .)
for file in "$DOTFILES_DIR"/.*; do
    # Skip if not a file or directory
    if [[ ! -e "$file" ]]; then
        continue
    fi

    filename="$(basename "$file")"

    # Skip . and .. directories
    if [[ "$filename" == "." || "$filename" == ".." ]]; then
        continue
    fi

    # Skip .git directory
    if [[ "$filename" == ".git" ]]; then
        continue
    fi

    # Create symlink
    create_symlink "$file" "$HOME/$filename"
done

# Handle non-dotfiles that should be symlinked (optional)
# Add any non-dotfiles you want to link here
for file in "README.md"; do
    if [[ -f "$DOTFILES_DIR/$file" ]]; then
        create_symlink "$DOTFILES_DIR/$file" "$HOME/$file"
    fi
done

echo ""
echo "✅ Setup complete!"

# Source the new .zshrc if it exists and we're in a zsh session
if [[ -f "$HOME/.zshrc" ]]; then
    echo "🔄 Reloading shell configuration..."
    exec zsh -l
else
    echo "📋 Please restart your terminal to apply changes"
fi
