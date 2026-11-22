<#
.SYNOPSIS
    Disables System Restore on all drives permanently.

.DESCRIPTION
    This function disables Windows System Restore functionality by using the Disable-ComputerRestore cmdlet for the system drive and setting the DisableSR registry policy to 1.
    This prevents the creation of restore points and reclaims disk space reserved for system protection.
    The change applies system-wide and persists across reboots.

.NOTES
    This function requires administrator privileges.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Disable-SystemRestore {
    Write-Running 'Disabling Computer Restore in all Drivers'
    Disable-ComputerRestore 'C:\'

    Write-Running 'Disabling System Restore Permanently'
    Set-RegistryValue -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore' -Name 'DisableSR' -Value 1

    Write-Ok 'Computer Restore Disabled!'
}
