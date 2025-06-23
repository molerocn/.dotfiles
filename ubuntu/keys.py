import os
import sys
from io import open

dvorak_maps = ["a", "apostrophe", "o", ["comma", "w"], "e", "period"]
qwerty_maps = ["a", "q", "s", "w", "d", "e"]
colemak_maps = ["a", "q", "r", "w", "s", "f"]
test_maps = []


def source(maps: list) -> list:
    def my_map(item):
        if isinstance(item, list):
            return [item[0], item[1]]
        else:
            return [item, item]

    return list(map(my_map, maps))

def write_maps(maps):
    with open("keys.conf", "w+") as file:
        switch_phrase = "switch-to-workspace-<index>=['<map>']"
        move_phrase = "move-to-workspace-<index>=['<map>']"

        list_mapped = source(maps)
        content = ["[/]\n"]
        for index, map in enumerate(list_mapped):
            content.append(switch_phrase.replace("<index>", str(index+1)).replace("<map>", f"<Alt>{map[0]}") + "\n")
            content.append(move_phrase.replace("<index>", str(index+1)).replace("<map>", f"<Control><Alt>{map[1]}") + "\n")

        file.writelines(content)


if __name__ == "__main__":
    layout = sys.argv[1]
    keymap = []
    if (layout == "dvorak"):
        keymap = dvorak_maps
    elif (layout == "qwerty"):
        keymap = qwerty_maps
    elif (layout == "colemak"):
        keymap = colemak_maps
    else:
        print("Not a valid layout")

    write_maps(keymap)
    os.system("dconf load /org/gnome/desktop/wm/keybindings/ < keys.conf")
