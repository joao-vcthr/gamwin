<#
.SYNOPSIS
    Provides standardized console logging functions for script output.

.DESCRIPTION
    This module defines a set of helper functions for consistent colored console output throughout the project:
    - Write-Header displays section titles in cyan
    - Write-Ok shows success messages in green
    - Write-Skip shows skipped items in dark gray
    - Write-Fail shows errors in red
    - Write-Running shows progress messages in yellow.
    These functions standardize the visual feedback across all scripts.

.NOTES
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Write-Header {
    param ([string] $Title)
    Write-Host "===  [$Title]  ===" -ForegroundColor Cyan
}

function Write-Ok {
    param ([string] $Msg)
    Write-Host "[OK]  $Msg" -ForegroundColor Green
}

function Write-Skip {
    param ([string] $Msg)
    Write-Host "[--]  $Msg" -ForegroundColor DarkGray
}

function Write-Fail {
    param ([string] $Msg)
    Write-Host "[X]  $Msg" -ForegroundColor Red
}

function Write-Running {
    param ([string] $Msg)
    Write-Host "[>>]  $Msg" -ForegroundColor Yellow
}
