# Enhanced nvim wrapper function
v() {
	if [ $# -eq 1 ] && [ -d "$1" ]; then
		(cd "$1" && nvim .)
	else
		nvim "$@"
	fi
}

# Quick directory creation and navigation
mkcd() {
	mkdir -p "$@" && cd "$_" && ls
}

# Extract various archive formats
extract() {
	if [ -f "$1" ]; then
		case "$1" in
		*.tar.bz2) tar xjf "$1" ;;
		*.tar.gz) tar xzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xf "$1" ;;
		*.tbz2) tar xjf "$1" ;;
		*.tgz) tar xzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*) echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Enhanced cd with ls after
cl() {
	cd "$@" && ls
}

# Docker cleanup function
docker-cleanup() {
	docker container prune -f
	docker image prune -f
	docker network prune -f
	docker volume prune -f
}

# Git convenience functions
# Quick git add, commit, push
gacp() {
	git add . && git commit -m "$1" && git push
}

# Quick git checkout with fzf
gco() {
	local branches branch
	branches=$(git branch --all | grep -v HEAD) &&
		branch=$(echo "$branches" | fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
		git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Find-in-file function with ripgrep and fzf
fif() {
	if [ ! "$#" -gt 0 ]; then
		echo "Need a string to search for!"
		return 1
	fi
	rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Quick HTTP server
serve() {
	local port=${1:-8000}
	python3 -m http.server "$port"
}
