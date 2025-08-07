# Autostart template

```bash
#!/bin/bash
function run {
	if ! pgrep -x $(basename $1 | head -c 15) 1>/dev/null; then
		$@ &
	fi
}

run nm-applet &
run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueberry-tray &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
run volumeicon &
xmodmap ~/.Xmodmap &
parcellite --no-icon &
firefox &
gnome-pomodoro --no-default-window &
alacritty -e tmux &
# xgamma -gamma 0.8
```
