export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh
alias get='sudo apt install'
alias put='sudo dpkg -i'

# bun completions
[ -s "/home/juancamr/.bun/_bun" ] && source "/home/juancamr/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$PATH:$HOME/.local/go/bin"

function vimf() {
    selected=$(find . -type d \( -name node_modules -o -name .git -o -name __pycache__ \) -prune -o -type f -print | fzf)
    if [[ -n "$selected" ]]; then
        nvim "$selected"
    fi
}

bindkey -s '^E' '^U\025nvim .\r'
bindkey -s '^G' '^Uvimf\r'
bindkey -s '^F' '^U~/.local/bin/tmux-sessionizer \r'
bindkey -s '^B' '^Utmux a\r'
bindkey -r '^S'
# bindkey -r '^R'
#

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ANKI_WAYLAND=1

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
alias get="sudo apt install -y "
