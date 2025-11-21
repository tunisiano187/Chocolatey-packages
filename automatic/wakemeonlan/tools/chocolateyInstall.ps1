$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://www.nirsoft.net/utils/wakemeonlan.zip'
$checksum = '5f8a9ae13c8c81287dff2abd80fedb0795b2cff91c092e56a90ecc8f49add147'
$checksumType = 'sha256'
#$url64 = $env:ChocolateyPackageName
#$checksum64 = $env:ChocolateyPackageName
#$checksumType64 = $env:ChocolateyPackageName
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

Set-Content -Path ("$installFile.gui") `
            -Value $null
