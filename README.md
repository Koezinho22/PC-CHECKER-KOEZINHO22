# Koezy - PC Cheat Checker v2.0

Personal tool for scanning a PC for known Roblox exploit and cheat indicators. Covers files, browser history, network activity, firewall rules, prefetch, registry, DLL injection, and more. Results are sent privately after the scan completes.

---

## Files

| File | Description |
|------|-------------|
| `cheat_checker.bat` | Main scanner — run this |
| `config.ini` | Private config — keep this to yourself |
| `README.md` | This file |

---

## Requirements

- Windows 10 / 11
- **Run as Administrator** — required for Prefetch, Firewall, and Registry access
- PowerShell 5.1+ (built into all modern Windows)

---

## How to Run

Right-click `cheat_checker.bat` → **Run as administrator**

Or from an admin CMD:
```cmd
cd "C:\Users\birch\Downloads\cmd prompts\cheat engine checker"
cheat_checker.bat
```

---

## Menu

| Option | Action |
|--------|--------|
| `1. CHECK` | Runs the full scan |
| `2. EXIT` | Close |

Press **Enter** on the Terms screen to proceed.

---

## What Gets Scanned

### 1 — File Search
Scans `%AppData%`, `%LocalAppData%`, Downloads, C:\, D:\ for files matching known cheat tool names:
```
voidstrap, velostrap, xeno, wave, solara, bootstrapper, bytebreaker,
real, medium, volcano, volt, potassium, sirhurt, swift, velocity,
vortex, matcha, lumen, photon, plexity, fishtrap
```

### 2 — Prefetch
`C:\Windows\Prefetch` — logs every program ever executed, even if deleted.

### 3 — Recent Files
`%AppData%\Microsoft\Windows\Recent` — keyword filtered.

### 4 — Temp Folders
`%TEMP%` and `C:\Windows\Temp` — keyword filtered.

### 5 — Firewall Rules
Outbound rules — exploit tools sometimes add rules to block anticheat traffic.

### 6 — Browser History
Raw read of Chrome, Edge, and Firefox history databases.
Searches for cheat keywords + `exploit`, `cheat`, `hack`, `inject`, `executor`.
> Close the browser before scanning for best results.

### 7 — Network & DNS
- Active outbound connections mapped to process names
- DNS cache — recently resolved domains, keyword filtered
- Hosts file — non-default entries flagged (common anticheat bypass method)

### 8 — Roblox Versions + DLL Injection
- Full scan of `%LocalAppData%\Roblox\Versions\`
- Any `.dll` not matching known Roblox/system DLLs is flagged as a potential injected DLL

### 9 — Running Processes
Live `tasklist` filtered against all cheat keywords.

### 10 — Registry & Scheduled Tasks
- Installed programs (HKLM + HKCU)
- Startup keys (`Run`)
- Scheduled tasks

### 11 — Recently Modified Executables
`.exe` and `.dll` files modified in the last **7 days** in AppData and Downloads.

---

## Notes

- C: + D: drive scan can take a few minutes depending on drive size — normal.
- D: drive is silently skipped if it doesn't exist.
- Run as Administrator or Prefetch/Firewall/Registry sections will be incomplete.
- DLL check uses a known-good allowlist — false positives possible for legitimate software.
