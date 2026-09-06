dconf load /org/gnome/desktop/wm/keybindings/ < ~/personal/.dotfiles/ubuntu/workspaces.dconf

gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25 # 30 default
gsettings set org.gnome.desktop.peripherals.keyboard delay 300 # 500 default