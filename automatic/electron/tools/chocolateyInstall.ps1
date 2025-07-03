$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v37.2.0/electron-v37.2.0-win32-ia32.zip'
$checksum = '9a5c59480472aadf32854e2b9b4ca5639ffc2bff57d2f8a22998d52769460d15'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v37.2.0/electron-v37.2.0-win32-x64.zip'
$checksum64 = '4d4451179993fa22a1125bbc0130858903bc16e5c87900a969fa7bbac5c8f6a3'
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
