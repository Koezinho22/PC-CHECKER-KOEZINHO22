# Koezy PC Cheat Checker v2.0

> **League Anti-Cheat Tool — Authorised Use Only**

This tool is operated as part of an official competitive league integrity programme. It scans a PC for known Roblox exploit and cheat software indicators. Scan results are reported privately to league administrators for review.

---

## ⚠️ Legal Disclaimer

**This tool must only be run with the full knowledge and explicit consent of the person whose PC is being scanned.**

- This tool does **not** collect passwords, personal files, financial data, or any information unrelated to cheat software.
- It scans for file names, browser history entries, registry keys, and process names associated with known Roblox exploit tools only.
- All data collected is used solely for the purpose of maintaining competitive integrity within the league.
- Scan results are retained only as long as necessary for the integrity review process.
- Unauthorised use of this tool against someone without their consent may constitute unauthorised computer access under applicable law (e.g. Computer Misuse Act 1990 UK, CFAA USA). **Do not use this tool without consent.**
- The operator of this tool accepts full responsibility for ensuring informed consent is obtained before any scan is run.

By running this tool, the user confirms they have been informed of and consented to this scan as part of league procedures.

---

## Files

| File | Description |
|------|-------------|
| `cheat_checker.bat` | Single-file scanner — run this |
| `README.md` | This file |

---

## Requirements

- Windows 10 / 11
- **Run as Administrator** — required for Prefetch, Firewall, and Registry access
- PowerShell 5.1+ (built into all modern Windows)

---

## How to Run

**Option A — Direct:**
Right-click `cheat_checker.bat` → **Run as administrator**

**Option B — Remote (PowerShell):**
```powershell
$f=$env:TEMP+'\koezy.bat'; (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Koezinho22/PC-CHECKER-KOEZINHO22/main/cheat_checker.bat',$f); Start-Process cmd -ArgumentList ('/c '+$f) -Verb RunAs
```

---

## What Gets Scanned

| Section | What it checks |
|---------|----------------|
| **1 — File Search** | `%AppData%`, `%LocalAppData%`, Downloads, Temp — keyword matched filenames |
| **2 — Prefetch** | `C:\Windows\Prefetch` — every program ever executed, even if deleted |
| **3 — Recent Files** | `%AppData%\Microsoft\Windows\Recent` — keyword filtered |
| **4 — Temp Folders** | `%TEMP%` and `C:\Windows\Temp` — keyword filtered |
| **5 — Firewall Rules** | Outbound rules — exploit tools sometimes add rules to block anticheat |
| **6 — Browser History** | Chrome, Edge, Firefox — cheat keywords + executor/inject/hack terms |
| **6b — Download History** | Browser download URLs — `.exe/.dll/.zip` downloads + cheat-keyword URLs |
| **6c — Discord Cache** | Discord local cache scanned for cheat-related URLs and file links |
| **7 — Network & DNS** | Active outbound connections, DNS cache, hosts file tampering |
| **7b — Voidstrap/Bloxstrap** | Checks for Voidstrap/Bloxstrap install folders and dumps FFlag configs |
| **8 — Roblox DLL Injection** | Non-standard DLLs in Roblox Versions folder flagged |
| **9 — Running Processes** | Live process list filtered against all cheat keywords |
| **10 — Registry & Tasks** | Installed programs, startup keys, scheduled tasks |
| **11 — Downloads** | Executable files in Downloads with suspicious names |

### Keywords scanned for:
```
voidstrap, velostrap, xeno, wave, solara, bootstrapper, bytebreaker,
volcano, volt, potassium, sirhurt, swift, velocity, vortex, matcha,
lumen, photon, plexity, fishtrap, fflags, fastflags
```

---

## Notes

- Results are saved as a `.txt` on the scanned PC's Desktop and posted to the league administrator's Discord.
- No results are stored on any third-party server. No personal data beyond cheat indicators is collected.
- False positives are possible. No scan result is treated as definitive proof without further review by league staff.
- Run as Administrator or Prefetch/Firewall/Registry sections will be incomplete.
- Close browsers before scanning for best browser history results.
