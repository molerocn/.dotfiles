# Lanzar-Marimo.ps1 (Versión con fzf)

$CarpetasBase = @("$HOME\work", "$HOME\personal", "$HOME\projects")

# Buscar proyectos silenciosamente
$Proyectos = Get-ChildItem -Path $CarpetasBase -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName

# --- AQUI ESTA LA MAGIA DE FZF ---
# Pasamos la lista a fzf con algo de estilo
# $Seleccion = $Proyectos | fzf --prompt="Abrir proyecto: " --layout=reverse --height=50% --border="rounded" --info="inline"
$Seleccion = $Proyectos | fzf --layout=reverse

# Si presionas ESC o cierras, fzf no devuelve nada
if (-not $Seleccion) {
    exit
}

# Función para notificaciones de Windows
function Mostrar-Notificacion {
    param ([string]$Titulo, [string]$Mensaje)
    Add-Type -AssemblyName System.Windows.Forms
    $notify = New-Object System.Windows.Forms.NotifyIcon
    $notify.Icon = [System.Drawing.SystemIcons]::Information
    $notify.Visible = $true
    $notify.ShowBalloonTip(3000, $Titulo, $Mensaje, [System.Windows.Forms.ToolTipIcon]::Info)
    Start-Sleep -Seconds 3
    $notify.Dispose()
}

$NombreProyecto = Split-Path $Seleccion -Leaf

# Evitar duplicados
$ProcesosMarimo = Get-CimInstance Win32_Process -Filter "CommandLine LIKE '%marimo edit%'"
$YaEjecutando = $false
foreach ($proc in $ProcesosMarimo) {
    if ($proc.CommandLine -match [regex]::Escape($Seleccion)) {
        $YaEjecutando = $true
        break
    }
}

if ($YaEjecutando) {
    Mostrar-Notificacion -Titulo "Marimo" -Mensaje "El proyecto ya esta en ejecucion: $NombreProyecto"
    exit
}

# Lanzar marimo en modo oculto
$Comando = "Set-Location '$Seleccion'; uv run marimo edit ."
Start-Process -FilePath "powershell.exe" -ArgumentList "-WindowStyle Hidden -Command `"$Comando`"" -WindowStyle Hidden

Mostrar-Notificacion -Titulo "Marimo" -Mensaje "Iniciando servidor para: $NombreProyecto"
