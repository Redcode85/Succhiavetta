===========================================================================
      SISTEMA DI BACKUP AUTOMATICO E INVISIBILE - GUIDA OPERATIVA v1.0
===========================================================================

1. REQUISITO FONDAMENTALE
---------------------------------------------------------------------------
- NOME UNITÀ USB: La chiavetta DEVE essere rinominata come: MIA_USB
  Il nome è essenziale per le funzioni di espulsione automatica.

2. STRUTTURA DEL KIT (FILE DA IMPOSTARE COME "NASCOSTI")
---------------------------------------------------------------------------
- INSTALLA.bat          : Motore di installazione con controllo Lock File.
- Documenti.vbs         : Lanciatore invisibile (ponte tra USB e PC).
- avvia_nascosto.vbs    : Script di sistema per l'invisibilità di PowerShell.
- cercafiles.ps1        : Motore v1.0 (Copia, Pulizia e Auto-Espulsione).
- RIPRISTINA_NOMI.bat   : Utility da usare solo sul proprio PC.

3. INTERFACCIA UTENTE (CONFIGURAZIONE COLLEGAMENTO SE NECESSARIO)
---------------------------------------------------------------------------
- Nome: Documenti
- Destinazione: cmd.exe /c wscript.exe Documenti.vbs
- Inizia in/Da: (LASCIARE VUOTO - Fondamentale per la portabilità)
- Icona: Tasto destro > Proprietà > Cambia Icona. Inserire il percorso:
  %SystemRoot%\System32\shell32.dll
  Selezionare l'icona della CARTELLA GIALLA standard.

4. SICUREZZA E PROTEZIONE MULTI-CLIC
---------------------------------------------------------------------------
- Anti-Sovrapposizione: Al primo clic viene creato un file "semaforo" 
  temporaneo (%TEMP%\sys_check.lock). 
- Protezione Attiva: Ogni clic successivo rileva il file lock e mostra 
  istantaneamente il pop-up: "L'antivirus sta analizzando il contenuto...".
- Pulizia Tracce: Al termine, il sistema elimina la cartella SystemView, 
  rimuove il file lock e cancella i messaggi temporanei dal PC target.

5. PROCEDURA OPERATIVA
---------------------------------------------------------------------------
1. Inserire la chiavetta MIA_USB nel PC target.
2. Cliccare sul collegamento "Documenti".
3. Apparirà alcuna finestra nera per 1 sec.; il lavoro avviene in background.
4. Attendere il pop-up finale dopo 30 min: "Ora e possibile rimuovere l'hardware."
5. Oppure tasto destro e crea nuovo file .txt nominalo STOP.txt (maiusc.)
   e premi Invio se non si vuole aspettare.
5. La chiavetta verrà espulsa automaticamente con messaggio:
   "Ora e possibile rimuovere l'hardware."


6. RECUPERO DATI E VISUALIZZAZIONE
---------------------------------------------------------------------------
- Abilitare "Mostra file e cartelle nascosti" nelle opzioni di Windows.
- Percorso dati: "System_Data_Vault" (Cartella nascosta sulla USB).
- Eseguire "RIPRISTINA_NOMI.bat" per tornare ai nomi originali dei file.

7. GESTIONE CLIC RIPETUTI
---------------------------------------------------------------------------
- Se l'utente clicca più volte sul collegamento "Documenti", il sistema
  rileva il processo già attivo e mostra un pop-up di "Windows Defender"
  che invita ad attendere l'analisi dell'antivirus.

===========================================================================
                      FINE DOCUMENTAZIONE - v1.0
                          Firmato: Red_Code
===========================================================================
