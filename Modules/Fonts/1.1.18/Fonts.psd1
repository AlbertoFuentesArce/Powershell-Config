@{
    RootModule            = 'Fonts.psm1'
    ModuleVersion         = '1.1.18'
    CompatiblePSEditions  = @(
        'Core'
        'Desktop'
    )
    GUID                  = '8fce9115-08d2-4586-8abe-4ec5f4c8a5e3'
    Author                = 'PSModule'
    CompanyName           = 'PSModule'
    Copyright             = '(c) 2025 PSModule. All rights reserved.'
    Description           = 'A PowerShell module for managing fonts.'
    PowerShellVersion     = '5.1'
    ProcessorArchitecture = 'None'
    RequiredModules       = @(
        @{
            RequiredVersion = '1.1.5'
            ModuleName      = 'Admin'
        }
    )
    TypesToProcess        = @()
    FormatsToProcess      = @()
    FunctionsToExport     = @(
        'Get-Font'
        'Install-Font'
        'Uninstall-Font'
    )
    CmdletsToExport       = @()
    VariablesToExport     = @()
    AliasesToExport       = @(
        'Get-Fonts'
        'Install-Fonts'
        'Uninstall-Fonts'
    )
    ModuleList            = @()
    FileList              = 'Fonts.psm1'
    PrivateData           = @{
        PSData = @{
            Tags       = @(
                'fonts'
                'Linux'
                'MacOS'
                'powershell'
                'powershell-module'
                'PSEdition_Core'
                'PSEdition_Desktop'
                'Windows'
            )
            LicenseUri = 'https://github.com/PSModule/Fonts/blob/main/LICENSE'
            ProjectUri = 'https://github.com/PSModule/Fonts'
            IconUri    = 'https://raw.githubusercontent.com/PSModule/Fonts/main/icon/icon.png'
        }
    }
}

