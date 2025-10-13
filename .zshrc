export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/personal/.dotfiles/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export USBS=/run/media/molerocn
export WIN=/mnt/win
export VAULT=$HOME/personal/second-brain
export DOTFILES=$HOME/personal/.dotfiles
# export ANKI_WAYLAND=1

ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh

bindkey -s '^E' '^Uvim .\r'
bindkey -s '^Y' '^Unautilus -w . > /dev/null 2>&1 & \r'
bindkey -s '^F' '^U$DOTFILES/bin/tmux-sessionizer \r'
bindkey -s '^B' '^Utmux a\r'
bindkey -s '^O' '^Ucreate_note \r'
bindkey -s '^G' '^Uobsmat \r'
bindkey -r '^S'
bindkey '^ ' autosuggest-accept

# aliases
alias notepad="gnome-text-editor"
alias sc="source ~/.zshrc"
alias esc="nvim ~/.zshrc"
alias a="ls -lah"
alias at="ls -lahtr ~/Downloads"
# alias vim="nvim"
alias mountwin="sudo mount /dev/nvme0n1p3 /mnt/win"
alias copy="wl-copy"
alias paste="wl-paste"
alias gic="git commit -m"
alias edge="microsoft-edge-stable"
alias turnoff="closeall; shutdown now"
# alias open="xdg-open"
alias kandroid="pkill studio; pkill qemu; pkill java"
# alias ankiex="/usr/bin/python3 ~/.local/bin/anki_import.py"
# alias lpart="lsblk"
alias usboff="udisksctl unmount -b /dev/sda1; udisksctl power-off -b /dev/sda"
# alias book="open ~/Documents/libros/fundamentos\ matematicos/mml-without-margin.pdf &"
# alias usbs="cd /run/media/molerocn/; ls -lah"
# alias supercp="rsync -ah --progress"
# alias jlab="/opt/JupyterLab/jupyterlab-desktop"
alias mlrc="mlr --csv"
alias mlrcs='mlr --csv --ifs=";"'
alias cpwd='pwd | copy'
# alias balsamiq="wine $WIN/Program\ Files/Balsamiq\ Mockups/Balsamiq\ Mockups\ 3.exe"
# alias epaste="echo $(paste)"
alias open='nohup xdg-open >/dev/null 2>&1'
alias slog='gnome-session-quit --logout --no-prompt'
alias kzo="pkill zoom"
alias pom="gnome-pomodoro"
alias eautostart="vim $DOTFILES/scripts/autostart"

# nasty functions --------------

setopt NO_NOMATCH # no mostrar errores tras no coincidir con ? o *
function te() {
    trans -b en:es "$*"
}
function ts() {
    trans -b es:en "$*"
}

# vim in first window discipline
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

# copy last file or n last items from ~/Downloads
cpd() {
    local n=1 dest=""

    # primer argumento numérico -> cantidad de archivos/carpetas
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        n="$1"
        shift
    fi

    # segundo argumento -> carpeta destino
    if [[ -n "$1" ]]; then
        dest="$1"
    fi

    # si no hay destino, error
    if [[ -z "$dest" ]]; then
        echo "Error: falta carpeta de destino. Ejemplo: cpd 2 .  o  cpd ~/Desktop"
        return 1
    fi

    # si el destino no existe, también error
    if [[ ! -e "$dest" ]]; then
        echo "Error: el destino '$dest' no existe."
        return 1
    fi

    # listar los n ítems más recientes (archivos o carpetas)
    local files
    files=$(ls -t "$HOME/Downloads" 2>/dev/null | head -n "$n")

    if [[ -z "$files" ]]; then
        echo "No hay archivos ni carpetas en ~/Downloads."
        return 1
    fi

    # copiar todo, recursivamente si hace falta (-r maneja carpetas)
    while IFS= read -r f; do
        cp -r -v "$HOME/Downloads/$f" "$dest/"
    done <<< "$files"
}


# copy last command
function cpc() {
  local last_cmd
  last_cmd=$(fc -ln -1)
  echo -n "$last_cmd" | wl-copy
}

# go back to parent directory
function cde() {
    # if not in tmux, behave like `cd ~`
    if [ -z "$TMUX" ]; then
        cd ~ || return
        return
    fi

    # get the current tmux session name
    session=$(tmux display-message -p '#S' 2>/dev/null) || {
        echo "cdroot: cannot determine tmux session" >&2
        return 1
    }

    # get SESSION_ROOT from that session
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

