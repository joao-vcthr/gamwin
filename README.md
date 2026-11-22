# GamWin Mode - Windows 11 Game Ready Setup

A personal collection of PowerShell automation scripts plus a post-install guide to turn a clean Windows 11 machine into a dedicated gaming and streaming "console".

---

## Overview

This project is organized around a menu-driven workflow under the `main.ps1` script:

- **[`./main.ps1`](.\main.ps1)** — the main entry point; launches a text menu with the most common setup and maintenance actions.
- **[`windows-gaming-post-install-guide.md`](.\guides\windows-gaming-post-install-guide.md)** — the full walkthrough for manual Windows configuration, driver setup, and app-level tuning beyond what the scripts automate.
- **Scripts in [`scripts/`](.\scripts)** — automate the repetitive system hardening, bloat removal, app installation, and cleanup tasks.

This README is the quick reference for the current structure, available commands, and the recommended order of operations.

---

## Project structure

```text
.
│   bootstrap.ps1
│   launcher.ps1
│   main.ps1
│   README.md
│
├───configs
│   ├───debloat
│   │       AppxPackages.psd1
│   │       Capabilities.psd1
│   │       Features.psd1
│   │
│   ├───install
│   │       Dependencies.psd1
│   │       GamingApplications.psd1
│   │
│   ├───menu
│   │       ExtrasMenu.psd1
│   │       MainMenu.psd1
│   │
│   ├───network
│   │       DnsServerAddresses.psd1
│   │
│   └───system
│           AppPermissions.psd1
│           Services.psd1
│
├───functions
│   ├───Disable
│   │       Disable-AppPermissions.ps1
│   │       Disable-Features.ps1
│   │       Disable-GameDVR.ps1
│   │       Disable-PointerPrecision.ps1
│   │       Disable-Services.ps1
│   │       Disable-SystemRestore.ps1
│   │       Disable-Telemetry.ps1
│   │
│   ├───Enable
│   │       Enable-TaskbarEndTask.ps1
│   │
│   ├───Helpers
│   │       Install-WingetPackage.ps1
│   │       Request-Restart.ps1
│   │       Set-RegistryValue.ps1
│   │       Start-Elevated.ps1
│   │       Write-Log.ps1
│   │
│   ├───Remove
│   │       Remove-AppxPackages.ps1
│   │       Remove-Capabilities.ps1
│   │       Remove-OneDrive.ps1
│   │
│   ├───Set
│   │       Set-DnsProvider.ps1
│   │       Set-PowerPlan.ps1
│   │       Set-SystemClock.ps1
│   │
│   └───UI
│           Write-Banner.ps1
│           Write-Menu.ps1
│
├───guides
│       windows-gaming-post-install-guide.md
│
└───scripts
    │   CleanSystem.ps1
    │   ConfigurePrivacy.ps1
    │   ConfigureSystemBehavior.ps1
    │   DebloatSystem.ps1
    │   DisableServices.ps1
    │   Extras.ps1
    │   ImportBackup.ps1
    │   InstallApplications.ps1
    │   InstallDependencies.ps1
    │   SetupSystem.ps1
    │
    └───extras
            DisableMultiPlaneOverlay.ps1
            RepairSystem.ps1
            SetNewDnsProvider.ps1
```

The real entry point is `main.ps1`. The menu script orchestrates the work, while the `configs/` files define package lists and system settings, and the `functions/` folder contains reusable PowerShell logic.

---

## Requirements

- Windows 11 (clean install is recommended)
- Internet connection for dependency and app installation steps
- `#Requires -RunAsAdministrator` is enforced in some of the scripts

---

## Getting started

The easiest and most reliable way to begin is to launch PowerShell or Windows Terminal and use the bootstrap installer from GitHub.

### Recommended quick start

