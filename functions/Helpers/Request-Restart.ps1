<#
.SYNOPSIS
    Prompts the user to restart the computer.

.DESCRIPTION
    This function displays an interactive prompt asking the user whether to restart the computer now.
    It accepts 'Y' to immediately restart using Restart-Computer,
    'N' to return without action,
    and loops on invalid input until a valid choice is made.
    The prompt is case-insensitive.

.NOTES
    This function requires administrator privileges to execute Restart-Computer.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Request-Restart {
    $done = $false
    do {
        $option = Read-Host 'Restart the computer now? [Y/N]'
        $option = $option.ToUpper()

        switch ($option) {
            'Y' { Write-Running 'Restarting the computer' ; Restart-Computer ; $done = $true }
            'N' { $done = $true }
            default { Write-Fail 'Invalid Option, try again' }
        }
    } while (-not $done)
}
