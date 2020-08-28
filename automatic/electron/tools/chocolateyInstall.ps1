$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v10.1.0/electron-v10.1.0-win32-ia32.zip'
$checksum = 'c620305c568edbbb4f69532ce7cae01bc887f7fb87fbad8c6679a29b3c45065e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v10.1.0/electron-v10.1.0-win32-x64.zip'
$checksum64 = '7d438e9023b14440f3e5ad7152b8a763082c5935cdc4a6ce8710b785c217c293'
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
