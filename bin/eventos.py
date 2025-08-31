from ics import Calendar
from datetime import date
import subprocess

ics_files = [
    "/home/molerocn/Documents/eventos.ics",
    "/home/molerocn/Documents/festivos.ics"
]

hoy = date.today()
eventos = []

# Procesar múltiples archivos .ics
for ics_file in ics_files:
    with open(ics_file, "r") as f:
        content = f.read()

    # Separar los múltiples VCALENDAR y procesarlos
    calendars = content.split("BEGIN:VCALENDAR")

    for block in calendars:
        if not block.strip():
            continue
        cal_text = "BEGIN:VCALENDAR" + block
        c = Calendar(cal_text)

        for event in c.events:
            dt = event.begin.date()
            dias_faltantes = (dt - hoy).days
            if dias_faltantes >= 0:
                # Guardamos también la fecha para mostrar día/mes
                eventos.append((event.name, dt, dias_faltantes))

# Ordenar por días faltantes y quedarse con los 5 más cercanos
eventos = sorted(eventos, key=lambda x: x[1])[:5]

# Mostrar en consola
# for nombre, fecha, dias in eventos:
#     print(
#         f"{nombre}: {fecha.strftime('%d/%m')} "
#         f"{'(hoy)' if dias == 0 else '(falta 1 día)' if dias == 1 else f'(faltan {dias} días)'}"
#     )

# Crear el mensaje de notificación con zenity
if eventos:
    mensaje = "\n".join([
        f"{nombre} ({fecha.strftime('%d/%m')}, "
        f"{'hoy)' if dias == 0 else 'mañana)' if dias == 1 else f'faltan {dias} días)'}"
        for nombre, fecha, dias in eventos
    ])

    subprocess.run([
        "zenity",
        "--info",
        "--width=350",  # ancho de la ventana en píxeles
        "--title=Eventos",
        f"--text={mensaje}"
    ])

