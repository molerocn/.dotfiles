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

source "$OSH"/oh-my-bash.sh
source /usr/share/fzf/key-bindings.bash

alias gaa="git add ."
alias gic="git commit -m"
alias gst="git status"
alias glog="git log --oneline --decorate --graph --all"
alias gce="git commit --amend --no-edit"
alias g="git"
alias py="python"
alias vim="nvim"
alias ivm="nvim"
alias vmi="nvim"
alias ebash="nvim ~/.bashrc"
alias sbash="clear; source ~/.bashrc"
alias tree="tree -C -I 'node_modules'"
alias update="sudo pacman -Syu"
alias upgrade="sudo pamac upgrade"

alias devorak="xmodmap ~/.Xmodmap"
alias audio="sh ~/.local/bin/audio.sh"

alias settings="cd ~/.config/qtile; nvim ."
alias copythis="xclip -selection clipboard"
