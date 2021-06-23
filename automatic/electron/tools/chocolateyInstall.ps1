$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v13.1.4/electron-v13.1.4-win32-ia32.zip'
$checksum = 'd2c796d5c26600c912275e806310b93f5efdf22ce56edab20bc99d074a50dd6e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v13.1.4/electron-v13.1.4-win32-x64.zip'
$checksum64 = 'f8cedd695273292a07f32149224b1a88609e81865c83f04a2655a602b4dfd346'
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
