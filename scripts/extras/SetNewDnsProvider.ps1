<#
.SYNOPSIS
    Configures the DNS servers used by the Ethernet network adapter.

.DESCRIPTION
    This script clears the DNS client cache and presents an interactive menu for the user to select a DNS provider
    (Cloudflare, Google, OpenDNS, Quad9, reset to default, or keep the current configuration). The selected DNS
    servers are applied to the Ethernet interface using Set-DnsClientServerAddress. After the change, the script
    displays the configured DNS server addresses and offers to restart the Ethernet network adapter so the new
    settings take effect immediately.

.NOTES
    This script requires administrator privileges to run.
    Author:      joao-vcthr
    Date:        11/19/2026
#>

#Requires -RunAsAdministrator

$ProjectRoot = Split-Path -Parent $PSScriptRoot

. "$ProjectRoot\..\functions\Set\Set-DnsProvider.ps1"
. "$ProjectRoot\..\functions\Helpers\Write-Log.ps1"
. "$ProjectRoot\..\functions\UI\Write-Menu.ps1"

Write-Header 'CHANGE DNS'

$providers = Import-PowerShellDataFile -Path "$ProjectRoot\..\configs\network\DnsServerAddresses.psd1"
Set-DnsProvider -Providers $providers

$option = Read-Host 'Restart Net Adapter? [Y/N]'

if ($option -eq 'Y') {
    Write-Running 'Restarting NetAdapter' ;
    Restart-NetAdapter -Name 'Ethernet' -Confirm:$false -Verbose
}

Read-Host 'Press ENTER to continue...'
