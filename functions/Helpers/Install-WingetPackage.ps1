<#
.SYNOPSIS
    Installs packages using Windows Package Manager (winget).

.DESCRIPTION
    This function installs one or more packages via winget, automatically accepting package and source agreements to enable unattended installation.
    It passes the provided package array directly to winget install with the
    --accept-package-agreements and --accept-source-agreements flags for non-interactive operation.

.NOTES
    Requires winget to be installed and available in PATH.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Install-WingetPackage {
    param(
        [string[]]$Package
    )

    winget install --id $Package --exact --source 'winget' --accept-package-agreements --accept-source-agreements
}
