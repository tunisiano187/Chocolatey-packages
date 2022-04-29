$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.2.0/electron-v18.2.0-win32-ia32.zip'
$checksum = '0fd2f7414cfa9ee98fc3059342434bff6c72de66a50b5bd8f3bb6548a2deaaab'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.2.0/electron-v18.2.0-win32-x64.zip'
$checksum64 = '0f98b695d32c52374c2b9a4ccd14f4c05e9e7b1fc0f044a6b4c8e6d74ddb8095'
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
