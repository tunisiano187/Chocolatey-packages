$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v28.2.1/electron-v28.2.1-win32-ia32.zip'
$checksum = '7b536925984b9b89809434983f7ae52609c357ccc8e1bc56436f188d91ee194f'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v28.2.1/electron-v28.2.1-win32-x64.zip'
$checksum64 = '215b176da1efe2fc891b3ae7afba84c70087270db9c6b2c5e73c7579dc6c0f4d'
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
