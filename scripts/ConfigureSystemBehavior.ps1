<#
.SYNOPSIS
    Configures Windows personalization settings.

.DESCRIPTION
    This script configures various Windows personalization options such as
    disabling pointer precision and enabling the taskbar end task feature.

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
. "$ProjectRoot\functions\Disable\Disable-PointerPrecision.ps1"
. "$ProjectRoot\functions\Disable\Disable-GameDVR.ps1"
. "$ProjectRoot\functions\Enable\Enable-TaskbarEndTask.ps1"

Write-Header 'SYSTEM PERSONALIZATION'

Write-Running 'Disabling Pointer Precision'
Disable-PointerPrecision

Write-Running 'Disabling GameDVR'
Disable-GameDVR

Write-Running 'Enabling "End Task" option on Taskbar'
Enable-TaskbarEndTask

Read-Host 'Press ENTER to continue...'
