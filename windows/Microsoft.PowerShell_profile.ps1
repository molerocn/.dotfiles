function cpwd {
    pwd | Set-Clipboard
}

function copyf {
    param([string]$Path)
    if (-not $Path) {
        Write-Host "Usage: copyf <file>"
        return
    }
    $file = Resolve-Path $Path -ErrorAction SilentlyContinue
    if (-not $file) {
        Write-Error "File not found: $Path"
        return
    }
    Add-Type -AssemblyName System.Windows.Forms
    $files = New-Object System.Collections.Specialized.StringCollection
    [void]$files.Add($file.Path)
    [System.Windows.Forms.Clipboard]::SetFileDropList($files)
}

function cpd {
    param(
        [string]$Dest = "."
    )
    $downloads = Join-Path $HOME "Downloads"
    $sourceFile = Get-ChildItem -Path $downloads -File |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 1
    if (-not $sourceFile) {
        Write-Error "No se encontraron archivos en $downloads"
        return
    }
    Copy-Item -Path $sourceFile.FullName -Destination $Dest -Verbose
}

Set-Alias -Name a -Value Get-ChildItem
Set-Alias -Name open -Value explorer

$ONEDRIVE = "C:\Users\juancarlos.molero\OneDrive - Verisure\filerPeru - 01.Sales Performance\00.Planificación_Estratégica\20 ETL"
$DATASET = "C:\Users\juancarlos.molero\OneDrive - Verisure\filerPeru - 01.Sales Performance\00.Planificación_Estratégica\20 ETL\dataset"
$SHAREPOINT = "C:\Users\juancarlos.molero\OneDrive - Verisure\PE -Data Files - Documentos\Documentos locales\Planificacion Estrategica\Historicos"

Invoke-Expression (& { (zoxide init powershell | Out-String) })
Set-Alias -Name n -Value z

# funciones propias

function etl {
    C:\Users\juancarlos.molero\work\ETL-verisure\.venv\scripts\python.exe "C:\Users\juancarlos.molero\work\ETL-verisure\src\main.py" @args
}
