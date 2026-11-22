<#
.SYNOPSIS
    Enables the 'End Task' option in the taskbar context menu.

.DESCRIPTION
    This function enables the hidden "End Task" feature in the Windows 11 taskbar by setting the TaskbarEndTask registry value to 1 under the TaskbarDeveloperSettings key.
    This allows users to right-click an application on the taskbar and select "End Task" to forcefully close it, similar to the functionality in previous Windows versions.

.NOTES
    This function modifies current user registry settings.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Enable-TaskbarEndTask {
    Set-RegistryValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings' -Name 'TaskbarEndTask' -Value 1 -Type DWord

    Write-Ok '"End Task" option has been enabled!'
}
