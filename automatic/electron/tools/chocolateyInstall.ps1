$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v10.0.0/electron-v10.0.0-win32-ia32.zip'
$checksum = '717805a6ad20c05a5331f68a09238e0ed33b0b88caf0337368b91febc1d3a895'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v10.0.0/electron-v10.0.0-win32-x64.zip'
$checksum64 = 'd8a37cab37f536c564922197c358e53ae00106c25a849507d83bb2e0e1888492'
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
