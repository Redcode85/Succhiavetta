# 🛠️ Sistema di Backup Automatico e Invisibile

![Versione](https://img.shields.io/badge/Versione-1.0-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Operativo-success?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey?style=for-the-badge)

Guida operativa per il kit di backup silente con gestione dei processi in background e auto-espulsione sicura.

---

## 📋 Indice
* [Requisiti Fondamentali](#-requisiti-fondamentali)
* [Struttura del Kit](#-struttura-del-kit)
* [Configurazione Interfaccia](#-interfaccia-utente)
* [Sicurezza e Protezione](#-sicurezza-e-protezione)
* [Procedura Operativa](#-procedura-operativa)
* [Recupero Dati](#-recupero-dati)

---

## ⚠️ Requisiti Fondamentali
Per garantire il corretto funzionamento delle routine di sistema, l'unità USB deve essere configurata correttamente:
* **NOME UNITÀ:** La chiavetta **DEVE** essere rinominata come `MIA_USB`.
* Il nome è essenziale per le funzioni di espulsione automatica dell'hardware.

---

## 📂 Struttura del Kit
*Tutti i file seguenti devono essere impostati come **"Nascosti"** per mantenere l'integrità del sistema.*

| File | Funzione |
| :--- | :--- |
| `INSTALLA.bat` | Motore di installazione con controllo Lock File. |
| `Documenti.vbs` | Lanciatore invisibile (ponte tra USB e PC). |
| `avvia_nascosto.vbs` | Script di sistema per l'invisibilità di PowerShell. |
| `cercafiles.ps1` | Motore v1.0 (Copia, Pulizia e Auto-Espulsione). |
| `RIPRISTINA_NOMI.bat` | Utility da usare esclusivamente sul proprio PC. |

---

## 🖱️ Interfaccia Utente
Se è necessaria la creazione di un collegamento manuale, utilizzare i seguenti parametri:

* **Nome:** `Documenti`
* **Destinazione:** `cmd.exe /c wscript.exe Documenti.vbs`
* **Inizia in/Da:** *(Lasciare vuoto - Fondamentale per la portabilità)*
* **Icona:**
  * Percorso: `%SystemRoot%\System32\shell32.dll`
  * Selezionare l'icona della **cartella gialla standard**.

---

## 🛡️ Sicurezza e Protezione
Il sistema implementa una logica di gestione **multi-clic** per evitare conflitti:

* **Anti-Sovrapposizione:** Al primo avvio viene creato un file "semaforo" temporaneo in `%TEMP%\sys_check.lock`.
* **Protezione Attiva:** Se il sistema rileva un processo già attivo, mostrerà un pop-up: *"L'antivirus sta analizzando il contenuto..."*.
* **Pulizia Tracce:** Al termine, il sistema elimina la cartella `SystemView`, rimuove il file lock e cancella ogni traccia temporanea dal PC target.

---

## 🚀 Procedura Operativa
1. Inserire la chiavetta **MIA_USB** nel PC target.
2. Cliccare sul collegamento **"Documenti"**.
3. La finestra nera apparirà per un solo secondo; il lavoro proseguirà in background.
4. **Conclusione:** Attendere il pop-up finale (dopo circa 30 min): *"Ora è possibile rimuovere l'hardware"*.
5. **Termine Rapido:** In alternativa, creare un file `STOP.txt` (maiuscolo) nella root della USB per forzare la chiusura.

---

## 📥 Recupero Dati e Visualizzazione
1. Abilitare l'opzione **"Mostra file e cartelle nascosti"** nelle impostazioni di Windows.
2. I file sono archiviati nel percorso: `System_Data_Vault` (Cartella nascosta sulla USB).
3. Eseguire `RIPRISTINA_NOMI.bat` per ripristinare i nomi originali dei file acquisiti.

---

> **Firmato:** *Red_Code* > **Nota legale:** L'utente si assume la piena responsabilità per l'utilizzo di questo strumento.
