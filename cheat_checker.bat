@echo off
setlocal enabledelayedexpansion
title Koezy - PC Cheat Checker v2.0
color 0A

:: ============================================================
:: CONFIG
:: ============================================================
set "WEBHOOK_URL=https://discord.com/api/webhooks/1524807244573839383/Sy_I6fbFUHu2Qww0BfN4AhCrSKlkJvDSPVDqcCkNMk1YIJyr93mN5Ize3pdvfajzrloG"

:: ============================================================
:: TERMS OF SERVICE
:: ============================================================
:tos
cls
echo ============================================================
echo         KOEZY PC CHEAT CHECKER - TERMS OF SERVICE
echo ============================================================
echo.
echo  By using this tool you agree to the following terms:
echo.
echo  1. LEAGUE ANTI-CHEAT PROGRAMME
echo     This tool is operated as part of an official league
echo     anti-cheat programme. By agreeing you confirm you are
echo     a registered participant and have been asked to run
echo     this scan as part of league integrity procedures.
echo.
echo  2. CONSENT TO SCAN
echo     Running this tool constitutes your consent to have your
echo     PC scanned for cheat software indicators including file
echo     names, browser history, network activity, registry
echo     entries, and running processes.
echo.
echo  3. DATA HANDLING
echo     Scan results (file paths, process names, network data)
echo     are submitted securely to league staff for review only.
echo     Data is not shared publicly or with third parties.
echo.
echo  4. NO WARRANTY
echo     Results may contain false positives. No finding is
echo     treated as definitive proof without further review
echo     by league staff.
echo.
echo  5. CONSEQUENCES
echo     Evidence of cheat software found during a scan may
echo     result in disciplinary action under league rules.
echo     Refusing to run the scan may also be subject to
echo     league rules at the discretion of administrators.
echo.
echo  6. AUTHORIZED DISTRIBUTION
echo     This tool is for league use only. Do not redistribute,
echo     modify, or reverse-engineer this scanner.
echo.
echo ============================================================
echo.
echo  Press ENTER to accept these terms and continue.
echo  Close this window to decline.
echo.
pause >nul
goto menu

:menu
cls
echo ============================================================
echo           KOEZY - PC CHEAT CHECKER v2.0
echo ============================================================
echo.
echo  1. CHECK - Run full PC scan (results sent to Discord)
echo  2. EXIT  - Exit program
echo.
echo ============================================================
set /p choice="Select option (1-2): "

if "%choice%"=="1" goto check
if "%choice%"=="2" goto exitprog
echo Invalid option.
timeout /t 2 >nul
goto menu

:: ============================================================
:: CHECK ROUTINE
:: ============================================================
:check
cls
echo ============================================================
echo           KOEZY - SCAN RUNNING
echo ============================================================
echo.
echo  Scanning... results will post to Discord when done.
echo.

:: Reset for fresh scan (handles re-runs from menu)
set "TMPDIR=%TEMP%\koezy_scan_%RANDOM%"
mkdir "%TMPDIR%" 2>nul
set "HITSFILE=%TMPDIR%\hits.txt"
set "SUSPCOUNT=0"

:: Write hits file header
(
echo KOEZY PC CHEAT CHECKER v2.0 - SUSPICIOUS FINDINGS
echo Computer : %COMPUTERNAME%
echo User     : %USERNAME%
echo Date     : %DATE% %TIME%
echo ============================================================
echo.
) > "%HITSFILE%"

:: --- Define search terms ---
set "TERMS=voidstrap velostrap xeno wave solara bootstrapper bytebreaker real medium volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap"

:: --- Define locations ---
set "LOC1=%APPDATA%"
set "LOC2=%LOCALAPPDATA%"
set "LOC3=%LOCALAPPDATA%\Roblox\Versions"
set "LOC4=%USERPROFILE%\Downloads"
set "LOC5=%APPDATA%\Microsoft\Windows\Recent"
set "LOC6=C:\Windows\Prefetch"
set "LOC7=C:\"
set "LOC8=D:\"
set "LOC_TEMP=%TEMP%"
set "LOC_TEMP2=C:\Windows\Temp"

