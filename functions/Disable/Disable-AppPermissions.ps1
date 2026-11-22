<#
.SYNOPSIS
    Disables application permissions via registry policies.

.DESCRIPTION
    This function configures app privacy restrictions by setting registry values under the AppPrivacy policy key to force-deny (value 2) for specified permissions.
    It accepts an array of hashtables containing permission names and labels.
    Additionally, it disables automatic file downloads for CloudFiles (OneDrive) by setting the DisableLibraryRehydration policy.

.NOTES
    This function requires administrator privileges for machine-wide policy changes.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Disable-AppPermissions {
    param(
        [Parameter(Mandatory)]
        [hashtable[]]$Permissions
    )

    $policyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy'

    # Value 2 = Force Deny
    $forceDeny = 2

    foreach ($perm in $Permissions) {
        if ($PSCmdlet.ShouldProcess($perm.Label, 'Disable permission')) {
            try {
                Set-RegistryValue -Path $policyPath -Name $perm.Name -Value $forceDeny
                Write-Ok $perm.Label
            } catch {
                Write-Fail "$($perm.Label) -- $($_.Exception.Message)"
            }
        }
    }

    # Automatic File Downloads
    Write-Running 'Disabling Automatic File Downloads'

    if ($PSCmdlet.ShouldProcess('Automatic File Downloads', 'Disable')) {
        try {
            Set-RegistryValue -Path 'HKCU:\Software\Policies\Microsoft\CloudFiles' -Name 'DisableLibraryRehydration' -Value 1
            Write-Ok 'Automatic File Downloads'
        } catch {
            Write-Fail "Automatic File Downloads -- $($_.Exception.Message)"
        }
    }

    Write-Ok 'App permissions disabled!'
}
