export VISUAL=nvim

set -o vi

bindkey -v
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#bindkey -s '^l': 'clear'
bindkey -s '^o' 'lfcd\n'  # zsh
bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'
