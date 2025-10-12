js() {
  if [ -t 0 ] && [ -z "$1" ]; then
    echo "Usage: js <file> or pipe JSON into js"
    return 1
  fi
  jq -C . ${1:--} | less -R
}

mcd() { mkdir -p "$@" && cd "$@"; }

man() {
  if command -v tldr >/dev/null; then
    tldr "$@"
  else
    command man "$@"
  fi
}

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
  viins | main)
    # Insert mode (or default mode)
    echo -ne $VI_MODE_CURSOR_BEAM
    ;;
  esac
}

function zle-line-init {
  # Set the initial cursor to a vertical bar
  echo -ne $VI_MODE_CURSOR_BEAM
}

# ============================
# Edit current command in Neovim popup (tmux only)# ----------------------------
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
  viins | main)
    # Insert mode (or default mode)
    echo -ne $VI_MODE_CURSOR_BEAM
    ;;
  esac
}

function zle-line-init {
  # Set the initial cursor to a vertical bar
  echo -ne $VI_MODE_CURSOR_BEAM
}

#
# ============================
edit_command_in_tmux_popup() {
  local tmpfile=$(mktemp /tmp/zsh-edit-XXXX.txt)
  print -r -- "$BUFFER" >"$tmpfile"

  if [[ -n "$TMUX" ]]; then
    # Open Neovim in tmux popup
    tmux display-popup -E -w 85% -h 70% -T "📝 Edit Command" "nvim '$tmpfile'"
    BUFFER=$(<"$tmpfile")
    CURSOR=${#BUFFER}
    rm -f "$tmpfile"
    zle reset-prompt
  else
    # fallback
    zle edit-command-line
  fi
}
