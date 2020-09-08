$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/pinginfoview.zip'
$checksum = '05c894741b3b9d0ead16b1d4f78cbe30efbeda1eeba43666aa7ec8c950730209'
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
