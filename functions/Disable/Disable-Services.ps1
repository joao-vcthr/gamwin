<#
.SYNOPSIS
    Stops and disables specified Windows services.

.DESCRIPTION
    This function iterates through a provided array of service names, stopping each running service and setting its startup type to Disabled.
    It gracefully handles services that don't exist by skipping them, and uses ShouldProcess for confirmation support.
    Errors during service manipulation are caught and reported without halting the entire operation.

.NOTES
    This function requires administrator privileges.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Disable-Services {
    param(
        [Parameter(Mandatory)]
        [string[]]$Services
    )

    foreach ($Name in $Services) {
        $svc = Get-Service -Name $Name -ErrorAction SilentlyContinue

        if (-not $svc) {
            Write-Skip $Name
            continue
        }

        if ($PSCmdlet.ShouldProcess($Name, 'Stop and disable service')) {
            try {
                Stop-Service -Name $Name -Force -ErrorAction SilentlyContinue
                Set-Service -Name $Name -StartupType Disabled -ErrorAction Stop
                Write-Ok $Name
            } catch {
                Write-Fail "$Name -- $($_.Exception.Message)"
            }
        }
    }

    Write-Ok 'Services disabled!'
}
