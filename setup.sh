#!/bin/bash
rm ~/.bashrc
rm ~/.inputrc
rm -rf ~/.config/qtile
rm -rf ~/.config/alacritty

ln -s ~/.dotfiles/bash/.bashrc ~/.bashrc
ln -s ~/.dotfiles/bash/.inputrc ~/.inputrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.Xmodmap ~/.Xmodmap
ln -s ~/.dotfiles/alacritty ~/.config/alacritty/

mkdir ~/.local/bin
ln -s ~/.dotfiles/bin/tmux-sessionizer ~/.local/bin/tmux-sessionizer
ln -s ~/.dotfiles/bin/audio.sh ~/.local/bin/audio.sh
ln -s ~/.dotfiles/bin/open_code.sh ~/.local/bin/open_code.sh
ln -s ~/.dotfiles/bin/picom.conf ~/.local/bin/picom.conf

ln -s ~/.dotfiles/qtile ~/.config/qtile
