<#
.SYNOPSIS
    Disables Multi-Plane Overlay (MPO).

.DESCRIPTION
    This script disables the Multi-Plane Overlay (MPO) feature in the Desktop Window Manager (DWM)
    by setting the OverlayTestMode registry value to 5 under HKLM:\SOFTWARE\Microsoft\Windows\Dwm.
    A system restart is required for the change to take effect.

.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        11/19/2026
#>

#Requires -RunAsAdministrator

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\..\functions\Helpers\Write-Log.ps1"
. "$ProjectRoot\..\functions\Helpers\Request-Restart.ps1"
. "$ProjectRoot\..\functions\Helpers\Set-RegistryValue.ps1"

Write-Header 'DISABLE MPO'

Write-Running 'Disabling MPO'

Set-RegistryValue -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Dwm' -Name 'OverlayTestMode' -Value 5
Write-Ok 'MPO disabled!'

Request-Restart
