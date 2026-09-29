# change directory faster using fzf
change_dir_faster() {
    local dir
    dir="$(cdselect)" || return
    if [[ -n "$dir" ]]; then
        cd "$dir"
        zle reset-prompt
    fi
}

zle -N change_dir_faster