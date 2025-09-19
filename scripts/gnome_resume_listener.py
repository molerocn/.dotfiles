#!/usr/bin/env python3
import gi, subprocess
gi.require_version('Gio', '2.0')
from gi.repository import Gio, GLib

def on_sleep_signal(connection, sender_name, object_path, interface_name, signal_name, parameters):
    sleeping = parameters.unpack()[0]
    if not sleeping:  # al reanudar
        import subprocess
        subprocess.Popen(['/home/molerocn/personal/.dotfiles/bin/toggle_theme', 'automatic'])

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

