<#
.SYNOPSIS
    Sets the system time zone to Brasília and synchronizes the clock.

.DESCRIPTION
    This function configures the system time zone to 'E. South America Standard Time' (Brasília) using Set-TimeZone,
    then ensures the Windows Time service is running and forces an immediate clock synchronization with the configured time server using W32tm /resync /force.
    This ensures accurate system time for the target locale.

.NOTES
    This function requires administrator privileges.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Set-SystemClock {
    Write-Running 'Synchronizing clock...'
    net start w32time
    W32tm /resync /force

    Write-Ok 'Clock synchronized successfully!'
}
