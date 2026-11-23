<#
.SYNOPSIS
    Cleans up the system by removing temporary files, old restoration points, old updates, and optimizing the disk.
.DESCRIPTION
    This script performs a series of cleanup operations to free up disk space and improve system performance.
    It removes temporary files, clears the recycle bin, deletes old restoration points,
    cleans the DNS cache, resets the Windows Winsock catalog, and optimizes the main disk using TRIM.
    The computer will be restarted upon completion.
.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        10/04/2026
#>

#Requires -RunAsAdministrator

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\functions\Helpers\Write-Log.ps1"
. "$ProjectRoot\functions\Helpers\Request-Restart.ps1"

Write-Header 'SYSTEM CLEANUP'

Write-Running 'Cleaning Windows Update'
Dism.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase
Remove-Item -Path 'C:\Windows\SoftwareDistribution\Download\*' -Recurse -Force -ErrorAction SilentlyContinue

Write-Running 'Cleaning User temp files'
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Running 'Cleaning System temp files'
Remove-Item -Path 'C:\Windows\Temp\*' -Recurse -Force -ErrorAction SilentlyContinue

Write-Running 'Cleaning AppData temp files'
Remove-Item -Path 'C:\Users\Joao\AppData\Local\Temp\*' -Recurse -Force -ErrorAction SilentlyContinue

Write-Running 'Cleaning Prefetch'
Remove-Item -Path 'C:\Windows\Prefetch\*' -Recurse -Force -ErrorAction SilentlyContinue

$choice = (Read-Host 'Clean "Downloads" folder? (Y/N) (Default = N)').Trim().ToUpperInvariant()
switch ($choice) {
    'Y' {
        Write-Running 'Cleaning Downloads folder'
        Remove-Item -Path "$env:USERPROFILE\Downloads" -Recurse -Force -ErrorAction SilentlyContinue
    }
    default {
        Write-Running 'Skiping... Downloads folder will not be cleaned'
    }
}

Write-Running 'Cleaning Recycle Bin'
Clear-RecycleBin -Force -ErrorAction SilentlyContinue

Write-Running 'Deleting old restoration points'
vssadmin delete shadows /all /quiet

Write-Running 'Cleaning DNS Cache'
Clear-DnsClientCache

Write-Running 'Cleaning Windows Winsock catalog'
netsh winsock reset

Write-Running 'Optimizing Disk'
Optimize-Volume -DriveLetter 'C' -ReTrim -Verbose

Write-Ok 'System Cleaned!'

Request-Restart
