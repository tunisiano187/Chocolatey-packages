$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.3/electron-v16.0.3-win32-ia32.zip'
$checksum = 'f094e626fa870602203af0389dcbfae67abf2c76bfa4d84ff6b17685dc02714d'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.3/electron-v16.0.3-win32-x64.zip'
$checksum64 = 'daa38337556be621d2ab21c7bc0bab5c6776343861bf64f132faa6e3eea9faf7'
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
