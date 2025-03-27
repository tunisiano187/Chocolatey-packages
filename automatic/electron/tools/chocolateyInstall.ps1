$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.1.1/electron-v35.1.1-win32-ia32.zip'
$checksum = 'bc5f0e1d66c4d1a9d6cdf06fcf4bf3a2546d6ce3ad34123d918718ee52514942'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.1.1/electron-v35.1.1-win32-x64.zip'
$checksum64 = '4941b6d669494639f0cfd3096b916cd22766f3a49e2049688d3fcff8a0c13176'
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
