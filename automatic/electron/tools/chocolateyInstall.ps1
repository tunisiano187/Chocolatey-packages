$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v42.2.0/electron-v42.2.0-win32-ia32.zip'
$checksum = '1a866e0634ff95f83a043c7c6738e148f38362ed0afa60aa5eb8dcab16def7b5'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v42.2.0/electron-v42.2.0-win32-x64.zip'
$checksum64 = '6e034b748ad5ed9445bd3da4b7d0792ed49556774a541217b507c156b00dd69a'
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
