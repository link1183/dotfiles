# put any useful function in there

v() {
    if [ $# -eq 1 ] && [ -d "$1" ]; then
        (cd "$1" && nvim .)
    else
        nvim "$@"
    fi
}


