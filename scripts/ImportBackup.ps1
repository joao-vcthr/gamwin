<#
.SYNOPSIS
    Imports a backup from a specified source folder to a specified destination folder.
.DESCRIPTION
    This script copies the contents of a backup folder to the specified destination folder folder.
    It checks for the existence of the source and destination folders,
    creates the destination folder if it doesn't exist,
    and uses Robocopy to perform the copy operation with specified options.
.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\functions\Helpers\Write-Log.ps1"

Write-Header 'IMPORT BACKUP'

$HomePath = $env:USERPROFILE
$DefaultDestination = Join-Path $HomePath 'Backup'

$cancelled = $false
$validPaths = $false

while (-not $validPaths -and -not $cancelled) {

    $backupSourceFolder = (Read-Host 'Enter backup source folder (0 to cancel)').Trim()

    if ($backupSourceFolder -eq '0') {
        $cancelled = $true
        break
    }

    if ([string]::IsNullOrWhiteSpace($backupSourceFolder)) {
        Write-Warning 'Source folder cannot be empty.'
        continue
    }

    if (-not (Test-Path -LiteralPath $backupSourceFolder -PathType Container)) {
        Write-Warning "Source folder does not exist: $backupSourceFolder"
        continue
    }

    $backupDestinationFolder = (Read-Host "Enter destination folder (ENTER for $DefaultDestination, 0 to cancel)").Trim()

    if ($backupDestinationFolder -eq '0') {
        $cancelled = $true
        break
    }

    if ([string]::IsNullOrWhiteSpace($backupDestinationFolder)) {
        $backupDestinationFolder = $DefaultDestination
    }

    if (Test-Path -LiteralPath $backupDestinationFolder) {

        if (-not (Test-Path -LiteralPath $backupDestinationFolder -PathType Container)) {
            Write-Warning 'Destination exists but is not a directory.'
            continue
        }

    }
    else {
        Write-Running "Creating destination folder: $backupDestinationFolder"
        New-Item -Path $backupDestinationFolder -ItemType Directory -Force | Out-Null
    }

    $validPaths = $true
}

if ($cancelled) {
    Write-Host 'Backup import cancelled.'
}
elseif ($validPaths) {

    if ($PSCmdlet.ShouldProcess(
        $backupDestinationFolder,
        "Import backup from $backupSourceFolder"
    )) {
        Write-Running "Copying Backup from $backupSourceFolder to $backupDestinationFolder"
        Robocopy.exe $backupSourceFolder $backupDestinationFolder *.* /E /V /R:2 /W:2 /MT
        Write-Ok 'Backup import complete!'
    }
}

Read-Host 'Press ENTER to continue...'
