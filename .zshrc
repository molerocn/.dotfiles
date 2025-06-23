export ZSH="$HOME/.oh-my-zsh"
export PATH=$HOME/.local/bin:$PATH

ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
    git
    # zsh-syntax-highlighting
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh

bindkey -s '^E' '^U\025nvim .\r'
bindkey -s '^F' '^U~/.local/bin/tmux-sessionizer \r'
bindkey -s '^B' '^Utmux a\r'
bindkey -r '^S'
bindkey '^ ' autosuggest-accept

# functions
# function cfile() {
#     file=$(fd . --type f | fzf)
#     wl-copy < "$file"
#     return 1
# }

export ANKI_WAYLAND=1

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
alias opull="cd ~/personal/segunda_mente/; git pull origin main"
alias opush="cd ~/personal/segunda_mente/; git pull origin main; git add .; git commit -m '$(date "+%Y-%m-%d %H:%M:%S")'; git push origin main"
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
## Initialization code that may require console input (password prompts, [y/n]
## confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

export TSTRUCT_TOKEN="tstruct_eyJ2ZXJzaW9uIjoxLCJkYXRhIjp7InVzZXJJRCI6NzEwNzMyMTQsInVzZXJFbWFpbCI6ImNhcmxvcy5tb2xlcm8ubkBnbWFpbC5jb20iLCJ0ZWFtSUQiOjE0OTY0Nzc4OTUsInRlYW1OYW1lIjoiY2FybG9zLm1vbGVyby5uQGdtYWlsLmNvbSdzIHRlYW0iLCJyZW5ld2FsRGF0ZSI6IjIwMjUtMDYtMjRUMjE6NDY6NTAuOTA5MDUzMjUyWiIsImNyZWF0ZWRBdCI6IjIwMjUtMDYtMTdUMjE6NDY6NTAuOTA5MDU0MDg1WiJ9LCJzaWduYXR1cmUiOiIzQmFSOURydkdBeGp2VHpqeUZJSXFMZTQ3ZkdJNkdQSUlON1RPckZoSjcxbkh0bWYwZ1p0ZXVzM0JOampaYmtYcFhJdjJpbHBMbkdBY082OGJZV3VDdz09In0="
