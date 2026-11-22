<#
.SYNOPSIS
    Configures Windows privacy settings.

.DESCRIPTION
    Imports the configured application permissions, disables those permissions,
    and disables system telemetry. This script requires administrator privileges
    and supports -WhatIf through ShouldProcess.

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
. "$ProjectRoot\functions\Disable\Disable-AppPermissions.ps1"
. "$ProjectRoot\functions\Disable\Disable-Telemetry.ps1"

Write-Header 'PRIVACY CONFIGURATION'

Write-Running 'Importing data'
$AppPermissions = Import-PowerShellDataFile -Path "$ProjectRoot\configs\system\AppPermissions.psd1"

Write-Running 'Disabling App Permissions'
Disable-AppPermissions -Permissions $AppPermissions.Permissions

Write-Running 'Disabling Telemetry'
Disable-Telemetry

Write-Ok 'Privacy Configuration completed!'

Read-Host 'Press ENTER to continue...'
