[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type rg &>/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob '"'"'!.git/'"'"
fi

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
#  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  IFS=$'\n' files=($(fzf-tmux --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down --query="$1" --multi --select-1 --exit-0))
#   [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
   [[ -n "$files" ]] && nvim "${files[@]}"
}

ff() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
    [[ -n "$files" ]] && {    
    case $(file --mime-type "$(stat -f $files)" -b) in
        text/*|application/json|inode/x-empty) nvim $ "${files[@]}";;
        audio/*) mpv --audio-display=no "${files[@]}";;
        image/*) open "${files[@]}" > /dev/null 2>&1 ;;
        video/*) mpv "${files[@]}" -quiet ;;
       	application/vnd.openxmlformats-officedocument.wordprocessingml.document|application/vnd.oasis.opendocument.text) open "${files[@]}" > /dev/null 2>&1 ;;
       	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet|application/octet-stream|application/vnd.oasis.opendocument.spreadsheet|application/vnd.oasis.opendocument.spreadsheet-template)  open "${files[@]}" > /dev/null 2>&1 ;;
    	application/vnd.openxmlformats-officedocument.presentationml.presentation|application/vnd.oasis.opendocument.presentation-template|application/vnd.oasis.opendocument.presentation|application/vnd.ms-powerpoint) open "${files[@]}" > /dev/null 2>&1 ;;
	application/pdf|application/vnd*|application/epub*) mupdf-gl "${files[@]}" > /dev/null 2>&1 & ;;	
        application/pgp-encrypted) nvim "${files[@]}" ;;
        *) for f in $fx; do open "${files[@]}" > /dev/null 2> /dev/null & done;;
    esac
    } 
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
