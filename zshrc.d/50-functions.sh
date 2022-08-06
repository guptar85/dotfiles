js() {
  # JSON scroll
  jq -C . < "$1" | less -R
}

ytplay() { 
    if [ -z "$(pbpaste)" ]; then
        echo "Nothing in clipboard"
    else
        mpv "$(pbpaste)"
    fi
    return 
}

# make directory and enter it
mcd() { mkdir -p "$@" && cd "$@"; }
