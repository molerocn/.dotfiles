export ZSH="$HOME/.oh-my-zsh"
export DOTFILES=$HOME/personal/.dotfiles
export PATH=$HOME/.local/bin:$PATH

ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
source /usr/share/fzf/shell/key-bindings.zsh

bindkey -s '^E' '^Uvim .\r'
bindkey -s '^Y' '^Udolphin . > /dev/null 2>&1 & \r'
bindkey -s '^F' '^U$DOTFILES/tmux/tmux-sessionizer \r'
bindkey -s '^B' '^Utmux a\r'
bindkey -r '^S'
bindkey '^ ' autosuggest-accept

# aliases
alias notepad="kwrite"
alias sc="source ~/.zshrc"
alias esc="nvim ~/.zshrc"
alias a="ls -lah"
alias at="ls -lahtr ~/Downloads"
alias atd="ls -lahtr"
alias copy="wl-copy"
alias paste="wl-paste"
alias cpwd='pwd | copy'
alias open='nohup xdg-open >/dev/null 2>&1'
alias get="sudo dnf install"

# for free space
alias space-in-disk="df -h"
alias howmuch="du -ha -d 1 | sort -rh | head -n 10"

vim() {
    if [[ -n "$TMUX" ]]; then
        local win
        win=$(tmux display-message -p '#{window_index}')
        if [[ "$win" != "1" ]]; then
            echo "vim is only allowed in first window" >&2
            return 1
        fi
    fi
    command nvim "$@"
}

cde() {
    if [ -z "$TMUX" ]; then
        cd ~ || return
        return
    fi
    session=$(tmux display-message -p '#S' 2>/dev/null) || {
        echo "cdroot: cannot determine tmux session" >&2
        return 1
    }
    root=$(tmux show-environment -t "$session" SESSION_ROOT 2>/dev/null | sed 's/^SESSION_ROOT=//')
    if [ -z "$root" ]; then
        echo "cdroot: SESSION_ROOT not set for session '$session'" >&2
        return 1
    fi
    cd "$root" || {
        echo "cdroot: failed to cd to '$root'" >&2
        return 1
    }
}

copyf() {
  [ $# -eq 0 ] && { echo "Usage: copyf <file>"; return 1; }
  [ ! -e "$1" ] && { echo "File not found: $1" >&2; return 2; }
  wl-copy --type text/uri-list "file://$(realpath "$1")"
}

cpd() {
    local dest="${1:-.}"
    local source_file
    source_file=$(ls -tp "$HOME/Downloads" | grep -v / | head -n 1)
    if [[ -z "$source_file" ]]; then
        echo "Error: No se encontraron archivos en ~/Downloads"
        return 1
    fi
    cp -v "$HOME/Downloads/$source_file" "$dest"
}
