# Lanzar-Marimo.ps1 (Versión Rápida con API Nativa WinForms)

# 1. Cargar la API nativa de Windows para interfaces gráficas
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 2. Buscar proyectos silenciosamente
$CarpetasBase = @("$HOME\work", "$HOME\personal", "$HOME\projects")
$Proyectos = Get-ChildItem -Path $CarpetasBase -Directory -ErrorAction SilentlyContinue | Select-Object -ExpandProperty FullName

# Si no hay proyectos, salimos
if ($Proyectos.Count -eq 0) { exit }

# 3. Construir la interfaz gráfica minimalista (Estilo Rofi)
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Abrir proyecto de Marimo"
$Form.Size = New-Object System.Drawing.Size(600, 400)
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedToolWindow" # Borde minimalista
$Form.KeyPreview = $true
$Form.TopMost = $true # Para que aparezca siempre por encima

# Caja de texto (Buscador)
$TextBox = New-Object System.Windows.Forms.TextBox
$TextBox.Location = New-Object System.Drawing.Point(10, 10)
$TextBox.Size = New-Object System.Drawing.Size(565, 30)
$TextBox.Font = New-Object System.Drawing.Font("Segoe UI", 12)
$Form.Controls.Add($TextBox)

# Lista de resultados
$ListBox = New-Object System.Windows.Forms.ListBox
$ListBox.Location = New-Object System.Drawing.Point(10, 45)
$ListBox.Size = New-Object System.Drawing.Size(565, 300)
$ListBox.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$ListBox.Items.AddRange($Proyectos)
$ListBox.SelectedIndex = 0
$Form.Controls.Add($ListBox)

# 4. Lógica del buscador y teclado
$global:Seleccion = $null

# Filtrar en tiempo real al escribir
$TextBox.Add_TextChanged({
    $ListBox.Items.Clear()
    if ([string]::IsNullOrWhiteSpace($TextBox.Text)) {
        $ListBox.Items.AddRange($Proyectos)
    } else {
        $Filtrado = $Proyectos | Where-Object { $_ -match [regex]::Escape($TextBox.Text) }
        if ($Filtrado) { $ListBox.Items.AddRange($Filtrado) }
    }
    if ($ListBox.Items.Count -gt 0) { $ListBox.SelectedIndex = 0 }
})

# Control de teclas (Enter, Escape, Flechas)
$Form.Add_KeyDown({
    if ($_.KeyCode -eq 'Escape') {
        $Form.Close()
    }
    elseif ($_.KeyCode -eq 'Enter') {
        if ($ListBox.SelectedItem) {
            $global:Seleccion = $ListBox.SelectedItem
            $Form.Close()
        }
    }
    elseif ($_.KeyCode -eq 'Down') {
        if ($ListBox.SelectedIndex -lt ($ListBox.Items.Count - 1)) { $ListBox.SelectedIndex++ }
        $_.SuppressKeyPress = $true
    }
    elseif ($_.KeyCode -eq 'Up') {
        if ($ListBox.SelectedIndex -gt 0) { $ListBox.SelectedIndex-- }
        $_.SuppressKeyPress = $true
    }
})

# Mostrar la ventana y esperar
$Form.ShowDialog() | Out-Null

# 5. Si cerramos la ventana sin seleccionar (Escape), salir
if (-not $global:Seleccion) { exit }

# 6. Funciones y ejecución de Marimo
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

$NombreProyecto = Split-Path $global:Seleccion -Leaf

# Evitar duplicados
$ProcesosMarimo = Get-CimInstance Win32_Process -Filter "CommandLine LIKE '%marimo edit%'"
$YaEjecutando = $false
foreach ($proc in $ProcesosMarimo) {
    if ($proc.CommandLine -match [regex]::Escape($global:Seleccion)) {
        $YaEjecutando = $true
        break
    }
}

if ($YaEjecutando) {
    Mostrar-Notificacion -Titulo "Marimo" -Mensaje "El proyecto ya esta en ejecucion: $NombreProyecto"
    exit
}

# Lanzar marimo en modo oculto
$Comando = "Set-Location '$global:Seleccion'; uv run marimo edit ."
Start-Process -FilePath "powershell.exe" -ArgumentList "-WindowStyle Hidden -Command `"$Comando`"" -WindowStyle Hidden

Mostrar-Notificacion -Titulo "Marimo" -Mensaje "Iniciando servidor para: $NombreProyecto"
