# ----------------------------
# Powerlevel10k
# ----------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ----------------------------
# History
# ----------------------------
HISTFILE=$HOME/.zhistory
SAVEHIST=100000
HISTSIZE=100000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt extended_history  # timestamped history

# --- VI Mode  ---
bindkey -v

# Up/down arrows search history by prefix
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Lf and Fzf
bindkey -s '^o' 'lfcd\n' # zsh
# bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'
bindkey -s '^f' 'fopen\n'   # Ctrl-f → pick a file in current dir
bindkey -s '^d' 'fcd\n'
# ----------------------------
# Completions
# ----------------------------
autoload -Uz compinit
compinit

# ----------------------------
# Zoxide (better cd)
# ----------------------------
eval "$(zoxide init zsh)"

# ----------------------------
# Plugins
# ----------------------------
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export DOTFILES="$HOME/dotfiles"

export RAINDROP_TOKEN="ab0ef098-8f2a-4d54-87a4-033ff29614a1"
export PATH="$DOTFILES/scripts:$PATH"

export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"
export COLIMA_HOME="$HOME/.config/colima"

# ----------------------------
# Vi Mode Cursor Shape
# ----------------------------
# Changes cursor shape to block in normal mode and a pipe in insert mode.
# This requires a terminal that supports DECSCUSR, like Alacritty.

VI_MODE_CURSOR_BLOCK='\e[2 q'
VI_MODE_CURSOR_BEAM='\e[6 q'

function zle-keymap-select {
  case $KEYMAP in
    vicmd)
      # Normal mode
      echo -ne $VI_MODE_CURSOR_BLOCK
      ;;
    viins|main)
      # Insert mode (or default mode)
      echo -ne $VI_MODE_CURSOR_BEAM
      ;;
  esac
}

function zle-line-init {
  # Set the initial cursor to a vertical bar
  echo -ne $VI_MODE_CURSOR_BEAM
}

# Register the functions as ZLE widgets
zle -N zle-keymap-select
zle -N zle-line-init

# Set the initial cursor shape when Zsh starts
echo -ne $VI_MODE_CURSOR_BEAM

# Use 'jj' to escape from insert mode to normal mode
bindkey -M viins 'jk' vi-cmd-mode

for rcfile in "$DOTFILES"/zshrc.d/*.sh; do
  source "$rcfile"
done


