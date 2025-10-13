# mostrar_eventos.py
import json
from datetime import date
import subprocess

with open("/home/molerocn/Documents/eventos.json", "r") as f: eventos = json.load(f)

hoy = date.today()
procesados = []

for ev in eventos:
    dt = date.fromisoformat(ev["fecha"])
    dias = (dt - hoy).days
    if dias >= 0:
        procesados.append((ev["nombre"], dt, dias))

procesados = sorted(procesados, key=lambda x: x[1])[:6]

if procesados:
    mensaje = "\n".join([
        f"{nombre} ({fecha.strftime('%A %d/%m')}, "
        f"{'hoy)' if dias == 0 else 'mañana)' if dias == 1 else f'faltan {dias} días)'}"
        for nombre, fecha, dias in procesados
    ])

    subprocess.run([
        "zenity",
        "--info",
        "--width=450",
        "--title=Eventos",
        f"--text={mensaje}"
        # "notify-send",
        # "--expire-time=8000",
        # "Eventos",
        # f"{mensaje}"
    ])

