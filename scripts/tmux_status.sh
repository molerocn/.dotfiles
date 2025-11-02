#!/bin/bash

# --- CONFIGURACIÓN ---
# CICLOS=4   # Pomodoros por bloque
#
# # Función para obtener propiedades de gnome-pomodoro
# get_prop() {
#   gdbus call --session \
#     --dest org.gnome.Pomodoro \
#     --object-path /org/gnome/Pomodoro \
#     --method org.freedesktop.DBus.Properties.Get \
#     org.gnome.Pomodoro "$1" \
#     | grep -o '[0-9a-zA-Z._-]\+' | tail -n1
# }
#
# get_state() {
#   gdbus call --session \
#     --dest org.gnome.Pomodoro \
#     --object-path /org/gnome/Pomodoro \
#     --method org.freedesktop.DBus.Properties.Get \
#     org.gnome.Pomodoro State \
#     | cut -d"'" -f2
# }
#
# # --- POMODORO ---
# state=$(get_state)
# total=$(get_prop StateDuration)
# elapsed=$(get_prop Elapsed)
#
# remaining=$(echo "$total - $elapsed" | bc)
# minutes=$(echo "$remaining/60" | bc)
#
# case $state in
#     pomodoro)
#         pomo="work ${minutes}m"
#         ;;
#     short-break)
#         pomo="break ${minutes}m"
#         ;;
#     long-break)
#         pomo="long break ${minutes}m"
#         ;;
#     *)
#         pomo="idle"
#         ;;
# esac

# --- OTROS DATOS ---
# wifi=$(nmcli -t -f WIFI general | grep -q enabled && echo ON || echo OFF)
# bt=$(bluetoothctl show | awk '/Powered/ {print ($2=="yes"?"ON":"OFF")}')
# battery=$(cat /sys/class/power_supply/BAT0/capacity)
day_name=$(date +"%A" | tr '[:upper:]' '[:lower:]')
date_time=$(date +"%d %b %l:%M %P")

output=$(date +"%A %d %b %l:%M %P")
# --- IMPRIMIR ---
echo "$output"

