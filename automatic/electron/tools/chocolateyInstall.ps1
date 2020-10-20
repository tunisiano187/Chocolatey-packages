$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v10.1.4/electron-v10.1.4-win32-ia32.zip'
$checksum = '585426edb38fd7468f05f008d47aab6eff3f78fdef4d8727d17aa4628176d7e9'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v10.1.4/electron-v10.1.4-win32-x64.zip'
$checksum64 = '182ba01acfe6c8366cc00e2390b7b80f1d5c30112529ff771e9cf04285717cbb'
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
