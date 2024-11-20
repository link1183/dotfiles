# Enhanced nvim wrapper function
def v [...args: path] {
  if ($args | length) == 1 and ($args | first | path exists) and ($args | first | path type) == "dir" {
    do { cd ($args | first); nvim . }
  } else {
    nvim ...$args
  }
}

# Quick directory creation and navigation
def mkcd --env [dir: path] {
  mkdir $dir
  cd $dir
}

# Extract various archive formats
def extract [file: path] {
  if ($file | path exists) and ($file | path type) == "file" {
    let ext = ($file | path expand | str downcase)
    match $ext {
      $path if ($path | str ends-with ".tar.bz2") => { tar xjf $file }
      $path if ($path | str ends-with ".tar.gz") => { tar xzf $file }
      $path if ($path | str ends-with ".bz2") => { bunzip2 $file }
      $path if ($path | str ends-with ".rar") => { unrar x $file }
      $path if ($path | str ends-with ".gz") => { gunzip $file }
      $path if ($path | str ends-with ".tar") => { tar xf $file }
      $path if ($path | str ends-with ".tbz2") => { tar xjf $file }
      $path if ($path | str ends-with ".tgz") => { tar xzf $file }
      $path if ($path | str ends-with ".zip") => { unzip $file }
      $path if ($path | str ends-with ".Z") => { uncompress $file }
      $path if ($path | str ends-with ".7z") => { 7z x $file }
      _ => { echo $"'($file)' cannot be extracted via extract()" }
    }
  } else {
    echo $"'($file)' is not a valid file"
  }
}

# Enhanced cd with ls after
def cl --env [dir: path] {
  cd $dir
  ls
}

# Cleanup docker containers, images, networks and volumes
def docker-cleanup [] {
  docker container prune -f
  docker image prune -f
  docker network prune -f
  docker volume prune -f
}

# Git convenience functions
# Quick git add, commit, push
def gacp [message: string] {
  git add .
  git commit -m $message
  git push
}

# Quick git checkout with fzf
def gco [] {
  let branches = (git branch --all | lines | where not ($it | str contains "HEAD"))
  if ($branches | length) > 0 {
    let height = (2 + ($branches | length))
    let branch = ($branches 
      | fzf-tmux --height $height --select-1 
      | str trim
      | parse "{state} {branch}" 
      | get branch
      | str replace --regex "remotes/[^/]*/" ""
    )
    if not ($branch | is-empty) {
      git checkout $branch
    }
  }
}

# Find-in-file function with ripgrep and fzf
def fif [pattern: string] {
    let preview_cmd = $"rg --ignore-case --pretty --context 10 '($pattern)' {}"

    let selected = (rg --files-with-matches --no-messages $pattern 
        | fzf --preview $preview_cmd)

    if not ($selected | is-empty) {
        nvim $selected $"+/($pattern)"
    }
}

# Quick HTTP server
def serve [port?: int = 8000] {
  python3 -m http.server $port
}

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}
