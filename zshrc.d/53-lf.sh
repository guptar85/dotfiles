# lfcd - change working directory in shell to last dir in lf on exit
lfcd() {
  local tmp dir
  # Create a temporary file and set a trap to clean it up on exit
  tmp="$(mktemp)" || return 1
  trap 'rm -f "$tmp"' EXIT

  # Run lf, passing the temp file path
  lf -last-dir-path="$tmp" "$@"

  # Read the directory path from the temp file if it exists
  if [[ -f "$tmp" ]]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp" # Clean up immediately after reading

    # Change directory if it's valid and different from the current one
    if [[ -d "$dir" ]] && [[ "$dir" != "$PWD" ]]; then
      cd "$dir" || return
    fi
  fi
}
