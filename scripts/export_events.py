#!/usr/bin/env python3
import subprocess
from ics import Calendar
import json
import sys
import os

# Comprobar argumentos
if len(sys.argv) < 3:
    print(f"Uso: {sys.argv[0]} <id-gmail> <id-festivos>")
    sys.exit(1)

id_gmail = sys.argv[1]
id_festivos = sys.argv[2]

# Directorio de destino
dest_dir = os.path.expanduser("~/Documents")

ics_files = {
    "eventos": os.path.join(dest_dir, "eventos.ics"),
    "festivos": os.path.join(dest_dir, "festivos.ics")
}

# Ejecutar syncevolution para exportar ICS
print("📥 Exportando calendarios desde Evolution…")
subprocess.run(
    f"syncevolution --export - backend=evolution-calendar database={id_gmail} > {ics_files['eventos']}",
    shell=True, check=True
)
subprocess.run(
    f"syncevolution --export - backend=evolution-calendar database={id_festivos} > {ics_files['festivos']}",
    shell=True, check=True
)

# Procesar .ics y generar lista de eventos
eventos = []

for ics_file in ics_files.values():
    with open(ics_file, "r") as f:
        content = f.read()
    for c in Calendar.parse_multiple(content):
        for event in c.events:
            if not event.begin:
                continue
            dt = event.begin.date().isoformat()
            eventos.append({
                "nombre": event.name,
                "fecha": dt
            })

# Guardar en JSON
json_path = os.path.join(dest_dir, "eventos.json")
with open(json_path, "w") as f:
    json.dump(eventos, f, ensure_ascii=False, indent=2)

print(f"✅ Caché generado en: {json_path}")
print(f"   Eventos totales: {len(eventos)}")
