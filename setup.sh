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
brew install node@22 neovim fzf rg lazygit tmux bat zsh-syntax-highlighting typewritten zsh-autosuggestions gh
brew install cormacrelf/tap/dark-notify
brew install --cask alacritty

# Build bat theme
echo "🦇 Building bat themes..."
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
# Replace _night in the lines below with _day, _moon, or _storm if needed.
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_day.tmTheme
bat cache --build
cd -

# Increase repeat rate on OS X
echo "🏎️ Increasing key repeat rate... Log out and back in for changes to take effect."
defaults write -g InitialKeyRepeat -float 10.0 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -float 1.0 # normal minimum is 2 (30 ms)

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

    # If target already exists
    if [[ -e "$target" || -L "$target" ]]; then
        # If it's already the correct symlink, skip
        if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
            echo "✓ $filename already correctly linked"
            return
        fi

        # If it's a broken symlink or wrong symlink, remove it
        if [[ -L "$target" ]]; then
            echo "Removing broken/incorrect symlink: $filename"
            rm "$target"
        # If it's a real file/directory, back it up
        else
            echo "Backing up existing $filename to ${filename}.backup"
            mv "$target" "${target}.backup"
        fi
    fi

    # Create the symlink
    ln -sf "$source" "$target"
    echo "✓ Linked $filename"
}

# Symlink .claude directory contents
echo "🔗 Symlinking Claude configuration..."
mkdir -p "$HOME/.claude"
create_symlink "$DOTFILES_DIR/.claude/agents" "$HOME/.claude/agents"
create_symlink "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
create_symlink "$DOTFILES_DIR/.claude/statusline-command.sh" "$HOME/.claude/statusline-command.sh"

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

    # Skip .claude directory (handled separately above)
    if [[ "$filename" == ".claude" ]]; then
        continue
    fi

    # Only process top-level dotfiles/directories, avoid recursion
    if [[ "$file" == "$DOTFILES_DIR/$filename" ]]; then
        create_symlink "$file" "$HOME/$filename"
    fi
done

echo ""
echo "✅ Setup complete!"

# Offer to clean up old backup files
backup_files=(~/*.backup)
if [[ -e "${backup_files[0]}" ]]; then
   echo ""
   echo "🧹 Found backup files from previous installations:"
   ls -la ~/*.backup 2>/dev/null || true
   echo ""
   read -p "Would you like to remove these backup files? (y/n): " -n 1 -r
   echo
   if [[ $REPLY =~ ^[Yy]$ ]]; then
       rm -f ~/*.backup
       echo "✅ Backup files cleaned up!"
   else
       echo "📁 Backup files kept (you can remove them manually later)"
   fi
fi

# Source the new .zshrc if it exists and we're in a zsh session
if [[ -f "$HOME/.zshrc" ]]; then
    echo "🔄 Reloading shell configuration..."
    exec zsh -l
else
    echo "📋 Please restart your terminal to apply changes"
fi
