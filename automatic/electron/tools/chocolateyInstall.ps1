$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.0.0/electron-v18.0.0-win32-ia32.zip'
$checksum = '612641b158ee4a7872ef7040a7d54b4a46a46e90852dee0777bcb16aa7453c39'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.0.0/electron-v18.0.0-win32-x64.zip'
$checksum64 = '6706372e6590636d582a8287b6796d058e4987b4fbb16194167e2f82258e2d46'
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
