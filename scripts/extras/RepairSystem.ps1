<#
.SYNOPSIS
    Executes a comprehensive suite of maintenance tasks to rectify system corruption and optimise disk health.

.DESCRIPTION
    This script is designed for periodic system 'tuning' and error correction. It performs a deep-level analysis of the operating system's integrity and storage performance through the following actions:
    - Initialises an online cleanup and restoration of the Windows Image using DISM.
    - Runs the System File Checker (SFC) to cross-reference and repair protected system files.
    - Schedules an offline volume repair (CHKDSK) for the C: drive to address file system inconsistencies.
    - Optimises the primary partition using the 'ReTrim' command, which is particularly beneficial for maintaining SSD performance.

.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

#Requires -RunAsAdministrator

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\..\functions\Helpers\Write-Log.ps1"
. "$ProjectRoot\..\functions\Helpers\Request-Restart.ps1"

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Write-Header 'SYSTEM REPAIR'

Dism.exe /Online /Cleanup-Image /RestoreHealth
sfc.exe /SCANNOW
Repair-Volume -DriveLetter 'C' -OfflineScanAndFix -Confirm:$false

Write-Ok 'System repair completed! Restart the computer'

Request-Restart
