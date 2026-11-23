<#
.SYNOPSIS
    Displays the application banner with ASCII art logo and version.

.DESCRIPTION
    This function renders a stylized ASCII art banner with gradient colors to the console, displaying the project logo and current version number.
    It calculates padding to right-align the version text and clears the host before drawing.
    The banner uses a cyan-to-blue color gradient for visual appeal.

.NOTES
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Write-Banner {
    $logo = @'
:'######::::::'###::::'##::::'##:'##:::::'##:'####:'##::: ##:
'##... ##::::'## ##::: ###::'###: ##:'##: ##:. ##:: ###:: ##:
 ##:::..::::'##:. ##:: ####'####: ##: ##: ##:: ##:: ####: ##:
 ##::'####:'##:::. ##: ## ### ##: ##: ##: ##:: ##:: ## ## ##:
 ##::: ##:: #########: ##. #: ##: ##: ##: ##:: ##:: ##. ####:
 ##::: ##:: ##.... ##: ##:.:: ##: ##: ##: ##:: ##:: ##:. ###:
. ######::: ##:::: ##: ##:::: ##:. ###. ###::'####: ##::. ##:
:......::::..:::::..::..:::::..:::...::...:::....::..::::..::
'@

    $version = 'v0.1.2'
    $colors = 'Cyan', 'Cyan', 'Cyan', 'DarkCyan', 'DarkCyan', 'Blue', 'Blue', 'DarkBlue'
    $lines = $logo -split "`r?`n"
    $logoWidth = $lines[-1].TrimEnd().Length
    $versionText = "Version: $version"
    $rightPadding = 0
    $leftPadding = $logoWidth - $versionText.Length - $rightPadding

    Clear-Host
    Write-Host ""

    for ($i = 0; $i -lt $lines.Count; $i++) {
        Write-Host $lines[$i] -ForegroundColor $colors[$i]
    }

    Write-Host (" " * $leftPadding + $versionText) -ForegroundColor DarkCyan
    Write-Host ""
}
