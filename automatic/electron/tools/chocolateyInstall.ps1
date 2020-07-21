$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v9.1.1/electron-v9.1.1-win32-ia32.zip'
$checksum = '855ba74bd803e6e228bb4028e10466e9a7752ce7b38864b90463fa72d1581557'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v9.1.1/electron-v9.1.1-win32-x64.zip'
$checksum64 = '244ee34ff5845e24508e727e0ecb95cf8598d15c9afe6b6ac3631ff573ccb941'
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
