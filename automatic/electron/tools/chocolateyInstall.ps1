$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v27.0.1/electron-v27.0.1-win32-ia32.zip'
$checksum = 'e26903b5bac2c2272b0c41948943da426eaeaf24ab09c0b3d42387504721fcbd'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v27.0.1/electron-v27.0.1-win32-x64.zip'
$checksum64 = '91e85f08396c755d2f3bd8aaeae1a56eff5a5fac8ebb1ec4ef8d547cb9f8fb48'
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
