<#
.SYNOPSIS
    Displays the main menu with all available options.

.DESCRIPTION
    This function renders the primary navigation menu to the console with a colored box layout.
    It presents 10 numbered options covering system setup, debloating, dependency installation,
    application installation, backup import, system cleaning, behavior configuration, privacy configuration,
    service configuration, and an extras submenu, plus an exit option.
    The menu uses a cyan-to-blue color gradient for visual hierarchy.

.NOTES
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Write-Menu {
    param(
        [Parameter(Mandatory)]
        [hashtable]$Options,

        [string]$MenuName,

        [int]$Width = 40
    )

    $colors = @(
        'Cyan',
        'DarkCyan',
        'Blue',
        'DarkBlue'
    )

    $menuOptions = @($Options.Values | Sort-Object -Property {$_.Order})

    $labels = @(
        $menuOptions | ForEach-Object {
            "[$($_.OptionId)] $($_.Name)"
        }
    )

    $longestOption = ($labels | Measure-Object -Property Length -Maximum).Maximum

    $Width = [Math]::Max($Width, $longestOption)
    $Width = [Math]::Max($Width, $MenuName.Length)

    $border = '+' + ('-' * ($Width + 2)) + '+'

    $title = $MenuName.PadLeft(
        [Math]::Floor(($Width + $MenuName.Length) / 2)
    ).PadRight($Width)

    Write-Host ''
    Write-Host $border -ForegroundColor $colors[0]
    Write-Host "| $title |" -ForegroundColor $colors[0]
    Write-Host $border -ForegroundColor $colors[0]

    for ($i = 0; $i -lt $menuOptions.Count; $i++) {

        $colorIndex = [Math]::Floor(
            $i * $colors.Count / $menuOptions.Count
        )

        $option = $menuOptions[$i]
        $label = "[$($option.OptionId)] $($option.Name)"
        $label = $label.PadRight($Width)

        Write-Host "| $label |" -ForegroundColor $colors[$colorIndex]
    }

    Write-Host $border -ForegroundColor $colors[-1]
    Write-Host ''
}
