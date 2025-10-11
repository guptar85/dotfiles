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
