$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v39.2.7/electron-v39.2.7-win32-ia32.zip'
$checksum = '85acd7db5dbb39e16d6c798a649342969569caa2c71d6b5bb1f0c8ae96bca32e'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v39.2.7/electron-v39.2.7-win32-x64.zip'
$checksum64 = '3464537fa4be6b7b073f1c9b694ac2eb1f632d6ec36f6eeac9e00d8a279f188c'
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
