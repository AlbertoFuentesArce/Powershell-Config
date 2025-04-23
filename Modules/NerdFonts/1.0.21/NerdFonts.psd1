@{
    RootModule            = 'NerdFonts.psm1'
    ModuleVersion         = '1.0.21'
    CompatiblePSEditions  = @(
        'Core'
        'Desktop'
    )
    GUID                  = 'de12da3d-3ca2-4c87-82f3-5a59038e6e8b'
    Author                = 'PSModule'
    CompanyName           = 'PSModule'
    Copyright             = '(c) 2025 PSModule. All rights reserved.'
    Description           = 'A PowerShell module to download and install fonts from NerdFonts.'
    PowerShellVersion     = '5.1'
    ProcessorArchitecture = 'None'
    RequiredModules       = @(
        @{
            RequiredVersion = '1.1.18'
            ModuleName      = 'Fonts'
        }
    )
    TypesToProcess        = @()
    FormatsToProcess      = @()
    FunctionsToExport     = @(
        'Get-NerdFont'
        'Install-NerdFont'
    )
    CmdletsToExport       = @()
    VariablesToExport     = @()
    AliasesToExport       = @(
        'Get-NerdFonts'
        'Install-NerdFonts'
    )
    ModuleList            = @()
    FileList              = @(
        'FontsData.json'
        'NerdFonts.psm1'
    )
    PrivateData           = @{
        PSData = @{
            Tags       = @(
                'fonts'
                'Linux'
                'MacOS'
                'module'
                'nerdfonts'
                'powershell'
                'powershell-module'
                'PSEdition_Core'
                'PSEdition_Desktop'
                'Windows'
            )
            LicenseUri = 'https://github.com/PSModule/NerdFonts/blob/main/LICENSE'
            ProjectUri = 'https://github.com/PSModule/NerdFonts'
            IconUri    = 'https://raw.githubusercontent.com/PSModule/NerdFonts/main/icon/icon.png'
        }
    }
}

