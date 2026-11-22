<#
.SYNOPSIS
    Facilitates the initial commissioning and hardening of a freshly installed Windows 11 environment.

.DESCRIPTION
    This script automates the essential configuration steps required to transform a default installation into an optimised workstation. It consolidates multiple administrative tasks into a single workflow to ensure consistency across deployments.

    Key actions include:
    - Changing power plan to balanced and deactivating hibernation to reclaim storage.
    - Synchronising the system clock and localising the time zone settings.
    - Establishing a secure network configuration with custom DNS and cleared caches.
    - Renaming the computer to a predefined hostname.
    - Disabling System Restore.

.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

#Requires -RunAsAdministrator

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\functions\Helpers\Write-Log.ps1"
. "$ProjectRoot\functions\Helpers\Set-RegistryValue.ps1"
. "$ProjectRoot\functions\Set\Set-SystemClock.ps1"
. "$ProjectRoot\functions\Set\Set-PowerPlan.ps1"
. "$ProjectRoot\functions\Set\Set-DnsProvider.ps1"
. "$ProjectRoot\functions\Disable\Disable-SystemRestore.ps1"
. "$ProjectRoot\functions\UI\Write-Menu.ps1"

Write-Header 'SYSTEM SETUP'

Write-Running 'Configuring the System Clock'
Set-SystemClock

Write-Running 'Configuring the DNS'
$providers = Import-PowerShellDataFile -Path "$ProjectRoot\configs\network\DnsServerAddresses.psd1"
Set-DnsProvider -Providers $providers

Write-Running 'Configuring the Power Plan'
Set-PowerPlan

Write-Running 'Disabling Delivery Optimisation'
Set-DODownloadMode -DownloadMode 0 # Disable Delivery Optimization


$choice = Read-Host "Do you want do disable System Restore to save disk space? If you disable it, you wont be able to recover the system to a previous state. (Y/N)"
$choice = $choice.Trim().ToUpperInvariant()

switch ($choice) {
    'Y' {
        Write-Running 'Disabling System Restore...'
        Disable-SystemRestore
    }
    'N' {
        Write-Running 'Keeping System Restore On'
    }
    default {
        Write-Fail 'Invalid Option'
        Write-Running 'Keeping System Restore On'
    }
}

$choice = Read-Host "Your computer's name is currently $env:ComputerName. Do you want to rename it? (Y/N)"
$choice = $choice.Trim().ToUpperInvariant()

switch ($choice) {
    'Y' {
        $pcname = Read-Host 'Type the new computer name'
        Write-Running 'Renaming the computer'
        Rename-Computer -NewName $pcname
    }
    'N' {
        Write-Running 'Keeping the current name'
    }
    default {
        Write-Fail 'Invalid Option'
        Write-Running 'Keeping the current name'
    }
}

Write-Ok 'Basic Setup Done!'

Read-Host 'Press ENTER to continue...'
