Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent $PSScriptRoot

Invoke-Item -Path "$ProjectRoot\guides\windows-gaming-post-install-guide.md"
Start-Sleep -Milliseconds 100