```powershell
powershell -ExecutionPolicy Bypass -Command "irm `"https://raw.githubusercontent.com/joao-vcthr/gamwin/main/bootstrap.ps1`" | iex"
```

This downloads the bootstrap script and runs the project setup flow from the repository.

### Using the launcher

Go to 'Gamwin' folder on file explorer, right-click 'launcher.ps1' and click 'Run with Powershell'

If Powershell's Execution Policy is set to 'Restricted' the launcher will not work. To fix this, launch PowerShell or Windows Terminal as Administrator and run:

```powershell
Set-ExecutionPolicy 'Unrestricted'
```

### Cloning the repo manually, and using starting gamwin from the main.ps1 file 

If you prefer to work locally from a checked-out copy:

Launch PowerShell or Windows Terminal and change the directory to where 'Gamwin' is saved, example 'cd $HOME\Downloads\gamwin', and run:
```powershell
git clone https://github.com/joao-vcthr/gamwin-mode.git
Set-Location -Path .\gamwin-mode
powershell -ExecutionPolicy Bypass -File ".\main.ps1"
```

This opens the main interactive menu, which is the recommended path for most users.

### Running the menu from the repository

If you already have the repo checked out, you can start it directly with:

```powershell
Set-Location .\gamwin-mode
powershell -ExecutionPolicy Bypass -File ".\main.ps1"
```

### Advanced: run individual scripts directly

Use this only if you want to execute a specific step manually instead of using the menu:

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\SetupSystem.ps1"
powershell -ExecutionPolicy Bypass -File ".\scripts\DebloatSystem.ps1"
powershell -ExecutionPolicy Bypass -File ".\scripts\InstallDependencies.ps1"
powershell -ExecutionPolicy Bypass -File ".\scripts\InstallApplications.ps1"
powershell -ExecutionPolicy Bypass -File ".\scripts\ConfigureSystemBehavior.ps1"
powershell -ExecutionPolicy Bypass -File ".\scripts\ConfigurePrivacy.ps1"
powershell -ExecutionPolicy Bypass -File ".\scripts\ConfigureServices.ps1"
powershell -ExecutionPolicy Bypass -File ".\scripts\CleanSystem.ps1"
```

> For a clean Windows 11 install, start with the menu-driven flow and follow the recommended order in the next section.

---

## Main menu options

The interactive menu in `./main.ps1` includes the following actions:

| Menu option | Script | What it does |
|---|---|---|
| 1 | `SetupSystem.ps1` | Basic OS setup: system clock, network/DNS, keyboard layout, delivery optimization, power plan, and system restore disablement. |
| 2 | `DebloatSystem.ps1` | Removes AppX packages, optional capabilities, Windows features, and OneDrive based on the config data. |
| 3 | `InstallDependencies.ps1` | Enables .NET 3.5 and installs dependency packages from `configs/install/Dependencies.psd1`. |
| 4 | `InstallApplications.ps1` | Installs gaming and utility apps from `configs/install/GamingApplications.psd1`. |
| 5 | `ImportBackup.ps1` | Imports the saved backup/configuration profile for the system. |
| 6 | `CleanSystem.ps1` | Runs a cleanup pass: WinSxS component cleanup, temp files, recycle bin, DNS cache, Winsock reset, and TRIM optimization. |
| 7 | `ConfigureSystemBehavior.ps1` | Disables pointer precision, Game DVR, and enables taskbar end-task behavior. |
| 8 | `ConfigurePrivacy.ps1` | Disables app permissions and telemetry. |
| 9 | `DisableeServices.ps1` | Stops and disables non-essential services defined in `configs/Services.psd1`. |
| E | `Extras.ps1` | Opens a secondary menu with additional tasks such as DNS tweaks, MPO disabling, and repair flows. |
| 0 | — | Exits the menu. |

---

## Additional maintenance scripts

These scripts are still available as standalone tools outside the main menu:

| Script | What it does |
|---|---|
| `RepairSystem.ps1` | Runs repair tasks such as `DISM /RestoreHealth`, `sfc /scannow`, and disk repair checks. |
| `Extras.ps1` | Provides additional configuration and maintenance tasks beyond the main flow. |

> Use the repair and cleanup routines periodically when system errors, slowness, or storage issues appear.

---

## Recommended flow

For a fresh Windows 11 install, the typical order is:

1. Run `./main.ps1`
2. Choose `Setup System`
3. Choose `Debloat System`
4. Choose `Install Dependencies`
5. Choose `Install Applications`
6. Choose `Configure System Behavior`
7. Choose `Configure Privacy`
8. Choose `Configure Services`
9. Run `Clean System` at the end

For the full walkthrough, including manual Windows settings, drivers, and app-specific personalization, see **[windows-gaming-post-install-guide.md](./windows-gaming-post-install-guide.md)**.

---
