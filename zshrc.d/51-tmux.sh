tmn() {
	local name="${1:-$(basename "$PWD")}"
	tmux new-session -s "$name"
}

tmw() {
	local target
	target=$(tmux list-windows -a -F "#S:#I:#W" | fzf --prompt="Switch to window> ")
	[ -n "$target" ] && tmux switch-client -t "$target"
}

tmls() {
	tmux list-sessions -F "#S (#{session_windows} windows) [created: #{session_created_string}]"
}

tmk() {
	local session
	session=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Kill session> ")
	[ -n "$session" ] && tmux kill-session -t "$session"
}

# tm - create new tmux session or attach/switch to existing one
tm() {
	local change
	[[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"

	if [ -n "${1:-}" ]; then
		# If you passed a name, attach or create
		tmux $change -t "$1" 2>/dev/null || {
			tmux new-session -d -s "$1"
			tmux $change -t "$1"
		}
		return
	fi

	# If no arg, show picker via fzf
	local session
	session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --prompt="tmux sessions> " --exit-0)

	if [ -n "$session" ]; then
		tmux $change -t "$session"
	else
		echo "No tmux sessions found."
	fi
}
