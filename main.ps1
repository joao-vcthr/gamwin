<#
.SYNOPSIS
    The main entry point for GamWin.

.DESCRIPTION
    This script is the main entry point for GamWin, displaying the main menu, handling user input and executing the selected actions.

.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

. "$PSScriptRoot\functions\UI\Write-Banner.ps1"
. "$PSScriptRoot\functions\UI\Write-Menu.ps1"
. "$PSScriptRoot\functions\Helpers\Write-Log.ps1"
. "$PSScriptRoot\functions\Helpers\Start-Elevated.ps1"

$script:ExitRequested = $false
$ScriptsRoot = Join-Path -Path $PSScriptRoot -ChildPath 'scripts'
$MenuOptions = Import-PowerShellDataFile -Path "$PSScriptRoot\configs\menu\MainMenu.psd1"

do {
    Write-Banner
    Write-Menu -Options $MenuOptions -MenuName 'MENU'

    $choice = (Read-Host 'Enter your choice (1-9, E, 0)').Trim().ToUpperInvariant()
    $selected = $MenuOptions.Values | Where-Object { $_.OptionId -eq $choice }
    $OptionId = if ($selected) {
        $selected.OptionId
    } else {
        'Invalid'
    }

    Write-Host "selected option $choice"

    try {
        switch ($OptionId) {
            'Invalid' { Write-Fail 'Invalid choice. Please try again.' }
            '0' { Write-Host 'Exiting...' ; $script:ExitRequested = $true }
            default {
                if ($selected.NeedsAdmin) {
                    Start-Elevated -ScriptsRoot $ScriptsRoot -ScriptFile $selected.FileName
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
