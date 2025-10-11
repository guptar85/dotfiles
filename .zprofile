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
# 🧠 Auto-start tmux (smarter + cwd aware)
# ----------------------------
if [[ "$(hostname)" == "Rahuls-MacBook-Air.local" ]]; then
  if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [ -t 1 ]; then
    SESSION="main"
    CURRENT_DIR="$(pwd)"

    # Check if session exists
    if tmux has-session -t "$SESSION" 2>/dev/null; then
      # Attach to existing session, starting in current dir if detached
      exec tmux attach-session -t "$SESSION"
    else
      # Start a new session in the current working directory
      exec tmux new-session -s "$SESSION" -c "$CURRENT_DIR"
    fi
  fi
fi
