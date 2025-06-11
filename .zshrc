export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh

bindkey -s '^E' '^U\025nvim .\r'
bindkey -s '^F' '^U~/.local/bin/tmux-sessionizer \r'
bindkey -s '^B' '^Utmux a\r'
# bindkey -r '^S'

# functions
function cfile() {
    archivo=$(find . -type f | fzf)
    copy < "$archivo"
}

export ANKI_WAYLAND=1

# aliases
alias docsql='mysql -u root -h 172.17.0.2 -p'
alias notepad="gnome-text-editor"
alias sc="source ~/.zshrc"
alias esc="nvim ~/.zshrc"
export PATH=$HOME/.local/bin:$PATH
alias a="ls -lah"
alias at="ls -lahtr"
alias vim="nvim"
alias mountwin="sudo mount /dev/nvme0n1p3 /mnt/win"
alias win="cd /mnt/win"
alias opull="cd ~/personal/segunda_mente/; git pull origin main"
alias opush="cd ~/personal/segunda_mente/; git pull origin main; git add .; git commit -m '$(date "+%Y-%m-%d %H:%M:%S")'; git push origin main"
alias copy="wl-copy"
alias paste="wl-paste"
alias gic="git commit -m"
alias edge="microsoft-edge-stable"
alias isthere="sudo dpkg -l | grep "
alias get='sudo apt install -y'
alias course="python3 ~/.local/bin/courses.py"
