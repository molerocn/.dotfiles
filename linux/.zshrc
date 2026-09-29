export ZSH="$HOME/.oh-my-zsh"
export DOTFILES=$HOME/personal/.dotfiles
export PATH=$HOME/.local/bin:$PATH
export PATH=$DOTFILES/linux/bin:$PATH

ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source ~/personal/.dotfiles/linux/functions.zsh
bindkey '^ ' autosuggest-accept
bindkey '^H' change_dir_faster
bindkey -r "^S"

alias sc="source ~/.zshrc"
alias esc="vim ~/.zshrc"
alias a="ls -lah"
alias at="ls -lahtr ~/Downloads"
alias atd="ls -lahtr"
alias copy="wl-copy"
alias paste="wl-paste"
alias cpwd='pwd | copy'
alias open='nohup xdg-open >/dev/null 2>&1'
alias get="sudo apt install"
alias notepad="gnome-text-editor"
alias space-in-disk="df -h"
alias howmuch="du -ha -d 1 | sort -rh | head -n 10"
alias cde='cd -'