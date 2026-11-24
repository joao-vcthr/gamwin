<#
.SYNOPSIS
    Opens the Windows gaming post-install guide.
.DESCRIPTION
    Launches guides/windows-gaming-post-install-guide.md with the default Markdown viewer for reference during setup.
.NOTES
    Author:      joao-vcthr
    Date:        11/23/2026
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

Invoke-Item -Path "$ProjectRoot\guides\windows-gaming-post-install-guide.md"
Start-Sleep -Milliseconds 100
