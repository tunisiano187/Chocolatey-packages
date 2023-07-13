$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v25.3.0/electron-v25.3.0-win32-ia32.zip'
$checksum = '52ed90bcc12f1f80a3347061941ba88d25ed7443f04164c3d22a3939f3362406'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v25.3.0/electron-v25.3.0-win32-x64.zip'
$checksum64 = 'f75c2822c613c46cdc4c150ca9d0226708e1d634101250de5a2b5da663e3ebb6'
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
