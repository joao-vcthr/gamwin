<#
.SYNOPSIS
    Installs applications from a specified list.
.DESCRIPTION
    This script installs the applications packages defined in the .psd1 file under .\configs.
.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\functions\Helpers\Write-Log.ps1"
. "$ProjectRoot\functions\Helpers\Install-WingetPackage.ps1"

Write-Header 'APPS INSTALLATION'

Write-Running 'Updating WinGet'
winget source update

Write-Running 'Importing Gaming Applications'
$applications = Import-PowerShellDataFile -Path "$ProjectRoot\configs\install\GamingApplications.psd1"

Write-Running 'Installing Apps'
$count = 1
foreach ($package in $applications.Packages) {
    Write-Running "Installing $count/$($applications.Packages.Count)"
    Install-WingetPackage -Package $package
    $count += 1
}

Write-Ok 'Apps installed!'

Read-Host 'Press ENTER to continue...'
