$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.4.0/electron-v36.4.0-win32-ia32.zip'
$checksum = '4aef78894be648db7d537017c9ed81a8fd50066ac58c2e0afdde464777c814d0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.4.0/electron-v36.4.0-win32-x64.zip'
$checksum64 = '06ac065519743b4e5fc16f61272542313385cc0de849d2589db1f2f8e5e6effb'
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
