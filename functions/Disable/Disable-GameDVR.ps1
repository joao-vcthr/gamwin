<#
.SYNOPSIS
    Disables Game DVR and game capture features system-wide.

.DESCRIPTION
    This function disables the Game DVR functionality by modifying registry values for both the current user and the local machine policy.
    It turns off game capture features in the GameConfigStore and GameDVR registry keys,
    and sets the AllowGameDVR policy to 0 to prevent game recording and broadcasting system-wide.

.NOTES
    This function requires administrator privileges for the machine-wide policy change.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Disable-GameDVR {
    # User Settings
    Write-Running 'Disabling Game DVR capture'
    Set-RegistryValue -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Value 0
    Set-RegistryValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR' -Name 'AppCaptureEnabled' -Value 0

    # Local Machine Settings (requires admin)
    $policyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR'
    Write-Running 'Disabling AllowGameDVR global policy'
    Set-RegistryValue -Path $policyPath -Name 'AllowGameDVR' -Value 0

    Write-Ok 'Game DVR disabled!'
}
