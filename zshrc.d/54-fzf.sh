# Smart fuzzy cd (fzf + fd for dirs)
fcd() {
	local dir
	# If no argument is given, search from the current directory.
	local search_dir="${1:-.}"

	dir=$(fd --type d --hidden --follow --exclude .git . "$search_dir" |
		fzf --height=40% --layout=reverse --border \
			--prompt="Go to: " \
			--preview 'eza --tree --level=1 --icons --color=always {}')

	# Exit if no directory was selected
	if [[ -z "$dir" ]]; then
		echo "No directory selected."
		return 1
	fi

	cd "$dir" || return
}

# Smart fuzzy opener (fzf + fd + bat)
fopen() {
	local search_dir="${1:-.}"
	local file

	file=$(fd --type f --hidden --follow --exclude .git . "$search_dir" |
		fzf --height=40% --layout=reverse --border \
			--prompt="Open: " \
			--preview 'bat --style=numbers --color=always --line-range :300 {} 2>/dev/null || file --brief {}')

	if [[ -z "$file" ]]; then
		echo "No file selected."
		return 1
	fi

	[[ -L "$file" ]] && file="$(readlink -f "$file")"

	# --- NEW, MORE RELIABLE LOGIC ---
	# Get the MIME type of the file
	local mime_type
	mime_type=$(file --brief --mime-type "$file")

	case "$mime_type" in
	# Any kind of text file -> open in Neovim
	text/* | inode/x-empty)
		nvim "$file"
		;;

	# Media files
	audio/*) mpv --audio-display=no "$file" ;;
	image/*) open "$file" >/dev/null 2>&1 ;;
	video/*) mpv "$file" ;;

	# Document files
	application/pdf | application/epub+zip)
		mupdf-gl "$file" >/dev/null 2>&1 &
		;;

	# Default fallback for all other types
	*)
		echo "Opening with default application..."
		open "$file" >/dev/null 2>&1 &
		;;
	esac
}

# fkill - Fuzzy kill a process
fkill() {
	# Get a list of processes, excluding the fkill command itself
	local pid
	pid=$(ps -ef | sed 1d | fzf -m --height=40% --layout=reverse | awk '{print $2}')

	if [[ -n "$pid" ]]; then
		# Kill the selected processes
		echo "$pid" | xargs kill -9
		echo "Killed process(es): $pid"
	else
		echo "No process selected."
	fi
}

# Fuzzy live text search with rg + fzf + bat
fif() {
	local match file line

	match=$(rg --no-heading --line-number --color=always "" . 2>/dev/null |
		fzf --ansi --delimiter : \
			--nth 1,2,3 \
			--phony --query "" \
			--bind "change:reload(rg --no-heading --line-number --color=always {q} . 2>/dev/null)" \
			--preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
			--preview-window=up:60%) || return

	file=$(echo "$match" | cut -d: -f1)
	line=$(echo "$match" | cut -d: -f2)

	[ -n "$file" ] && nvim +"$line" "$file"
}

# ============================
# Git + FZF helpers
# ============================

# Checkout branch
gco() {
	local branch
	branch=$(git branch --all --sort=-committerdate |
		sed 's/^[* ] //' | grep -v HEAD |
		fzf --height=40% --reverse --preview 'git log -n 5 --color=always {}') &&
		git checkout "$(echo "$branch" | sed 's#remotes/[^/]*/##')"
}

# Checkout commit (detached HEAD)
gch() {
	local commit
	commit=$(git log --oneline --decorate --color=always |
		fzf --height=40% --reverse --ansi --preview 'echo {} | cut -d" " -f1 | xargs git show --color=always | head -200') &&
		git checkout "$(echo "$commit" | awk '{print $1}')"
}

# Interactive stash apply
gsta() {
	local stash
	stash=$(git stash list | fzf --height=40% --reverse --preview 'git stash show -p {1} --color=always | head -200') &&
		git stash apply "$(echo "$stash" | awk -F: '{print $1}')"
}

# Browse git log with preview
glg() {
	git log --oneline --decorate --color=always |
		fzf --ansi --height=80% --reverse --preview 'echo {} | cut -d" " -f1 | xargs git show --color=always | bat --style=plain --color=always --language=diff'
}

# Show changed files and open one
gdf() {
	local file
	file=$(git diff --name-only | fzf --height=40% --reverse --preview 'git diff --color=always -- {} | bat --style=plain --color=always --language=diff') &&
		nvim "$file"
}

# Show tracked files and open one
gfile() {
	local file
	file=$(git ls-files | fzf --height=40% --reverse --preview 'bat --style=numbers --color=always --line-range :200 {}') &&
		nvim "$file"
}
