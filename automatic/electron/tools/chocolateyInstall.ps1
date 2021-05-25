$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.0.0/electron-v13.0.0-win32-ia32.zip'
$checksum = '8b0c279f90a2f99b7ad5629c0fb1bcd2d3a55275a99448347d585ea8da2b96c8'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.0.0/electron-v13.0.0-win32-x64.zip'
$checksum64 = '6f6715116b29811de652921c98e5a296e9a5ebb6f22b91c7047b92ade0b18947'
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
