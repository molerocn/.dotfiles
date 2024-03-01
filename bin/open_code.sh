#!/bin/bash

DIRECTORIOS=("$HOME/data")

carpetas=()
for dir in "${DIRECTORIOS[@]}"; do
    carpetas+=($(find "$dir" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;))
done

seleccion=$(printf "%s\n" "${carpetas[@]}" | dmenu -i -p "Select a project: ")

if [ -n "$seleccion" ]; then
    for dir in "${DIRECTORIOS[@]}"; do
        if [[ -d "$dir/$seleccion" ]]; then
            cd "$dir/$seleccion"
            code --reuse-window .
            exit 0
        fi
    done
else
    echo "No project selected"
fi

