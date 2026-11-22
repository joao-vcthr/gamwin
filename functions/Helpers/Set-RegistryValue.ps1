<#
.SYNOPSIS
    Safely creates or updates a registry value with existence checks.

.DESCRIPTION
    This helper function sets a registry value at the specified path, automatically creating the registry key if it doesn't exist.
    It checks whether the value already exists and either creates it with New-ItemProperty or updates it with Set-ItemProperty.
    The function supports specifying the registry value type (default: DWord) and provides verbose output for debugging.
    Errors are caught and reported via Write-Fail.

.NOTES
    This function requires appropriate privileges for the target registry hive.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Set-RegistryValue {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        $Value,

        [Parameter(Mandatory = $false)]
        [Microsoft.Win32.RegistryValueKind]$Type = [Microsoft.Win32.RegistryValueKind]::DWord
    )

    try {
        # Verify if path exists
        if (-not (Test-Path -Path $Path)) {
            Write-Verbose " '$Path' does not exist. Creating..."
            New-Item -Path $Path -Force | Out-Null
        }

        # Verify if the value/property already exists
        $existingProperty = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue

        if ($null -eq $existingProperty) {
            Write-Verbose " '$Name' does not exist. Creating..."
            New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
        }
        else {
            Write-Verbose "Changing '$Name'..."
            Set-ItemProperty -Path $Path -Name $Name -Value $Value
        }

        Write-Ok "'$Name' defined as '$Value' at '$Path'"
    }
    catch {
        Write-Fail "Error defining registry value: $_"
    }
}
