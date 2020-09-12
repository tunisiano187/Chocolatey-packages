<#
.SYNOPSIS
    Download and prepare to add a package in the automatic folder

.DESCRIPTION
    Download the nupkg, expand it, create the package folder in
    the automatic folder, copy the nuspec and the tools, download the icon

.PARAMETER packageName
    the package to download

.PARAMETER folder
    The folder where the packages are
    Default : ..\automatic\

.PARAMETER iconfolder
    The folder where we're adding the icons
    Default : ..\icons\

.OUTPUTS
    A folder containing the main files and the icon if that's available
#>
param(
        [Parameter(Mandatory = $true)]
        [string]$packageName,
        [string]$folder = '..\automatic\',
        [string]$iconfolder = '..\icons\'
    )
    $nupkg = "$env:TEMP/$($packageName)"

    # Try to download the nupkg
    Invoke-WebRequest -Uri "https://chocolatey.org/api/v2/package/$($packageName)" -OutFile "$nupkg.zip"
    if(Test-Path "$nupkg.zip") {
        # Expand file
        Expand-Archive -Path "$nupkg.zip" -DestinationPath $nupkg -Force
        New-Item -ItemType Directory -Name $packageName.ToLower() -Path "$folder\" -Force

        # copy required files in the new folder
        Copy-Item -Path "$nupkg\$packageName.nuspec" -Destination "$folder\$packageName\" -Recurse
        if(Test-Path "$nupkg\tools") {
            Move-Item -Path "$nupkg\tools" -Destination "$folder\$packageName\" -Force
        }

        # read nuspec
        [xml]$nuspec = Get-Content "$folder\$packageName\$packageName.nuspec"

        # Check if the nuspec has an iconUrl and download the icon to the right folder
        if($nuspec.package.metadata.iconUrl) {
            Invoke-WebRequest -Uri $nuspec.package.metadata.iconUrl -OutFile "$iconfolder\$packageName.$(($nuspec.package.metadata.iconUrl).split('.')[-1])"
        }
    }