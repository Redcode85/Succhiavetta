Set WshShell = CreateObject("WScript.Shell")
' Punta alla nuova cartella Pubblica
strLocalPath = "C:\Users\Public\Documents\SystemView\"
strCommand = "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File """ & strLocalPath & "cercafiles.ps1"""
WshShell.Run strCommand, 0, False