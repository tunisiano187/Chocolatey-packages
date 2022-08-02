$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v20.0.0/electron-v20.0.0-win32-ia32.zip'
$checksum = '1a461618d0556c32f02f4ea8c93e32a3282c8d2027113d26567cdb5fa67425f9'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v20.0.0/electron-v20.0.0-win32-x64.zip'
$checksum64 = '6b13eb2bbec4e0f03d51d66312a084b6c36db568aafd91a3a3f2f4991d1dc175'
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
