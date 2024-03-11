#!/bin/bash

DIRECTORIOS=("$HOME/data" "$HOME/personal" "$HOME/university" "$HOME/projects")

proyectos=()
for dir in "${DIRECTORIOS[@]}"; do
    while IFS= read -r -d '' proyecto; do
        proyectos+=("$proyecto")
    done < <(find "$dir" -maxdepth 1 -mindepth 1 -type d -print0)
done

seleccion=$(printf "%s\n" "${proyectos[@]}" | rofi -dmenu -i -p "Select a project")

if [ -n "$seleccion" ]; then
    cd "$seleccion"
    code --reuse-window .
    exit 0
else
    echo "No project selected"
fi

