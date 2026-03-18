$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.0.3/electron-v41.0.3-win32-ia32.zip'
$checksum = 'c1c29f2d2b3b8fb209403d1186887c4a47aaa6d7c190cd642e3cdcbf30bce1ab'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.0.3/electron-v41.0.3-win32-x64.zip'
$checksum64 = '93346b31dfcd779c4c4cdfdfb2e3f9642e7a9888e388a8971ff3e95dbf948887'
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
