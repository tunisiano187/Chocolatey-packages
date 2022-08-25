$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.1.0/electron-v20.1.0-win32-ia32.zip'
$checksum = 'ad6cf28be839ae9e1b02df9cdd64fa7c2c8134978d4146e27f8d63e387a44e5f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.1.0/electron-v20.1.0-win32-x64.zip'
$checksum64 = 'bd15fdc8a5ce13e65302234a73491876743c903c7efbe20abffdc30b370515e0'
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
