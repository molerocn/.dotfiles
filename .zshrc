# export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/personal/.dotfiles/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export USBS=/run/media/molerocn
export WIN=/mnt/win
export VAULT=$HOME/personal/second-brain
export DOTFILES=$HOME/personal/.dotfiles
export VM=$HOME/windows
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
bindkey -s '^G' '^Uobsmat \r'
bindkey -r '^S'
bindkey '^ ' autosuggest-accept

# aliases
alias notepad="gnome-text-editor"
alias sc="source ~/.zshrc"
alias esc="nvim ~/.zshrc"
alias a="ls -lah"
alias at="ls -lahtr ~/Downloads"
alias atd="ls -lahtr"
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
alias mlrc="mlr --csv"
alias mlrcs='mlr --csv --ifs=";"'
alias cpwd='pwd | copy'
alias open='nohup xdg-open >/dev/null 2>&1'
alias slog='gnome-session-quit --logout --no-prompt'
alias kzo="pkill zoom; echo 'Closing zoom...'"
alias pom="gnome-pomodoro"
alias eautostart="vim $DOTFILES/scripts/autostart"
alias get="sudo dnf install"
alias scopus="zen -P scopus &"
alias android="~/Android/Sdk/emulator/emulator -avd Medium_Phone_API_36.0 >/dev/null 2>&1 &"

# for free space
alias space-in-disk="df -h"
alias howmuch="du -ha -d 1 | sort -rh | head -n 10"

# nasty functions --------------

setopt NO_NOMATCH # no mostrar errores tras no coincidir con ? o *
te() {
    trans -b en:es "$*"
}
ts() {
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
# cpd() {
#     local n=1 dest=""
#
#     # primer argumento numérico -> cantidad de archivos/carpetas
#     if [[ "$1" =~ ^[0-9]+$ ]]; then
#         n="$1"
#         shift
#     fi
#
#     # segundo argumento -> carpeta destino
#     if [[ -n "$1" ]]; then
#         dest="$1"
#     fi
#
#     # si no hay destino, error
#     if [[ -z "$dest" ]]; then
#         echo "Error: falta carpeta de destino. Ejemplo: cpd 2 .  o  cpd ~/Desktop"
#         return 1
#     fi
#
#     # si el destino no existe, también error
#     if [[ ! -e "$dest" ]]; then
#         echo "Error: el destino '$dest' no existe."
#         return 1
#     fi
#
#     # listar los n ítems más recientes (archivos o carpetas)
#     local files
#     files=$(ls -t "$HOME/Downloads" 2>/dev/null | head -n "$n")
#
#     if [[ -z "$files" ]]; then
#         echo "No hay archivos ni carpetas en ~/Downloads."
#         return 1
#     fi
#
#     # copiar todo, recursivamente si hace falta (-r maneja carpetas)
#     while IFS= read -r f; do
#         cp -r -v "$HOME/Downloads/$f" "$dest/"
#     done <<< "$files"
# }


# copy last command
cpc() {
  local last_cmd
  last_cmd=$(fc -ln -1)
  echo -n "$last_cmd" | wl-copy
}

# go back to parent directory
cde() {
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

# copy file using uri-list
copyf() {
  [ $# -eq 0 ] && { echo "Usage: copyf <file>"; return 1; }
  [ ! -e "$1" ] && { echo "File not found: $1" >&2; return 2; }
  wl-copy --type text/uri-list "file://$(realpath "$1")"
}
cpd() {
    local n=1 dest=""
    local source_file=""
    local files=""
    
    # 1. Manejo del argumento numérico (n=cantidad de archivos)
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        n="$1"
        shift
    fi

    # 2. Manejo del argumento de destino
    dest="$1" # El destino es el primer argumento restante

    # Si no hay destino, error
    if [[ -z "$dest" ]]; then
        echo "Error: falta el destino."
        echo "Uso: cpd [N] [archivo_destino] (para N=1) o cpd [N] [directorio_destino] (para N>1)"
        return 1
    fi

    # 3. Listar los n ítems más recientes
    files=$(ls -t "$HOME/Downloads" 2>/dev/null | head -n "$n")

    if [[ -z "$files" ]]; then
        echo "No hay archivos ni carpetas en ~/Downloads para copiar."
        return 1
    fi

    # 4. Lógica de Copia y Renombrado
    if (( n > 1 )); then
        # CASO A: Copia Múltiple (n > 1) -> El destino DEBE ser un directorio
        if [[ ! -d "$dest" ]]; then
            echo "Error: Para copiar múltiples archivos, el destino '$dest' debe ser un directorio existente."
            return 1
        fi
        
        # echo "Copiando los $n ítems más recientes de ~/Downloads a '$dest/'..."
        while IFS= read -r f; do
            cp -r -v "$HOME/Downloads/$f" "$dest/"
        done <<< "$files"
        
    else
        # CASO B: Copia Única (n = 1) -> El destino puede ser un archivo (renombrado) o un directorio
        
        # El archivo a copiar es el único resultado de 'files'
        source_file="$HOME/Downloads/$files"
        
        # Si el destino NO existe, se asume que es un nuevo nombre de archivo (renombrado)
        if [[ ! -e "$dest" ]]; then
            # echo "Copiando '$source_file' como '$dest' (renombrado)..."
            cp -v "$source_file" "$dest"
        
        # Si el destino ES un directorio, se copia dentro del directorio
        elif [[ -d "$dest" ]]; then
            # echo "Copiando '$source_file' a '$dest/'..."
            cp -v "$source_file" "$dest/"

        # Si el destino existe, pero NO es un directorio (es un archivo existente)
        elif [[ -f "$dest" ]]; then
            # echo "El destino '$dest' existe y será sobrescrito."
            cp -v "$source_file" "$dest"
        fi
    fi
}
