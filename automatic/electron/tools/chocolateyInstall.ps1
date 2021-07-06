$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.1.6/electron-v13.1.6-win32-ia32.zip'
$checksum = 'bb6f34548879c9813897e2b023d195bf8b735198687db4448e19a13f71d77766'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.1.6/electron-v13.1.6-win32-x64.zip'
$checksum64 = 'd9b3edaa6d2b47a0bd3322322ab8f58863a16a14b0444b10c56939b562e0d11f'
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
