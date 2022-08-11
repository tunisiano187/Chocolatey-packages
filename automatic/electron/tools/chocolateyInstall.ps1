$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.0.2/electron-v20.0.2-win32-ia32.zip'
$checksum = 'e7179a946fa2767c751db918b070bede37b55aebf6ed8c64d81f4159213c2937'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.0.2/electron-v20.0.2-win32-x64.zip'
$checksum64 = '1f4d09fddab879a4a74f174153abae27defab6aa9ea95c088031b8515a48ce4b'
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
