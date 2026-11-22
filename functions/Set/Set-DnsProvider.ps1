<#
.SYNOPSIS
    Configures DNS provider selection and clears DNS cache.

.DESCRIPTION
    This function clears the DNS client cache and presents an interactive menu for the user to select a DNS provider:
    Google (8.8.8.8, 8.8.4.4)Cloudflare (1.1.1.1, 1.0.0.1), OpenDNS (208.67.222.222, 208.67.220.220), Quad9 (9.9.9.9, 149.112.112.112), or keeping the current configuration.
    The selected DNS servers are applied to the Ethernet interface using Set-DnsClientServerAddress.
    The menu loops until a valid selection is made.

.NOTES
    This function requires administrator privileges.
    Author:      joao-vcthr
    Date:        10/23/2026
#>

function Set-DnsProvider {
    param(
        [Parameter(Mandatory)]
        [hashtable]$Providers,

        [string]$InterfaceAlias = 'Ethernet'
    )

    $done = $false

    do {
        Write-Menu -Options $Providers -MenuName 'DNS Servers'

        $choice = (Read-Host 'Choose Your DNS Provider').Trim().ToUpperInvariant()
        $selected = $Providers.Values | Where-Object { $_.OptionId -eq $choice }
        $OptionId = if ($selected) {
            $selected.OptionId
        } else {
            'Invalid'
        }

        try {
            switch ($OptionId) {
                'Invalid' {
                    Write-Fail 'Invalid Option; Please try again'
                }

                'K' {
                    Write-Running 'Keeping current DNS'
                    $done = $true
                }

                'R' {
                    Write-Running 'Resetting DNS to default'
                    Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ResetServerAddresses
                    $done = $true
                }

                default {
                    $serverAddresses = @($selected.IPV4Addresses) + @($selected.IPV6Addresses)

                    Write-Running "Changing DNS to $($selected.Name)"
                    Set-DnsClientServerAddress -InterfaceAlias $InterfaceAlias -ServerAddresses $serverAddresses
                    $done = $true
                }
            }
        } catch {
            Write-Fail "`n[ERROR] $($_.Exception.Message)"
        }

    } while (-not $done)

    Write-Running 'Cleaning DNS Cache'
    Clear-DnsClientCache

    $addresses = Get-DnsClientServerAddress -InterfaceAlias $InterfaceAlias
    $PrimaryIPV4DnsServeAddress = $addresses.ServerAddresses[0]
    $SecondaryIPV4DnsServeAddress = $addresses.ServerAddresses[1]
    $PrimaryIPV6DnsServeAddress = $addresses.ServerAddresses[2]
    $SecondaryIPV6DnsServeAddress = $addresses.ServerAddresses[3]

    Write-Ok 'DNS configuration complete!'
    Write-Ok "IPV4 DNS Addresses: ($PrimaryIPV4DnsServeAddress, $SecondaryIPV4DnsServeAddress)"
    Write-Ok "IPV6 DNS Addresses: ($PrimaryIPV6DnsServeAddress, $SecondaryIPV6DnsServeAddress)"
}
