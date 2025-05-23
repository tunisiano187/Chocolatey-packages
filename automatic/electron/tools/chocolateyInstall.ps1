$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v36.3.0/electron-v36.3.0-win32-ia32.zip'
$checksum = '785b12f66960b43f4afc28646b1bb13a1cf506367df2d16552f0f9d9f07d8627'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v36.3.0/electron-v36.3.0-win32-x64.zip'
$checksum64 = 'cfcc2d7aa90c973a8809b399f81abd50c2443b95f5f0c22b232cffd67162ae5f'
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
