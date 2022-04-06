$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v18.0.2/electron-v18.0.2-win32-ia32.zip'
$checksum = 'c1840d010e0be70e5ee3ad0c34aae818e345f5a82c72cafb7e17a0d706607336'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v18.0.2/electron-v18.0.2-win32-x64.zip'
$checksum64 = '96d44d61e133f755d831003798bbd7d33cf03e350adf11dde47fb676f9595c56'
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
