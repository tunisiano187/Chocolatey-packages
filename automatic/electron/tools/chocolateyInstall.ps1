$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v16.0.1/electron-v16.0.1-win32-ia32.zip'
$checksum = '03fdd87065ba3ceefdf5fdd2b33272dbf851282e9d1ca138c6213eec0921e837'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v16.0.1/electron-v16.0.1-win32-x64.zip'
$checksum64 = '2fa69302360fba54add65f389f08944fd969b9f5e6bef3a8191401829209230a'
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
