export ZSH="$HOME/.oh-my-zsh"
export TERM=xterm-256color

ZSH_THEME="robbyrussell"


plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-z)

source $ZSH/oh-my-zsh.sh

alias v="nvim"
alias y="yarn"
alias ys="y start"
alias yd="y dev"
alias yb="y build"
alias cdw="cd ~/projects/web-frontend"  
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"
