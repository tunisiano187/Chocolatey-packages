$ErrorActionPreference = 'Stop'
$packageName = $env:ChocolateyPackageName
$url = 'https://github.com/electron/electron/releases/download/v34.3.0/electron-v34.3.0-win32-ia32.zip'
$checksum = '889a3ee0f76c8ab1b68154194b5b174efc480654e5dcd28f5229f481e2194b69'
$checksumType = 'sha256'
$url64 = 'https://github.com/electron/electron/releases/download/v34.3.0/electron-v34.3.0-win32-x64.zip'
$checksum64 = '1e482577779532c4a4d838a34c4653665d6665d29c463bdad4e8d4abae8e701a'
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
