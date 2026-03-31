export ZSH="$HOME/.oh-my-zsh"
export DOTFILES=$HOME/personal/.dotfiles
export PATH=$HOME/.local/bin:$PATH
export PATH=$DOTFILES/bin:$PATH

ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
source /usr/share/fzf/shell/key-bindings.zsh

bindkey -s '^E' '^Uvim .\r'
# bindkey -s '^N' '^Unotebook\r'
bindkey -s '^Y' '^Udolphin . > /dev/null 2>&1 & \r'
bindkey -s '^F' '^U$DOTFILES/bin/tmux-sessionizer \r'
bindkey -s '^G' '^U$DOTFILES/bin/notebook \r'
bindkey -s '^B' '^Utmux a\r'
bindkey -r '^S'
bindkey '^ ' autosuggest-accept

alias notepad="kwrite"
alias sc="source ~/.zshrc"
alias esc="nvim ~/.zshrc"
alias a="ls -lah"
alias at="ls -lahtr ~/Downloads"
alias atd="ls -lahtr"
alias copy="wl-copy"
alias paste="wl-paste"
alias cpwd='pwd | copy'
alias open='nohup xdg-open >/dev/null 2>&1'
alias get="sudo dnf install"
alias space-in-disk="df -h"
alias howmuch="du -ha -d 1 | sort -rh | head -n 10"
alias knb='pkill marimo'

cde() { local target=$(get-tmux-root); cd "$target" }
