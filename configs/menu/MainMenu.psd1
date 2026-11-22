@{
    SetupSystem = @{
        Name       = 'Setup System'
        FileName   = 'SetupSystem.ps1'
        NeedsAdmin = $true
        OptionId   = '1'
        Order      = 1
    }

    DebloatSystem = @{
        Name       = 'Debloat System'
        FileName   = 'DebloatSystem.ps1'
        NeedsAdmin = $true
        OptionId   = '2'
        Order      = 2
    }

    InstallDependencies = @{
        Name       = 'Install Dependencies'
        FileName   = 'InstallDependencies.ps1'
        NeedsAdmin = $true
        OptionId   = '3'
        Order      = 3
    }

    InstallApplications = @{
        Name       = 'Install Applications'
        FileName   = 'InstallApplications.ps1'
        NeedsAdmin = $false
        OptionId   = '4'
        Order      = 4
    }

    ImportBackup = @{
        Name       = 'Import Backup'
        FileName   = 'ImportBackup.ps1'
        NeedsAdmin = $false
        OptionId   = '5'
        Order      = 5
    }

    CleanSystem = @{
        Name       = 'Clean System'
        FileName   = 'CleanSystem.ps1'
        NeedsAdmin = $true
        OptionId   = '6'
        Order      = 6
    }

    ConfigurePrivacy = @{
        Name       = 'Configure Privacy'
        FileName   = 'ConfigurePrivacy.ps1'
        NeedsAdmin = $true
        OptionId   = '7'
        Order      = 7
    }

    ConfigureSystemBehavior = @{
        Name       = 'Configure System Behavior'
        FileName   = 'ConfigureSystemBehavior.ps1'
        NeedsAdmin = $true
        OptionId   = '8'
        Order      = 8
    }

    ConfigureServices = @{
        Name       = 'Disable Services'
        FileName   = 'DisableServices.ps1'
        NeedsAdmin = $true
        OptionId   = '9'
        Order      = 9
    }

    Extras = @{
        Name       = 'Extras'
        FileName   = 'Extras.ps1'
        NeedsAdmin = $false
        OptionId   = 'E'
        Order      = 10
    }

    Exit = @{
        Name      = 'Exit'
        OptionId  = '0'
        Order     = 11
    }
}
