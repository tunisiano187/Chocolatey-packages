$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v23.0.0/electron-v23.0.0-win32-ia32.zip'
$checksum = '183127f7e628ed60f749a688576bce2e2b42b7382fb44c182d29e7b0401d02a0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v23.0.0/electron-v23.0.0-win32-x64.zip'
$checksum64 = '0ac90fab302f5a012b298df0256cf1a9cd13ec61d6405691ec1d997fc8873b03'
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
