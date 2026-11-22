<#
.SYNOPSIS
    Removes specified Windows capabilities.

.DESCRIPTION
    This function removes Windows capabilities by name using the Remove-WindowsCapability cmdlet.
    It temporarily starts the Windows Update service (wuauserv) if not already running, as it's required for capability removal.
    The function queries for installed capabilities matching the provided name patterns, skips those not found or not installed, and restores the Windows Update service to its original state upon completion.
    Errors during removal are caught and reported per capability.

.NOTES
    This function requires administrator privileges.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Remove-Capabilities {
    param(
        [Parameter(Mandatory)]
        [string[]]$Capabilities
    )

    # Ensures the Windows Update service is running and restores the original state at the end.
    $wuauserv           = Get-Service -Name wuauserv
    $wuauservWasRunning = $wuauserv.Status -eq 'Running'

    if (-not $wuauservWasRunning) {
        Write-Running 'Starting Windows Update service temporarily'
        Start-Service -Name wuauserv
    }

    try {
        foreach ($Name in $Capabilities) {
            try {
                $found = Get-WindowsCapability -Online -ErrorAction Stop |
                         Where-Object { $_.Name -like "$Name*" -and $_.State -eq 'Installed' }
            } catch {
                Write-Skip "$Name (not queryable -- $($_.Exception.Message))"
                continue
            }

            if (-not $found) {
                Write-Skip $Name
                continue
            }

            if ($PSCmdlet.ShouldProcess($Name, 'Remove-WindowsCapability')) {
                try {
                    $found | Remove-WindowsCapability -Online -ErrorAction Stop | Out-Null
                    Write-Ok $Name
                } catch {
                    Write-Fail "$Name -- $($_.Exception.Message)"
                }
            }
        }
    } finally {
        # Stops the service only if it was started by this script
        if (-not $wuauservWasRunning) {
            Write-Running 'Stopping Windows Update service'
            Stop-Service -Name wuauserv
        }
    }

    Write-Ok 'Capabilities removed!'
}
