$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v24.1.3/electron-v24.1.3-win32-ia32.zip'
$checksum = '78807ad733b04f6054037b78d71e8aa29877760a1f68a7a62a7d5c7777f9e07f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v24.1.3/electron-v24.1.3-win32-x64.zip'
$checksum64 = 'd47ec5c2acddafdfa45c5604929e620ca55bc33d15cd90e405bdeef2df35a4a9'
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
