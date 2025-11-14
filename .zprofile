# Use hardcoded brew prefix for faster startup
if [[ -d "/opt/homebrew" ]]; then
  FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
elif [[ -d "/usr/local/Homebrew" ]]; then
  FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
else
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
