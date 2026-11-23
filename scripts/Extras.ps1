<#
.SYNOPSIS
    Extra functionalities for GamWin, providing additional options for system configuration and maintenance.

.DESCRIPTION
    This script provides extra functionalities for GamWin, including additional system configuration and maintenance options such as:
    - Changing DNS settings
    - Repairing the system
    - Disabling MPO (Multiplane Overlay)

.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\functions\UI\Write-Menu.ps1"
. "$ProjectRoot\functions\Set\Set-DnsProvider.ps1"
. "$ProjectRoot\functions\Helpers\Start-Elevated.ps1"

$script:ExitRequested = $false
$MenuOptions = Import-PowerShellDataFile -Path "$PSScriptRoot\..\configs\menu\ExtrasMenu.psd1"

do {
    Write-Banner
    Write-Menu -Options $MenuOptions -MenuName 'EXTRAS'
    $choice = (Read-Host 'Enter your choice (1-3, 0)').Trim().ToUpperInvariant()
    $selected = $MenuOptions.Values | Where-Object { $_.OptionId -eq $choice }
    $optionId = if ($selected) {
        $selected.OptionId
    } else {
        'Invalid'
    }

    try {
        switch ($OptionId) {
            'Invalid' { Write-Fail 'Invalid Option; Please try again' }
            '0' { Write-Host 'option 0: Return to main Menu' ; $script:ExitRequested = $true }

            default {
                if ($selected.NeedsAdmin) {
                    Start-Elevated -ScriptsRoot $ScriptsRoot\extras -ScriptFile $selected.FileName
                } else {
                    & (Join-Path $ScriptsRoot $selected.FileName)
                }
            }
        }
    }
    catch {
        Write-Fail "`n[ERROR] $($_.Exception.Message)"
    }

} while (-not $script:ExitRequested)
