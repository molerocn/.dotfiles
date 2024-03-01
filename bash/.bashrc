# Enable the subsequent settings only in interactive sessions
case $- in
*i*) ;;
*) return ;;
esac

export OSH='/home/juancamr/.oh-my-bash'
export PATH="$PATH:$HOME/bin"
export TERM="xterm-256color"
OSH_THEME="robbyrussell"
# OSH_THEME="agnoster"
OMB_USE_SUDO=true
completions=(git composer ssh)
aliases=(general)
plugins=(git bashmarks)

function codev() {
  local dir
  dir=$(find ~/personal ~/projects ~/work -maxdepth 1 -type d | fzf +m) && cd "$dir" && code --reuse-window . || return
}

# create a new directory and enter it
function create() {
  mkdir -p "$@" && cd "$@"
}

source "$OSH"/oh-my-bash.sh
source /usr/share/fzf/key-bindings.bash

alias gaa="git add ."
alias gic="git commit -m"
alias gst="git status"
alias gs="git status"
alias gsnt="git status"
alias glog="git log --oneline --decorate --graph --all"
alias gce="git commit --amend --no-edit"
alias g="git"
alias py="python"

alias vim="nvim"
alias ivm="nvim"
alias vmi="nvim"
alias mvi="nvim"
alias imv="nvim"
alias v="nvim"
alias v.="nvim ."
alias .v="nvim ."

alias ebash="nvim ~/.bashrc"
alias sbash="clear; source ~/.bashrc"
alias tree="tree -C -I 'node_modules'"
alias update="sudo pacman -Syu"
alias upgrade="sudo pamac upgrade"
alias evim="nvim ~/.config/nvim"

alias restart="qtile-cmd -o cmd -f restart"

alias devorak="xmodmap ~/.Xmodmap"
alias audio="sh ~/.local/bin/audio.sh"

alias settings="cd ~/.config/qtile; nvim ."
alias copythis="xclip -selection clipboard"

alias dev="code --reuse-window"
alias herigone="python ~/personal/herigone/main.py"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# go
export PATH=$PATH:/usr/local/go/bin

# anaconda
[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh
