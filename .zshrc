export ZSH="$HOME/.oh-my-zsh"
zstyle ':omz:update' mode auto
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
alias cc='claude'
alias wm='workmux'
alias python='python3'
alias pip='pip3'

export DOTFILES="${${(%):-%x}:A:h}"
export XDG_CONFIG_HOME="$HOME/.config"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export BUN_INSTALL="$HOME/.bun"

latest_node_bin=("$NVM_DIR"/versions/node/*/bin(N[-1]))
path=(
  "$HOME/.local/bin"
  "$HOME/.opencode/bin"
  "$BUN_INSTALL/bin"
  "$HOME/.npm-global/bin"
  $latest_node_bin
  $path
  "$HOME/.lmstudio/bin"
)

load_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

for command_name in nvm node npm npx; do
  eval "$command_name() { load_nvm; $command_name \"\$@\"; }"
done

alias pi-sandbox="$DOTFILES/docker/pi-sandbox/run.sh"

BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"
source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
