Copy all of the files in `~/.config/systemd/user/`

Reload the systemd service `systemctl --user daemon-reload`
Enable at startup `systemctl --user enable --now toggle_theme.timer`

In case you've edited the files restart it with `systemctl --user restart toggle_theme.timer`
