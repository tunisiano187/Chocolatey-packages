$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    unzipLocation  = $toolsDir
    url            = 'https://www.nirsoft.net/utils/soundvolumeview.zip'
    checksum       = '93064FBBDB8D3B42B9F5FCFB80C1ED8C17A21C207869052940683607E889054B'
    checksumType   = 'sha256'
    url64bit       = 'https://www.nirsoft.net/utils/soundvolumeview-x64.zip'
    checksum64     = 'EE2C45553FB9FB31B71DB88B537C18E25C1A387A4A9009D081BDB38265C68E1F'
    checksumType64 = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

$installFile = (Get-ChildItem -Path $toolsDir -Filter '*.exe' -Recurse).FullName

Set-Content -Path ("$installFile.gui") `
            -Value $null
