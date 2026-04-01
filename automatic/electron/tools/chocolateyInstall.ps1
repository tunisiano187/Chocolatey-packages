$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.1.1/electron-v41.1.1-win32-ia32.zip'
$checksum = '361407bc25161fb3d8b0740d0c13ccd3a8594e32b456a4769013c42fcdd65564'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.1.1/electron-v41.1.1-win32-x64.zip'
$checksum64 = '1259809991d6c0914f51ae12829abdacedeca76f5be9f7f55347f8bf0b632a2e'
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
