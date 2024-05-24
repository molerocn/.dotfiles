#!/bin/bash

# Obtén el volumen actual del sink predeterminado
CURRENT_VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')

# Incremento/Decremento del volumen
CHANGE=$1

# Nueva cantidad de volumen
if [[ "$CHANGE" == "up" ]]; then
    NEW_VOLUME=$((CURRENT_VOLUME + 10))
elif [[ "$CHANGE" == "down" ]]; then
    NEW_VOLUME=$((CURRENT_VOLUME - 10))
fi

# Limitar el volumen máximo a 100%
if [[ "$NEW_VOLUME" -gt 100 ]]; then
    NEW_VOLUME=100
fi

# Asegurarse de que el volumen no sea menor a 0%
if [[ "$NEW_VOLUME" -lt 0 ]]; then
    NEW_VOLUME=0
fi

# Establecer el nuevo volumen
pactl set-sink-volume @DEFAULT_SINK@ ${NEW_VOLUME}%
