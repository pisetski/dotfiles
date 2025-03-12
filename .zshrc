export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color
export EDITOR=nvim
export VISUAL="$EDITOR"

# Install day and storm themes https://github.com/folke/tokyonight.nvim/issues/23#issuecomment-1636639722
export BAT_THEME="tokyonight_storm"

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

plugins=(git zsh-autosuggestions zsh-syntax-highlighting z)
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
alias air='~/go/bin/air'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
