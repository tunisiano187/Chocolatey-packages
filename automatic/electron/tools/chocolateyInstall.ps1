$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.5.0/electron-v41.5.0-win32-ia32.zip'
$checksum = 'c7699e4a22deb6145dac63d0e4549a83ba7c5c78dc847ba6e569558e27400ed0'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.5.0/electron-v41.5.0-win32-x64.zip'
$checksum64 = '80ca17147647872ddf2c5322e7aad198b67ab179954998eebc295316861ecd51'
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
