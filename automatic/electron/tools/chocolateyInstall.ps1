$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v11.0.2/electron-v11.0.2-win32-ia32.zip'
$checksum = 'a1ba18ef4affbba617edff3a48c00ea996f3ac9e79d7d76f8159650f08bf0a3d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v11.0.2/electron-v11.0.2-win32-x64.zip'
$checksum64 = '4523e1a736ef1afc912940f7e8a79ed4f45a70331719189389257f063ff3e9b6'
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
