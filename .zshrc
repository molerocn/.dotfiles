setopt NO_NOMATCH # no mostrar errores tras no coincidir con ? o *
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/personal/.dotfiles/bin:$PATH
export USBS=/run/media/molerocn
export WIN=/mnt/win
export ANKI_WAYLAND=1

ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh

bindkey -s '^E' '^U\025nvim .\r'
bindkey -s '^Y' '^Unautilus . > /dev/null 2>&1 & \r'
bindkey -s '^F' '^U~/personal/.dotfiles/bin/tmux-sessionizer \r'
bindkey -s '^B' '^Utmux a\r'
bindkey -s '^O' '^Ucreate_note \r'
# bindkey -s '^S' '^Uankiex \r'
bindkey -r '^S'
bindkey '^ ' autosuggest-accept

# aliases
alias docsql='mysql -u root -h 172.17.0.2 -p'
alias notepad="gnome-text-editor"
alias sc="source ~/.zshrc"
alias esc="nvim ~/.zshrc"
alias a="ls -lah"
alias at="ls -lahtr"
alias vim="nvim"
alias mountwin="sudo mount /dev/nvme0n1p3 /mnt/win"
alias copy="wl-copy"
alias paste="wl-paste"
alias gic="git commit -m"
alias edge="microsoft-edge-stable"
alias turnoff="closeall; shutdown now"
alias launcher="wofi --normal-window --dmenu --width 400 --height 200 --xoffset 760 --yoffset 440 -S drun"
alias puml="java -jar ~/Downloads/plantuml.jar"
alias light="sed -i 's/github_dark_default/github_light/' ~/.config/alacritty/alacritty.toml"
alias dark="sed -i 's/github_light/github_dark_default/' ~/.config/alacritty/alacritty.toml"
alias open="xdg-open"
alias kandroid="pkill studio; pkill qemu; pkill java"
alias ankiex="/usr/bin/python3 ~/.local/bin/anki_import.py"
alias lpart="lsblk"
alias usboff="udisksctl unmount -b /dev/sda1; udisksctl power-off -b /dev/sda"
alias book="open ~/Documents/libros/fundamentos\ matematicos/mml-without-margin.pdf &"
alias usbs="cd /run/media/molerocn/; ls -lah"
alias supercp="rsync -ah --progress"
alias jlab="/opt/JupyterLab/jupyterlab-desktop"
alias mlrc="mlr --csv"
alias mlrcs='mlr --csv --ifs=";"'
alias cpwd='pwd | copy'
alias balsamiq="wine $WIN/Program\ Files/Balsamiq\ Mockups/Balsamiq\ Mockups\ 3.exe"
alias epaste="echo $(paste)"
alias open='nohup xdg-open >/dev/null 2>&1'
# alias tre="trans -b en:es"
# alias tr="trans -b es:en"

# my nasty functions
function mkdirc() {
    mkdir $1
    cd $1
}
function te() {
    trans -b en:es "$*"
}

function ts() {
    trans -b es:en "$*"
}
