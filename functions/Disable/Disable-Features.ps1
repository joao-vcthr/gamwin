<#
.SYNOPSIS
    Disables specified Windows optional features.

.DESCRIPTION
    This function iterates through a provided array of Windows optional feature names and disables each one that is currently enabled.
    It queries the feature state using Get-WindowsOptionalFeature, skips features that are not found or already disabled,
    and uses Disable-WindowsOptionalFeature with the NoRestart flag to remove the feature without requiring an immediate reboot.
    Errors are caught and reported per feature.

.NOTES
    This function requires administrator privileges.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Disable-Features {
    param(
        [Parameter(Mandatory)]
        [string[]]$Features
    )

    foreach ($Name in $Features) {
        try {
            $found = Get-WindowsOptionalFeature -Online -FeatureName $Name -ErrorAction Stop
        } catch {
            Write-Skip "$Name (not queryable -- $($_.Exception.Message))"
            continue
        }

        if (-not $found -or $found.State -ne 'Enabled') {
            Write-Skip $Name
            continue
        }

        if ($PSCmdlet.ShouldProcess($Name, 'Disable-WindowsOptionalFeature')) {
            try {
                Disable-WindowsOptionalFeature -Online -FeatureName $Name -NoRestart -ErrorAction Stop | Out-Null
                Write-Ok $Name
            } catch {
                Write-Fail "$Name -- $($_.Exception.Message)"
            }
        }
    }

    Write-Ok 'Features disabled!'
}
