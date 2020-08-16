$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'http://www.nirsoft.net/utils/chromehistoryview.zip'
$checksum = 'a2161a23cdcc92293301402b267e60ff638f83e129a2ad3c1684609c0323d2e6'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "$($packageName).exe"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType"

Set-Content -Path ("$installFile.gui") `
            -Value $null
