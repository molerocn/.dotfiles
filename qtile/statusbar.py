from libqtile.widget import WindowName, Memory, Volume, CurrentLayout, Clock, Systray, Sep, GroupBox
from libqtile import qtile

class Statusbar:
    panel_background = ["#18181b","#18181b"] 
    group_selected = ["#1e40af", "#1e40af"]
    group_inactive = ["#52525b", "#52525b"]
    white = ["#fafafa", "#fafafa"]
    font = "Ubuntu"
    font_size = 13

    spacer = Sep(linewidth=0, padding=5, background=panel_background)

    workspaces = GroupBox(font=font, fontsize=font_size, margin_y=2, margin_x=0, padding_y=5,
        padding_x=3, borderwidth=3, active=white, inactive=group_inactive, rounded=False,
        highlight_method="block", urgent_alert_method="block", this_current_screen_border=group_selected,
        this_screen_border=panel_background, other_current_screen_border=panel_background,
        other_screen_border=panel_background, foreground=white, background=panel_background,
        disable_drag=True)

    window_name =  WindowName(foreground=white, font=font,
        background=panel_background, fontsize=font_size, padding=0)

    systray = Systray(background=panel_background)

    memory = Memory(foreground=white, background=panel_background, font=font,
        mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("alacritty" + " -e htop")},
        fontsize=font_size)

    volume = Volume(font=font, foreground=white, background=panel_background,
        padding=5, fontsize=font_size)

    layout = CurrentLayout(foreground=white, fontsize=font_size,
        background=panel_background, padding=5, font=font)

    clock = Clock(foreground=white, background=panel_background, font=font,
        fontsize=font_size, format="%B %d - %H:%M")

    def get_default_widgets(self):
        return [self.workspaces, self.spacer, self.window_name, self.systray, self.memory,
                self.volume, self.layout, self.clock]
