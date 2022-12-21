$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/pinginfoview.zip'
$checksum = '37317a3d50815ab8c07fd4b7e52d5970873620db661dfade969b5403d43549b4'
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
