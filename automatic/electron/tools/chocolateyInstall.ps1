$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.2.0/electron-v25.2.0-win32-ia32.zip'
$checksum = '73af64421209f38081837a2d5fc6dc75173771026dd1e395a787f8045dfce7e6'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.2.0/electron-v25.2.0-win32-x64.zip'
$checksum64 = 'ac7ede4adccaab27016dfd43575407434f05c3fd36b7882cf9f4c0b99af44d42'
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
