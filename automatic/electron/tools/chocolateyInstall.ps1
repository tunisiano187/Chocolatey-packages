$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.0.3/electron-v20.0.3-win32-ia32.zip'
$checksum = '7806c2c233fe7d7b7a3f74bfef1eb62e3ce3188a2a836d4f0f76604889ad36f4'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.0.3/electron-v20.0.3-win32-x64.zip'
$checksum64 = '77b9879f2d9841a41b4daefd15ab9f342dc798066ecf9964ab0979b4173a2463'
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
