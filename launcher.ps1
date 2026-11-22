Start-Process 'powershell.exe' -ArgumentList "-ExecutionPolicy Bypass -File $PSScriptRoot/main.ps1"

$option = Read-Host 'Set execution policy back to "Restricted"? (Y/N)'

if ($option -eq 'Y') {
    Set-ExecutionPolicy -ExecutionPolicy Restricted -Force
    Write-Host 'Execution policy set to "Restricted".'
} else {
    Write-Host 'Execution policy not changed.'
}
