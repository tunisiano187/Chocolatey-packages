$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/pinginfoview.zip'
$checksum = 'eda580e50af14a89fcf79d2ce3621d6efcf193b0cba144a9825031110165516d'
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
