<#
.SYNOPSIS
    Disables Windows services.

.DESCRIPTION
    Tests the services configuration file, imports the list of services to manage,
    and stops and disables each available service. This script requires administrator
    privileges and supports -WhatIf through ShouldProcess.

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
. "$ProjectRoot\functions\Disable\Disable-Services.ps1"

Write-Header 'DISABLE SERVICES'

Write-Running 'Importing data'
$services = Import-PowerShellDataFile -Path "$ProjectRoot\configs\system\Services.psd1"

Write-Running 'Disabling Services'
Disable-Services -Services $services.Services

Read-Host 'Press ENTER to continue...'
