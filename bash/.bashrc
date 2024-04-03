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

alias gaa="git add ."
alias gic="git commit -m"
alias gst="git status"
alias gs="git status"
alias gsnt="git status"
alias gstn="git status"
alias glog="git log --oneline --decorate --graph --all"
alias gce="git commit --amend --no-edit"
alias g="git"
alias py="python"

alias vim="nvim"
alias ivm="nvim"
alias vmi="nvim"
alias mvi="nvim"
alias imv="nvim"
alias vim.="nvim ."
alias ivm.="nvim ."
alias vmi.="nvim ."
alias mvi.="nvim ."

alias ebash="nvim ~/.bashrc"
alias sbash="clear; source ~/.bashrc"
alias tree="tree -C -I 'node_modules'"
alias update="sudo pacman -Syu"
alias upgrade="sudo pamac upgrade"
alias d="cd"
alias restart="qtile cmd-obj -o cmd -f restart"

alias devorak="xmodmap ~/.Xmodmap"
alias audio="sh ~/.local/bin/audio.sh"

alias config="nvim ~/.dotfiles/qtile/config.py";
alias copythis="xclip -selection clipboard"

alias herigone="python ~/personal/herigone/main.py"
alias catzip="unzip -l"
alias tkill="tmux kill-server"
alias howmuch="du -h --max-depth=1"
alias exca="mv ~/Downloads/*.excalidraw ~/university/boards/"
alias mountpoints="lsblk"
alias mountusb="sudo mount /dev/sdb1 /mnt/usb; cd /mnt/usb"
alias backspace="xmodmap -e 'keycode 22 = NoSymbol'"
alias note="nvim ~/Documents/apuntes.md"

# anki
alias aprompt="python ~/.dotfiles/bin/anki_prompt.py"
alias catprompt="cat ~/Documents/anki/anki_prompt.txt"
alias aresponse="python ~/.dotfiles/bin/anki_response.py"

# pdf
alias pdprompt="python ~/.dotfiles/bin/pdf_reader.py"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# java
# export PATH=$HOME/.jdks/openjdk-21.0.2/bin:$PATH

# go
export PATH=$PATH:/usr/local/go/bin

# anaconda
[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh

# # theming
# alacritty_config="$HOME/.config/alacritty/alacritty.toml"
# current_hour=$(date +"%H")
# if [ "$current_hour" -ge 17 ] && [ "$current_hour" -le 23 ] || [ "$current_hour" -ge 0 ] && [ "$current_hour" -le 6 ]; then
#     if grep -q 'github_light' "$alacritty_config"; then
#         sed -i -e 's/github_light/gruvbox_dark' "$alacritty_config"
#     fi
# else
#     if grep -q 'gruvbox_dark' "$alacritty_config"; then
#         sed -i -e 's/gruvbox_dark/github_light' "$alacritty_config" 
#     fi
# fi
