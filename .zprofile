# Use hardcoded brew prefix for faster startup
if [[ -d "/opt/homebrew" ]]; then
  FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
elif [[ -d "/usr/local/Homebrew" ]]; then
  FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
else
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
