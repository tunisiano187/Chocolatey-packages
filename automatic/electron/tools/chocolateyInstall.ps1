$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.1.0/electron-v41.1.0-win32-ia32.zip'
$checksum = 'c14210d8ee42dc89326838b0ac01b229b9721881799e17bed8215ee30cc1dcfc'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.1.0/electron-v41.1.0-win32-x64.zip'
$checksum64 = 'bbb798d1817bc173a187c1de30432247e48046f737fa13ade126fe3788303b81'
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
