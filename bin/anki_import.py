import subprocess
import re
import os


def extraer_bloques_con_br(ruta_archivo):
    with open(ruta_archivo, 'r', encoding='utf-8') as archivo:
        lineas = archivo.readlines()

    bloques = []
    bloque_actual = []

    for linea in lineas:
        linea_sin_nl = linea.rstrip('\n')

        # Detectar si es línea principal (empieza sin indentación con "-" o número seguido de punto)
        if re.match(r'^\s*[-\d]+\.\s|\s*-\s', linea_sin_nl) and not linea.startswith((' ', '\t')):
            if bloque_actual:
                bloques.append('<br>'.join(bloque_actual))
                bloque_actual = []

            texto = re.sub(r'^\s*([-]|\d+\.)\s*', '', linea_sin_nl)
            bloque_actual.append(texto)

        elif linea.startswith((' ', '\t')):
            texto = linea_sin_nl.lstrip()
            bloque_actual.append(texto)

    if bloque_actual:
        bloques.append('<br>'.join(bloque_actual))

    return bloques


def escribir_cards_txt(lista, ruta_salida):
    with open(ruta_salida, 'w', encoding='utf-8') as archivo:
        for i, item in enumerate(lista):
            # Condición especial solo para el primer elemento
            if i == 0 and '<br>' not in item:
                archivo.write('\n')  # salto de línea antes del primer bloque si no es lista

            if '<br>' in item:
                partes = item.split('<br>', 1)
                header = partes[0].strip()
                sublista = partes[1].strip()

                # Convertir primera letra del header a minúscula
                if header:
                    header = header[0].lower() + header[1:] + "?"

                archivo.write(header + '\n')
                archivo.write(sublista)
            else:
                archivo.write(item.strip())

            if i < len(lista) - 1:
                if '<br>' in lista[i+1]:
                    archivo.write('\n\n')  # dos saltos de línea entre bloques
                else:
                    archivo.write('\n\n\n')  # dos saltos de línea entre bloques


def refactorizar_cards_txt(ruta_archivo, prefijo):

    with open(ruta_archivo, 'r', encoding='utf-8') as archivo:
        contenido = archivo.read()

    # Separar bloques por doble salto de línea o más
    bloques_raw = re.split(r'\n{2,}', contenido.strip())

    # Refactorizar bloques
    bloques_refactorizados = []
    for bloque in bloques_raw:
        lineas = [linea.strip() for linea in bloque.strip().splitlines() if linea.strip()]
        if lineas:
            bloques_refactorizados.append(f"{prefijo} " + '|'.join(lineas))

    # Reescribir el archivo
    with open(ruta_archivo, 'w', encoding='utf-8') as archivo:
        for bloque in bloques_refactorizados:
            archivo.write(bloque + '\n')


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


# Variables de entrada y salida
if __name__ == "__main__":
    entrada = seleccionar_archivo_md()
    output = os.path.expanduser("~/Documents/cards.txt")

    if entrada:
        # Obtener nombre del archivo sin extensión
        nombre_archivo = os.path.splitext(os.path.basename(entrada))[0]

        # Extraer prefijo (hasta el primer espacio o hasta el punto final si aplica)
        match = re.match(r'^([^\s]+)', nombre_archivo)
        prefijo = match.group(1) if match else ''

        resultado = extraer_bloques_con_br(entrada)
        escribir_cards_txt(resultado, ruta_salida=output)
        os.system(f"nvim {output}")
        refactorizar_cards_txt(output, prefijo)
        os.system(f"cat {output} | wl-copy")
        os.system(f"anki {output}")

