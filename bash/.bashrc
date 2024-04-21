# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

export OSH='/home/juancamr/.oh-my-bash'
export PATH="$PATH:$HOME/bin"
export TERM="xterm-256color"
OSH_THEME="robbyrussell"
OMB_USE_SUDO=true
completions=(git composer ssh)
aliases=(general)
plugins=(git bashmarks)

function create() {
  mkdir -p "$@" && cd "$@"
}

function mkzip() {
    local carpeta_nombre=$(basename "$1")
    zip -r "${carpeta_nombre}.zip" "$1"
}

function cpcontent() {
    local file=$1
    xsel --clipboard < "$file"
    echo "Copied!"
}

function mind() {
    local message=$1
    cd ~/personal/second_mind/
    git add .
    git commit -m "$message"
    git push origin main
}

source "$OSH"/oh-my-bash.sh
source /usr/share/fzf/key-bindings.bash

alias glog="git log --oneline --decorate --graph --all"
alias gce="git commit --amend --no-edit"
alias vim="nvim"
alias ebash="nvim ~/.bashrc"
alias sbash="clear; source ~/.bashrc"
alias tree="tree -C -I 'node_modules'"
alias update="sudo pacman -Syu"
alias upgrade="sudo pamac upgrade"
alias restart="qtile cmd-obj -o cmd -f restart"
alias d="cd"
alias dvorak="setxkbmap us -variant dvp; xmodmap ~/.Xmodmap"
alias audio="sh ~/.local/bin/audio.sh"
alias copythis="xclip -selection clipboard"
alias herigone="python ~/personal/herigone/main.py"
alias catzip="unzip -l"
alias tkill="tmux kill-server"
alias howmuch="du -h --max-depth=1"
alias exca="mv ~/Downloads/*.excalidraw ~/university/boards/"
alias mountpoints="lsblk"
alias mountusb="sudo mount /dev/sdb1 /mnt/usb"
alias lusb="l /mnt/usb"
alias backspace="xmodmap -e 'keycode 22 = NoSymbol'"
alias control="xmodmap -e 'keycode 66 = NoSymbol'; xmodmap -e 'clear control'"
alias note="nvim ~/Documents/apuntes.md"
alias dark="sed -i -e 's/github_light/github_dark_default/' ~/.config/alacritty/alacritty.toml"
alias light="sed -i -e 's/github_dark_default/github_light/' ~/.config/alacritty/alacritty.toml"
alias down="cd ~/Downloads"
alias doc="cd ~/Documents"
alias pic="cd ~/Pictures"
alias vid="cd ~/Videos"
alias pom="gnome-pomodoro"

# anki
alias apro="python ~/.dotfiles/bin/anki_prompt.py"
alias ares="python ~/.dotfiles/bin/anki_response.py"

# workspaces
alias personal="cd ~/personal"
alias projects="cd ~/projects"
alias university="cd ~/university"

# pdf
alias pdprompt="python ~/.dotfiles/bin/pdf_reader.py"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# go
export PATH=$PATH:/usr/local/go/bin

# anaconda
[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/usr/etc/profile.d/conda.sh" ]; then
#         . "/usr/etc/profile.d/conda.sh"
#     else
#         export PATH="/usr/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
