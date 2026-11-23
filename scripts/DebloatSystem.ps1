<#
.SYNOPSIS
    Windows 11 Debloat Script — removes AppX packages, optional capabilities and Windows features.

.DESCRIPTION
    Removes the AppX packages, optional capabilities and Windows features defined in the
    .psd1 files under .\configs. Designed to be idempotent: items that are already absent
    are silently skipped.
.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

#Requires -RunAsAdministrator

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\functions\Helpers\Set-RegistryValue.ps1"
. "$ProjectRoot\functions\Helpers\Write-Log.ps1"
. "$ProjectRoot\functions\Remove\Remove-AppxPackages.ps1"
. "$ProjectRoot\functions\Remove\Remove-Capabilities.ps1"
. "$ProjectRoot\functions\Remove\Remove-OneDrive.ps1"
. "$ProjectRoot\functions\Disable\Disable-Features.ps1"

Write-Header 'SYSTEM DEBLOAT'

Write-Running 'Importing data'
$appxPackages = Import-PowerShellDataFile -Path "$ProjectRoot\configs\debloat\AppxPackages.psd1"
$capabilities = Import-PowerShellDataFile -Path "$ProjectRoot\configs\debloat\Capabilities.psd1"
$features     = Import-PowerShellDataFile -Path "$ProjectRoot\configs\debloat\Features.psd1"

# Remove AppX Packages
Write-Running 'Removing AppX Packages'
Remove-AppxPackages -Packages $appxPackages.Packages

# Remove Optional Capabilities
Write-Running 'Removing Optional Capabilities'
Remove-Capabilities -Capabilities $capabilities.Capabilities

# Disable Optional Features
Write-Running 'Disabling Optional Features'
Disable-Features -Features $features.Features

# Remove OneDrive
Write-Running 'Removing OneDrive'
Remove-OneDrive

Write-Ok 'Done. A restart may be required for some changes to take effect.'

Read-Host 'Press ENTER to continue...'
