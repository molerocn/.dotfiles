export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git)

if [ -f $ZSH/oh-my-zsh.sh ]; then
  source $ZSH/oh-my-zsh.sh
fi

export PAGER='most'

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/fzf/key-bindings.zsh

setopt GLOB_DOTS
unsetopt SHARE_HISTORY

[[ $- != *i* ]] && return

export HISTCONTROL=ignoreboth:erasedups

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

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

function vimf() {
    selected=$(find . -type d \( -name node_modules -o -name .git -o -name __pycache__ \) -prune -o -type f -print | fzf)
    if [[ -n "$selected" ]]; then
        nvim "$selected"
    fi
}

bindkey -s '^E' 'nvim .\r'
bindkey -s '^G' 'vimf\r'
bindkey -s '^F' '~/.local/bin/tmux-sessionizer \r'
bindkey -r "^S"

alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

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
alias layout="setxkbmap us -variant dvp; xmodmap ~/.Xmodmap"
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
alias a="l"
alias get="sudo apt install"

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

# bun completions
[ -s "/home/juancamr/.bun/_bun" ] && source "/home/juancamr/.bun/_bun"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/juancamr/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/juancamr/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/juancamr/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/juancamr/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$PATH:/opt/nvim-linux64/bin"
export MODULAR_HOME="/home/juancamr/.modular"
export PATH="/home/juancamr/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
