$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v41.4.0/electron-v41.4.0-win32-ia32.zip'
$checksum = 'd50632c1fd206d4a8fc5b81af002f1d61742b156ed47b162e800cd4c9d959655'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v41.4.0/electron-v41.4.0-win32-x64.zip'
$checksum64 = 'a49241fcc6849f90708a33dda1fd717ed024285a01330d3d3da80be12fa9fe50'
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
