export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/bin:$PATH
export ANKI_WAYLAND=1

ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh

bindkey -s '^E' '^U\025nvim .\r'
bindkey -s '^F' '^U~/.local/bin/tmux-sessionizer \r'
bindkey -s '^B' '^Utmux a\r'
bindkey -s '^O' '^Ucreate_note \r'
bindkey -s '^S' '^Uankiex \r'
# bindkey -r '^S'
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
alias win="cd /mnt/win"
alias copy="wl-copy"
alias paste="wl-paste"
alias gic="git commit -m"
alias edge="microsoft-edge-stable"
alias isthere="sudo dpkg -l | grep "
alias get="sudo apt install -y"
alias gett="sudo dpkg -i"
alias course="python3 ~/.local/bin/courses.py"
alias material="nautilus ~/personal/segunda_mente/Universidad/zMaterial/"
alias turnoff="closeall; shutdown now"
alias launcher="wofi --normal-window --dmenu --width 400 --height 200 --xoffset 760 --yoffset 440 -S drun"
alias puml="java -jar ~/Downloads/plantuml.jar"
alias light="sed -i 's/github_dark_default/github_light/' ~/.config/alacritty/alacritty.toml"
alias dark="sed -i 's/github_light/github_dark_default/' ~/.config/alacritty/alacritty.toml"
alias open="xdg-open"
alias kandroid="pkill studio; pkill qemu; pkill java"
alias ankiex="/usr/bin/python3 ~/.local/bin/anki_import.py"

export SYNC_USER1=carlos.molero.n@gmail.com:09241688jc
