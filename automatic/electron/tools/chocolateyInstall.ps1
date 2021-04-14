$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v12.0.4/electron-v12.0.4-win32-ia32.zip'
$checksum = '31e4574d5d9b867ea398f50b82e4ea367f66e5ab952c423d633f6819114c0a28'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v12.0.4/electron-v12.0.4-win32-x64.zip'
$checksum64 = 'd6ea5d6c09480edf6b7040e571302953f29a8a43d4d9a0527f4ae0d2a5835737'
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
