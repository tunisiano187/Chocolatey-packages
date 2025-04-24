$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v35.2.1/electron-v35.2.1-win32-ia32.zip'
$checksum = '1573e2ec09f6cf4e01ca470ef7d64e9216166e1daa27ff8bdd40670286a77bdf'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v35.2.1/electron-v35.2.1-win32-x64.zip'
$checksum64 = '8fce5aad5191cd91194d679679542a4fbe42c593477e5ad82e03c8a3344ab78b'
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
