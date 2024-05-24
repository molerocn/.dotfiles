from libqtile.layout import MonadTall, MonadWide, Matrix, Bsp, Floating, RatioTile, Max
from libqtile.widget import Memory, Volume, CurrentLayout, Clock, GroupBox, CPU, Systray, WindowName
from libqtile.config import Group, Match, Key, Screen
from libqtile.command import lazy
from libqtile import hook, bar
import os, subprocess 

MOD, ALT, SHIFT, CONTROL = "mod4", "mod1", "shift", "control"
MC, MS, MA, M, A, AS = [MOD, CONTROL], [MOD, SHIFT], [MOD, ALT], [MOD], [ALT], [ALT, SHIFT]
rh_kbds_wkps = ["h", "t", "n", "s", "c"]

HOME = os.path.expanduser("~")

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
def capture_and_copy():
    screenshot_path = "/tmp/temp_capture.png"
    shutter_command = f"shutter -s -e -o {screenshot_path} && xclip -selection clipboard -target image/png -i {screenshot_path} &"
    subprocess.run(shutter_command, shell=True, check=True)
    os.remove(screenshot_path)

def manage_volume(qtile, direction: int):
    qtile.cmd_spawn(f"amixer -D pulse sset Master 5%{'+' if direction == 1 else '-'}")

@hook.subscribe.startup_once
def start_once():
    subprocess.call([HOME + "/.config/qtile/autostart.sh"])

@hook.subscribe.client_new
def set_floating(window):
    floating_types = ["notification", "toolbar", "splash", "dialog"]
    if ( window.window.get_wm_transient_for() or window.window.get_wm_type() in floating_types):
        window.floating = True

# Keybindings ---------------------------------------------------------------

alacritty_match = Match(wm_class="Alacritty")
group_matches = [[], [alacritty_match], [], [], []]
groups = [Group(name=str(index+1), label=str(index+1), layout="bsp", matches=matches) for index, matches in enumerate(group_matches)]
keys = []
for group, keymap in zip(groups, rh_kbds_wkps):
    keys.extend([
                    Key(A, keymap, lazy.group[group.name].toscreen()),
                    Key(AS, keymap, lazy.window.togroup(group.name), lazy.group[group.name].toscreen())
                ])
# for group, keymap_rh, keymap_lh in zip(groups, rh_kbds_wkps, lh_kbds_wkps):
#     keys.extend([ Key(M, keymap_rh, lazy.group[group.name].toscreen()),
#                  Key(MS, keymap_rh, lazy.window.togroup(group.name), lazy.group[group.name].toscreen())])
#                 Key(M, keymap_lh, lazy.group[group.name].toscreen()),

lay = lazy.layout
movements = [["k", lay.up(), lay.shuffle_up()], ["j", lay.down(), lay.shuffle_down()], ["g", lay.left(), lay.shuffle_left()], ["l", lay.right(), lay.shuffle_right()]]
keys.extend([Key(M, movement[0], movement[1]) for movement in movements])
keys.extend([Key(MS, movement[0], movement[2]) for movement in movements])

keys.extend([
    Key(M, "period", lazy.window.toggle_fullscreen()),
    Key(A, "q", lazy.window.kill()),
    Key(MS, "q", lazy.window.kill()),
    Key(MS, "i", lazy.restart()),
    Key(MC, "l", lazy.layout.grow_right(), lazy.layout.grow(), lazy.layout.increase_ratio(), lazy.layout.delete()),
    Key(MC, "g", lazy.layout.grow_left(), lazy.layout.shrink(), lazy.layout.decrease_ratio(), lazy.layout.add()),
    Key(MC, "k", lazy.layout.grow_up(), lazy.layout.grow(), lazy.layout.decrease_nmaster()),
    Key(MC, "j", lazy.layout.grow_down(), lazy.layout.shrink(), lazy.layout.increase_nmaster()),
    Key(M, "m", lazy.window.toggle_floating()),
])

keys.extend([
    Key(M, "Return", lazy.spawn("alacritty")),
    Key(M, "x", lazy.spawn("archlinux-logout")),
    Key(A, "space", lazy.spawn("dmenu_run")),
    Key(M, "b", lazy.spawn("firefox")),
    Key(M, "v", lazy.function(lambda qtile: manage_volume(qtile, 1))),
    Key(MS, "v", lazy.function(lambda qtile: manage_volume(qtile, -1))),
    Key(M, "p", lazy.function(lambda _: capture_and_copy())),
])

# Layouts ---------------------------------------------------------------------

b_active, b_inactive = ["#4863A0", "#4863A0"], ["#030712", "#030712"]
layout_theme = { "margin": 0, "border_width": 1, "border_focus": b_active, "border_normal": b_inactive }
q_layouts = [MonadTall, MonadWide, Matrix, Bsp, Floating, RatioTile, Max]
layouts = [layout(**layout_theme) for layout in q_layouts]

windows = ["confirm", "dialog", "download", "error", "file_progress", "notification", "splash", "toolbar", "archlinux-logout", "pavucontrol", "shutter"]
float_rules = [*Floating.default_float_rules]
float_rules.extend([Match(wm_class=window) for window in windows])
floating_layout = Floating(float_rules = float_rules, **layout_theme)

widgets_list = [
    GroupBox(highlight_method="block", rounded=False, disable_drag=True, toggle=False, use_mouse_wheel=False),
    WindowName(),
    CPU(),
    Memory(),
    Volume(),
    CurrentLayout(),
    Clock(format="%A, %B %d - %H:%M"),
    Systray()
]
screens = [Screen(bottom=bar.Bar(widgets=widgets_list, size=20, opacity=1))]
