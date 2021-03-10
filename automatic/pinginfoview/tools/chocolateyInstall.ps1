$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/pinginfoview.zip'
$checksum = 'd22f5e1cae00d30ade975cdd82987da90a8ca3736e4a998fa7d21ab750ef3585'
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
