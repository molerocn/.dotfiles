from libqtile.layout import MonadTall, MonadWide, Matrix, Bsp, Floating, RatioTile, Max
from libqtile.widget import Memory, Volume, CurrentLayout, Clock, Systray, GroupBox, Spacer
from libqtile.config import Group, Match, Key, Screen
import os, subprocess 
from libqtile.command import lazy
from libqtile import hook, bar

MOD, ALT, SHIFT, CONTROL = "mod4", "mod1", "shift", "control"
MC, MS, MA, M, A = [MOD, CONTROL], [MOD, SHIFT], [MOD, ALT], [MOD], [ALT]
HOME = os.path.expanduser("~")
PYHASHER = f"python {HOME}/personal/pyhasher/main.py &"
TERMINAL = "alacritty"
DEVORAK = "setxkbmap us -variant dvp && xmodmap ~/.Xmodmap &"
WORKSPACES_KEYBINDINGS = ["h", "t", "n", "s", "c", "r"]
WHATSAPP = "firefox https://web.whatsapp.com &"

dgroups_key_binder = None
dgroups_app_rules = []
main = None
floating_types = ["notification", "toolbar", "splash", "dialog"]
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
wmname = "LG3D"

# Functions -----------------------------------------------------------------

@lazy.function
def capture_and_copy(_):
    screenshot_path = "/tmp/temp_capture.png"
    shutter_command = f"shutter -s -e -o {screenshot_path} && xclip -selection clipboard -target image/png -i {screenshot_path}"
    subprocess.run(shutter_command, shell=True, check=True)
    os.remove(screenshot_path)

@lazy.function
def volume_up(qtile):
    qtile.cmd_spawn("amixer -D pulse sset Master 5%+")

@lazy.function
def volume_down(qtile):
    qtile.cmd_spawn("amixer -D pulse sset Master 5%-")

@lazy.function
def kill_other_windows(qtile):
    [window.kill() for window in qtile.current_group.windows if window != qtile.current_window]

def random_wallpaper():
    os.system(f"feh --randomize --bg-fill {HOME}/Pictures/background/*")

@hook.subscribe.startup_once
def start_once():
    random_wallpaper()
    subprocess.call([HOME + "/.config/qtile/autostart.sh"])

@hook.subscribe.client_new
def set_floating(window):
    floating_types = ["notification", "toolbar", "splash", "dialog"]
    if ( window.window.get_wm_transient_for() or window.window.get_wm_type() in floating_types):
        window.floating = True

# Keybindings ---------------------------------------------------------------

obsidian_match = Match(wm_class="obsidian")
todoist_match = Match(wm_class="Todoist")
group_matches = [[], [], [todoist_match], [obsidian_match], [], []]
groups = [Group(name=name, layout="bsp", label=name, matches=matches) for name, matches in zip(WORKSPACES_KEYBINDINGS, group_matches)]

keys = [key for key_array in [[Key(M, i.name, lazy.group[i.name].toscreen()),
            Key(MC, i.name, lazy.window.togroup(i.name)),
            Key(MS, i.name, lazy.window.togroup(i.name), lazy.group[i.name].toscreen()),
        ] for i in groups] for key in key_array]

keys.extend([
    Key(M, "k", lazy.layout.up()),
    Key(M, "j", lazy.layout.down()),
    Key(M, "g", lazy.layout.left()),
    Key(M, "l", lazy.layout.right()),
    Key(MS, "f", lazy.window.toggle_fullscreen()),
    Key(MS, "q", lazy.window.kill()),
    Key(A, "q", lazy.window.kill()),
    Key(MS, "i", lazy.restart()),
    Key(MC, "l", lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio(), lazy.layout.delete()),
    Key(MC, "g", lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio(), lazy.layout.add()),
    Key(MC, "k", lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster()),
    Key(MC, "j", lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster()),
    Key(MS, "k", lazy.layout.shuffle_up()),
    Key(MS, "j", lazy.layout.shuffle_down()),
    Key(MS, "g", lazy.layout.shuffle_left()),
    Key(MS, "l", lazy.layout.shuffle_right()),
    Key(M, "m", lazy.window.toggle_floating()),
    Key(M, "space", lazy.next_layout()),
])

keys.extend([
    Key(M, "Return", lazy.spawn(TERMINAL)),
    Key(A, "s", lazy.function(lambda _: os.system(PYHASHER))),
    Key(A, "a", lazy.window.toggle_fullscreen()),
    Key(M, "x", lazy.spawn("archlinux-logout")),
    Key(M, "d", lazy.spawn("dmenu_run")),
    Key(M, "b", lazy.spawn("firefox")),
    Key(M, "e", lazy.spawn("thunar")),
    Key(MA, "n", lazy.function(lambda _: random_wallpaper())),
    Key(MA, "d", lazy.function(lambda _: os.system(DEVORAK))),
    Key(MA, "s", lazy.function(lambda _: os.system("setxkbmap es"))),
    Key(M, "f", lazy.function(lambda _: os.system("~/.local/bin/open_code.sh &"))),
    Key(M, "w", lazy.function(lambda _: os.system(WHATSAPP))),
    Key(MA, "t", kill_other_windows),
    Key(MS, "p", capture_and_copy),
    Key(M, "v", volume_up),
    Key(MS, "v", volume_down),
])

# Layouts ---------------------------------------------------------------------

windows = ["confirm", "dialog", "download", "error", "file_progress",
           "notification", "splash", "toolbar", "archlinux-logout",
           "Thunar", "pavucontrol", "shutter"]
float_rules = [*Floating.default_float_rules]
float_rules.extend([Match(wm_class=window) for window in windows])
floating_layout = Floating(float_rules = float_rules, fullscreen_border_width = 0, border_width = 0)

b_active, b_inactive = ["#0c4a6e", "#0c4a6e"], ["#030712", "#030712"]
layout_theme = { "margin": 0, "border_width": 1, "border_focus": b_active, "border_normal": b_inactive }
q_layouts = [MonadTall, MonadWide, Matrix, Bsp, Floating, RatioTile, Max]
layouts = [layout(**layout_theme) for layout in q_layouts]

widgets_list = [GroupBox(highlight_method="block", rounded=False), Spacer(), Systray(), Memory(), Volume(), CurrentLayout(), Clock(format="%B %d - %H:%M")]
screens = [Screen(bottom=bar.Bar(widgets=widgets_list, size=20, opacity=1))]