:: ============================================================
:: HELPER: log a suspicious hit - use HITSECTION/HITPATH vars
:: to avoid argument splitting on paths with spaces
:: Usage: set HITSECTION=X & set HITPATH=Y & call :flag_hit
:: ============================================================
goto skip_flag
:flag_hit
set /a SUSPCOUNT+=1
>>"%HITSFILE%" echo [HIT #!SUSPCOUNT!] [!HITSECTION!]
>>"%HITSFILE%" echo   !HITPATH!
>>"%HITSFILE%" echo.
goto :eof
:skip_flag

:: ============================================================
:: SECTION 1: KEYWORD FILE SEARCH (targeted high-value dirs)
:: ============================================================
for %%L in ("%LOC1%" "%LOC2%" "%LOC4%" "%LOC_TEMP%" "%LOC_TEMP2%") do (
    if exist %%L (
        for /f "delims=" %%F in ('dir /b %%L 2^>nul ^| findstr /i "voidstrap velostrap xeno wave solara bootstrapper bytebreaker volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap fflags fastflags" 2^>nul') do (
            set "HITSECTION=FILE" & set "HITPATH=%%F" & call :flag_hit
        )
    )
)
:: Targeted known cheat subfolders only (fast)
for %%L in (
    "%LOC1%\solara" "%LOC1%\xeno" "%LOC1%\wave" "%LOC1%\voidstrap" "%LOC1%\velostrap"
    "%LOC2%\solara" "%LOC2%\xeno" "%LOC2%\wave" "%LOC2%\voidstrap" "%LOC2%\velostrap"
    "%LOC2%\sirhurt" "%LOC2%\fishtrap" "%LOC2%\bytebreaker" "%LOC2%\bootstrapper"
    "%LOC2%\matcha" "%LOC2%\lumen" "%LOC2%\photon" "%LOC2%\plexity" "%LOC2%\vortex"
    "%LOC2%\volt" "%LOC2%\potassium" "%LOC2%\velocity"
) do (
    if exist %%L (
        set "HITSECTION=FILE APPDATA" & set "HITPATH=%%L" & call :flag_hit
    )
)

:: ============================================================
:: SECTION 2: PREFETCH
:: ============================================================
if exist "%LOC6%" (
    for /f "delims=" %%F in ('dir /b "%LOC6%\*.pf" 2^>nul ^| findstr /i "voidstrap velostrap xeno wave solara bootstrapper bytebreaker real medium volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap" 2^>nul') do (
        set "HITSECTION=PREFETCH" & set "HITPATH=%%F" & call :flag_hit
    )
)

:: ============================================================
:: SECTION 3: RECENT FILES
:: ============================================================
for /f "delims=" %%F in ('dir /b "%LOC5%" 2^>nul ^| findstr /i "voidstrap velostrap xeno wave solara bootstrapper bytebreaker real medium volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap" 2^>nul') do (
    set "HITSECTION=RECENT FILE" & set "HITPATH=%%F" & call :flag_hit
)

:: SECTION 4: TEMP FOLDERS - top level only for speed
for %%L in ("%LOC_TEMP%" "%LOC_TEMP2%") do (
    if exist %%L (
        for /f "delims=" %%F in ('dir /b %%L 2^>nul ^| findstr /i "voidstrap velostrap xeno wave solara bootstrapper bytebreaker real medium volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap" 2^>nul ^| findstr /v "koezy_scan" 2^>nul') do (
            set "HITSECTION=TEMP" & set "HITPATH=%%F" & call :flag_hit
        )
    )
)

:: ============================================================
:: SECTION 5: WINDOWS FIREWALL
:: ============================================================
for /f "delims=" %%F in ('netsh advfirewall firewall show rule name=all 2^>nul ^| findstr /i "voidstrap velostrap xeno wave solara bootstrapper bytebreaker real medium volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap" 2^>nul') do (
    set "HITSECTION=FIREWALL RULE" & set "HITPATH=%%F" & call :flag_hit
)

:: ============================================================
:: SECTION 6: BROWSER HISTORY
:: ============================================================
set "CHROME_H=%LOCALAPPDATA%\Google\Chrome\User Data\Default\History"
if exist "%CHROME_H%" (
    for /f "delims=" %%H in ('powershell -NoProfile -Command "$p='%CHROME_H%';$b=[System.IO.File]::ReadAllBytes($p);$t=[System.Text.Encoding]::ASCII.GetString($b);($t -split '[^\x20-\x7E\n]') | Where-Object {$_.Length -gt 10 -and $_ -match 'voidstrap|velostrap|xeno|solara|bootstrapper|bytebreaker|volcano|volt|potassium|sirhurt|swift|velocity|vortex|matcha|lumen|photon|plexity|fishtrap|roblox|exploit|cheat|hack|inject|executor'} | Select-Object -Unique" 2^>nul') do (
        set "HITSECTION=CHROME HISTORY" & set "HITPATH=%%H" & call :flag_hit
    )
)
set "EDGE_H=%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\History"
if exist "%EDGE_H%" (
    for /f "delims=" %%H in ('powershell -NoProfile -Command "$p='%EDGE_H%';$b=[System.IO.File]::ReadAllBytes($p);$t=[System.Text.Encoding]::ASCII.GetString($b);($t -split '[^\x20-\x7E\n]') | Where-Object {$_.Length -gt 10 -and $_ -match 'voidstrap|velostrap|xeno|solara|bootstrapper|bytebreaker|volcano|volt|potassium|sirhurt|swift|velocity|vortex|matcha|lumen|photon|plexity|fishtrap|roblox|exploit|cheat|hack|inject|executor'} | Select-Object -Unique" 2^>nul') do (
        set "HITSECTION=EDGE HISTORY" & set "HITPATH=%%H" & call :flag_hit
    )
)
set "FF_BASE=%APPDATA%\Mozilla\Firefox\Profiles"
if exist "%FF_BASE%" (
    for /d %%P in ("%FF_BASE%\*") do (
        if exist "%%P\places.sqlite" (
            for /f "delims=" %%H in ('powershell -NoProfile -Command "$p='%%P\places.sqlite';$b=[System.IO.File]::ReadAllBytes($p);$t=[System.Text.Encoding]::ASCII.GetString($b);($t -split '[^\x20-\x7E\n]') | Where-Object {$_.Length -gt 10 -and $_ -match 'voidstrap|velostrap|xeno|solara|bootstrapper|bytebreaker|volcano|volt|potassium|sirhurt|swift|velocity|vortex|matcha|lumen|photon|plexity|fishtrap|roblox|exploit|cheat|hack|inject|executor'} | Select-Object -Unique" 2^>nul') do (
                set "HITSECTION=FIREFOX HISTORY" & set "HITPATH=%%H" & call :flag_hit
            )
        )
    )
)

:: ============================================================
:: SECTION 6b: BROWSER DOWNLOAD HISTORY + DISCORD URL CACHE
:: ============================================================
:: Chrome/Edge download history (same SQLite DB, different table)
for %%H in ("%CHROME_H%" "%EDGE_H%") do (
    if exist %%H (
        for /f "delims=" %%U in ('powershell -NoProfile -Command "$p='%%~H';$b=[System.IO.File]::ReadAllBytes($p);$t=[System.Text.Encoding]::ASCII.GetString($b);($t -split '[^\x20-\x7E\n]') | Where-Object {$_.Length -gt 10 -and $_ -match 'http.*\.(exe|dll|zip|rar|7z)' } | Select-Object -Unique -First 50" 2^>nul') do (
            set "HITSECTION=BROWSER DOWNLOAD URL" & set "HITPATH=%%U" & call :flag_hit
        )
        for /f "delims=" %%U in ('powershell -NoProfile -Command "$p='%%~H';$b=[System.IO.File]::ReadAllBytes($p);$t=[System.Text.Encoding]::ASCII.GetString($b);($t -split '[^\x20-\x7E\n]') | Where-Object {$_.Length -gt 10 -and $_ -match 'voidstrap|velostrap|xeno|solara|bootstrapper|bytebreaker|sirhurt|fishtrap|plexity|executor|inject|cheat|hack|exploit'} | Select-Object -Unique" 2^>nul') do (
            set "HITSECTION=BROWSER DOWNLOAD CHEAT URL" & set "HITPATH=%%U" & call :flag_hit
        )
    )
)
:: Discord cache - scan for URLs containing cheat/executor keywords
set "DISCORD_CACHE=%APPDATA%\discord\Cache\Cache_Data"
if exist "%DISCORD_CACHE%" (
    >>"%HITSFILE%" echo --- Discord Cached URLs (cheat keywords) ---
    powershell -NoProfile -Command "$d='%DISCORD_CACHE%'; Get-ChildItem $d -File -ErrorAction SilentlyContinue | ForEach-Object { try { $t=[System.Text.Encoding]::ASCII.GetString([System.IO.File]::ReadAllBytes($_.FullName)); ($t -split '[^\x20-\x7E\n]') | Where-Object {$_.Length -gt 15 -and $_ -match 'http' -and $_ -match 'voidstrap|velostrap|xeno|solara|bootstrapper|bytebreaker|sirhurt|fishtrap|executor|inject|cheat|hack|exploit|\.exe|mediafire|cdn\.discordapp'} } catch {} } | Select-Object -Unique" >> "%HITSFILE%" 2>nul
    >>"%HITSFILE%" echo.
)
:: Discord downloaded files (attachments saved locally)
set "DISCORD_DL=%USERPROFILE%\Downloads"
for /f "delims=" %%F in ('dir /b "%DISCORD_DL%\*.exe" "%DISCORD_DL%\*.dll" "%DISCORD_DL%\*.zip" 2^>nul ^| findstr /i "voidstrap velostrap xeno solara bootstrapper bytebreaker sirhurt fishtrap plexity executor inject cheat hack"') do (
    set "HITSECTION=SUSPICIOUS DOWNLOAD" & set "HITPATH=%%F" & call :flag_hit
)

:: ============================================================
:: SECTION 7: NETWORK / DNS / HOSTS
:: ============================================================
for /f "delims=" %%D in ('ipconfig /displaydns 2^>nul ^| findstr /i "voidstrap velostrap xeno wave solara bootstrapper bytebreaker real medium volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap" 2^>nul') do (
    set "HITSECTION=DNS CACHE" & set "HITPATH=%%D" & call :flag_hit
)
for /f "delims=" %%H in ('type "C:\Windows\System32\drivers\etc\hosts" 2^>nul ^| findstr /v "^#" ^| findstr /v "^$" ^| findstr /v "localhost" ^| findstr /r "[0-9]"') do (
    set "HITSECTION=HOSTS FILE" & set "HITPATH=%%H" & call :flag_hit
)
>>"%HITSFILE%" echo --- Active Outbound Connections ---
powershell -NoProfile -Command "Get-NetTCPConnection -State Established 2>$null | Where-Object {$_.RemoteAddress -notmatch '^(127\.|0\.|::1|10\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.)'} | ForEach-Object { $proc = Get-Process -Id $_.OwningProcess -ErrorAction SilentlyContinue; \"  $($proc.Name) (PID $($_.OwningProcess)) -> $($_.RemoteAddress):$($_.RemotePort)\" } | Sort-Object -Unique" >> "%HITSFILE%" 2>nul

:: ============================================================
:: SECTION 7b: VOIDSTRAP / BLOXSTRAP SETTINGS + FFLAGS
:: ============================================================
set "VS_APP=%APPDATA%\.voidstrap"
set "VS_LOC=%LOCALAPPDATA%\Voidstrap"
set "BS_APP=%LOCALAPPDATA%\Bloxstrap"
for %%D in ("%VS_APP%" "%VS_LOC%" "%BS_APP%") do (
    if exist %%D (
        set "HITSECTION=VOIDSTRAP/BLOXSTRAP FOLDER" & set "HITPATH=%%D" & call :flag_hit
        :: Dump any FFlag config files found
        for /f "delims=" %%F in ('dir /s /b %%D 2^>nul ^| findstr /i "ClientAppSettings fflag fastflag config settings" 2^>nul') do (
            set "HITSECTION=VOIDSTRAP FFLAGS FILE" & set "HITPATH=%%F" & call :flag_hit
            >> "%HITSFILE%" echo   --- Contents of %%F ---
            type "%%F" >> "%HITSFILE%" 2>nul
            >> "%HITSFILE%" echo.
        )
    )
)
:: Also check Roblox ClientAppSettings directly (FFlags stored here)
set "RBX_FFLAGS=%LOCALAPPDATA%\Roblox\GlobalBasicSettings_13.xml"
if exist "%RBX_FFLAGS%" (
    set "HITSECTION=ROBLOX FFLAGS SETTINGS" & set "HITPATH=%RBX_FFLAGS%" & call :flag_hit
    >> "%HITSFILE%" echo   --- Contents ---
    type "%RBX_FFLAGS%" >> "%HITSFILE%" 2>nul
    >> "%HITSFILE%" echo.
)

:: ============================================================
:: SECTION 8: ROBLOX VERSIONS + DLL INJECTION
:: ============================================================
if exist "%LOC3%" (
    for /f "delims=" %%F in ('dir /s /b "%LOC3%" 2^>nul ^| findstr /i "voidstrap velostrap xeno wave solara bootstrapper bytebreaker real medium volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap" 2^>nul') do (
        set "HITSECTION=ROBLOX VERSIONS" & set "HITPATH=%%F" & call :flag_hit
    )
    for /f "delims=" %%F in ('dir /s /b "%LOC3%\*.dll" 2^>nul') do (
        echo %%F | findstr /i "RobloxApp\|RobloxProxy\|ssl\|winhttp\|xinput\|d3d\|dxgi\|version\|dbghelp\|msvcp\|vcruntime\|concrt" >nul 2>nul
        if errorlevel 1 (
            set "HITSECTION=UNEXPECTED DLL IN ROBLOX" & set "HITPATH=%%F" & call :flag_hit
        )
    )
)

:: ============================================================
:: SECTION 9: RUNNING PROCESSES
:: ============================================================
for /f "delims=" %%F in ('tasklist 2^>nul ^| findstr /i "voidstrap velostrap xeno wave solara bootstrapper bytebreaker real medium volcano volt potassium sirhurt swift velocity vortex matcha lumen photon plexity fishtrap" 2^>nul') do (
    set "HITSECTION=RUNNING PROCESS" & set "HITPATH=%%F" & call :flag_hit
)

:: ============================================================
:: SECTION 10: REGISTRY (INSTALLED + STARTUP)
:: ============================================================
set "KW_REG=voidstrap velostrap xeno wave solara bootstrapper bytebreaker volcano volt potassium sirhurt velocity vortex matcha lumen photon plexity fishtrap"
for /f "delims=" %%F in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s 2^>nul ^| findstr /i "%KW_REG%" 2^>nul') do (set "HITSECTION=INSTALLED PROGRAM" & set "HITPATH=%%F" & call :flag_hit)
for /f "delims=" %%F in ('reg query "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s 2^>nul ^| findstr /i "%KW_REG%" 2^>nul') do (set "HITSECTION=INSTALLED PROGRAM" & set "HITPATH=%%F" & call :flag_hit)
for /f "delims=" %%F in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s 2^>nul ^| findstr /i "%KW_REG%" 2^>nul') do (set "HITSECTION=INSTALLED PROGRAM" & set "HITPATH=%%F" & call :flag_hit)
for /f "delims=" %%F in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| findstr /i "%KW_REG%" 2^>nul') do (set "HITSECTION=STARTUP ENTRY" & set "HITPATH=%%F" & call :flag_hit)
for /f "delims=" %%F in ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| findstr /i "%KW_REG%" 2^>nul') do (set "HITSECTION=STARTUP ENTRY" & set "HITPATH=%%F" & call :flag_hit)
for /f "delims=" %%F in ('schtasks /query /fo LIST /v 2^>nul ^| findstr /i "%KW_REG%" 2^>nul') do (set "HITSECTION=SCHEDULED TASK" & set "HITPATH=%%F" & call :flag_hit)

:: ============================================================
:: SECTION 11: RECENTLY MODIFIED EXECUTABLES (Downloads only - fast)
:: ============================================================
for /f "delims=" %%F in ('dir /b "%LOC4%\*.exe" "%LOC4%\*.dll" 2^>nul') do (
    set "HITSECTION=EXE IN DOWNLOADS" & set "HITPATH=%%F" & call :flag_hit
)

:: ============================================================
:: FINALIZE - WRITE FOOTER + PRINT + SEND
:: ============================================================
if !SUSPCOUNT!==0 (
    >>"%HITSFILE%" echo NO SUSPICIOUS FINDINGS - All sections clean.
) else (
    >>"%HITSFILE%" echo ============================================================
    >>"%HITSFILE%" echo TOTAL SUSPICIOUS HITS: !SUSPCOUNT!
    >>"%HITSFILE%" echo ============================================================
)
cls
echo ============================================================
echo           KOEZY - SCAN RESULTS
echo ============================================================
echo  Computer : %COMPUTERNAME%
echo  User     : %USERNAME%
echo  Date     : %DATE% %TIME%
echo  Hits     : !SUSPCOUNT!
echo ============================================================
echo.
if !SUSPCOUNT!==0 (
    echo  [CLEAN] No suspicious findings detected.
) else (
    echo  [!!] SUSPICIOUS FINDINGS:
    echo.
    type "%HITSFILE%"
)
echo.
echo ============================================================
echo.

:: Save results to their Desktop
set "SAVEFILE=%USERPROFILE%\Desktop\koezy_%COMPUTERNAME%_%DATE:~-4%%DATE:~3,2%%DATE:~0,2%.txt"
copy "%HITSFILE%" "%SAVEFILE%" >nul 2>nul
echo  Saved to: %SAVEFILE%
echo.

:: Send to Discord - write PS1 to temp and run it
echo Sending to Discord...
set "SENDPS1=%TMPDIR%\send.ps1"
(
echo param^($hitsFile,$suspCount,$url,$computerName,$userName,$dateStr^)
echo $color=if^($suspCount -gt 0^){16711680}else{65280}
echo $status=if^($suspCount -gt 0^){"SUSPICIOUS - $suspCount hit(s)"}else{"CLEAN"}
echo $embed=[ordered]@{title="KOEZY SCAN - $computerName / $userName";color=$color;description="See attached file.";fields=@^([ordered]@{name='Result';value=$status;inline=$true},[ordered]@{name='Hits';value="$suspCount";inline=$true},[ordered]@{name='Date';value=$dateStr;inline=$false}^)}
echo $payload=[ordered]@{username='Koezy Cheat Checker';embeds=@^($embed^)}^|ConvertTo-Json -Depth 10 -Compress
echo $boundary=[System.Guid]::NewGuid^(^).ToString^("N"^)
echo $fileName="koezy_${computerName}.txt"
echo $fileContent=[System.IO.File]::ReadAllText^($hitsFile^)
echo $body="--$boundary`r`nContent-Disposition: form-data; name=`"payload_json`"`r`nContent-Type: application/json`r`n`r`n$payload`r`n--$boundary`r`nContent-Disposition: form-data; name=`"file`"; filename=`"$fileName`"`r`nContent-Type: text/plain`r`n`r`n$fileContent`r`n--$boundary--"
echo $bodyBytes=[System.Text.Encoding]::UTF8.GetBytes^($body^)
echo try{Invoke-RestMethod -Uri $url -Method Post -Body $bodyBytes -ContentType "multipart/form-data; boundary=$boundary" -ErrorAction Stop;Write-Host '[OK] Sent to Discord.'}catch{Write-Host "[ERR] $_"}
) > "%SENDPS1%"
powershell -NoProfile -ExecutionPolicy Bypass -File "%SENDPS1%" "%HITSFILE%" "!SUSPCOUNT!" "%WEBHOOK_URL%" "%COMPUTERNAME%" "%USERNAME%" "%DATE% %TIME%"

:: Clean up temp
rmdir /s /q "%TMPDIR%" 2>nul

echo ============================================================
echo  Press any key to return to menu...
echo ============================================================
pause >nul
goto menu

:: ============================================================
:: EXIT
:: ============================================================
:exitprog
cls
echo Exiting Koezy Cheat Checker...
timeout /t 2 >nul
exit /b 0
