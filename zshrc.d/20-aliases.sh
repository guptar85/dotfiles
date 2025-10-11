# ============================
#  General Utility
# ============================
alias grep="grep --color=auto"
alias Z="source $HOME/.zshrc"

# Safe and verbose file operations
alias cp="cp -ivr"
alias mv="mv -iv"

# Use trash-cli for a safer 'rm'
alias rm='trash-put'
alias tl='trash-list'
alias tr='trash-restore'
alias te='trash-empty'

# ============================
#  Navigation
# ============================
alias ...="cd ../.."
alias ....="cd ../../.."
alias d="cd $DOTFILES"

# Use eza for ls
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --long --header --git --icons --group-directories-first'
alias la='eza -la --long --header --git --icons --group-directories-first'
alias lt='eza --tree --level=2 --long --header --git --icons --group-directories-first'

# ============================
#  Application Shortcuts
# ============================
alias v="nvim"
alias sv="sudo nvim"
alias g="git"
alias l="lf"
alias sl="sudo lf"
alias f="fzf"
alias rss="newsboat"

# =esqc===========================
#  Config Editing
# ============================
alias vz="v ~/.zshrc"
alias vza="v $DOTFILES/zshrc.d/20-aliases.sh"
alias vzf="v $DOTFILES/zshrc.d/50-functions.sh"
alias c="v ~/.config"
alias n="v ~/.config/nvim/init.lua"

# ============================
#  System & Other
# ============================
# Update Homebrew and clean up old packages
alias brewup="brew update && brew upgrade && brew cleanup"

# Show whitespace characters
alias whitespace="sed 's/ /·/g;s/\t/￫/g;s/\r/§/g;s/$/¶/g'"
