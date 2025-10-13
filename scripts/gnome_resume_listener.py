import gi
import subprocess
gi.require_version('Gio', '2.0')
from gi.repository import Gio, GLib

# def is_pomodoro_modal_running():
#     try:
#         # pgrep -f busca coincidencias en toda la línea de comando
#         result = subprocess.run(
#             ["pgrep", "-f", "pomodoro.py"],
#             stdout=subprocess.DEVNULL,
#             stderr=subprocess.DEVNULL
#         )
#         return result.returncode == 0
#     except Exception as e:
#         print(f"Error verificando pomodoro.py: {e}")
#         return False

def on_sleep_signal(connection, sender_name, object_path, interface_name, signal_name, parameters):
    sleeping = parameters.unpack()[0]
    if sleeping:
        # subprocess.Popen(['gnome-pomodoro', '--pause'])
        subprocess.Popen(['playerctl', 'pause'])
    else:
        subprocess.Popen(['/home/molerocn/personal/.dotfiles/bin/toggle_theme', 'automatic'])
        # if not is_pomodoro_modal_running():
        #     subprocess.Popen(['gnome-pomodoro', '--resume'])

bus = Gio.bus_get_sync(Gio.BusType.SYSTEM, None)
bus.signal_subscribe(
    None,
    "org.freedesktop.login1.Manager",
    "PrepareForSleep",
    None,
    None,
    Gio.DBusSignalFlags.NONE,
    on_sleep_signal
)

GLib.MainLoop().run()

