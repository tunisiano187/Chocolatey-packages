$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.2.2/electron-v39.2.2-win32-ia32.zip'
$checksum = 'e648fc3ae3058ee184e79b9336cb4de896685f0f71681df5620dfa579cc4df6c'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.2.2/electron-v39.2.2-win32-x64.zip'
$checksum64 = '76d884aa264b473eff192bc92040f95d8b3d995539e1e0d51c81fabd30419a3d'
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
