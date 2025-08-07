import subprocess
import os
import re
import sys

is_first_time = True

def seleccionar_deck_con_fzf():
    comando = r"""
    cd ~/personal/segunda_mente && \
    find . -type d \
    -not -path "*/.git*" \
    -not -path "*/.obsidian*" \
    -not -path "*/__pycache__*" \
    -not -path "*/.*" \
    | sed 's|^\./||' \
    | grep -v '^$' \
    | sed 's|/|::|g' \
    | fzf
    """
    resultado = subprocess.run(comando, shell=True, stdout=subprocess.PIPE, text=True)
    return resultado.stdout.strip()

def seleccionar_archivo_md():
    comando_fzf = r"""
    find ~/personal/segunda_mente/ -type f -name '*.md' -print0 \
    | xargs -0 stat --format '%Y %n' \
    | sort -nr \
    | cut -d' ' -f2- \
    | sed 's|.*/personal/segunda_mente/||' \
    | fzf \
    | sed 's|^|~/personal/segunda_mente/|'
    """
    resultado = subprocess.run(comando_fzf, shell=True, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)
    ruta_completa = resultado.stdout.strip()
    return os.path.expanduser(ruta_completa) if ruta_completa else None


def normalizar_indentacion(linea):
    return linea.replace('\t', '    ')


def procesar_md_respetando_indentacion_desde_lineas(lineas):
    tarjetas = []
    clave_actual = None
    lista_actual = []

    for linea in lineas:
        original = linea.rstrip('\n')
        original = normalizar_indentacion(original)

        match_linea_simple = re.match(r'^\s*-\s*(.*?)\s*::\s*(.+)$', original)
        if match_linea_simple:
            clave = match_linea_simple.group(1).strip()
            valor = match_linea_simple.group(2).strip()
            tarjetas.append(f"{clave}|{valor}")
            continue

        match_inicio_lista = re.match(r'^\s*-\s*(.*?)\s*::\s*$', original)
        if match_inicio_lista:
            if clave_actual and lista_actual:
                tarjetas.append(f"{clave_actual}|" + '<br>'.join(lista_actual))
                lista_actual = []
            clave_actual = match_inicio_lista.group(1).strip()
            continue

        match_item_lista = re.match(r'^(\s*)(-|\d+\.)\s+(.+)', original)
        if clave_actual and match_item_lista:
            espacios = match_item_lista.group(1)
            bullet = match_item_lista.group(2)
            item = match_item_lista.group(3).strip()

            nivel_espacios = len(espacios) // 4

            # El primer subnivel (nivel_espacios == 1) no lleva indentación
            if nivel_espacios <= 1:
                lista_actual.append(f"{bullet} {item}")
            else:
                indent = '&nbsp;' * ((nivel_espacios - 1) * 4)
                lista_actual.append(f"{indent}{bullet} {item}")

    # nivel_indentacion = len(espacios) // 4
    # espacios = espacios[4:] if nivel_indentacion > 0 else ''
    # lista_actual.append(f"{espacios}{bullet} {item}")

    if clave_actual and lista_actual:
        tarjetas.append(f"{clave_actual}|" + '<br>'.join(lista_actual))

    return tarjetas


def guardar_tarjetas(tarjetas, ruta_salida, deck):
    with open(ruta_salida, 'a', encoding='utf-8') as archivo:
        if is_first_time:
            archivo.write(f"#separator:pipe\n#html:true\n#deck:{deck}\n")
        for tarjeta in tarjetas:
            count = tarjeta.count("$")
            if count >= 2:
                for i in range(count):
                    if i == 0 or i % 2 == 0:
                        tarjeta = tarjeta.replace("$", "\\(", 1)
                    else:
                        tarjeta = tarjeta.replace("$", "\\)", 1)
            archivo.write(f"{tarjeta}\n")


if __name__ == "__main__":
    try:
        output = os.path.expanduser("~/Documents/cards.txt")
        open(output, 'w').close()

        if len(sys.argv) > 1:
            # Modo con argumento: usar portapapeles y elegir deck
            deck_name = seleccionar_deck_con_fzf()
            if not deck_name:
                print("No se seleccionó ningún deck.")
                exit(1)

            proceso = subprocess.run("wl-paste", shell=True, stdout=subprocess.PIPE, text=True)
            contenido = proceso.stdout

            if not contenido.strip():
                print("El portapapeles está vacío.")
                exit(1)

            lineas = contenido.splitlines()
            tarjetas = procesar_md_respetando_indentacion_desde_lineas(lineas)
            guardar_tarjetas(tarjetas, output, deck_name)

            os.system("clear")
            os.system(f"cat {output}")
            continuar = input("¿Deseas continuar? (y/n): ").strip().lower()
            if continuar != 'y':
                exit()

            os.system(f"anki {output}")

        else:
            # Modo original con selección de archivo
            while True:
                entrada = seleccionar_archivo_md()
                if not entrada:
                    print("No se seleccionó ningún archivo.")
                    exit()

                with open(entrada, 'r', encoding='utf-8') as archivo:
                    lineas = archivo.readlines()

                tarjetas = procesar_md_respetando_indentacion_desde_lineas(lineas)

                relativa = entrada.split("segunda_mente/")[-1]
                partes = relativa.split(os.sep)[:-1]
                deck = "::".join(partes)

                guardar_tarjetas(tarjetas, output, deck)

                os.system("clear")
                os.system(f"cat {output}")
                continuar = input("¿Deseas agregar otro archivo? (y/n): ").strip().lower()
                is_first_time = False

                if continuar != 'y':
                    break

            os.system(f"anki {output}")
    except KeyboardInterrupt:
        print("")

