import tkinter as tk
import subprocess
import sys
import os

def iniciar_pomodoro():
    try:
        subprocess.run(["gnome-pomodoro", "--start"])
        ventana.destroy()
    except Exception as e:
        print(f"Error al ejecutar el comando: {e}")

def continuar_pomodoro():
    try:
        subprocess.run(["gnome-pomodoro", "--resume"])
        ventana.destroy()
    except Exception as e:
        print(f"Error al ejecutar el comando: {e}")

def ask_in_10_min():
    try:
        # Programa que se ejecute de nuevo este mismo script en 10 minutos
        subprocess.Popen(
            ["bash", "-c", f"sleep 600 && python3 '{os.path.abspath(__file__)}'"], 
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
        ventana.destroy()
    except Exception as e:
        print(f"Error al programar la reapertura: {e}")

def bloquear_cierre():
    # Evita que el usuario cierre la ventana
    pass

try:
    option = sys.argv[1]
except:
    option = ""

ventana = tk.Tk()
ventana.title("Pomodoro")
ventana.resizable(False, False)
ventana.attributes("-topmost", True)
ventana.geometry("360x140")

ventana.protocol("WM_DELETE_WINDOW", bloquear_cierre)

frame_botones = tk.Frame(ventana)
frame_botones.pack(expand=True)

if option == "pause":
    try:
        subprocess.run(["gnome-pomodoro", "--pause"])
    except Exception as e:
        print(f"Error al ejecutar el comando: {e}")
    boton_principal = tk.Button(frame_botones, text="Continuar pomodoro", command=continuar_pomodoro, width=34)
    boton_principal.grid(row=0, column=0, padx=10, pady=20)
else:
    boton_principal = tk.Button(frame_botones, text="Iniciar Pomodoro", command=iniciar_pomodoro, width=16)
    boton_principal.grid(row=0, column=0, padx=10, pady=20)

    boton_ask = tk.Button(frame_botones, text="Ask in 10 min", command=ask_in_10_min, width=16)
    boton_ask.grid(row=0, column=1, padx=10, pady=20)

ventana.mainloop()

