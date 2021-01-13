$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v11.2.0/electron-v11.2.0-win32-ia32.zip'
$checksum = '912bc35412efa7976629a27ea7782d3011326ce80cfa4b0715a9572fd6d3b7ef'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v11.2.0/electron-v11.2.0-win32-x64.zip'
$checksum64 = '99deb27ce739bb90339fbe1eb9f83d3be642c7e7bd05fc4e81dbb580c26c1987'
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
