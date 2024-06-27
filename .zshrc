export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
alias get='sudo apt install'

# conda initialize
__conda_setup="$('/home/juancamr/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/juancamr/miniconda3/etc/profile.d/conda.sh" ]; then
# . "/home/juancamr/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
    else
# export PATH="/home/juancamr/miniconda3/bin:$PATH"  # commented out by conda initialize
    fi
fi
unset __conda_setup

# bun completions
[ -s "/home/juancamr/.bun/_bun" ] && source "/home/juancamr/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

function vimf() {
    selected=$(find . -type d \( -name node_modules -o -name .git -o -name __pycache__ \) -prune -o -type f -print | fzf)
    if [[ -n "$selected" ]]; then
        nvim "$selected"
    fi
}

bindkey -s '^E' '\025nvim .\r'
bindkey -s '^G' 'vimf\r'
bindkey -s '^F' '~/.local/bin/tmux-sessionizer \r'
bindkey -s '^B' 'tmux a\r'
bindkey -r '^S'
bindkey -r '^R'

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

alias docsql='mysql -u root -h 172.17.0.2 -p'
alias notepad="gnome-text-editor"
