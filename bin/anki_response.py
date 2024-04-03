import pyperclip
import os

file_path = os.path.expanduser("~/Documents/anki_source.txt")
contenido = pyperclip.paste()

with open(file_path, "w+") as file:
    file.write(contenido)
