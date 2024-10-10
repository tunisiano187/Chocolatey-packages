$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v32.2.0/electron-v32.2.0-win32-ia32.zip'
$checksum = 'fb49f9c334905fc4bf8fa25a3114ed32a813ee4776837e384512537c749eb0f1'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v32.2.0/electron-v32.2.0-win32-x64.zip'
$checksum64 = '3f7190e3c916e99b3eb09ee6ef4ba9e67c3e7932c749eba0fadda90d7808215b'
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
