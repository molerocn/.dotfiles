import os
from io import open

qwerty_maps = ["n", "t", "h"]
dvorak_maps = []
test_maps = []


def source(maps: list) -> list:
    def my_map(item):
        if type(item) == list:
            return [item[0], item[1]]
        else:
            return [item, item]

    map(my_map, maps)
    return maps


if __name__ == "__main__":
    with open("keys.conf", "a") as file:
        switch_phrase = "switch-to-workspace-<index>=['<map>']"
        move_phrase = "move-to-workspace-<index>=['<map>']"

        list_mapped = source(qwerty_maps)
        content = []
        for index, map in enumerate(list_mapped):
            content.append(switch_phrase.replace("<index>", str(index+1)).replace("<map>", f"<Alt>{map}") + "\n")
            content.append(move_phrase.replace("<index>", str(index+1)).replace("<map>", f"<Control><Alt>{map}") + "\n")

        file.writelines(content)

    os.system("cat keys.conf")

    # os.system("dconf load /org/gnome/desktop/wm/keybindings/ < keysdvorak.conf")
