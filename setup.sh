#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

links=(
  ".config:.config"
  ".editorconfig:.editorconfig"
  ".gitignore:.gitignore"
  ".tmux.conf:.tmux.conf"
  ".zprofile:.zprofile"
  ".zshrc:.zshrc"
  ".claude/agents:.claude/agents"
  ".claude/skills:.claude/skills"
  ".claude/settings.json:.claude/settings.json"
  ".claude/statusline-command.sh:.claude/statusline-command.sh"
  "agents/AGENTS.md:.claude/CLAUDE.md"
)

link() {
  local source="$DOTFILES_DIR/$1"
  local target="$HOME/$2"

  if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
    echo "✓ $2"
    return
  fi

  mkdir -p "$(dirname "$target")"
  if [[ -e "$target" || -L "$target" ]]; then
    mv "$target" "${target}.backup"
  fi
  ln -s "$source" "$target"
  echo "→ $2"
}

command -v brew &> /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file="$DOTFILES_DIR/Brewfile"

[[ -d "$HOME/.oh-my-zsh" ]] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
[[ -d "$HOME/.tmux/plugins/tpm" ]] || git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

for entry in "${links[@]}"; do
  link "${entry%%:*}" "${entry#*:}"
done

bat cache --build

defaults write -g InitialKeyRepeat -float 10.0
defaults write -g KeyRepeat -float 1.0

echo "Done. Restart your shell, and log out and back in for key repeat changes."
