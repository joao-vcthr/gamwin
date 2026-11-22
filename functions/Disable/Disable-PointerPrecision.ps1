<#
.SYNOPSIS
    Disables mouse pointer precision (acceleration) for the current user.

.DESCRIPTION
    This function disables mouse pointer precision (also known as mouse acceleration)
    by setting the MouseSpeed, MouseThreshold1, and MouseThreshold2 registry values to 0 under HKCU:\Control Panel\Mouse.

.NOTES
    This function modifies current user registry settings.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Disable-PointerPrecision {
    $path = 'HKCU:\Control Panel\Mouse'

    Set-RegistryValue -Path $path -Name 'MouseSpeed'      -Value 0
    Set-RegistryValue -Path $path -Name 'MouseThreshold1' -Value 0
    Set-RegistryValue -Path $path -Name 'MouseThreshold2' -Value 0

    Write-Ok 'Pointer Precision has been disabled!'
}
