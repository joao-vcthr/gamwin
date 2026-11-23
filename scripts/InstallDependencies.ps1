<#
.SYNOPSIS
    Installs dependencies from a specified list.
.DESCRIPTION
    This script installs the dependencies packages defined in the .psd1 file under .\configs\install.
.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

#Requires -RunAsAdministrator

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

Write-Host "$ProjectRoot"

. "$ProjectRoot\functions\Helpers\Write-Log.ps1"
. "$ProjectRoot\functions\Helpers\Request-Restart.ps1"
. "$ProjectRoot\functions\Helpers\Install-WingetPackage.ps1"

Write-Header 'DEPENDENCIES INSTALLATION'

Write-Running 'Importing data'
$dependencies = Import-PowerShellDataFile -Path "$ProjectRoot\configs\install\Dependencies.psd1"

Write-Running 'Updating Winget'
winget source update

Write-Running 'Installing dependencies'
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All # Enable .NET 3.5

$count = 1
foreach ($package in $dependencies.Packages) {
    Write-Running "Installing $count/$($dependencies.Packages.Count)"
    Install-WingetPackage -Package $package
    $count += 1
}

Write-Ok 'Dependencies installed! Restart the computer.'
Request-Restart
