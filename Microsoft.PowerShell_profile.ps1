#Import Modules
Import-Module Terminal-Icons
Import-Module PSReadLine
Import-Module CompletionPredictor

#OHMYPOSH
oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/kushal.omp.json | Invoke-Expression

#Zochzide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

#PSREADLINE
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord 'Alt+d' -Function DeleteWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+z' -Function Undo
Set-PSReadLineKeyHandler -Chord 'Ctrl+y' -Function Redo

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -MaximumHistoryCount 10000


Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord
Set-PSReadLineOption -Colors @{ InlinePrediction = '#8A0303'}
Set-PSReadLineOption -Colors @{ InlinePrediction = '#2F7004'}

$PSReadLineOptions = @{
    EditMode = 'Windows'
    HistoryNoDuplicates = $true
    HistorySearchCursorMovesToEnd = $true
    Colors = @{
        Command = '#87CEEB'  # SkyBlue (pastel)
        Parameter = '#98FB98'  # PaleGreen (pastel)
        Operator = '#FFB6C1'  # LightPink (pastel)
        Variable = '#DDA0DD'  # Plum (pastel)
        String = '#FFDAB9'  # PeachPuff (pastel)
        Number = '#B0E0E6'  # PowderBlue (pastel)
        Type = '#F0E68C'  # Khaki (pastel)
        Comment = '#D3D3D3'  # LightGray (pastel)
        Keyword = '#8367c7'  # Violet (pastel)
        Error = '#FF6347'  # Tomato (keeping it close to red for visibility)
    }
    PredictionSource = 'History'
    PredictionViewStyle = 'ListView'
    BellStyle = 'None'
}
Set-PSReadLineOption @PSReadLineOptions


#FUNCTIONS

function reload-profile {
        & $profile
}

function touch($file) {
        "" | Out-File $file -Encoding ASCII
}

function df {
        get-volume
}

function which($name) {
        Get-Command $name | Select-Object -ExpandProperty Definition
}

function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function ff($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.FullName)"
    }
}

function admin {
    if ($args.Count -gt 0) {
        $argList = $args -join ' '
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | select-string $regex
        return
    }
    $input | select-string $regex
}

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
    Get-Process $name
}

function touch { 
    param (
        [string]$FileName, # The name of the file to create 
        [switch]$Force # Overwrite the file if it already exists 

    )
        # Ensure a file name is provided
        if (-not $FileName) {
            Write-Error "You must specify a file name."
                return
        }

        # Resolve the full file path
        $FilePath = Join-Path -Path (Get-Location).Path -ChildPath $FileName

        # Check for existing file
        if (Test-Path $FilePath) {
            Write-Warning "File already exists."
                return
        }

        # Determine action based on file extension
        switch ([System.IO.Path]::GetExtension($FileName).ToLower()) {
        ".py" {
                # Blank Python file
                "" | Out-File -FilePath $FilePath -Encoding UTF8
        }

        ".txt" {
            # Plain text file
            "" | Out-File -FilePath $FilePath -Encoding UTF8
        }

        default {
            # Default behavior: create an empty file
            "" | Out-File -FilePath $FilePath -Encoding UTF8
        }
    }

    Write-Host "File created: $FilePath" -ForegroundColor Green

}

function mvd {
    param(
        [int]$c=1,
        [string]$p = (Get-Location).Path
        )

    $DownloadsPath = "$HOME\Downloads"

    $RecentFiles = Get-ChildItem -Path $DownloadsPath -File | Sort-Object LastWriteTime -Descending | Select-Object -First $c

    if (-not $RecentFiles){
        Write-Error "No files found in the Downloads folder."
        return

    }
    
    if (Get-Command z -ErrorAction SilentlyContinue){
        try {
            $ResolvedDestination = zoxide query $p
            if ($ResolvedDestination){
                $p= $ResolvedDestination
            }
        } catch {
            Write-Warning "zoxide command failed. Using the provided destination path."
        }

    }

    if (-not (Test-Path $p)) {
        New-Item -ItemType Directory -Path $p | Out-Null

    }

    foreach ($File in $RecentFiles) {
        $DestinationFile = Join-Path -Path $p -ChildPath $File.Name
        try {
            Move-Item -Path $File.FullName -Destination $DestinationFile
            Write-Host "Moved: $($File.FullName) -> $DestinationFile" -ForegroundColor Green
        } catch {
            Write-Error "Failed to move file '$($File.Name)': $_"

        }

    }

}


