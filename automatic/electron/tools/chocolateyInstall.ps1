$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v27.0.0/electron-v27.0.0-win32-ia32.zip'
$checksum = '650da55912588c72be9e48cf325299d09526019f4fc8f0b15a6283bfdec4ed24'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v27.0.0/electron-v27.0.0-win32-x64.zip'
$checksum64 = '678c822ca5fb4979caf61580c72a90da73ab64df5db1e510d8858e7cb6944455'
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
