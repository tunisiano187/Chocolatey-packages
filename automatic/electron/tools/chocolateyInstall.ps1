$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v9.1.0/electron-v9.1.0-win32-ia32.zip'
$checksum = 'e2d9d1eff868f2c0f1397c1cf0f05ee01ba8b2154b1f5bb0c9a7358a6465c0db'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v9.1.0/electron-v9.1.0-win32-x64.zip'
$checksum64 = '9097ecf63581a7c0e228b3f72a00f0d77990cbcf389e579d43a725bbd6011ca1'
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
