$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$toolsDir       = Split-Path -parent $MyInvocation.MyCommand.Definition
$fileLocation   = (Get-ChildItem -Path $toolsDir -Filter '*.zip').FullName

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    file            = $fileLocation
    UnzipLocation   = "$toolsDir"
}

Install-ChocolateyZipPackage @packageArgs

Remove-Item $fileLocation -Force