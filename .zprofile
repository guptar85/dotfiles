# ----------------------------
# Homebrew
# ----------------------------
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ----------------------------
# NVM (Node Version Manager)
# ----------------------------
export NVM_DIR="$HOME/.nvm"

# Load NVM
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
  . "$NVM_DIR/bash_completion"
fi

# Ensure default Node is always available (for tmux, Neovim, etc.)
if command -v nvm &>/dev/null; then
  nvm use default &>/dev/null
fi

# Auto-use .nvmrc if present (interactive shells only)
if [[ $- == *i* ]]; then
  autoload -U add-zsh-hook
  load-nvmrc() {
    if [[ -f .nvmrc && -r .nvmrc ]]; then
      nvm use > /dev/null
    fi
  }
  add-zsh-hook chpwd load-nvmrc
  load-nvmrc
fi

# ----------------------------
# Auto-start tmux (safe)
# ----------------------------
if [[ "$(hostname)" == "Rahuls-MacBook-Air.local" ]]; then
  if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [ -t 1 ]; then
    tmux has-session -t main 2>/dev/null
    if [ $? -eq 0 ]; then
      exec tmux attach-session -t main
    else
      exec tmux new-session -s main
    fi
  fi
fi
