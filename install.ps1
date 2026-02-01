#
# KNEX Symbol - Windows Installation Script
# Run with: powershell -ExecutionPolicy Bypass -File install.ps1
#

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "+==========================================================+" -ForegroundColor Cyan
Write-Host "|    K KNEXCOIN CURRENCY SYMBOLS - Windows INSTALLER       |" -ForegroundColor Cyan
Write-Host "|           Type K (KNEX) and < (RAW) anywhere!            |" -ForegroundColor Cyan
Write-Host "+==========================================================+" -ForegroundColor Cyan
Write-Host ""

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# ============================================================
# STEP 1: Install Font
# ============================================================
Write-Host "[1/3] Installing KNEX Symbol Font..." -ForegroundColor Green

$FontPath = Join-Path $ScriptDir "KnexSymbol.ttf"
$FontsFolder = (New-Object -ComObject Shell.Application).Namespace(0x14)

if (Test-Path $FontPath) {
    $FontsFolder.CopyHere($FontPath, 0x10)
    Write-Host "Font installed to Windows Fonts folder"
} else {
    Write-Host "Font file not found at $FontPath" -ForegroundColor Red
}

# ============================================================
# STEP 2: Create AutoHotkey Script
# ============================================================
Write-Host ""
Write-Host "[2/3] Creating AutoHotkey Script..." -ForegroundColor Green

$AhkScript = @'
; KNEX Currency Symbol AutoHotkey Script
; Hotkeys for typing KNEX (K) and RAW (<) symbols
;
; Shortcuts:
;   Alt+K        -> K + space (KNEX)
;   Alt+Shift+K  -> K (no space)
;   Alt+R        -> < + space (RAW)
;   Alt+Shift+R  -> < (no space)

#NoEnv
#SingleInstance Force
SendMode Input

; KNEX Symbol
!k::Send {U+20AD}{Space}
!+k::Send {U+20AD}

; RAW Symbol
!r::Send {U+22D6}{Space}
!+r::Send {U+22D6}

; Copy to clipboard variants
^!k::
    Clipboard := Chr(0x20AD)
    ToolTip, K copied!
    Sleep 1000
    ToolTip
    return

^!r::
    Clipboard := Chr(0x22D6)
    ToolTip, < copied!
    Sleep 1000
    ToolTip
    return
'@

$AhkPath = Join-Path $env:USERPROFILE "Documents\KnexSymbol.ahk"
$AhkScript | Out-File -FilePath $AhkPath -Encoding UTF8
Write-Host "AutoHotkey script created at: $AhkPath"

# ============================================================
# STEP 3: Create Startup Shortcut
# ============================================================
Write-Host ""
Write-Host "[3/3] Setting up Auto-Start..." -ForegroundColor Green

$StartupFolder = [Environment]::GetFolderPath("Startup")
$ShortcutPath = Join-Path $StartupFolder "KnexSymbol.lnk"

# Check if AutoHotkey is installed
$AhkExe = "C:\Program Files\AutoHotkey\AutoHotkey.exe"
$AhkExeV2 = "C:\Program Files\AutoHotkey\v2\AutoHotkey.exe"

if (Test-Path $AhkExeV2) {
    $AhkExe = $AhkExeV2
}

if (Test-Path $AhkExe) {
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($ShortcutPath)
    $Shortcut.TargetPath = $AhkExe
    $Shortcut.Arguments = "`"$AhkPath`""
    $Shortcut.Save()
    Write-Host "Startup shortcut created"

    # Start the script now
    Start-Process $AhkExe -ArgumentList "`"$AhkPath`""
    Write-Host "KNEX Symbol hotkeys are now active!"
} else {
    Write-Host ""
    Write-Host "AutoHotkey not found. Please install it:" -ForegroundColor Yellow
    Write-Host "  https://www.autohotkey.com/download/" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "After installing AutoHotkey, double-click:" -ForegroundColor Yellow
    Write-Host "  $AhkPath" -ForegroundColor Yellow
}

# ============================================================
# DONE
# ============================================================
Write-Host ""
Write-Host "+==========================================================+" -ForegroundColor Cyan
Write-Host "|                 INSTALLATION COMPLETE!                   |" -ForegroundColor Cyan
Write-Host "+==========================================================+" -ForegroundColor Cyan
Write-Host ""
Write-Host "Keyboard shortcuts:" -ForegroundColor Green
Write-Host ""
Write-Host "  KNEX (K):                      RAW (<):"
Write-Host "  ---------------------          ---------------------"
Write-Host "  * Alt+K     -> K + space       * Alt+R     -> < + space"
Write-Host "  * Alt+Shift+K -> K             * Alt+Shift+R -> <"
Write-Host "  * Alt+Ctrl+K  -> copy          * Alt+Ctrl+R  -> copy"
Write-Host ""
Write-Host "  Currency: 1 K = 10,000,000 < (10M RAW)"
Write-Host ""
Write-Host "Happy KNEXing! K <" -ForegroundColor Green
Write-Host ""

Read-Host "Press Enter to exit"
