$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.2.0/electron-v35.2.0-win32-ia32.zip'
$checksum = '7b487c27a29a19d7789ecc05a46fd9e496aa2d118e6a9dc95b1585a173c77032'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.2.0/electron-v35.2.0-win32-x64.zip'
$checksum64 = '1c798d3093cca780a3ee6a14e0e658f960e097135a495521ce9a183a05a6ff41'
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
