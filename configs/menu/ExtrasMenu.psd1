@{
    ChangeDNS = @{
        Name       = 'Change DNS Provider'
        FileName   = 'SetNewDnsProvider.ps1'
        NeedsAdmin = $true
        OptionId   = '1'
        Order      = 1
    }

    RepairSystem = @{
        Name       = 'Repair System'
        FileName   = 'RepairSystem.ps1'
        NeedsAdmin = $true
        OptionId   = '2'
        Order      = 2
    }

    DisableMPO = @{
        Name       = 'Disable Multi-Plane Overlay (MPO)'
        FileName   = 'DisableMultiPlaneOverlay.ps1'
        NeedsAdmin = $true
        OptionId   = '3'
        Order      = 3
    }

    Return = @{
        Name       = 'Return to Main Menu'
        OptionId   = '0'
        Order      = 4
    }
}
