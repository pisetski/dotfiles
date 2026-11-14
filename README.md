```sh
git clone https://github.com/pisetski/dotfiles.git
cd dotfiles && ./setup.sh
```

The script:
- installs Homebrew (if missing) and everything in `Brewfile`
- installs oh-my-zsh and TPM
- symlinks configs into `$HOME`, keeping existing files as `*.backup`
- sets fast key repeat (log out and back in to apply)

Then open `tmux` and press `prefix + I` to install plugins.
