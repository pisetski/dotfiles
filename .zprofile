# Use hardcoded brew prefix for faster startup
if [[ -d "/opt/homebrew" ]]; then
  FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
elif [[ -d "/usr/local/Homebrew" ]]; then
  FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
else
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Added by `rbenv init` on Tue Nov 11 19:53:57 CET 2025
# eval "$(rbenv init - --no-rehash zsh)"
