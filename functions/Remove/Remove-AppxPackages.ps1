<#
.SYNOPSIS
    Removes specified AppX packages for all users.

.DESCRIPTION
    This function uninstalls AppX packages by name across all user profiles.
    For each package, it queries for installed instances using Get-AppxPackage, skips packages not found, and removes them with Remove-AppxPackage -AllUsers.
    It also attempts to remove any provisioned packages matching the display name to prevent reinstallation for new users.
    Errors are caught and reported per package.

.NOTES
    This function requires administrator privileges.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Remove-AppxPackages {
    param(
        [Parameter(Mandatory)]
        [string[]]$Packages
    )

    foreach ($Name in $Packages) {

        $found = Get-AppxPackage -Name $Name -AllUsers -ErrorAction SilentlyContinue

        if (-not $found) {
            Write-Skip $Name
            continue
        }

        if ($PSCmdlet.ShouldProcess($Name, 'Remove-AppxPackage')) {
            try {
                $found | Remove-AppxPackage -AllUsers -ErrorAction Stop

                $provisioned = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue |
                               Where-Object { $_.DisplayName -like $Name }
                if ($provisioned) {
                    $provisioned | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Out-Null
                }

                Write-Ok $Name
            } catch {
                Write-Fail "$Name -- $($_.Exception.Message)"
            }
        }
    }

    Write-Ok 'AppX packages removed!'
}
