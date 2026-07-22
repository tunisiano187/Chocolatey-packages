$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v43.2.0/electron-v43.2.0-win32-ia32.zip'
$checksum = '9b98b4071bd5a7af91d8773bdd0021b6d14970f9cbeedeef72ffacc5522ca3b2'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v43.2.0/electron-v43.2.0-win32-x64.zip'
$checksum64 = 'eba5f5088af40ecb364fe258809c79a5234c6ece5a75c64722772eba01b02786'
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
