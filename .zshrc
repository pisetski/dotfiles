export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color
export EDITOR=nvim
export VISUAL="$EDITOR"
export BAT_THEME="Enki-Tokyo-Night"

ZSH_THEME="refined"

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
