export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color
export EDITOR=nvim
export VISUAL="$EDITOR"

export TMPDIR="$HOME/.cache/tmp"
mkdir -p "$HOME/.cache/tmp"

# Install day and night themes https://github.com/folke/tokyonight.nvim/issues/23#issuecomment-1636639722
export BAT_THEME="tokyonight_night"

# Custom theme https://github.com/reobin/typewritten
export ZSH_THEME=""
export TYPEWRITTEN_SYMBOL="❯"
export TYPEWRITTEN_COLOR_MAPPINGS="primary:white;secondary:yellow;accent:cyan;foreground:default"
export TYPEWRITTEN_DISABLE_RETURN_CODE="true"
export TYPEWRITTEN_CURSOR="beam"
export TYPEWRITTEN_PROMPT_LAYOUT="pure"
export TYPEWRITTEN_ARROW_SYMBOL="➔"
autoload -U promptinit; promptinit
prompt typewritten

plugins=(git z)
source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias y="yarn"
alias ya="y add"
alias yad="ya -D"
alias yr="y remove"
alias ys="y start"
alias yd="y dev"
alias yb="y build"
alias cdw="cd ~/projects/web-frontend"
alias t="tmux"
alias ta="t a -t"
alias tl="t ls"
alias tn="t new -t"
alias tk="t kill-server"
alias p="pnpm"
alias gp="git pull"
alias air='$HOME/go/bin/air'
alias oc='opencode'

export XDG_CONFIG_HOME="$HOME/.config"
export NVM_DIR="$HOME/.config/nvm"

# Lazy load nvm for faster shell startup
# This creates placeholder functions that load nvm on first use
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  nvm "$@"
}

node() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  node "$@"
}

npm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  npm "$@"
}

npx() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  npx "$@"
}

# Add node to PATH if nvm default is set (without loading nvm)
if [ -d "$NVM_DIR/versions/node" ]; then
  NODE_VERSION=$(ls -1 "$NVM_DIR/versions/node" | tail -1)
  export PATH="$NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH"
fi

# Cache brew prefix for faster loading (typically /opt/homebrew on Apple Silicon, /usr/local on Intel)
if [[ -d "/opt/homebrew" ]]; then
  BREW_PREFIX="/opt/homebrew"
elif [[ -d "/usr/local/Homebrew" ]]; then
  BREW_PREFIX="/usr/local"
else
  BREW_PREFIX="$(brew --prefix)"
fi

source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
export PATH=~/.npm-global/bin:$PATH

# Bell on long command completion
autoload -U add-zsh-hook

# Configuration
_start_time=0
_bell_threshold=10  # Ring bell for commands taking longer than 10 seconds

# Function called before command execution
preexec_bell() {
    _start_time=$SECONDS
}

# Function called after command completion (before next prompt)
precmd_bell() {
    if (( _start_time > 0 && SECONDS - _start_time > _bell_threshold )); then
        echo -e '\a'  # Send bell character
    fi
    _start_time=0
}

# Register the hooks
add-zsh-hook preexec preexec_bell
add-zsh-hook precmd precmd_bell


# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# opencode
export PATH=$HOME/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
