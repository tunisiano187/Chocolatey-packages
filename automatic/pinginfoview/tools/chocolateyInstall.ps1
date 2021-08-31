$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/pinginfoview.zip'
$checksum = 'df39845ff9b7b4b094b3db3f4bc8e9bdd96be7eb5f8efc7e21b96ecf3d7cfe1c'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

$packageArgs = @{
    packageName     = $env:ChocolateyPackageName
    url             = $url
    UnzipLocation   = $toolsDir
    softwareName    = '$packageName*'
    checksum        = $checksum
    checksumType    = $checksumType
}

Install-ChocolateyZipPackage @packageArgs

Set-Content -Path ("$installFile.gui") `
            -Value $null
