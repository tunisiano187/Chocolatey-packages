$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.4/electron-v16.0.4-win32-ia32.zip'
$checksum = '8597d658f01b9dbb40841d919f33bb8ac7e00480374af16f51749908bf2df68e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.4/electron-v16.0.4-win32-x64.zip'
$checksum64 = '5671e2a44e0edce0c60858c787755ea984a3241e5a876ccaacdd2285066908e5'
$checksumType64 = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage -PackageName "$packageName" `
                             -Url "$url" `
                             -UnzipLocation "$toolsDir" `
                             -Url64bit "$url64" `
                             -Checksum "$checksum" `
                             -ChecksumType "$checksumType" `
                             -Checksum64 "$checksum64" `
                             -ChecksumType64 "$checksumType64"
