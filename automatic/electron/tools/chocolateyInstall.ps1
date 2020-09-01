$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v10.1.1/electron-v10.1.1-win32-ia32.zip'
$checksum = '79d76181518e9ddd7a242f91b63eb14ea821215b596fce75164bf26000bc9837'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v10.1.1/electron-v10.1.1-win32-x64.zip'
$checksum64 = '8b8171514d53b2edc9a79a2094fb150b1ccb6ad363eb41ecdee8ce4a68907b06'
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
