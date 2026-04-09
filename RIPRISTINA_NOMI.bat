@echo off
setlocal enabledelayedexpansion

:: 1. Nome della cartella dei dati
set "target_dir=System_Data_Vault"

if not exist "%target_dir%" (
    echo ERRORE: Cartella %target_dir% non trovata!
    pause
    exit
)

echo ---------------------------------------------------
echo 1. Rendendo la cartella visibile...
:: Rimuove l'attributo "Nascosto" (H) dalla cartella e da tutti i file contenuti
attrib -h "%target_dir%" /d /s

echo 2. Ripristino nomi originali in corso...
cd "%target_dir%"

:: 3. Usa PowerShell per rimuovere i primi 13 caratteri dai file che hanno il prefisso
powershell -Command "Get-ChildItem | Where-Object { $_.Name -match '^.{12}_' } | Rename-Item -NewName { $_.Name -replace '^.{13}', '' } -ErrorAction SilentlyContinue"

echo ---------------------------------------------------
echo Operazione completata! 
echo La cartella e ora visibile e i file hanno i nomi originali.
echo ---------------------------------------------------
pause