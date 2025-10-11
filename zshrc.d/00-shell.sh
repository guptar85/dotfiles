# ============================
#  Modern CLI Tools Config
# ============================

# 1. Bat (A better 'cat')
# ----------------------------
# Use 'bat' as the default pager for 'man' pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# Use 'bat' for 'fzf' previews
export FZF_PREVIEW_COMMAND='bat --color=always --style=numbers,changes --line-range :300 {}'

# 2. Fd (A better 'find')
# ----------------------------
# Set default 'fd' options to ignore .git and follow symlinks
export FD_OPTS="--hidden --follow --exclude .git"

# Make 'fzf' use 'fd' by default
export FZF_DEFAULT_COMMAND="fd --type f $FD_OPTS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
